-- 4�� 2°�� ���� (2��°�� 5�� ��)
-- ���̺� ����, ���� ����, ���� �ο� �� (�̷��� �ȳ�����)

SELECT * FROM memberTBL;

SELECT * FROM memberTBL 
WHERE membername = '�����'; -- memberTBL���� membername�� '�����'�� �ʵ� ���

-- �����ð� ������ 19p ���� ����

commit; -- ���� ��� ������ ���������� ������ Ȯ���Ѵ�
select * from emp; -- emp ���̺� �ִ� ������ �о ��� �÷��� ȭ�鿡 ����Ѵ�
select * from dept;

select job, mgr, hiredate, sal , comm, deptno, empno from emp;
