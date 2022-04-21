-- 계정 생성
create user mirim identified by mirim123;
grant resource, connect, dba to mirim;
commit;

-- 테이블 생성
CREATE TABLE DEPT(
    DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) 
); 

CREATE TABLE EMP(
    EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);

CREATE TABLE SALGRADE( 
    GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER 
);

CREATE TABLE LOCATIONS (
     LOC_CODE  CHAR(2) ,
     CITY      VARCHAR2(12)
) ;

-- 데이터 삽입
INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('09-12-1982','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('12-1-1983','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

commit; -- 확정

------------------------------------
-- 산술 연산자
select ename, sal, sal+300
from emp;

select empno, ename, sal, comm, comm-10
from emp;

-- 별칭 (공백, 특수문자는 "" 처리)
select ename, sal, sal*12 "sal!"
from emp;

-- 연결 연산자 (||)
select ename || ':' || empno || ':' || job
from emp;

select ename || ' is a ' || job
from emp;

select ename ||' : 1 Year salary = ' || sal*12 -- 연봉 조회(*12개월)
from emp;

-- 중복 제거 (distinct - select 다음에 작성)
select distinct job 
from emp;

select distinct deptno, job
from emp;

-- 비교 연산자
select empno, ename, job, sal
from emp
where job = 'MANAGER';

select empno, ename, job, sal
from emp
where sal >= 3000;

select ename, sal, deptno
from emp
where deptno != 30; -- <>, ^= 도 같지 않음을 표현함

-- 비교 연산자2
select ename, job, sal, deptno
from emp
where sal BETWEEN 1300 and 1700;

select empno, ename, job, sal, hiredate
from emp
where empno IN ('7902', '7788', '7566');

select ename, sal, job
from emp
where ename LIKE '_A%'; -- _ 하나의 문자, % 여러개의 문자

select ename, sal, job
from emp
where ename LIKE '%A%';

select *
from emp
where comm IS NULL;

-- 논리 연산자
select empno, ename, job, sal, hiredate, deptno
from emp
where sal >= 2800 AND job = 'MANAGER';

select empno, ename, job, sal, hiredate, deptno
from emp
where sal > 2800 OR job = 'MANAGER';

-- NOT 연산자
select empno, ename, job, sal, deptno
from emp
where job NOT IN ('MANAGER', 'CLERK', 'ANALYST');

select ename, sal, job
from emp
where sal NOT BETWEEN 1000 and 3000;

select ename, sal, deptno
from emp
where ename NOT LIKE 'A%';

select ename, sal, comm, deptno
from emp
where comm IS NOT NULL; -- NOT IS NULL (X)

-- 정렬 (오름차순 ASC(기본), 내림차순 DESC)
select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate;

select empno, ename, job, deptno, sal
from emp
ORDER BY deptno, sal desc; -- deptno는 오름차순, sal은 내림차순으로

select distinct deptno, job
from emp
ORDER BY job;

-- 문자 함수
select empno, ename, job, LOWER(job), INITCAP(job) -- INITCAT() : 첫 글자를 대문자로
from emp
where deptno = 10;

select empno, ename, job, sal, deptno
from emp
where SUBSTR(ename, 1, 1) > 'K' AND SUBSTR(ename, 1, 1) < 'Y' -- SUBSTR() : 해당 문자열에서 해당 위치부터(1~) 해당 개수만큼 가져오기
order by ename;

select empno, ename, LENGTH(ename), sal, LENGTH(sal)
from emp
where deptno = 20;

select ename, INSTR(ename, 'L') "E_NULL" -- INSTR() : 해당 문자 위치 반환
from emp;

-- 문자 함수2
select ename, job, LTRIM(job, 'A'), LTRIM(sal, 1)
from emp
where deptno = 20;

select ename, job, RTRIM(job, 'T'), RTRIM(sal, 0)
from emp
where deptno = 10;

select ename, REPLACE(ename, 'SC', '*?') -- REPLACE() : SC가 *?로
from emp
where deptno = 20;

select ename, TRANSLATE(ename, 'SC', '*?') -- TRANSLATE() : S가 *로, C가 ?로
from emp
where deptno = 20;

select ename, TRANSLATE(ename, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') ename_lower -- LOWER()을 사용해도 같은 결과
from emp;

-- 숫자 함수
select ROUND(4567.678,2), ROUND(4567.678, -2) -- 해당 위치에서 반올림 (음수는 앞 부터)
from dual; -- 가상 테이블

select TRUNC(4567.678,2), TRUNC(4567.678, -2) -- 해당 위치에서 버림
from dual;

select POWER(2,10), CEIL(3.7) 올림, FLOOR(3.7) 버림 -- POWER(): 몇 승, CEIL(): 올림, FLOOR(): 버림
from dual;

select sal, MOD(sal, 30) sal_mod -- MOD() : 나머지
from emp
where deptno = 10;

select ename, sal, SIGN(sal-2975) sal_sign -- 음수면 -1, 양수면 1, 0이면 0
from emp
where deptno = 20;

-- 날짜 계산

-- 날짜 형식 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
commit;

select ename, hiredate, sysdate, 
       sysdate-hiredate "Total Days", 
       TRUNC((sysdate-hiredate)/7, 0) Weeks, -- 총 일자를 7(일주일)로 나눈 것을 0의 자리에서 버림
       ROUND(MOD((sysdate-hiredate), 7),0) DAYS -- 총 일자를 7로 나눈 나머지를 0의 자리에서 반올림
from emp
order by sysdate-hiredate desc;

-- EXTRACT 함수
select EXTRACT(day from sysdate) 일자, 
       EXTRACT(month from sysdate) 월, 
       EXTRACT(year from sysdate)년도
from dual;

select ename, hiredate,
       EXTRACT(year from hiredate) "입사년도",
       EXTRACT(month from hiredate)"입사 월"
from emp;

-- 날짜 함수
select ename, hiredate, sysdate, 
       MONTHS_BETWEEN(sysdate, hiredate) M_between, -- MONTHS_BETWEEN() : 날짜 사이의 개월 수
       TRUNC(MONTHS_BETWEEN(sysdate, hiredate),0) T_between -- 구한 개월 수를 0의 자리에서 버림
from emp
where deptno = 10;

select ename, hiredate, ADD_MONTHS(hiredate, 5) "PLUS 5 MONTH" -- ADD_MONTHS() : 월 더하기
from emp
where deptno = 10;
