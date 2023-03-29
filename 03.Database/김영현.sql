-- 연습문제
select * from student;
-- ex01) student 테이블의 주민등록번호 에서 성별만 추출
select substr (JUMIN,7,1) as 성별 from student;
-- ex02) student 테이블의 주민등록번호 에서 월일만 추출
select substr (JUMIN,3,4) as 월일 from student;
-- ex03)70년대에 태어난 사람만 추출
select name from student where substr (JUMIN,1,2) >=70 and substr (JUMIN,1,2) < 80 ;
-- ex04) student 테이블에서 jumin컬럼을 사용, 1전공이 101번인 학생들의
--       이름과 태어난월일, 생일 하루 전 날짜를 출력

select name "이름" , substr (JUMIN,3,4) "태어난월일" ,substr(JUMIN, 3, 2) || (substr(JUMIN,5,2)-1) "생일 하루 전 날짜" from student where deptno1 = 101;


