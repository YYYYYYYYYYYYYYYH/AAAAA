-- 연습문제
-- ex01) student에서 jumin에 월참조해서 해당월의 분기를 출력(1Q, 2Q, 3Q, 4Q)
-- name, jumin, 분기 

select * from student;
select name, jumin     
		 , case when substr(jumin,3,2) between 1 and 3  then '1Q'
				    when substr(jumin,3,2) between 4 and 6 then '2Q'
				    when substr(jumin,3,2) between 7 and 9 then '3Q' 
				    when substr(jumin,3,2) between 10 and 12 then '4Q' 
				end
from student;




-- ex02) dept에서 10=회계부, 20=연구실, 30=영업부, 40=전산실
-- 1) decode
select * from dept;
select deptno
		  , decode(deptno,10,'회계부',20,'연구실',30,'영업부',40,'전산실')
from dept;

-- 2) case
select deptno
       ,case deptno
			 when 10 then '회계부'
			 when 20 then '연구실'
			 when 30 then '영업부'
			 when 40 then '전산실'
			 end 
from dept;




-- deptno, 부서명
-- ex03) 급여인상율을 다르게 적용하기
-- emp에서 sal < 1000 0.8%인상, 1000~2000 0.5%, 2001~3000 0.3%
-- 그 이상은 0.1% 인상분 출력
-- ename, sal(인상전급여), 인상후급여 
-- sign () : 값이 음수 양수 결과를 -1 0 1 
select * from emp;
-- 1) decode
select ename , sal
       ,decode(sign(sal-1000),-1,sal*1.008 ,0,sal*1.005
			 ,1, decode(sign(sal-2000),-1, sal*1.005,0,sal*1.005
			 ,1,decode(sign(sal-3000),-1,sal*1.003	,0,sal*1.003	,1,sal*1.001)))
from emp;



-- 2) case 


select ename , sal
    , case when sal < 1000 then sal*1.008
				   when sal between 1000 and 2000 then sal*1.005 
					 when sal between 2001 and 3000 then sal*1.003 
					 when sal > 3000 then sal*1.001 
			end
from emp;

