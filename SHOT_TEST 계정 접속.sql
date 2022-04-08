-- 4월 2째주 수행 (2번째는 5월 말)
-- 테이블 생성, 계정 생성, 권한 부여 등 (이론은 안낼꺼임)

SELECT * FROM memberTBL;

SELECT * FROM memberTBL 
WHERE membername = '고양이'; -- memberTBL에서 membername가 '고양이'인 필드 출력

-- 다음시간 교과서 19p 부터 시작

commit; -- 위의 모든 내용을 물리적으로 저장을 확정한다
select * from emp; -- emp 테이블에 있는 내용을 읽어서 모든 컬럼을 화면에 출력한다
select * from dept;

select job, mgr, hiredate, sal , comm, deptno, empno from emp;
