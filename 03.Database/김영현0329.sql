/* 연습문제 */
-- ex01) professor, department을 join 교수번호, 교수이름, 소속학과이름 조회 View
select * from professor;  -- profno / name / deptno
select * from department; -- dname


create or replace view v_p1d1 as 
select p1.profno 교수번호, p1.name 교수이름, d1.dname 소속학과이름
  from professor p1 , department d1
where p1.deptno = d1.deptno ;

select * from v_p1d1;

-- ex02) inline view를 사용, student, department를 사용 학과별로 
-- 학생들의 최대키, 최대몸무게, 학과명을 출력
select * from student;
select * from department; 

 
select d2.dname 학과명
       ,s2.max_height 최대키
			 ,s2.max_weight 최대몸무게
from ( 
select deptno1 , max(height) max_height, max(weight) max_weight
from student
group by deptno1
) s2 , department d2 

where s2.deptno1 = d2.deptno ; 
			 
 
-- ex03) inline view를 사용, 학과명, 학과별최대키, 학과별로 가장 키가 큰 학생들의
-- 이름과 키를 출력

select d2.dname 학과명
       ,s2.max_height 최대키
			 ,s2.max_weight 최대몸무게
from ( 
select deptno1 , max(height) max_height, max(weight) max_weight
from student
group by deptno1
) s2 , department d2 

where s2.deptno1 = d2.deptno ; 



-- ex04) student에서 학생키가 동일학년의 평균키보다 큰 학생들의 학년과 이름과 키
-- 해당 학년의 평균키를 출력 단, inline view로

SELECT    d.dname "학과이름",

    a.max_height "최대키",

    s.name "학생이름",

    s.height "키" 

FROM       (

   SELECT    deptno1, 

 MAX(height) max_height

   FROM       student

   GROUP BY deptno1 

   ) a, student s, department d 

WHERE    s.deptno1 = a.deptno1 

AND        s.height = a.max_height 

AND        s.deptno1 = d.deptno ; 



-- ex05) professor에서 교수들의 급여순위와 이름, 급여출력 단, 급여순위 1~5위까지
-- create.....




-- ex06) 교수번호정렬후 3건씩해서 급여합계와 급여평균을 출력
-- hint) 
select rownum, profno, pay, ceil(rownum/3) from professor; -- rollup