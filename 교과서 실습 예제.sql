-- DROP TABLE EMP;
-- DROP TABLE DEPT;
-- DROP TABLE LOCATIONS;
-- DROP TABLE SALGRADE;

CREATE TABLE DEPT(
    DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) 
); -- 여기서 ctrl + enter 누르면 실행!
-- ;이 오라클 끝문장을 가르킨다

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

-- DEPT테이블에 데이터 삽입
INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');

-- EMP테이블에 데이터 삽입
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

-- SALGRADE테이블에 데이터 삽입
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

commit; -- 확정

SELECT * FROM emp; -- 웬만하면 대문자로 적어주기


--------------------------------------------------------------------------------
-- 23p 산술 연산자 실습
select ename, sal, sal+300 from emp;
select ename, sal, 2*sal+300 from emp;
select ename, sal, 2*(sal+300) from emp;

-- 25p null값(null 관련 연산은 무조건 null)
select empno, ename, sal, comm, comm+300 from emp; -- comm에 null값이 있었던 것은 계산이 되지 않는다
-- null은 알 수 없는 값으로,  0이나 ' '와 다르다

--26p 컬럼 별칭
select ename AS name, sal, sal*12 "Annual Salary" -- 절을 구분해서도 많이 사용한다 (select 절)
FROM emp; -- (from 절)

-- 27p
select ename 결과1, 'ABCde' 결과2, sal 결과3, 500 결과4 -- 'ABCde', 500은 우리가 만들어낸 컬럼이다
from emp;
-- 별칭은 "" 상수(문자,숫자,날짜)는 ''


-- 28p 연결 연산자
select ename || ':' || empno || ':' || job "이름_사원_담당업무"
from emp;

select ename || 'is a ' || job AS "Employees Details" -- 이게 하나의 컬럼인 것
from emp;

select ename || ': 1 Year Salary = ' || sal*12 Monthly --  sal*12는 월급에다가 x12개월을 하므로써 연봉을 조회한 것
from emp;

-- select ALL * from emp;
select * from emp; -- ALL이 생력되어 있는 것


-- 30p 중복 행 제거
select distinct job from emp; -- job 컬럼을 가지고 중복 제거
select distinct deptno, job from emp; -- deptno와 job 컬럼의 값이 중복되지 않게 출력


-- 31p 의사 열
select ROWID, rownum, ename, sal
from emp
where rownum <= 3; -- =3은 값이 안나온다. 열을 읽고 rownum을 부여하는데 조건이 안맞으면 수를 증가시키지 않는다. (3이 되지가 않는 것)
-- 일단은 알아만 두기

-- 34p 비교 연산자
select empno, ename, job, sal
from emp
where job = 'MANAGER'; -- DB가 한 라인 씩 읽어서 조건에 맞는 행을 보여준는 것

select empno, ename, job, sal
from emp
where job = 'Manger'; -- 실제 데이터는 전부 대문자로 저장되어 있기 때문에 대소문자를 꼭 구분해야한다!

select empno, ename, job, sal
from emp
where sal >= 3000;


select empno, ename, job, sal, deptno
from emp
where deptno != 30;

select empno, ename, job, sal, deptno
from emp
where deptno <> 30;

select empno, ename, job, sal, deptno
from emp
where deptno ^= 30;
-- 같지 않다는 연산자 (값은 전부 같음)


-- 36p 비교 연산자2
select ename, job, sal, deptno
from empdk
where sal BETWEEN 1300 AND 1700;
-- sal >= 1300 AND sal <= 1700

select ename, job, sal, deptno
from emp
where sal BETWEEN 1700 AND 1300; -- sal >= 1700 AND sal <= 1300 이라는 조건이니 성립X

select empno, ename, job, sal, hiredate
from emp
where empno IN (7902, 7788, 7566); -- emp 테이블의 데이터 중에서 empno값이 7902, 7788, 7566인 것을 조회 / TRUE 리턴

select empno, ename, job, sal, hiredate
from emp
where empno = 7902 OR empno = 7788 OR empno = 7566; -- 위 코드와 같은 결과 값이지만 깔끔하지 못함

select ename, sal, job
from emp
where ename LIKE '_A%'; -- wildcard 사용 (ename값 중 두번째 글짜가 A인 데이터를 조회 / TRUE 리턴)
-- (_는 1글자, %는 여러개)

select ename, sal, job
from emp
where ename LIKE '%A%'; -- wildcard 사용 (ename값 중 A가 포함된 데이터를 조회 / TRUE 리턴)

select empno, ename, job, sal, comm, deptno
from emp
where comm IS NULL; -- comm = null으로 작성XX (null을 포함한 연산은 무조건 null이기 때문에)


-- 39p 논리 연산자
select empno, ename, job, sal, deptno
from emp
where sal >= 2800 and job = 'MANAGER'; -- 꼭 대문자로 작성하기! (데이터는 대소문자를 구별한다)

select empno, ename, job, sal, deptno
from emp
where sal >= 2800 or job = 'MANAGER'; 


-- 40p NOT 연산자
select empno, ename, job, sal, deptno
from emp
where job NOT IN ('MANAGER','CLERK','ANALYST');

select ename, sal,job
from emp
where sal NOT BETWEEN 1000 AND 3000;

select ename, sal, deptno
from emp
where ename NOT LIKE 'A%'; -- A문자로 시작하지 않는 사원 출력

select ename, sal, comm, deptno
from emp
where comm IS NOT NULL; -- NOT IS NULL(x) IS NOT NULL(o) 

select ename, sal, comm, deptno
from emp
where (NVL(comm, 0) = 0); -- NVL(comm, 0)에서 comm이 NULL이면 0으로 값을 변경해라

-- 42p 연산자 우선 순위
select empno, ename, job, sal
from emp
where sal > 1500 AND job = 'PRESIDENT' OR job = 'SALESMAN';

select empno, ename, job, sal
from emp
where sal > 1500 AND (job = 'PRESIDENT' OR job = 'SALESMAN');

select empno, ename, job, sal
from emp
where sal > 1500 AND job IN('PRESIDENT', 'SALESMAN'); -- IN 연산자를 많이 사용한다


-- 44p 데이터 정렬
select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate; -- 입사일자가 빠른 사원이 먼저 나오도록

select empno, ename, job, sal, deptno
from emp
ORDER BY hiredate;  -- select절에서 지워도 입사일자를 기준으로 정렬이 된다

select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate DESC; -- 최근 날짜 순으로

select empno, ename, job, deptno, sal
from emp
ORDER BY deptno ASC, sal DESC; -- 부서번호는 오름차순(ASC)으로, 급여는 내림차순(DESC)


-- 46p 예제
select empno, ename, job, deptno, sal
from emp
ORDER BY deptno, sal DESC; -- ASC가 기본

select empno, ename, job, deptno, sal -- empno 컬럼은 1번, ename 컬럼은 2번...
from emp
ORDER BY 4; -- 4번을 기준으로 ASC 정렬

select empno, ename, job, deptno, sal -- empno 컬럼은 1번, ename 컬럼은 2번...
from emp
ORDER BY 4, 5 desc; -- 4번 컬럼은 ASC 정렬, 5번 컬럼은 DESC 정렬

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY ANN_SAL; -- ANN_SAL, 별칭을 정렬의 기준으로 사용할 수 있다

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY sal*12; -- 위와 같은 결과가 나온다

-- 47p
select DISTINCT deptno, job
from emp
order by job; -- 업무를 기준으로 오름차순

select DISTINCT deptno, job
from emp
order by sal; -- DISTINCT를 사용할 경우에는 select 절에 있는 컬럼만 정렬 가능하다 / 오류 발생

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY deptno; -- DISTINCT를 사용하지 않으면 emp 테이블에 있는 모든 컬럼을 정렬 기준으로 사용할 수 있다

select DISTINCT job, sal+comm
from emp
order by sal; -- sal+comm을 묶어 하나의 컬럼으로 보므로 sal 컬럼은 정렬 기준으로 사용할 수 없다

select DISTINCT job, sal+comm
from emp
order by 2; -- 이런 경우는 가능! 


-- 54p 문자 함수1
select empno, ename, job, LOWER(job), UPPER(job),INITCAP(job) -- LOWER 모두 소문자, UPPER 모두 대문자, INITCAP 첫글자가 대문자
from emp
where deptno = 10;

select empno, ename, job, 
       CONCAT(empno,ename) e_ename,    
       CONCAT(ename, empno) e_empno,
       CONCAT(ename, job) e_job  -- CONCAT(ename, job)은 ename과 job을 연결해서 하나의 컬럼을 만드는 것
from emp
where deptno = 10;

-- 예제3(시험문제 자주 낸다)
select empno, ename, job, sal, deptno
from emp
where SUBSTR(ename, 1, 1) > 'K' AND SUBSTR(ename, 1,1)  < 'Y'; -- (ename, 1, 1)은 ename의 값에서 첫번째 문자 1개를 반환한다
-- 이름의 첫글자를 가져와서 K보다 작고, Y보다 크면 출력

select empno, ename, length(ename), sal, length(sal) -- ename과 sal의 글자 길이를 출력
from emp
where deptno = 20;

select ename, 
       instr(ename,'L') e_null, -- instr(ename, 'L',1,1)에서 1,1이 생략된 것
       instr(ename, 'L',1,1) e_11,
       -- ename의 문자열 데이터 1(첫번째)값에서 'L'를 검색하여 처음 'L'이 나오는 위치를 반환
       instr(ename,'L',1,2) e_12,
       -- ename의 문자열 데이터 1(첫번째)값에서 'L'를 검색하여 'L'이 2번째 나오는 위치를 반환
       instr(ename, 'L',4,1) e_41
       -- ename의 문자열 데이터 4(네번째)값에서 'L'를 검색하여 처음 'L'이 나오는 위치를 반환
from emp
ORDER BY ename;

-- 한글 : 오라클에서 utf-8로 되어있다(한 글자가 3byte)
select parameter, value
from NLS_DATABASE_PARAMETERS
where parameter = 'NLS_CHARACTERSET';

select substrB('I am here with you', 5,3) 결과1, -- 공백 포함 5번째 위치부터 3글자 가져오기 (영문은 한 글자가 1byte)
       substr('나 여기 있어',5,3) 결과2,  -- 공백 포함 5번째 위치 부터 3글자 가져오기
       substrB('나 여기 있어',5,3) 결과3, -- 한글은 한 글자가 3byte, 공백은 1byte임. byte 기준이니 5번째 byte부터 3byte 뒤인 '여'가 출력
       substrB('나 여기 있어',5,4) 결과4,
       substrB('나 여기 있어',5,5) 결과5,
       substrB('나 여기 있어',5,6) 결과6  -- byte 기준이니 5번째 byte부터 6byte 뒤인 '여기'가 출력
from dual; -- dual은 오라클에서 제공하는 가상 테이블이다 (많이 사용한다)

select ename, 
       substr(ename, 1,3), -- ename의 1번째부터 포함해 3개의 문자열을 반환
       substr(ename, 3),   -- ename의 3번째부터 포함해 끝까지의 문자열을 반환
       substr(ename, -3, 2)  -- ename의 맨 오른쪽의 3번째부터 포함해 2개의 문자열을 반환
from emp
where deptno = 10;


-- 58p 문자 함수2
select ename, 
       lpad(ename, 15, '*'), -- 15자리로 출력하고 왼쪽 빈공간을 *로 채우기
       sal, 
       lpad(sal, 10, '&')    -- 10자리로 출력하고 왼쪽 빈공간을 &로 채우기
from emp
where deptno = 10;

select ename, 
       rpad(ename, 15, '*'), -- 15자리로 출력하고 오른쪽 빈공간을 *로 채우기
       sal, 
       rpad(sal, 10, '&')    -- 10자리로 출력하고 오른쪽 빈공간을 &로 채우기
from emp
where deptno = 10;

select ename, job, LTRIM(job, 'A'), sal, LTRIM(sal,1) -- job의 왼쪽에 A를 삭제, sal의 왼쪽에 1을 삭제(연속인 경우도)
from emp
where deptno = 20;
-- LTRIM(job, 'A'), 담당업무 데이터 맨 왼쪽에 'A' 문자가 있으면 삭제
-- LTRIM(sal, 1), 급여 데이터 맨 왼쪽에 1이 있으면 삭제(연속적으로 있으면 전부 삭제)

select ename, job, RTRIM(job, 'T'), sal, RTRIM(sal, 0) -- job의 오른쪽에 T를 삭제, job의 오른족에 0을 삭제
from emp
where deptno = 10;

select ename, REPLACE(ename, 'SC','*?') 변경결과 -- ename 데이터 중에서 'SC' 문자열이 포함되어 있으면 *?로 변경해서 조회
from emp
where deptno = 20;
-- REPLACE은 문자열 'SC'를 비교해서 모든 문자열이 같은 경우에만 변경

select ename, TRANSLATE(ename, 'SC', '*?') 변경결과2 -- ename 데이터가 'S'나 'C' 문자열이 포함되어 있으면 각각 '*', '?'로 변경해서 조회
from emp
where deptno = 20; 
-- TRANSLATE은 문자열 'S','C'를 비교해서 각 문자열이 같으면 변경


-- 61p (4/4 수업)
select TRIM(LEADING 'A' FROM 'AABDCADD') 결과1, -- 문자열 왼쪽에 있는 'A'를 전부 제거
       TRIM('A' FROM 'AABDCADD') 결과2, -- 문자열 양쪽에 있는 'A'를 전부 제거 (오른쪽에는 'A'가 없으니 위와 결과가 같다)
       TRIM(TRAILING 'D' FROM 'AABDCADD') 결과3 -- 문자열 오른쪽에 있는 'D'를 전부 제거 
FROM DUAL;

select empno, ename, 
       translate(ename, 'ABCDEFGHIJKLMNOP', 'abcdefghijklmnop') u_lower  -- 대문자를 소문자로 바꾸는 문장
from emp
where deptno = 10;

select empno, ename, 
       lower(ename) u_lower  -- LOWER을 사용해서 출력해도 결과는 같다
from emp
where deptno = 10;

-- 62p 숫자 함수
select round(4567.678) 결과1,   -- 소수점 바로 뒤에서 반올림
       round(4567.678,0) 결과2, -- 소수점 바로 뒤에서 반올림
       round(4567.678,2) 결과3, -- 뒤 2자리까지 반올림 후 표현
       round(4567.678,-2) 결과4 -- 앞 2자리까지만 반올림 후 표현
from dual;

select trunc(4567.678) 결과1,   -- 소수점 바로 뒤에서 버림
       trunc(4567.678,0) 결과2, -- 소수점 바로 뒤에서 버림
       trunc(4567.678,2) 결과3, -- 뒤 2자리까지 표현
       trunc(4567.678,-2) 결과4 -- 앞 2자리까지만 표현
from dual;

select power(2,10) 결과1, -- 2의 10승
       ceil(3.7) 결과2,   -- 소수점 이하 첫째 자리 올림(4)
       floor(3.7) 결과3   -- 소수점 이하 첫째 자리 내림(3)
from dual;

-- mod : 나머지 / 급여를 30으로 나눈 나머지 출력
select sal, mod(sal,30) 
from emp
where deptno = 10;

-- sign : 숫자가 양수이면 1, 음수이면 -1, 0이면 0 출력
select ename, sal, sign(sal-2975) 
from emp
where deptno = 20;

-- 65p 날짜 계산 함수
select SYSDATE -- 현재 날짜 및 시간을 반환
from dual;

select SYSTIMESTAMP -- 현재 날짜와 시간을 SYSTIMESTAMP 데이터 유형의 값으로 반환
from dual;

select value -- 오라클 날짜 형식을 조회
from NLS_SESSION_PARAMETERS
where parameter = 'NLS_DATE_FORMAT';

select ename, hiredate, hiredate + 3, hiredate + 5/24 -- hiredate + 5/24는 해당 시간을 더해서 날짜 형태로 출력하는 것
from emp
where deptno = 30;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; -- 날짜 형식 변경(HH24는 24시로, 보통 12시)

-- 66p
select ename, hiredate, sysdate, sysdate-hiredate "Total Days",
       trunc((sysdate-hiredate)/7,0) Weeks,
       round(mod((sysdate-hiredate),7),0) DAYS
from emp
ORDER BY sysdate-hiredate desc;

-- EXTRACT 함수 : 필드의 값을 숫자로 표현
select extract(day from sysdate) 일자, -- SYSDATE는 현재 날짜와 시간 반환
       extract(month from sysdate) 월,
       extract(year from sysdate) 년도
from dual;

