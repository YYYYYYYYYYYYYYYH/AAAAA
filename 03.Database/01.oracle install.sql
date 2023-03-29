select * from dba_users; 
select * from all_users;
alter user hr account lock;
alter user hr account unlock;
select * from tab;

/*
Oracle 기본 date 형식 변경하기
*/
-- 1. 오라클 환경변수 조회하기
select * from v$nls_parameters;

-- 2. 날짜형식 변경하기
-- alter session[system] set 시스템 변수 = 변경할 값     
-- system 은 영구적 변경
alter session set NLS_DATE_FORMAT = 'YYYY.MM.DD'; -- dateformat 변경
alter session set NLS_timestamp_FORMAT = 'YYYY.MM.DD HH:MI:SS'; -- timestamp 변경

--영구적 (system 레벨)
alter system set NLS_DATE_FORMAT = 'YYYY.MM.DD'scope = spfile; -- dateformat 변경
alter system set NLS_timestamp_FORMAT = 'YYYY.MM.DD HH:MI:SS'; -- timestamp 변경

--scope
--1.both : 바로 적용됨 or 재시작 (에러 날 확률이 있다.)
--2.spfile : db 재시작 시 적용됨
--SQL command line 에서 system 사용자로 변경 후 db 재시작



select * from hr.employees;




