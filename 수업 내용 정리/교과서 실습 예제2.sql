-------  4/25 수업

-- [일반 함수]
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


------- 5/13일 수업

-- [그룹 함수] 89p
select MIN(ename), MAX(ename), MIN(hiredate), MAX(hiredate)
from emp; -- 문자와 날짜 데이터도 최소/최대값을 구할 수 있다

select ename, hiredate
from emp
order by hiredate;

select AVG(sal), MAX(sal), MIN(sal), SUM(sal)
from emp
where job = 'SALESMAN';

select COUNT(*) c1, COUNT(comm) c2, AVG(comm) c3, AVG(NVL(comm, 0)) c4 -- NVL은 comm이 null이면 0으로 바꾸어줌
from emp;
-- COUNT(*)은 emp 테이블의 행의 갯수, count(comm)은 comm값이 null이 아닌 데이터 갯수, 
-- AVG(comm)은 null이 아닌 comm값의 평균, AVG(NVL(comm, 0))은 comm값이 null이면 0으로 변환 뒤 평균

select COUNT(deptno) c_dept, COUNT(DISTINCT deptno) c_dis, COUNT(DISTINCT job) c_job
from emp;
-- DISTINCT은 중복 제거

select AVG(comm), SUM(comm)/14
from emp;

select AVG(NVL(comm, 0)), SUM(comm)/14
from emp;

select COUNT(deptno), COUNT(DISTINCT deptno), 
       SUM(deptno), SUM(DISTINCT deptno)
from emp;


-- [GROUP BY절] 95p
select deptno, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by deptno;
-- deptno값을 그룹으로 설정하여 그룹별로 갯수, 평균, 최소, 최대, 합을 출력
-- count(*)은 쿼리 문장의 속도를 저하시키는 원인이 된다..

select deptno, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by sum(sal) desc;

/*
-- GROUP BY절에 사용하는 컬럼들은 SELECT절에 있어야 한다
select job, count(*), trunc(avg(sal),1), min(sal), max(sal), sum(sal)
from emp
GROUP BY deptno
order by sum(sal) desc;
*/

select job, count(*), trunc(avg(sal)), sum(sal)
from emp
GROUP BY job;
-- job을 기준으로 그룹을 나눈다

select job, deptno, count(*), avg(sal), sum(sal)
from emp
GROUP BY job, deptno;
-- job, deptno를 기준으로 그룹을 나눈다 (manager의 10번, manager의 20번...)
 
 
-- [HAVING절] 97p
select deptno, count(*), sum(sal)
from emp
GROUP BY deptno
HAVING count(*) > 4;
-- 인원이 4명보다 많은 부서에 대하여 번호, 인원수, 급여의 합 출력
 
select deptno, avg(sal), sum(sal)
from emp
GROUP BY deptno
HAVING max(sal) > 2900;
-- 급여가 최대 2900 이상인 부서에 대하여 번호, 평균 급여, 급여의 합 출력
-- HAVING절에 쓰는 컬럼은 SELECT절에 없어도 된다

select job, avg(sal), sum(sal)
from emp
GROUP BY job
HAVING avg(sal) >= 3000;


-- 5/16일 수업

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
AND job = 'CLERK'; -- job은 그룹으로 설정한 컬럼이 아니기 때문에 having절에서 사용 시 오류 발생

select MAX(SUM(sal)) -- 중첩 함수는 한번만 사용
from emp
GROUP BY deptno; -- 부서 번호별로 합계를 구한 후에 그 중에서 최대 값을 구한다

select ename, hiredate, MIN(hiredate), deptno -- GROUP BY 설정 없이 일반 컬럼과 기술될 수 없다 < 오류 발생
from emp
where deptno = 20; 
-- 일반 컬럼을 group by절에서 전부 그룹으로 설정하고 having절에서 조건을 기술해야 한다

select MIN(hiredate) -- 정상적으로 실행된다
from emp
where deptno = 20; 

select LISTAGG(ename, ';') -- 구분자를 ;으로
       WITHIN GROUP (ORDER BY ename desc) "Ename",
       LISTAGG(hiredate, ';')
       WITHIN GROUP (ORDER BY ename desc) "hiredate",  -- ename을 기준으로 내림차순
       MIN(hiredate) "Earliest"
from emp
where deptno = 20;
-- LISTAGG는 list aggregation(목록 집계함수)

select LISTAGG(ename, '$') -- 구분자를 ;으로
       WITHIN GROUP (ORDER BY ename desc) "Ename",
       LISTAGG(hiredate, ';')
       WITHIN GROUP (ORDER BY hiredate) "hiredate", -- hiredate를 기준으로 오름차순
       MIN(hiredate) "Earliest"
from emp
where deptno = 20;


-- [ROLLUP] 101p

-- 집합에서 통계 및 요약정보를 추출하는데 사용(많이 사용하지는 않는다)
-- ROLLUP과 CUBE, GROUPING SETS는 속도저하를 일으키기 쉬움

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
-- ROLLUP 함수와는 역방향 출력

select deptno, job, sum(sal)
from emp
group by CUBE(job, deptno);


-- 5/20일 수업

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
select * from emp; -- 14행
select * from dept; -- 5행
select * from locations; -- 4행
select * from salgrade; -- 5행

-- [카타시안 곱]
select empno, ename, dname
from emp, dept; -- 70행
-- (emp테이블의 행) 14 * (dept테이블의 행)5 = 70

select e.empno, e.ename, d.deptno, d.dname, d.loc_code -- 두 개의 테이블에 전부 존재하는 컬럼을 작성 시에는 테이블명을 적어주어야 한다
from emp e, dept d -- 테이블 이름에 별칭을 사용할 수 있다
order by empno; -- 모든 경우의 수를 전부 출력하기 때문에 데이터를 복제할 때 많이 사용한다


-- 5/23일 수업

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

-- [NON-EQUI JOIN] 121p (=이 아닌 것)
select e.empno, e.ename, e.job, e.sal, s.grade, s.losal, s.hisal
from salgrade s, emp e
where e.sal >= s.losal and e.sal <= s.hisal;

select e.empno, e.ename, e.job, e.sal, s.grade, s.losal, s.hisal
from salgrade s, emp e
where e.sal between s.losal and s.hisal; -- 위와 결과는 같다

-- [OUTER JOIN] 122p 
select e.empno, e.ename, e.job, e.deptno e_deptno, d.deptno e_deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+); 
-- d.deptno : 기준테이블(dept), e.dpetno(+) : emp테이블(데이터가 부족헌 쪽에 '+'를 붙인다)

select d.deptno, d.dname, d.loc_code, l.loc_code, l.city
from dept d, locations l
where d.loc_code = l.loc_code(+); 
-- dept : 기준테이블, locations : 데이터가 부족한 테이블('+' 사용)