-------  4/25 ����

-- [�Ϲ� �Լ�]
select ename, sal, comm, sal+comm, sal+NVL(comm,0)
from emp
where deptno = 30;
-- sal+comm�ؼ� comm���� null �̸� null�� �ȴ�
-- NVL(comm,0)���� comm���� null�̸� 0���� ��ȯ

select ename, deptno, mgr, NVL2(mgr, mgr||' ���','������')
from emp
where deptno <> 30;
-- NVL2(mgr, mgr||'���,'������')���� mgr�� null�� �ƴϸ� mgr||'���' ��ȯ
-- null�̸� '������' ��ȯ

select ename, job, NULLIF(job, 'SALESMAN') as result
from emp
where deptno = 30;
-- NULLIF(job, 'SALESMAN')���� job�� salesman�� ������ null ��ȯ
-- ���� ������ job�� ��ȯ

select ename, comm, sal, COALESCE(comm, sal, 50) result
from emp;
-- COALESCE(comm, sal, 50) comm�� null�� �ƴϸ� comm ���
-- comm�� null�̰� sal�� null�� �ƴϸ� sal ���
-- comm�� sal�� ��� null�̸� 50�� ���

select ename, comm, sal, GREATEST(sal, comm) ���
from emp
where comm is not null;
-- GREATEST(sal, comm)���� sal�� comm �߿��� ū ���� ���(��ȯ)
-- �� �߿� �ϳ��� null�̸� null�� ��ȯ

select ename, comm, sal, LEAST(sal, comm) ���
from emp
where comm is not null;
-- LEAST(sal, comm���� sal�� comm �߿��� ���� ���� ���(��ȯ)
-- �� �߿� �ϳ��� null�̸� null�� ��ȯ

-- DECODE �Լ�
select empno, ename, sal, job,
       DECODE(job, 'ANALYST', sal*1.1, -- job�� ANALYST �̸� sal*1.1�� ���
              'CLERK', sal*1.2, -- CLERK �̸� sal*1.2�� ���
              'MANAGER', sal*1.3,  -- MANAGER �̸� sal*1.3�� ���
              'PRESIDENT', sal*1.4,  -- PRESIDENT �̸� sal*1.4�� ���
              'SALESMAN', sal*1.5, -- SALESMAN �̸� sal*1.5�� ���
              sal) ������
from emp;

select ename, sal, 
       DECODE(SIGN(sal-1000), -1, 'A', 
       -- sal���� 1000���� ������ -1�̱� ������ 'A'�� ���
       DECODE(SIGN(sal-2500), -1, 'B', 'C')) grade 
       -- sal���� 1000���� ũ�� 2500���� ������ 'B'
       -- sal���� 2500���� ũ�� 'C'�� ���
from emp;
-- SIGN(sal-1000)���� sal-1000�� ���� 0���� ũ�� 1, 0���� ������ -1, 0�̸� 0�� ���

-- CASE �Լ�
select ename, sal, 
       CASE job WHEN 'ANALYST' THEN sal*1.1
                WHEN 'CLERK' THEN sal*1.2
                WHEN 'MANAGER' THEN sal*1.3
                WHEN 'PRESIDENT' THEN sal*1.4
                WHEN 'SALESMAN' THEN sal*1.5
                ELSE sal
       END salary
from emp;


------- 5/13�� ����

-- [�׷� �Լ�] 89p
select MIN(ename), MAX(ename), MIN(hiredate), MAX(hiredate)
from emp; -- ���ڿ� ��¥ �����͵� �ּ�/�ִ밪�� ���� �� �ִ�

select ename, hiredate
from emp
order by hiredate;

select AVG(sal), MAX(sal), MIN(sal), SUM(sal)
from emp
where job = 'SALESMAN';

select COUNT(*) c1, COUNT(comm) c2, AVG(comm) c3, AVG(NVL(comm, 0)) c4 -- NVL�� comm�� null�̸� 0���� �ٲپ���
from emp;
-- COUNT(*)�� emp ���̺��� ���� ����, count(comm)�� comm���� null�� �ƴ� ������ ����, 
-- AVG(comm)�� null�� �ƴ� comm���� ���, AVG(NVL(comm, 0))�� comm���� null�̸� 0���� ��ȯ �� ���

select COUNT(deptno) c_dept, COUNT(DISTINCT deptno) c_dis, COUNT(DISTINCT job) c_job
from emp;
-- DISTINCT�� �ߺ� ����

select AVG(comm), SUM(comm)/14
from emp;

select AVG(NVL(comm, 0)), SUM(comm)/14
from emp;

select COUNT(deptno), COUNT(DISTINCT deptno), 
       SUM(deptno), SUM(DISTINCT deptno)
from emp;


-- [GROUP BY��] 95p
select deptno, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by deptno;
-- deptno���� �׷����� �����Ͽ� �׷캰�� ����, ���, �ּ�, �ִ�, ���� ���
-- count(*)�� ���� ������ �ӵ��� ���Ͻ�Ű�� ������ �ȴ�..

select deptno, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by sum(sal) desc;

/*
-- GROUP BY���� ����ϴ� �÷����� SELECT���� �־�� �Ѵ�
select job, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by sum(sal) desc;
*/

select job, count(*), trunc(avg(sal)), sum(sal)
from emp
GROUP BY job;
-- job�� �������� �׷��� ������

select job, deptno, count(*), avg(sal), sum(sal)
from emp
GROUP BY job, deptno;
-- job, deptno�� �������� �׷��� ������ (manager�� 10��, manager�� 20��...)
 
 
-- [HAVING��] 97p
select deptno, count(*), sum(sal)
from emp
GROUP BY deptno
HAVING count(*) > 4;
-- �ο��� 4���� ���� �μ��� ���Ͽ� ��ȣ, �ο���, �޿��� �� ���
 
select deptno, avg(sal), sum(sal)
from emp
GROUP BY deptno
HAVING max(sal) > 2900;
-- �޿��� �ִ� 2900 �̻��� �μ��� ���Ͽ� ��ȣ, ��� �޿�, �޿��� �� ���
-- HAVING���� ���� �÷��� SELECT���� ��� �ȴ�

select job, avg(sal), sum(sal)
from emp
GROUP BY job
HAVING avg(sal) >= 3000;


-- 5/16�� ����

select deptno, SUM(sal)
from emp
GROUP BY deptno 
HAVING SUM(sal) > 10000
AND deptno IN(20,30);

select deptno, SUM(sal)
from emp
where job = 'CLERK'
GROUP BY deptno
HAVING AVG(sal) >= 1000;

select deptno,  AVG(sal)
from emp
GROUP BY deptno
HAVING AVG(sal) > 1000
AND job = 'CLERK'; -- job�� �׷����� ������ �÷��� �ƴϱ� ������ having������ ��� �� ���� �߻�

select MAX(SUM(sal)) -- ��ø �Լ��� �ѹ��� ���
from emp
GROUP BY deptno; -- �μ� ��ȣ���� �հ踦 ���� �Ŀ� �� �߿��� �ִ� ���� ���Ѵ�

select ename, hiredate, MIN(hiredate), deptno -- GROUP BY ���� ���� �Ϲ� �÷��� ����� �� ���� < ���� �߻�
from emp
where deptno = 20; 
-- �Ϲ� �÷��� group by������ ���� �׷����� �����ϰ� having������ ������ ����ؾ� �Ѵ�

select MIN(hiredate) -- ���������� ����ȴ�
from emp
where deptno = 20; 

select LISTAGG(ename, ';') -- �����ڸ� ;����
       WITHIN GROUP (ORDER BY ename desc) "Ename",
       LISTAGG(hiredate, ';')
       WITHIN GROUP (ORDER BY ename desc) "hiredate",  -- ename�� �������� ��������
       MIN(hiredate) "Earliest"
from emp
where deptno = 20;
-- LISTAGG�� list aggregation(��� �����Լ�)

select LISTAGG(ename, '$') -- �����ڸ� ;����
       WITHIN GROUP (ORDER BY ename desc) "Ename",
       LISTAGG(hiredate, ';')
       WITHIN GROUP (ORDER BY hiredate) "hiredate", -- hiredate�� �������� ��������
       MIN(hiredate) "Earliest"
from emp
where deptno = 20;


-- [ROLLUP] 101p

-- ���տ��� ��� �� ��������� �����ϴµ� ���(���� ��������� �ʴ´�)
-- ROLLUP�� CUBE, GROUPING SETS�� �ӵ����ϸ� ����Ű�� ����

select deptno, count(*), sum(sal)
from emp
group by ROLLUP(deptno);

select deptno, job, sum(sal)
from emp
group by ROLLUP(deptno, job);

select deptno, job, sum(sal)
from emp
group by ROLLUP(job, deptno);

select deptno, job, mgr,sum(sal)
from emp
group by ROLLUP(deptno, job, mgr);


-- [CUBE] 104p
select deptno, job, sum(sal)
from emp
group by CUBE(deptno, job);
-- ROLLUP �Լ��ʹ� ������ ���

select deptno, job, sum(sal)
from emp
group by CUBE(job, deptno);


-- 5/20�� ����

-- [GROUPING SETS]
select deptno, job, sum(sal)
from emp
group by GROUPING SETS(deptno, job);

select deptno, NULL job, sum(sal)
from emp
group by deptno
UNION ALL
select NULL deptno, job, sum(sal)
from emp
group by job;


-- [JOIN]
select * from emp; -- 14��
select * from dept; -- 5��
select * from locations; -- 4��
select * from salgrade; -- 5��

-- [īŸ�þ� ��]
select empno, ename, dname
from emp, dept; -- 70��
-- (emp���̺��� ��) 14 * (dept���̺��� ��)5 = 70

select e.empno, e.ename, d.deptno, d.dname, d.loc_code -- �� ���� ���̺� ���� �����ϴ� �÷��� �ۼ� �ÿ��� ���̺���� �����־�� �Ѵ�
from emp e, dept d -- ���̺� �̸��� ��Ī�� ����� �� �ִ�
order by empno; -- ��� ����� ���� ���� ����ϱ� ������ �����͸� ������ �� ���� ����Ѵ�


-- 5/23�� ����

-- [EQUI JOIN] 118p
select e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where d.deptno = e.deptno
order by d.deptno;

select e.empno, e.ename, e.sal, e.job, e.deptno, d.dname, d.loc_code
from emp e, dept d
where d.deptno = e.deptno and e.job = 'SALESMAN';

select e.empno, d.dname, e.deptno ed, d.deptno dd, d.loc_code dl, l.loc_code ll, e.sal, l.city
from emp e, dept d, locations l
where d.deptno = e.deptno and d.loc_code = l.loc_code;

select e.ename, e.sal, e.job, e.hiredate, e.comm
from emp e, dept d, locations l
where d.deptno = e.deptno and d.loc_code = l.loc_code and e.sal > 1500 and l.city = 'DALLAS';

-- [NON-EQUI JOIN] 121p (=�� �ƴ� ��)
select e.empno, e.ename, e.job, e.sal, s.grade, s.losal, s.hisal
from salgrade s, emp e
where e.sal >= s.losal and e.sal <= s.hisal;

select e.empno, e.ename, e.job, e.sal, s.grade, s.losal, s.hisal
from salgrade s, emp e
where e.sal between s.losal and s.hisal; -- ���� ����� ����

-- [OUTER JOIN] 122p 
select e.empno, e.ename, e.job, e.deptno e_deptno, d.deptno e_deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+); 
-- d.deptno : �������̺�(dept), e.dpetno(+) : emp���̺�(�����Ͱ� ������ �ʿ� '+'�� ���δ�)

select d.deptno, d.dname, d.loc_code, l.loc_code, l.city
from dept d, locations l
where d.loc_code = l.loc_code(+); 
-- dept : �������̺�, locations : �����Ͱ� ������ ���̺�('+' ���)