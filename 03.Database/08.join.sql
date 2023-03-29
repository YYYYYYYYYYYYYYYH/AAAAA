/*
	Join 문법
	
	1. Oracle 문법
	
		select t1.ename, t2.dname
			from emp t1, dept t2
		 where t1.deptno = t2.deptno

	2. Ansi Join
	
		select t1.ename, t2.dname
			from emp t1[inner(기본)|outer|full] join dept t2 on t1.deptno = t2.deptno
*/

select deptno, ename from emp;
select deptno, dname from dept;

-- oracle join

select emp.deptno, ename, dname
	from emp, dept
	where emp.deptno = dept.deptno;
	
-- ansi join
select emp.deptno, ename, dname
	from emp inner join dept on emp.deptno = dept.deptno;

-- table 별칭

select t1.deptno, t1.ename, t2.dname
	from emp t1, dept t2
	where t1.deptno = t2.deptno;

/*
	join의 종류
	
	1. equi-join(등가조인), inner join
	2. outer-join
	3. full-join
*/

-- A. equi-join
-- 실습1. student, professor에서 지도교수의 이름과 학생이름을 출력
-- oracle과 ansi join 각각 조회하기
-- 학생명과 교수명만 출력해 보기
select * from professor;
select * from student;
select * from department;
-- oracle
select pro.name, std.name
	from professor pro, student std
where pro.deptno = std.deptno1;


select pro.name 교수명, std.name 학생명
	from professor pro, student std
where pro.profno = std.profno;

-- ansi
select pro.name 교수명, std.name 학생명
	from professor pro inner join student std
 on pro.profno = std.profno;

select pro.name 교수명, std.name 학생명
	from professor pro inner join student std
 on std.profno = pro.profno;
 
 
 --실습2. student,professor, department에서 교수명,학생명,학과명을 출력
-- oracle 
select std.name, pro.name, dpt.dname
from student std, professor pro, department dpt
where std.profno = pro.profno and pro.deptno = dpt.deptno;

--ansi
select std.name, pro.name, dpt.dname
from student std inner join professor pro on std.profno = pro.profno
                 inner join department dpt on pro.deptno = dpt.deptno;
								 


--B. outer-join
select count(*) from student;
select count(*) from student where profno is null;

--지도교수가 정해져 있지 않은 학생까지도 출력
--1) oracle 에서만 사용되는 문법
select std.name, pro.name
from student std, professor pro
where std.profno = pro.profno (+) ;

--학생이 할당되지 않은 지도교수까지 나옴
select std.name, pro.name
from student std, professor pro
where std.profno (+) = pro.profno ;


--ansi outer join
select std.name, pro.name
from student std inner join professor pro
on std.profno = pro.profno ;


select std.name, pro.name
from student std left outer join professor pro
on std.profno = pro.profno ;


select std.name 학생 , pro.name 교수
from student std right outer join professor pro
on std.profno = pro.profno ;



--C. self join
select * from emp;

select empno from emp;
select mgr from emp;

select emp.empno, emp.ename  -- 사원
       ,mgr.empno , mgr.ename  -- 해당 사원의 매니저
from emp emp,emp mgr
where emp.mgr = mgr.empno ;





 
 
