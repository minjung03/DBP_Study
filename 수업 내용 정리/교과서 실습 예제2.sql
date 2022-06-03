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


-- 5/27일 수업
select d.deptno, d.dname, d.loc_code, l.loc_code, l.city
from dept d, locations l
where d.loc_code(+) = l.loc_code; 

select d.deptno, d.dname, d.loc_code, l.loc_code, l.city
from dept d, locations l
where d.loc_code(+) = l.loc_code(+); -- 오류 발생 (오라클에서는 FULL OUTER JOIN이 없다) 

select e.ename, e.sal, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno 
      and e.sal > 2000; -- OUTER JOIN 후에 and의 조건을 체크하여 OUTER JOIN 효과를 보지 못함 (논리 오류)

select e.ename, e.sal, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno 
      and e.sal(+) > 2000; -- OUTER JOIN 효과를 보기 위해 (+)기호 추가
      
-- [SELF JOIN] 126p
select e.empno 사원번호, e.ename 사원이름, m.empno 관리자사번, m.ename 관리자이름
from emp e, emp m
where e.mgr = m.empno
order by 1; -- 1번 컬럼으로 정렬

select w.ename || ' 관리자는 ' || NVL(m.ename, '미정') as "관리자 정보" -- m.ename이 null값이면 '미정' 출력
from emp w, emp m
where w.mgr = m.empno(+)
order by 1;

-- [ANSI JOIN 파트 - from절에서 join을 명시]
-- [CROSS JOIN] 129p (카타시안 곱과 같다)
select e.ename, d.dname
from emp e CROSS JOIN dept d;
-- 14 * 5 =70행

select * from emp; -- 14행
select * from dept; -- 5행

select e.ename, d.dname
from emp e, dept d; -- 위의 코드와 동일하다

-- [NATURAL JOIN] 130p (이름이 같은 모든 열을 기준으로 조인)
select e.ename, deptno, d.dname -- 조인 조건으로 사용한 열은 테이블 명칭을 명시할 수 없다
                                -- 공통 컬럼은 select절에 명시하지 않아도 상관 없다
from emp e NATURAL JOIN dept d;

select d.deptno, d.dname, loc_code, l.city
from dept d NATURAL JOIN locations l
where d.deptno in (10,30); -- 조건절을 추가할 수 있다

select e.ename, e.sal, deptno, d.dname, loc_code, l.city
from emp e NATURAL JOIN dept d NATURAL JOIN locations l -- emp와 dept테이블의 deptno, dept와 locations테이블의 loc_code
order by 1;

-- [USING JOIN] 132p
select e.ename, deptno, d.dname
from emp e JOIN dept d using (deptno) -- deptno라는 열을 가지고 조인하겠다 지정
order by e.ename desc;

select d.deptno, d.dname, loc_code, l.city
from dept d JOIN locations l USING (loc_code) 
where d.deptno in (10,30);

select e.ename, d.dname, l.city
from emp e JOIN dept d USING (deptno) JOIN locations l USING (loc_code);

-- [ON JOIN] 134p
select e.ename 사원명, e.sal 사원급여, m.ename 매니저명, m.sal 매니저급여
from emp e JOIN emp m ON (e.mgr = m.empno); -- self join이다

select e.ename, e.sal, s.grade
from emp e JOIN salgrade s ON (e.sal between s.losal and s.hisal)
order by e.sal desc;

select e.ename, d.dname, l.city
from emp e JOIN dept d ON (e.deptno = d.deptno) JOIN locations l ON (d.loc_code = l.loc_code)
where e.ename NOT LIKE '%A%';

-- [OUTER JOIN] 136p
select d.dname, d.loc_code, l.loc_code, l.city
from dept d LEFT OUTER JOIN locations l ON (d.loc_code = l.loc_code);

    -- 위 문장과 동일 (oracle 코드)
    select d.dname, d.loc_code, l.loc_code, l.city
    from dept d, locations l
    where d.loc_code = l.loc_code(+); 

select d.dname, d.loc_code, l.loc_code, l.city
from dept d RIGHT OUTER JOIN locations l ON (d.loc_code = l.loc_code);

    -- 위 문장과 동일 (oracle 코드)
    select d.dname, d.loc_code, l.loc_code, l.city
    from dept d, locations l
    where d.loc_code(+) = l.loc_code; 

select d.dname, d.loc_code, l.loc_code, l.city
from dept d FULL OUTER JOIN locations l ON (d.loc_code = l.loc_code);

select e.ename, e.sal, e.deptno, d.deptno, d.dname
from emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno AND e.sal >= 2000;


-- 5/30일 수업
-- [서브쿼리(sql문 안 sql문)] 153p
select ename, sal
from emp
where sal > (select sal -- 이 문장을 먼저 실행하고 결과 값을 
             from emp
             where empno = 7566);
             
select empno, ename, job, hiredate, sal
from emp
where job = (select job 
             from emp
             where empno = 7521)
      and sal > (select sal from emp
                 where empno = 7934);      
                 
select ename, deptno, sal, hiredate
from emp
where sal = max; 
-- 오류 발생 (max는 그룹함수이기 때문에 where절에 사용 불가)
-- 그룹 함수는 group by having절에 사용!
                 
select ename, deptno, sal, hiredate
from emp
where sal = (select max(sal) from emp); -- 혹은 이렇게 사용

select empno, ename, job, sal, deptno
from emp
where sal < (select avg(sal) from emp);

select deptno, min(sal) -- 부서번호와 부서의 최소값을 출력
from emp
group by deptno -- deptno를 기준으로 그룹 설정
having min(sal) > (select min(sal) from emp -- 20번 부서의 최소 급여를 출력하는 문장
                   where deptno = 20);
-- 20번 부서의 최소값 보다는 큰 부서의 최소값들을 출력


-- 6/3일 수업

-- [다중 행 서브쿼리] 129p
select empno, ename, sal, deptno
from emp
where sal = (select max(sal)
             from emp
             group by deptno); 
-- 오류 발생(sal 값은 1개만 받을 수 있기 때문에)

select empno, ename, sal, deptno
from emp
where sal IN (select max(sal)
             from emp
             group by deptno); 
-- IN으로 변경하면 가능!
-- sal값은 부서별 최대값과 비교하여 1개라고 만족하면 true 발생

select ename, sal, job
from emp
where job != 'SALESMAN'
      and sal > ANY(select sal from emp
                    where job = 'SALESMAN');
-- sal > ANY의 의미는 서브쿼리의 결과 값 중에서 제일 작은 값보다 크면 true 발생
-- 즉, > ANY의 의미는 최소 값보다 크다면

select ename, sal, job
from emp
where job != 'SALESMAN'
      and sal > (select min(sal) from emp
                 where job = 'SALESMAN');
-- 위의 문장과 같은 결과이다

select ename, sal, job
from emp
where job != 'SALESMAN'
      and sal < ANY (select sal from emp
                 where job = 'SALESMAN');
-- sal < ANY의 의미는 서브쿼리의 결과 값 중에서 제일 작은 값보다 크면 true 발생
-- 즉, < ANY의 의미는 최대 값보다 작으면

select ename, sal, job
from emp
where job != 'SALESMAN'
      and sal < ANY (select max(sal) from emp
                 where job = 'SALESMAN');
-- 위의 문장과 같은 결과이다

select ename, sal, job, hiredate, deptno
from emp
where job != 'SALESMAN'
      and sal > ALL (select sal from emp
                     where job = 'SALESMAN');
-- 서브쿼리의 sal값들 보다 큰 값을 출력
                     
select ename, sal, job, hiredate, deptno
from emp
where job != 'SALESMAN'
      and sal > (select max(sal) from emp
                 where job = 'SALESMAN');
-- 위의 결과와 같다
-- ANY를 사용하는 이유는 속도가 빠르기 때문!

-- [다중 열 서브쿼리] 162p
select ename, mgr, deptno
from emp
where mgr IN (select mgr from emp where ename IN('FORD', 'BLAKE'))
      and deptno IN (select deptno from emp where ename IN('FORD', 'BLAKE'))
      and ename NOT IN ('FORD', 'BLAKE');

select ename, mgr, deptno
from emp
where mgr IN (7566, 7839)
      and deptno IN (30,20)
      and ename NOT IN ('FORD', 'BLAKE');
-- 위의 문장과 같은 결과

select ename, mgr, deptno
from emp 
where (mgr, deptno) IN (select mgr, deptno
                        from emp
                        where ename IN ('FORD', 'BLAKE'))
      and ename not in ('FORD', 'BLAKE');
-- 'FORD'값에서 mgr : 7566, deptno : 20인 다른 사원들을 출력
-- 'BLAKE'값에서 mgr : 7839, deptno : 30인 다른 사원들을 출력

-- [상호 연관 서브쿼리] 164p
-- 메인 쿼리에서 값을 서브 쿼리에 넘겨주고, 서브 쿼리를 수행한 다음 그 결과를 다시 메인 쿼리로 반환해서 수행하는 쿼리
select ename, sal, deptno, hiredate, job
from emp e
where sal > (select avg(sal)
             from emp
             where deptno = e.deptno);
-- 1) 메인 쿼리에서 emp 테이블의 한 행을 읽어서 e.deptno값을 서브 쿼리로 전달
-- 2) 서브 쿼리는 메인 쿼리에서 받은 부서번호로 평균 급여를 계산
-- 3) 다시 메인 쿼리는 서브 쿼리의 평균 급여보다 급여가 큰 직원을 출력
-- 4) 1)2)3) 과정을 14번(emp테이블 행 갯수) 반복하게 된다

-- [FROM절 서브쿼리(인라인 뷰)] 166p
select e.empno, e.ename, e.deptno, d.dname, d.loc_code
from (select * from emp where deptno = 10) e, -- 부서번호가 10번인 사원들이 모인 가상 테이블의 이름 e
     (select * from dept) d
where e.deptno = d.deptno; 
-- 상호 연관 서브쿼리로 변경 가능한 경우에도 inline view가 성능이 더 좋다