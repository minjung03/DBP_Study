-- ���� ����
create user mirim identified by mirim123;
grant resource, connect, dba to mirim;
commit;

-- ���̺� ����
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

-- ������ ����
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

commit; -- Ȯ��

------------------------------------
-- ��� ������
select ename, sal, sal+300
from emp;

select empno, ename, sal, comm, comm-10
from emp;

-- ��Ī (����, Ư�����ڴ� "" ó��)
select ename, sal, sal*12 "sal!"
from emp;

-- ���� ������ (||)
select ename || ':' || empno || ':' || job
from emp;

select ename || ' is a ' || job
from emp;

select ename ||' : 1 Year salary = ' || sal*12 -- ���� ��ȸ(*12����)
from emp;

-- �ߺ� ���� (distinct - select ������ �ۼ�)
select distinct job 
from emp;

select distinct deptno, job
from emp;

-- �� ������
select empno, ename, job, sal
from emp
where job = 'MANAGER';

select empno, ename, job, sal
from emp
where sal >= 3000;

select ename, sal, deptno
from emp
where deptno != 30; -- <>, ^= �� ���� ������ ǥ����

-- �� ������2
select ename, job, sal, deptno
from emp
where sal BETWEEN 1300 and 1700;

select empno, ename, job, sal, hiredate
from emp
where empno IN ('7902', '7788', '7566');

select ename, sal, job
from emp
where ename LIKE '_A%'; -- _ �ϳ��� ����, % �������� ����

select ename, sal, job
from emp
where ename LIKE '%A%';

select *
from emp
where comm IS NULL;

-- �� ������
select empno, ename, job, sal, hiredate, deptno
from emp
where sal >= 2800 AND job = 'MANAGER';

select empno, ename, job, sal, hiredate, deptno
from emp
where sal > 2800 OR job = 'MANAGER';

-- NOT ������
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

-- ���� (�������� ASC(�⺻), �������� DESC)
select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate;

select empno, ename, job, deptno, sal
from emp
ORDER BY deptno, sal desc; -- deptno�� ��������, sal�� ������������

select distinct deptno, job
from emp
ORDER BY job;

-- ���� �Լ�
select empno, ename, job, LOWER(job), INITCAP(job) -- INITCAT() : ù ���ڸ� �빮�ڷ�
from emp
where deptno = 10;

select empno, ename, job, sal, deptno
from emp
where SUBSTR(ename, 1, 1) > 'K' AND SUBSTR(ename, 1, 1) < 'Y' -- SUBSTR() : �ش� ���ڿ����� �ش� ��ġ����(1~) �ش� ������ŭ ��������
order by ename;

select empno, ename, LENGTH(ename), sal, LENGTH(sal)
from emp
where deptno = 20;

select ename, INSTR(ename, 'L') "E_NULL" -- INSTR() : �ش� ���� ��ġ ��ȯ
from emp;

-- ���� �Լ�2
select ename, job, LTRIM(job, 'A'), LTRIM(sal, 1)
from emp
where deptno = 20;

select ename, job, RTRIM(job, 'T'), RTRIM(sal, 0)
from emp
where deptno = 10;

select ename, REPLACE(ename, 'SC', '*?') -- REPLACE() : SC�� *?��
from emp
where deptno = 20;

select ename, TRANSLATE(ename, 'SC', '*?') -- TRANSLATE() : S�� *��, C�� ?��
from emp
where deptno = 20;

select ename, TRANSLATE(ename, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') ename_lower -- LOWER()�� ����ص� ���� ���
from emp;

-- ���� �Լ�
select ROUND(4567.678,2), ROUND(4567.678, -2) -- �ش� ��ġ���� �ݿø� (������ �� ����)
from dual; -- ���� ���̺�

select TRUNC(4567.678,2), TRUNC(4567.678, -2) -- �ش� ��ġ���� ����
from dual;

select POWER(2,10), CEIL(3.7) �ø�, FLOOR(3.7) ���� -- POWER(): �� ��, CEIL(): �ø�, FLOOR(): ����
from dual;

select sal, MOD(sal, 30) sal_mod -- MOD() : ������
from emp
where deptno = 10;

select ename, sal, SIGN(sal-2975) sal_sign -- ������ -1, ����� 1, 0�̸� 0
from emp
where deptno = 20;

-- ��¥ ���

-- ��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
commit;

select ename, hiredate, sysdate, 
       sysdate-hiredate "Total Days", 
       TRUNC((sysdate-hiredate)/7, 0) Weeks, -- �� ���ڸ� 7(������)�� ���� ���� 0�� �ڸ����� ����
       ROUND(MOD((sysdate-hiredate), 7),0) DAYS -- �� ���ڸ� 7�� ���� �������� 0�� �ڸ����� �ݿø�
from emp
order by sysdate-hiredate desc;

-- EXTRACT �Լ�
select EXTRACT(day from sysdate) ����, 
       EXTRACT(month from sysdate) ��, 
       EXTRACT(year from sysdate)�⵵
from dual;

select ename, hiredate,
       EXTRACT(year from hiredate) "�Ի�⵵",
       EXTRACT(month from hiredate)"�Ի� ��"
from emp;

-- ��¥ �Լ�
select ename, hiredate, sysdate, 
       MONTHS_BETWEEN(sysdate, hiredate) M_between, -- MONTHS_BETWEEN() : ��¥ ������ ���� ��
       TRUNC(MONTHS_BETWEEN(sysdate, hiredate),0) T_between -- ���� ���� ���� 0�� �ڸ����� ����
from emp
where deptno = 10;

select ename, hiredate, ADD_MONTHS(hiredate, 5) "PLUS 5 MONTH" -- ADD_MONTHS() : �� ���ϱ�
from emp
where deptno = 10;
