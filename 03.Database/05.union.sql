/*
A. 집합 연산자

 1.union : 두 집합의 결과를 합쳐서 출력, 단 중복이 있을 경우 중복자료는 제외
 2.union all : 두 집합의 결과를 합쳐서 출력, 중복과 상관없이 전체 자료 조회
 3.intersect : 두 집합의 교집합을 출력 (정렬)
 4. minus : 두 집합의 차집합을 출력 (정렬), 순서 (선후) 가 중요
 
 [집합연산자의 조건]
 1. 두 집합의 select 절의 컬럼수가 동수이어야 한다.
 2. 두 집합의 select 절의 같은 위치에 있는 컬럼의 데이터 타입은 동일 데이터타입이어야 한다
 3. 두 집합의 컬럼명이 달라도 상관없다 . 단, 먼저 정의된 컬럼명으로 정해진다
*/

select * from student;
select * from professor;

select studno 학생번호 from student;
select profno 교수번호 from professor;

-- 1. union : 학생번호와 교수번호  정보를 하나로 합치기
select studno 학생번호 from student 
union 
select profno 교수번호 from professor;

-- 에러 / 1. 두 집합의 select 절의 컬럼수가 동수이어야 한다.
select studno 학생번호 , name from student 
union 
select profno 교수번호 from professor;

-- 에러 / 2. 두 집합의 select 절의 같은 위치에 있는 컬럼의 데이터 타입은 동일 데이터타입이어야 한다
select name from student 
union 
select profno 교수번호 from professor;


-- union / union all
select*from STUDENT;
select count(*) from student; -- 집계함수 count(* / 컬럼명)
select count(name) from student;
select count(deptno2) from student; -- null 은 카운트에 포함 안됨 (null은 값이 아니다)

--union (중복제거)
select studno,name,deptno1 from student 
union
select studno,name,deptno1 from student ;

--union all (중복 제거 안함)
select studno,name,deptno1 from student 
union all
select studno,name,deptno1 from student ;

-- 3. union은 정렬하지만 union all 은 정력하지 않는다
select studno,name,deptno1, 1 from student where deptno1 = 101  -- 정렬
union
select studno,name,deptno1, 2 from student where deptno1 = 101;

select studno,name,deptno1, 1 from student where deptno1 = 101  -- 정렬 x
union all
select studno,name,deptno1, 2 from student where deptno1 = 101;

-- 4. 교집합 intersect 
select studno,name,deptno1, 1 from student where deptno1 = 101
intersect
select studno,name,deptno1, 1 from student where deptno1 = 102;

--5. 차집합 minus
select studno,name,deptno1, 1 from student where deptno1 = 101
minus
select studno,name,deptno1, 1 from student where deptno1 = 102;

select studno,name,deptno1, 1 from student where deptno1 = 102
minus
select studno,name,deptno1, 1 from student where deptno1 = 101;








