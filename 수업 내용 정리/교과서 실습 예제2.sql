-- 4/25 ����

-- �Ϲ� �Լ�
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