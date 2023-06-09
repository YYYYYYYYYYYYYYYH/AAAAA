--select 명령 
--문법1.: select [*| column 명,,,] frome [table | view] where 조건절
-- 데이터를 조회하는 명령
-- 실습1. scott의 dept,emp 테이블내용 조회하기
--    2. emp 데이블의 모든 컬럼 조회하기
--    3. emp에서 사원명과 사원번호만 조회하기
--    4. 사용자 생성하기 : scott 대신에 your name, 비번은 12345
--    5. 생성된 사용자에게 권한 부여하기 
--    6. db 접속하기


select * from tabs;

--1
select * from tabs where table_name = 'DEPT' ;
select * from tabs where table_name = 'EMP' ;
--2
select*from emp;
select*from DEPT;
--3
select empNO, eNAME from emp;


/*
A. SQL 문의 종류
 1. DML (Data Manipulation language : 데이터 조작어)
  1) select : 자료를 조회 
	2) insert : 자료를 추가
	3) delet : 자료를 삭제
	4) update : 자료를 수정
	5) commit : CUD등의 작업을 최정적으로 확정하는 명령
	6) rollback CUD의 작업을 취소하는 명령
  
	* CRUD : creat, read, update , delete
	
 2. DDL (Data Definition language : 데이터 정의어)
 -oracle 객체과 관련된 명령어
 -객체(object) 의 종류 : user,table, view, index..
  1) create:  오라클 DB 객체를 생성
	2) drop : 오라클 DB 객체를 삭제 (완전삭제)
	3) truncate : 오라클 DB 객체를 삭제 (데이터만 삭제)
	4) alter : 오라클 DB 객체를 수정
	
 3. DCL (Data Control language : 데이터 관리어 )
  1) grant : 사용자에게 권한(or role) 부여 (connect, resource....)
	2) revoke : 사용자의 권한(or role) 을 취소 
	
B. select 문법
 select [distinc] {*, [col1[[as]별칭],...co1n]}
  from table명 (view명 , ...[select * from 테이블명])
  [where 조건절 [and,or,like,between...]]
	[order by 열이름 (or 표현식) [asc/desc],...]
	
	1. distinct : 중복행이 있을 경우 중복제거를 하고 한 행만 조회
	2. * : 객체의 모든 컬럼을 의미
	3. 별칭(alias) : 객체나 컴럼명을 별칭으로 정의
	4. where : 조건절에 만족하는 행만 출력
	5. 조건절 : 컬럼, 표현식, 상수 및 비교연산(>,<,=,!...)
	6. order by : 질의(query) 결과를 정렬 (asc 오름차순(기본값),desc 내림차순) 
	
*/

--1. 특정 테이블의 자료를 조회하기
select * from tabs;
select * from emp;
select * from scott.emp;
select * from hr.emp; --not exist (emp가 없어서 안나옴)
select * from hr.employees; -- not exist (hr에 권한 없어서 접근불가 )
-- emp에서 사원명과 사원번호만 조회하기
select empno, ename, sal from emp;

--별칭
select empno as 사원번호
       , ename 사원이름
			 , sal "사원 급여"
			 , sal payroll
from emp; 

--3. 표현식 : litral, 상수, 문자열 : 표현식은 잠은 따옴표로 정의해야 한다
select ename from emp;
select '사원이름 = ', ename from emp; -- '사원이름 = ' -> litral 
select '사원이름 = ' 이름, ename from emp;
select "사원이름 = ", ename from emp; -- 큰따옴표는 에러
select '사원이름 = ', "ename" from emp; -- 에러 // 컬럼을 큰 따옴표로 정의할 경우 대소문자 구분 
select '사원이름 = ', "ENAME" from emp; -- 정상


-- 4. distinct 죽복 제거 
select * from emp;
select deptno from emp;
select distinct deptno from emp; -- 값 중복 제거
select deptno distinct from emp; -- 에러 / distinct는 컴럼명 앞에 위치
select distinct deptno, ename from emp; 
select distinct deptno distinct ename from emp;  -- 에러 / distinct 선언은 한번만 컬럼명 앞에 정의

--5. 정렬 order by 
select * from emp ;
select * from emp order by ename;
select * from emp order by ename asc;
select * from emp order by 2;  -- 2는 select 절안에 컬럼의 위치를 의미
-- 위에 3개 다 똑같은 거임
select * from ename,empno from emp order by 1;

select * from emp order by ename desc;
select * from emp order by ename,hiredate desc, 6 desc; -- 복합순서로 정렬
select * from emp order by 6 desc, hiredate desc ,ename;

--실습 1. 부서와 직무를 조회하는데 중복제거
--    2. 중복제거 후 부서,직무순으로 정렬(asc,desc)
--    3. deptno를 부서번호, job을 직급으로 별칭으로 정의

select distinct job, deptno from emp; 
select distinct job, deptno from emp order by job desc;
select deptno as 부서번호 , job 직급 from emp; 
select distinct job as 직급, deptno as 부서번호 from emp order by job asc;

--6. 별칭으로 열이름 붙이기
select ename from emp;
select '사원이름', ename from emp; -- literal (문자열)은 하나의 열로 간주된다
select '사원이름', ename 사원이름 from emp; -- 별칭
select '사원이름', ename, 사원이름 from emp; -- 에러 / 세 번째의 사원이름은 emp의 사원이름이란 열로 간주
select '사원이름', ename, "사원이름" from emp; -- 에러 / 세 번째의 사원이름은 emp의 사원이름이란 열로 간주

select '사원''s이름 =', ename from emp;


--7. 컬럼 및 문자열 연결하기 : concat()함수 or || -> 연결자
select ename, deptno from emp;
-- SMITH(20) 형식으로 출력
-- 1) 연결연산자 (||)
select ename, '(',deptno,')' from emp;
select ename || '('||deptno||')' "사원명과 부서번호" from emp;

-- 2) concat(a,b) : 매개변수가 2개만 정의 가능
select concat (ename,'(') "사원명과 부서번호" from emp;
select concat (ename,'('), concat (deptno, ')') "사원명과 부서번호" from emp;
select concat (concat (ename,'('), concat (deptno, ')')) "사원명과 부서번호" from emp;
select concat (ename,'(') || concat (deptno, ')') "사원명과 부서번호" from emp;


-- 실습. "smith의 부서는 20입니다!" 형태로 출력하기
select ename, deptno from emp;
select ename || '의 부서는'||deptno|| '입니다' from emp;
select concat (concat(ename, '의 부서는 ' ),concat (deptno, '입니다'))from emp;


/*C. 연습문제
  1. Student 에서 학생들의 정보를 이용해서 'Id and Weight' 형식으로 출력하세요 
	2. emp 에서 'Name and Job' 형식으로 출력
	3. emp 에서 'Name and Sal'

*/
select* from Student;
select ID || ' and '||WEIGHT as "Id and Weight" from Student;

select* from emp;
select EName || ' and '||Job|| '입니다' as "Name and Job" from emp;
select EName || ' and '||Sal as "Name and Sal"from emp;






























