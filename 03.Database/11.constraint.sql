/*
 제약조건 (constraint)
 
 테이블에 정확한 데이터만 입력이 될 수 있도록 사전에 정의(제약)하는 조건을 말한다.
 데이터가 추가될 때 사전에 정의된 제약조건에 맞지 않는 자료는 DB엔진에서 사전에 방지할 수 있게 한다 .
 
 제약조건의 종류 
 1. not null (NN) : null 값이 입력되지 못하게 하는 조건
 2  unique (UK) : UK로 설정된 컬럼에는 중복된 값을 허용하지 않는 조건
 3. primary key (PK) : not null * unique인 컬럼, PK는 테이블당 한개의 PK만 정의 가능
                       PK는 한개 이상의 컬럼을 묶어서 한개의 pk로 지정할 수 있다
 4. forign key (FK) : 부모 테이블의 pk인 컬럼을 참조 (reference) 하도록 하는 조건
                      부모 테이블에 pk에 없는 값이 자식테이블에 입력되지 못하게 하는 조건
 5. check (CK) : 설정된 값만 입력이 되도록 하는 조건
*/

--1. 테이블 생성시에 지정
--1) 정식문법
create table new_emp1 (
  no  number(4)  constraint emp_no_pk primary key
 ,name varchar2(20) constraint emp_name_nn not null
 ,ssn varchar2(13) constraint emp_jumin_uk unique 
									 constraint emp_jumin_nn not null
 ,loc number(1)    constraint emp_loc_ck check(loc<5)
 ,deptno varchar2(6) constraint emp_deptno_fk references dept2(dcode)


);
select * from new_emp1;

--2) 약식문법

create table new_emp2 (
  no  number(4)  primary key
 ,name varchar2(20) not null
 ,ssn varchar2(13) unique not null
 ,loc number(1)    check(loc<5)
 ,deptno varchar2(6) references dept2(dcode)

);

select * from new_emp2;

--2. 테이블에 설정된 제약조건 조회하기
--data dictionary : xxx_constraints
select * from all_constraints;
select * from user_constraints;
select * from user_constraints where table_name like 'NEW_EMP%';


--실습1. 데이터 추가하기 (제약조건 테스트)
select * from new_emp1;

insert into new_emp1 values (1,'홍길동','8011181234567',1,1010);
insert into new_emp1 values (2,'홍길상','8111181234567',1,1010);
insert into new_emp1 values (3,'홍길녀','8011182234567',1,1010);

--에러
insert into new_emp1 values (1,'홍길동','8011181234567',1,1010); -- unique constraint (SCOTT.EMP_NO_PK) violated // no 중복
insert into new_emp1 values (2,'홍길동','8111181234567',1,1010); -- unique constraint (SCOTT.EMP_NO_PK) violated // ssn 중복
insert into new_emp1 values (null,'홍길동','8011181234567',1,1010); -- cannot insert NULL into
insert into new_emp1 values (4,null,'8011181234567',1,1010); -- cannot insert NULL into ("SCOTT"."NEW_EMP1"."NAME")
insert into new_emp1 values (4,'손흥민',null,1,1010); -- cannot insert NULL into ("SCOTT"."NEW_EMP1"."SSN")
insert into new_emp1 values (4,'손흥민','9911181234567',5,1010); -- check constraint (SCOTT.EMP_LOC_CK) violated // loc 5 미만만 가능
insert into new_emp1 values (4,'손흥민','9911181234567',3,9999); -- integrity constraint (SCOTT.EMP_DEPTNO_FK) violated - parent key not found


-----------------------------------------------------------------
insert into new_emp1 values (4,'손흥민','9911181234567',3,1000);
select * from new_emp1;


--실습2. 제약조건 수정하기
select * from user_constraints where table_name like 'NEW_EMP2';
--1) NEW_EMP2.name uk 제약조건을 추가 
alter table NEW_EMP2 add constraint NEW_EMP_uk unique(name);

insert into NEW_EMP2 values (4,'손흥민','9911181234567',3,1000);
insert into NEW_EMP2 values (5,'손흥민','9811181234567',3,1000); -- unique constraint (SCOTT.NEW_EMP_UK) violated
insert into NEW_EMP2 values (1,'이강인','9811181234567',null,1000);

select * from NEW_EMP2;


--2. NEW_EMP2.loc에 NN 제약조건을 추가하기
--a. 이미 데이터에 null 값이 있을 경우 제약조건 추가 불가, 단 null값이 없는 경우에는 제약조건 추가가능
--b. 이미 loc에는 check (loc<5) 제약조건이 있는경우 제약조건 추가 불가, 따라서 추가가 아니라 수정(modify)로 해야 함

alter table NEW_EMP2 add constraint emp_loc_nn not null (loc);  -- invalid identifier
alter table NEW_EMP2 modify (loc constraint emp_loc_nn not null );
select * from user_constraints where table_name = 'NEW_EMP2';


--실습3. FK 설정하기
create table c_test1 (
  no  number
 ,name varchar2(10)
 ,deptno number

);
create table c_test2 (
  no  number
 ,name varchar2(10)
 ,deptno number

);

select * from c_test2;

--primary key / foreign key 
--FK 는 참조테이블의 컬럼이 PK or UK 인 컬럼만 FK 로 정의할 수 있다 

alter table c_test1 add constraint c_test1_dept_fk foreign key (deptno) references c_test2(deptno); --no matching unique or primary key for this column-list // c_test2(deptno) 가  unique or primary key 아님


alter table c_test2 add constraint c2_deptno_uk unique(deptno); -- unique 제약조건 초가
alter table c_test1 add constraint c_test1_dept_fk foreign key (deptno) references c_test2(deptno);

--FK 제약사항 테스트 하기
select * from c_test2;
select * from c_test1;

insert into c_test1 values(1,'손흥민',10); -- integrity constraint (SCOTT.C_TEST1_DEPT_FK) violated - parent key not found
insert into c_test2 values(1,'인사부',10);
insert into c_test1 values(1,'손흥민',10); --  insert into c_test2 values(1,'인사부',10); 이거 하고 해야됨

--부모테이블인 c_test2에서 10부서인 자료를 삭제할 경우는 ?
delete from c_test2 where deptno = 10; -- 에러 (child record 가 있음) // integrity constraint (SCOTT.C_TEST1_DEPT_FK) violated - child record found

--부모자료를 삭제하려면 자식 자료를 삭제한 후에 가능하다.
delete from c_test1 where deptno = 10;
delete from c_test2 where deptno = 10;

--FK관계에서 부모테이블 자료를 삭제할 수 있도록 정의하는 옵션
--cascade 옵션 
--1) 부모와 자식을 동시에 삭제 옵션
--2) 부모는 삭제하고 자식에는 FK 컬럼을 null로 업데이트 하는 옵션
drop table c_test1;
drop table c_test2;

create table c_test1 (
  no  number
 ,name varchar2(10)
 ,deptno number

);
create table c_test2 (
  no  number
 ,name varchar2(10)
 ,deptno number

);

insert into c_test2 values(1,'인사부',10);
insert into c_test1 values(1,'손흥민',10);

select * from c_test2;
select * from c_test1;

select * from user_constraints where table_name like 'C_%';


 
--A. on delete cascade : 부모자료 삭제 (자식도 삭제)

alter table c_test2 add constraint c2_deptno_uk unique(deptno); -- unique 제약조건 초가

alter table c_test1 add constraints c1_deptno_fk foreign key (deptno) references c_test2(deptno)
 on delete cascade;  -- delete_rule : cascade
 
 
 
delete from c_test2 where deptno = 10;
select * from c_test2;
select * from c_test1;


--B. on delete set null : 부모자료 삭제할 경우 자식자료는 null값으로 변경

alter table c_test2 add constraint c2_deptno_uk unique(deptno); -- unique 제약조건 초가

alter table c_test1 add constraints c1_deptno_fk foreign key (deptno) references c_test2(deptno)
 on delete set null;  


select * from user_constraints where table_name like 'C_%'; -- delete_rule : set null

delete from c_test2 where deptno = 10;
select * from c_test2;
select * from c_test1;





