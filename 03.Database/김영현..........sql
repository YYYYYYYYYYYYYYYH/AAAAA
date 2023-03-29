/* 연습문제 */
-- ex01) student, department에서 학생이름, 학과번호, 1전공학과명출력
select std.name, dep.deptno, dep.dname
   from student std, department dep
 where std.deptno1 = dep.deptno;

-- ex02) emp2, p_grade에서 현재 직급의 사원명, 직급, 현재 년봉, 해당직급의 하한
--       상한금액 출력 (천단위 ,로 구분)
select e2.name 사원명, e2.position 직급
      ,to_char(e2.pay, '999,999,999') 현재연봉
			, to_char(pg.s_pay,'999,999,999') 하한금액
			, to_char(pg.e_pay, '999,999,999') 상한금액
   from emp2 e2, p_grade pg
 where e2.position = pg.position(+);
 
    
-- ex03) emp2, p_grade에서 사원명, 나이, 직급, 예상직급(나이로 계산후 해당 나이의
--       직급), 나이는 오늘날자기준 trunc로 소수점이하 절삭 
select e2.name 사원명, trunc((sysdate - e2.birthday) / 365 , 0) 나이, e2.position 직급, pg.position 예상직급
   from emp2 e2 join p_grade pg
 on trunc((sysdate - e2.birthday) / 365 , 0) between pg.s_age and pg.e_age;





-- ex04) customer, gift 고객포인트보나 낮은 포인트의 상품중에 Notebook을 선택할
--       수 있는 고객명, 포인트, 상품명을 출력    

select  cu.gname 고객명 , cu.point 포인트, gi.gname 상품명
   from customer cu, gift gi
 where cu.point > gi.g_start and gi.gname = 'Notebook' ;



-- ex05) professor에서 교수번호, 교수명, 입사일, 자신보다 빠른 사람의 인원수
--       단, 입사일이 빠른 사람수를 오름차순으로
select * from professor;


select p1.profno 교수번호, p1.name 교수명, p1.hiredate 입사일, count(p2.hiredate) 빠른사람
from professor p1, professor p2
where p2.hiredate(+) < p1.hiredate
group by p1.profno, p1.name, p1.hiredate
order by count(p2.hiredate);

 
-- ex06) emp에서 사원번호, 사원명, 입사일 자신보다 먼저 입사한 인원수를 출력
--       단, 입사일이 빠른 사람수를 오름차순 정렬

select * from emp;

select e1.empno 사원번호, e1.ename, e1.hiredate 입사일, count(e2.hiredate)-1 빠른사람
from emp e1 , emp e2
where e2.hiredate < e1.hiredate
group by e1.empno, e1.ename,e1.hiredate
order by count(e2.hiredate);



select e1.empno 사원번호, e1.ename, e1.hiredate 입사일, count(e2.hiredate) 빠른사람
from emp e1 , emp e2
where e2.hiredate(+) < e1.hiredate
group by e1.empno, e1.ename,e1.hiredate
order by count(e2.hiredate);










