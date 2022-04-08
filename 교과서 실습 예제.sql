-- DROP TABLE EMP;
-- DROP TABLE DEPT;
-- DROP TABLE LOCATIONS;
-- DROP TABLE SALGRADE;

CREATE TABLE DEPT(
    DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) 
); -- ���⼭ ctrl + enter ������ ����!
-- ;�� ����Ŭ �������� ����Ų��

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

-- DEPT���̺� ������ ����
INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');

-- EMP���̺� ������ ����
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

-- SALGRADE���̺� ������ ����
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

commit; -- Ȯ��

SELECT * FROM emp; -- �����ϸ� �빮�ڷ� �����ֱ�


--------------------------------------------------------------------------------
-- 23p ��� ������ �ǽ�
select ename, sal, sal+300 from emp;
select ename, sal, 2*sal+300 from emp;
select ename, sal, 2*(sal+300) from emp;

-- 25p null��(null ���� ������ ������ null)
select empno, ename, sal, comm, comm+300 from emp; -- comm�� null���� �־��� ���� ����� ���� �ʴ´�
-- null�� �� �� ���� ������,  0�̳� ' '�� �ٸ���

--26p �÷� ��Ī
select ename AS name, sal, sal*12 "Annual Salary" -- ���� �����ؼ��� ���� ����Ѵ� (select ��)
FROM emp; -- (from ��)

-- 27p
select ename ���1, 'ABCde' ���2, sal ���3, 500 ���4 -- 'ABCde', 500�� �츮�� ���� �÷��̴�
from emp;
-- ��Ī�� "" ���(����,����,��¥)�� ''


-- 28p ���� ������
select ename || ':' || empno || ':' || job "�̸�_���_������"
from emp;

select ename || 'is a ' || job AS "Employees Details" -- �̰� �ϳ��� �÷��� ��
from emp;

select ename || ': 1 Year Salary = ' || sal*12 Monthly --  sal*12�� ���޿��ٰ� x12������ �ϹǷν� ������ ��ȸ�� ��
from emp;

-- select ALL * from emp;
select * from emp; -- ALL�� ���µǾ� �ִ� ��


-- 30p �ߺ� �� ����
select distinct job from emp; -- job �÷��� ������ �ߺ� ����
select distinct deptno, job from emp; -- deptno�� job �÷��� ���� �ߺ����� �ʰ� ���


-- 31p �ǻ� ��
select ROWID, rownum, ename, sal
from emp
where rownum <= 3; -- =3�� ���� �ȳ��´�. ���� �а� rownum�� �ο��ϴµ� ������ �ȸ����� ���� ������Ű�� �ʴ´�. (3�� ������ �ʴ� ��)
-- �ϴ��� �˾Ƹ� �α�

-- 34p �� ������
select empno, ename, job, sal
from emp
where job = 'MANAGER'; -- DB�� �� ���� �� �о ���ǿ� �´� ���� �����ش� ��

select empno, ename, job, sal
from emp
where job = 'Manger'; -- ���� �����ʹ� ���� �빮�ڷ� ����Ǿ� �ֱ� ������ ��ҹ��ڸ� �� �����ؾ��Ѵ�!

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
-- ���� �ʴٴ� ������ (���� ���� ����)


-- 36p �� ������2
select ename, job, sal, deptno
from empdk
where sal BETWEEN 1300 AND 1700;
-- sal >= 1300 AND sal <= 1700

select ename, job, sal, deptno
from emp
where sal BETWEEN 1700 AND 1300; -- sal >= 1700 AND sal <= 1300 �̶�� �����̴� ����X

select empno, ename, job, sal, hiredate
from emp
where empno IN (7902, 7788, 7566); -- emp ���̺��� ������ �߿��� empno���� 7902, 7788, 7566�� ���� ��ȸ / TRUE ����

select empno, ename, job, sal, hiredate
from emp
where empno = 7902 OR empno = 7788 OR empno = 7566; -- �� �ڵ�� ���� ��� �������� ������� ����

select ename, sal, job
from emp
where ename LIKE '_A%'; -- wildcard ��� (ename�� �� �ι�° ��¥�� A�� �����͸� ��ȸ / TRUE ����)
-- (_�� 1����, %�� ������)

select ename, sal, job
from emp
where ename LIKE '%A%'; -- wildcard ��� (ename�� �� A�� ���Ե� �����͸� ��ȸ / TRUE ����)

select empno, ename, job, sal, comm, deptno
from emp
where comm IS NULL; -- comm = null���� �ۼ�XX (null�� ������ ������ ������ null�̱� ������)


-- 39p �� ������
select empno, ename, job, sal, deptno
from emp
where sal >= 2800 and job = 'MANAGER'; -- �� �빮�ڷ� �ۼ��ϱ�! (�����ʹ� ��ҹ��ڸ� �����Ѵ�)

select empno, ename, job, sal, deptno
from emp
where sal >= 2800 or job = 'MANAGER'; 


-- 40p NOT ������
select empno, ename, job, sal, deptno
from emp
where job NOT IN ('MANAGER','CLERK','ANALYST');

select ename, sal,job
from emp
where sal NOT BETWEEN 1000 AND 3000;

select ename, sal, deptno
from emp
where ename NOT LIKE 'A%'; -- A���ڷ� �������� �ʴ� ��� ���

select ename, sal, comm, deptno
from emp
where comm IS NOT NULL; -- NOT IS NULL(x) IS NOT NULL(o) 

select ename, sal, comm, deptno
from emp
where (NVL(comm, 0) = 0); -- NVL(comm, 0)���� comm�� NULL�̸� 0���� ���� �����ض�

-- 42p ������ �켱 ����
select empno, ename, job, sal
from emp
where sal > 1500 AND job = 'PRESIDENT' OR job = 'SALESMAN';

select empno, ename, job, sal
from emp
where sal > 1500 AND (job = 'PRESIDENT' OR job = 'SALESMAN');

select empno, ename, job, sal
from emp
where sal > 1500 AND job IN('PRESIDENT', 'SALESMAN'); -- IN �����ڸ� ���� ����Ѵ�


-- 44p ������ ����
select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate; -- �Ի����ڰ� ���� ����� ���� ��������

select empno, ename, job, sal, deptno
from emp
ORDER BY hiredate;  -- select������ ������ �Ի����ڸ� �������� ������ �ȴ�

select empno, ename, job, sal, hiredate, deptno
from emp
ORDER BY hiredate DESC; -- �ֱ� ��¥ ������

select empno, ename, job, deptno, sal
from emp
ORDER BY deptno ASC, sal DESC; -- �μ���ȣ�� ��������(ASC)����, �޿��� ��������(DESC)


-- 46p ����
select empno, ename, job, deptno, sal
from emp
ORDER BY deptno, sal DESC; -- ASC�� �⺻

select empno, ename, job, deptno, sal -- empno �÷��� 1��, ename �÷��� 2��...
from emp
ORDER BY 4; -- 4���� �������� ASC ����

select empno, ename, job, deptno, sal -- empno �÷��� 1��, ename �÷��� 2��...
from emp
ORDER BY 4, 5 desc; -- 4�� �÷��� ASC ����, 5�� �÷��� DESC ����

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY ANN_SAL; -- ANN_SAL, ��Ī�� ������ �������� ����� �� �ִ�

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY sal*12; -- ���� ���� ����� ���´�

-- 47p
select DISTINCT deptno, job
from emp
order by job; -- ������ �������� ��������

select DISTINCT deptno, job
from emp
order by sal; -- DISTINCT�� ����� ��쿡�� select ���� �ִ� �÷��� ���� �����ϴ� / ���� �߻�

select empno, sal, sal*12 ANN_SAL
from emp
ORDER BY deptno; -- DISTINCT�� ������� ������ emp ���̺� �ִ� ��� �÷��� ���� �������� ����� �� �ִ�

select DISTINCT job, sal+comm
from emp
order by sal; -- sal+comm�� ���� �ϳ��� �÷����� ���Ƿ� sal �÷��� ���� �������� ����� �� ����

select DISTINCT job, sal+comm
from emp
order by 2; -- �̷� ���� ����! 


-- 54p ���� �Լ�1
select empno, ename, job, LOWER(job), UPPER(job),INITCAP(job) -- LOWER ��� �ҹ���, UPPER ��� �빮��, INITCAP ù���ڰ� �빮��
from emp
where deptno = 10;

select empno, ename, job, 
       CONCAT(empno,ename) e_ename,    
       CONCAT(ename, empno) e_empno,
       CONCAT(ename, job) e_job  -- CONCAT(ename, job)�� ename�� job�� �����ؼ� �ϳ��� �÷��� ����� ��
from emp
where deptno = 10;

-- ����3(���蹮�� ���� ����)
select empno, ename, job, sal, deptno
from emp
where SUBSTR(ename, 1, 1) > 'K' AND SUBSTR(ename, 1,1)  < 'Y'; -- (ename, 1, 1)�� ename�� ������ ù��° ���� 1���� ��ȯ�Ѵ�
-- �̸��� ù���ڸ� �����ͼ� K���� �۰�, Y���� ũ�� ���

select empno, ename, length(ename), sal, length(sal) -- ename�� sal�� ���� ���̸� ���
from emp
where deptno = 20;

select ename, 
       instr(ename,'L') e_null, -- instr(ename, 'L',1,1)���� 1,1�� ������ ��
       instr(ename, 'L',1,1) e_11,
       -- ename�� ���ڿ� ������ 1(ù��°)������ 'L'�� �˻��Ͽ� ó�� 'L'�� ������ ��ġ�� ��ȯ
       instr(ename,'L',1,2) e_12,
       -- ename�� ���ڿ� ������ 1(ù��°)������ 'L'�� �˻��Ͽ� 'L'�� 2��° ������ ��ġ�� ��ȯ
       instr(ename, 'L',4,1) e_41
       -- ename�� ���ڿ� ������ 4(�׹�°)������ 'L'�� �˻��Ͽ� ó�� 'L'�� ������ ��ġ�� ��ȯ
from emp
ORDER BY ename;

-- �ѱ� : ����Ŭ���� utf-8�� �Ǿ��ִ�(�� ���ڰ� 3byte)
select parameter, value
from NLS_DATABASE_PARAMETERS
where parameter = 'NLS_CHARACTERSET';

select substrB('I am here with you', 5,3) ���1, -- ���� ���� 5��° ��ġ���� 3���� �������� (������ �� ���ڰ� 1byte)
       substr('�� ���� �־�',5,3) ���2,  -- ���� ���� 5��° ��ġ ���� 3���� ��������
       substrB('�� ���� �־�',5,3) ���3, -- �ѱ��� �� ���ڰ� 3byte, ������ 1byte��. byte �����̴� 5��° byte���� 3byte ���� '��'�� ���
       substrB('�� ���� �־�',5,4) ���4,
       substrB('�� ���� �־�',5,5) ���5,
       substrB('�� ���� �־�',5,6) ���6  -- byte �����̴� 5��° byte���� 6byte ���� '����'�� ���
from dual; -- dual�� ����Ŭ���� �����ϴ� ���� ���̺��̴� (���� ����Ѵ�)

select ename, 
       substr(ename, 1,3), -- ename�� 1��°���� ������ 3���� ���ڿ��� ��ȯ
       substr(ename, 3),   -- ename�� 3��°���� ������ �������� ���ڿ��� ��ȯ
       substr(ename, -3, 2)  -- ename�� �� �������� 3��°���� ������ 2���� ���ڿ��� ��ȯ
from emp
where deptno = 10;


-- 58p ���� �Լ�2
select ename, 
       lpad(ename, 15, '*'), -- 15�ڸ��� ����ϰ� ���� ������� *�� ä���
       sal, 
       lpad(sal, 10, '&')    -- 10�ڸ��� ����ϰ� ���� ������� &�� ä���
from emp
where deptno = 10;

select ename, 
       rpad(ename, 15, '*'), -- 15�ڸ��� ����ϰ� ������ ������� *�� ä���
       sal, 
       rpad(sal, 10, '&')    -- 10�ڸ��� ����ϰ� ������ ������� &�� ä���
from emp
where deptno = 10;

select ename, job, LTRIM(job, 'A'), sal, LTRIM(sal,1) -- job�� ���ʿ� A�� ����, sal�� ���ʿ� 1�� ����(������ ��쵵)
from emp
where deptno = 20;
-- LTRIM(job, 'A'), ������ ������ �� ���ʿ� 'A' ���ڰ� ������ ����
-- LTRIM(sal, 1), �޿� ������ �� ���ʿ� 1�� ������ ����(���������� ������ ���� ����)

select ename, job, RTRIM(job, 'T'), sal, RTRIM(sal, 0) -- job�� �����ʿ� T�� ����, job�� �������� 0�� ����
from emp
where deptno = 10;

select ename, REPLACE(ename, 'SC','*?') ������ -- ename ������ �߿��� 'SC' ���ڿ��� ���ԵǾ� ������ *?�� �����ؼ� ��ȸ
from emp
where deptno = 20;
-- REPLACE�� ���ڿ� 'SC'�� ���ؼ� ��� ���ڿ��� ���� ��쿡�� ����

select ename, TRANSLATE(ename, 'SC', '*?') ������2 -- ename �����Ͱ� 'S'�� 'C' ���ڿ��� ���ԵǾ� ������ ���� '*', '?'�� �����ؼ� ��ȸ
from emp
where deptno = 20; 
-- TRANSLATE�� ���ڿ� 'S','C'�� ���ؼ� �� ���ڿ��� ������ ����


-- 61p (4/4 ����)
select TRIM(LEADING 'A' FROM 'AABDCADD') ���1, -- ���ڿ� ���ʿ� �ִ� 'A'�� ���� ����
       TRIM('A' FROM 'AABDCADD') ���2, -- ���ڿ� ���ʿ� �ִ� 'A'�� ���� ���� (�����ʿ��� 'A'�� ������ ���� ����� ����)
       TRIM(TRAILING 'D' FROM 'AABDCADD') ���3 -- ���ڿ� �����ʿ� �ִ� 'D'�� ���� ���� 
FROM DUAL;

select empno, ename, 
       translate(ename, 'ABCDEFGHIJKLMNOP', 'abcdefghijklmnop') u_lower  -- �빮�ڸ� �ҹ��ڷ� �ٲٴ� ����
from emp
where deptno = 10;

select empno, ename, 
       lower(ename) u_lower  -- LOWER�� ����ؼ� ����ص� ����� ����
from emp
where deptno = 10;

-- 62p ���� �Լ�
select round(4567.678) ���1,   -- �Ҽ��� �ٷ� �ڿ��� �ݿø�
       round(4567.678,0) ���2, -- �Ҽ��� �ٷ� �ڿ��� �ݿø�
       round(4567.678,2) ���3, -- �� 2�ڸ����� �ݿø� �� ǥ��
       round(4567.678,-2) ���4 -- �� 2�ڸ������� �ݿø� �� ǥ��
from dual;

select trunc(4567.678) ���1,   -- �Ҽ��� �ٷ� �ڿ��� ����
       trunc(4567.678,0) ���2, -- �Ҽ��� �ٷ� �ڿ��� ����
       trunc(4567.678,2) ���3, -- �� 2�ڸ����� ǥ��
       trunc(4567.678,-2) ���4 -- �� 2�ڸ������� ǥ��
from dual;

select power(2,10) ���1, -- 2�� 10��
       ceil(3.7) ���2,   -- �Ҽ��� ���� ù° �ڸ� �ø�(4)
       floor(3.7) ���3   -- �Ҽ��� ���� ù° �ڸ� ����(3)
from dual;

-- mod : ������ / �޿��� 30���� ���� ������ ���
select sal, mod(sal,30) 
from emp
where deptno = 10;

-- sign : ���ڰ� ����̸� 1, �����̸� -1, 0�̸� 0 ���
select ename, sal, sign(sal-2975) 
from emp
where deptno = 20;

-- 65p ��¥ ��� �Լ�
select SYSDATE -- ���� ��¥ �� �ð��� ��ȯ
from dual;

select SYSTIMESTAMP -- ���� ��¥�� �ð��� SYSTIMESTAMP ������ ������ ������ ��ȯ
from dual;

select value -- ����Ŭ ��¥ ������ ��ȸ
from NLS_SESSION_PARAMETERS
where parameter = 'NLS_DATE_FORMAT';

select ename, hiredate, hiredate + 3, hiredate + 5/24 -- hiredate + 5/24�� �ش� �ð��� ���ؼ� ��¥ ���·� ����ϴ� ��
from emp
where deptno = 30;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; -- ��¥ ���� ����(HH24�� 24�÷�, ���� 12��)

-- 66p
select ename, hiredate, sysdate, sysdate-hiredate "Total Days",
       trunc((sysdate-hiredate)/7,0) Weeks,
       round(mod((sysdate-hiredate),7),0) DAYS
from emp
ORDER BY sysdate-hiredate desc;

-- EXTRACT �Լ� : �ʵ��� ���� ���ڷ� ǥ��
select extract(day from sysdate) ����, -- SYSDATE�� ���� ��¥�� �ð� ��ȯ
       extract(month from sysdate) ��,
       extract(year from sysdate) �⵵
from dual;

