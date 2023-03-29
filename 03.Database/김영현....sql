/* 연습문제 */
-- 1. emp 테이블을 사용하여 사원 중에서 급여(sal)와 보너스(comm)를 합친 금액이 가장 많은 경우와 
--    가장 적은 경우 , 평균 금액을 구하세요. 단 보너스가 없을 경우는 보너스를 0 으로 계산하고 
--    출력 금액은 모두 소수점 첫째 자리까지만 나오게 하세요
-- MAX, MIN, AVG
select * from emp;
select  min(sal+nvl(comm,0)) 최저급여
       ,max (sal+nvl(comm,0)) 최대급여
			 ,round(avg (sal+nvl(comm,0)),1)		 
from emp;


-- 2. student 테이블의 birthday 컬럼을 참조해서 월별로 생일자수를 출력하세요
-- TOTAL, JAN, ...,  5 DEC
--  20EA   3EA ....
select * from student;
select count (*)||'EA' TOTAL
     , count(decode(BB, '01', 1)) ||'EA' JAN 
		 , count(decode(BB, '02', 1)) ||'EA' FEB
		 , count(decode(BB, '03', 1)) ||'EA' MAR
		 , count(decode(BB, '04', 1)) ||'EA' APR
		 , count(decode(BB, '05', 1)) ||'EA' MAY
		 , count(decode(BB, '06', 1)) ||'EA' JUN
		 , count(decode(BB, '07', 1)) ||'EA' JUL
		 , count(decode(BB, '08', 1)) ||'EA' AUG
		 , count(decode(BB, '09', 1)) ||'EA' SEP
		 , count(decode(BB, '10', 1)) ||'EA' OCT
		 , count(decode(BB, '11', 1)) ||'EA' NOV
		 , count(decode(BB, '12', 1)) ||'EA' DEC
		 
 from(select to_char(birthday, 'MM') BB
             from student);
						 
--------------------------------------------------------------------------------						 
select count  (to_char(birthday, 'MM')) || 'EA' 
,count(decode(to_char(birthday, 'MM'),'01',0)) || 'EA' JAN 
from student;
						 




-- 3. Student 테이블의 tel 컬럼을 참고하여 아래와 같이 지역별 인원수를 출력하세요.
--    단, 02-SEOUL, 031-GYEONGGI, 051-BUSAN, 052-ULSAN, 053-DAEGU, 055-GYEONGNAM
--    으로 출력하세요
select * from student;
select 
       count(decode(T1, '02', 1))   SEOUL
     , count(decode(T1, '031', 1))  GYEONGGI
     , count(decode(T1, '051', 1))  BUSAN
     , count(decode(T1, '052', 1))  ULSAN
     , count(decode(T1, '053', 1))  DAEGU
     , count(decode(T1, '055', 1))  GYEONGNAM
  from(select substr (tel, 1, instr(tel, ')')-1) T1 from student);
 ----------------------------------------------------
 



-- 4. emp 테이블을 사용하여 직원들의 급여와 전체 급여의 누적 급여금액을 출력,
-- 단 급여를 오름차순으로 정렬해서 출력하세요.
-- sum() over()
select * from emp;
select sal
		 , sum(sal) over(order by sal) 
  from emp;
	
	


-- 6. student 테이블의 Tel 컬럼을 사용하여 아래와 같이 지역별 인원수와 전체대비 차지하는 비율을 
--    출력하세요.(단, 02-SEOUL, 031-GYEONGGI, 051-BUSAN, 052-ULSAN, 053-DAEGU,055-GYEONGNAM)

select T2, count(*), ratio_to_report (count(*)) over ()*100
from(select decode(substr(tel,1,instr(tel,')')-1), '02', 'SEOUL', '031', 'GYEONGGI', '051', 'BUSAN', '052', 'ULSAN', '052', 'ULSAN', '055', 'GYENGNAM', 'ETC') T2
from student)
group by T2 ;



       
-- 7. emp 테이블을 사용하여 부서별로 급여 누적 합계가 나오도록 출력하세요. 
-- ( 단 부서번호로 오름차순 출력하세요. )
select deptno , sum(sal) over (order by deptno) from emp;



-- 8. emp 테이블을 사용하여 각 사원의 급여액이 전체 직원 급여총액에서 몇 %의 비율을 
--    차지하는지 출력하세요. 단 급여 비중이 높은 사람이 먼저 출력되도록 하세요
select ename ,sal , round(ratio_to_report(sum(sal)) over()*100,0) "급여%"
from emp
group by ename,sal
order by sal desc;
   

-- 9. emp 테이블을 조회하여 각 직원들의 급여가 해당 부서 합계금액에서 몇 %의 비중을
--     차지하는지를 출력하세요. 단 부서번호를 기준으로 오름차순으로 출력하세요.
select ename ,sal , deptno 
      , round(ratio_to_report(sum(sal)) over(partition by deptno )*100,0) "비중%"

from emp group by ename,sal,deptno;
