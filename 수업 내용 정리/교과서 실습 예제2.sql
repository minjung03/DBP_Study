-- 4/25 수업

-- 일반 함수
select ename, sal, comm, sal+comm, sal+NVL(comm,0)
from emp
where deptno = 30;
-- sal+comm해서 comm값이 null 이면 null이 된다
-- NVL(comm,0)에서 comm값이 null이면 0으로 반환

select ename, deptno, mgr, NVL2(mgr, mgr||' 담당','상위자')
from emp
where deptno <> 30;
-- NVL2(mgr, mgr||'담당,'상위자')에서 mgr이 null이 아니면 mgr||'담당' 반환
-- null이면 '상위자' 반환

select ename, job, NULLIF(job, 'SALESMAN') as result
from emp
where deptno = 30;
-- NULLIF(job, 'SALESMAN')에서 job이 salesman과 같으면 null 반환
-- 같지 않으면 job을 반환

select ename, comm, sal, COALESCE(comm, sal, 50) result
from emp;
-- COALESCE(comm, sal, 50) comm이 null이 아니면 comm 출력
-- comm이 null이고 sal이 null이 아니면 sal 출력
-- comm과 sal이 모두 null이면 50을 출력

select ename, comm, sal, GREATEST(sal, comm) 결과
from emp
where comm is not null;
-- GREATEST(sal, comm)에서 sal과 comm 중에서 큰 값을 출력(반환)
-- 둘 중에 하나라도 null이면 null을 반환

select ename, comm, sal, LEAST(sal, comm) 결과
from emp
where comm is not null;
-- LEAST(sal, comm에서 sal과 comm 중에서 작은 값을 출력(반환)
-- 둘 중에 하나라도 null이면 null을 반환

-- DECODE 함수
select empno, ename, sal, job,
       DECODE(job, 'ANALYST', sal*1.1, -- job이 ANALYST 이면 sal*1.1을 출력
              'CLERK', sal*1.2, -- CLERK 이면 sal*1.2을 출력
              'MANAGER', sal*1.3,  -- MANAGER 이면 sal*1.3을 출력
              'PRESIDENT', sal*1.4,  -- PRESIDENT 이면 sal*1.4을 출력
              'SALESMAN', sal*1.5, -- SALESMAN 이면 sal*1.5을 출력
              sal) 변경결과
from emp;

select ename, sal, 
       DECODE(SIGN(sal-1000), -1, 'A', 
       -- sal값이 1000보다 작으면 -1이기 때문에 'A'를 출력
       DECODE(SIGN(sal-2500), -1, 'B', 'C')) grade 
       -- sal값이 1000보다 크고 2500보다 작으면 'B'
       -- sal값이 2500보다 크면 'C'가 출력
from emp;
-- SIGN(sal-1000)에서 sal-1000한 값이 0보다 크면 1, 0보다 작으면 -1, 0이면 0을 출력


-- CASE 함수
select ename, sal, 
       CASE job WHEN 'ANALYST' THEN sal*1.1
                WHEN 'CLERK' THEN sal*1.2
                WHEN 'MANAGER' THEN sal*1.3
                WHEN 'PRESIDENT' THEN sal*1.4
                WHEN 'SALESMAN' THEN sal*1.5
                ELSE sal
       END salary
from emp;