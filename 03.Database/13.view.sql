select * from emp ;

create or replace view v_emp as --insufficient privileges // 권한 부족
select ename, job, deptno from emp;


--sys로 접속
-- 1. create view 권한 부여하기
-- grant connect, resource to scott;
grant create view to scott;

--2. 권한조회
select * from user_role_privs;


/*
 View?
 
 1.view란 가상의 테이블이다.
 2.view 에는 실제 데이터가 존재하지 않고 view를 통해서 데이터만 조회할 수 있다 
 3.view는 복잡한 query를 통해 조회할 수 있는 결과를 사전에 정의한 view를 통해 
   간단히 조회할 수 있다.
 4.한개의 view로 여러 개의 table데이터를 검색할 수 있게 한다 .
 5.특정 기준에 따라 사용자별로 다른 조회 결과를 얻을 수 있게 한다.
 
 view의 제한조건
 
 1. 테이블에 not null로 만든 컬럼들이 view에 포함되어야 한다.
 2. view를 통해서도 데이터를 insert할 수 있다. 단, rowid,rownum,nextval,curval 등과 같은
    가상의 컬럼에 대해 참조하고 있을 경우에 가능하다.
 3. with read only 옵션으로 설정된 view 는 어떠한 데이터를 갱신할 수 없다 .
 4. wirh check option을 설정한 viwe는 view조건에 해당되는 데이터만 삽입, 삭제,수정 할 수 있다.
 
 view 문법
 
 create [or replace][force|noforce] view 뷰이름 as
 sub query..
 with read only 
 with check option
 
 1. or replace : 동일 이름의 view가 존재할 경우 삭제 후 다시 생성 (대체)
 2.force|noforce : 테이블의 존재유무와 상관없이 view를 생성할지 여부 (force - 테이블 없어도 강제로 생성 )
 3. with read only : 조회만 가능한 view
 4.wirh check option : 주어진 check 옵션 죽 , 제약조건에 맞는 데이터만 입력하거나 수정가능
 
 view 조회방법
 테이블과 동일한 문법으로 사용
 
 view를 생성할 수 있는 권한 부여하기
 1. 사용자권한 조회 : select * from user_role_privs;
 2. 권한부여 방법 : sysdba에 권한으로 부여가능 
    grant create view to scott(사용자계정 or schema);
*/



--3.단순 view 생성하기
create or replace view v_emp as 
select ename, job, deptno from emp;


select * from v_emp;


--4. 사용자 view 목록 조회하기
select * from user_views;


select * from emp;
select * from dept;


--- 5. 복합 view
create or replace view v_emp_dname as 
select emp.ename, dept.dname, emp.deptno 
  from emp emp ,dept dept 
where emp.deptno = dept.deptno;


select * from v_emp_dname;


--실습. 급여(sal.comm)가 포함된 view
--예) 급여조회권한이 있는 담당자만 사욜할 수 있는 view


create or replace view v_emp_sal as 
select empno 사원번호 
       ,ename "사원 이름"
			 ,job 직급
			 ,sal 급여
			 ,nvl(comm,0) 커미션
from emp;

select * from v_emp_sal;
select * from v_emp_sal where job = 'CLERK'; --에러 /"JOB": invalid identifier
select * from v_emp_sal where 직급 = 'CLERK';
select * from v_emp_sal where "사원 이름"  = 'SMITH';

select * 
 from(select empno 사원번호 
       ,ename "사원 이름"
			 ,job 직급
			 ,sal 급여
			 ,nvl(comm,0) 커미션
from emp)
where 직급 = 'CLERK';



--6.table과 view의 join
select emp.deptno, v_emp.*
  from emp emp, v_emp_sal v_emp
where emp.empno = v_emp.사원번호;


create or replace view v_test as 
select emp.deptno, v_emp.*
  from emp emp, v_emp_sal v_emp
where emp.empno = v_emp.사원번호;


select * from v_test;


--실습. emp에서 부서번호, dept에서 dname, v_emp_sal 와 join 
-- 사원번호, 사원이름, 부서명, 지급, 급여 출력할 수 있는 join 쿼리 
select * from v_emp_sal;
select * from emp;
select * from dept;


select dept.dname
  from emp emp , dept dept
where emp.deptno = dept.deptno ;



create or replace view v_emd_test as 
select emp.empno, emp.deptno 부서번호, dept.dname 부서명
  from emp emp , dept dept
where emp.deptno = dept.deptno ;

select * from v_emd_test;
select * from v_emp_sal;

select ve.empno 사원번호, vs."사원 이름" ,ve."부서명", vs.직급, vs.급여
  from v_emd_test ve, v_emp_sal vs
where ve.empno = vs.사원번호;


-----------------------------------------------------------------------
create or replace view v_e_dtest as 
select emp.deptno
		   ,dpt.dname
			 ,v_emp_sal .*
 from emp emp
      ,dept dpt
			,v_emp_sal
where emp.deptno = dpt.deptno
 and  emp.empno = v_emp_sal.사원번호;
 
 select * from v_e_dtest;
-------------------------------------------------------------------------

--7. inline view 
--제약사항 : 한개의 컬럼만 가능 
select emp.ename
       ,dpt.dname 
 from emp emp 
      ,dept dpt
where emp.deptno = dpt.deptno;
 

select emp.ename
      , (select dname from dept dpt where emp.deptno = dpt.deptno) -- 한개의 컬럼만 가능 dname
from emp emp;


select emp.ename
      , (select deptno, dname from dept dpt where emp.deptno = dpt.deptno) --에러 / too many values  (deptno, dname)
from emp emp;

select emp.ename
      ,dpt.dname 부서번호
		from emp emp
      , (select deptno , dname from dept dpt) dpt
			where emp.deptno = dpt.deptno ;
			
			
--8. view 삭제하기


drop view v_test2;
select * from user_views;

--실습. emp 와 dept를 조회 : 부서번호와 부서별 최대급여 및 부서명을 조회
select * from emp ; -- dempno 
select * from dept ; -- dname

--1) view 를 생성 
--2) inline view로 작성 
-- deptno, dname , max_sal :
-- view 이름 : v_max_sal_01

create or replace view v_max_sal_01 as 
select deptno
       ,max (sal) 최대급여
 from emp 
 group by deptno
 order by deptno;
 
 
 select * from v_max_sal_01;
 
 select d.deptno
			 ,d.dname
			 ,m.최대급여
  from dept d
		  ,v_max_sal_01 m
 where d.deptno = m.deptno;
 
 
create or replace view v_max_sal_01 as 
select emp.deptno
        ,dpt.dname
				,max (sal) 최대급여
	from emp emp
	     , dept dpt
where emp.deptno = dpt.deptno
group by emp.deptno, dpt.dname
order by emp.deptno;


 select * from v_max_sal_01;
 
 
--inline view (서브쿼리 - inline view에 group by 사용)
create or replace view v_max_sal_03 as 
select dpt.deptno
      ,dpt.dname
			,sal.max_sal
	 from dept dpt
	      ,(select deptno, sum(sal) as max_sal from emp group by deptno) sal
where dpt.deptno = sal.deptno;

 select * from v_max_sal_03;

-- inline view
create or replace view v_max_sal_04 as 
select dpt.deptno
       ,dpt.dname
			 ,nvl((select max(sal) from emp emp where dpt.deptno = emp.deptno group by deptno),0) 부서별최대급여
			 
	 from dept dpt;
 select * from v_max_sal_04;
		


