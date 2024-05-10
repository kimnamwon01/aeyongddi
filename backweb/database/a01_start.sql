SELECT * FROM emp; -- ctrl + enter
/*
# 데이터베이스 주석문(여러줄)
* */
-- 데이터베이스 주석문(단일줄)
/*
# sql문
1. oracle sql은 oracle 데이터베이스를 위한 표준 쿼리 언어
2. 데이터를 관리하고 조작하는데 필수적인 도구로, sql(Structed Query Language)의 강력한 확장 포함
3. 주요 특징
	1) 다양한 데이터 유형 지원:
		oracle sql은 표준 숫자, 문자열 데이터 유형 외에도 날짜, 타임스탬프, xml 등 다양한 데이터 유형 지원
	2) 고급 sql 기능: 분석함수, 모델 함수, 정규표현식 등 고급 기능을 제공하여 복잡한 데이터 분석과 처리 가능
4. sql과 일반 프로그램 언어의 차이점
	1) sql
		용도: 데이터베이스에서 데이터를 추출하여 문제 해결
		입출력: 입력은 테이블, 출력은 테이블
		번역: DBMS
		문법에 따른 기본 코드: select * from book;
	2) 일반 프로그래밍 언어
		용도: 모든 프로그램적인 문제 해결
		입출력: 모든 형태의 입출력 가능
		번역: 컴파일러
		문법에 따른 기본 코드: int main() {수행하는 코드}
# sql 기능에 따른 분류
1. 데이터 정의어(DDL)
	테이블이나 관계의 구조를 생성하는 데 사용
	create, alter, drop문 등
2. 데이터 조작어(DML)
	테이블에 데이터를 검색, 삽입, 수정, 삭제하는 데 사용
	select, insert, delete, update문 등
	select문: 질의어(query)
3. 데이터 제어어(DCL)
	데이터의 사용 권한을 관리하는 데 사용
	grant, revoke문등
# 기본 질의의 구조
select ename, job, loc
from emp
where sal>=3000

1. select: 질의 결과 추출되는 속성 리스트를 열거
2. from: 질의에 어느 테이블이 사용되는지 열거
3. where: 질의의 조건을 작성
* */
SELECT ename, job, sal
FROM emp;
WHERE sal>=3000;
SELECT *
FROM emp;
/*
select * : 전체 컬럼명, empno, ename,
from emp: 테이블명
where 조건문: 컬럼명을 비교/논리연산식에 의해서 filtering 처리 시 사용

 */
-- 컬럼명 선택
SELECT *
FROM emp; -- 전체 컬럼확인
SELECT empno, ename
FROM emp; -- 부분 컬럼명을 지정하여 출력
-- ex) *을 통해 전체 컬럼명을 확인한 후 2개, 또는 3개, 순서를 바꾸어 4개 컬럼명을 지정하여 출력
-- 1) 전체 컬럼명 지정 출력
SELECT * 
FROM EMP;
-- 2) 2개 컬럼명 지정 출력
SELECT empno, job
FROM emp;
-- 3) 3개 컬럼명 지정 출력
SELECT empno, ename, mgr
FROM emp;
-- 4) 4개 컬럼명 순서를 바꾸어 출력
SELECT deptno, comm, sal, hiredate
FROM emp;
SELECT deptno
FROM emp;
-- distinct: 중복된 데이터를 제거하고 보이게 할 때 
SELECT DISTINCT deptno
FROM EMP;
SELECT DISTINCT deptno, JOB	-- 두 개 컬럼 모두를 기준으로 동일하지 않게 출력
FROM EMP;
-- ex) emp테이블에 각 열별로 중복되는 컬럼을 확인하고 distinct로 중복제거하고 열별로 출력
SELECT *
FROM EMP;
SELECT DISTINCT job
FROM emp;
SELECT DISTINCT MGR 
FROM emp;
SELECT DISTINCT HIREDATE  
FROM emp;
SELECT DISTINCT COMM 
FROM emp;
SELECT DISTINCT DEPTNO 
FROM emp;
/*
# 컬럼명 별칭으로 사용하기
1. 모든 테이블의 구성요소 컬럼은 select 컬럼명으로 사용하여 호출 가능
2. 그러나 특정한 경우 컬럼명으로 변경하거나 통합된 컬럼며으로 처리해야 하는 경우 발생
	ex) 컬럼간의 연산, 문자열 연결
	select empno || ename 사원번호와 사원명연결
			ename || '님' 사원명과 '님' 문자연결
	# 데이터베이스에서는 + 연산자는 숫자형 연산시에만 활용, 문자열 연결 시 문자열 || 문자열 활용
3. 기본형식
	select 컬럼명 as 컬럼명 별칭	: as를 키워드로 별칭 사용
			컬럼명 컬럼명별칭	: 공백을 이용하여 별칭 사용
4. 별칭컬럼명의 예외 사항
	1) 컬럼명은 특수 문자나 공백을 포함할 경우
		"특수문자 "
		와 같이 ""사이에 넣어서 처리
 */
SELECT *
FROM emp; -- 초기에 컬럼명과 해당 구조로 테이블을 만들었기에 그 기본 순서를 출력 
-- 컬럼명과 컬럼순서, 타입과 구성요소를 변경 ==> alias명, ||, 연산자 활용하여 처리
SELECT EMPNO AS NO, ename "이 름"
FROM emp;
SELECT empno, empno AS 사원번호별칭, ename 사원명, job "##직 책##",
		EMPNO||ename AS "사원번호와 사원명"
FROM emp;
-- 별칭을 사용하면 아래와 같이 테이블의 타이블이 변경이 된다.
-- 다음의 각 컬럼에 alias를 한글로 설정하여 출력 .as, 공백 둘 다 활용
-- empno: 사원번호, enmae 사원명, job 직 책, mgr 관리자 번호, hiredate 입사일
-- sal: $급여$, comm 보너스, deptno 부서번호, 'Dear!' || ename 호칭
SELECT empno AS 사원번호, ename 사원명, job "직  책", mgr AS "관리자 번호", hiredate AS 입사일,
sal "$급여$", comm AS 보너스, deptno AS 부서번호, 'Dear!!' || ename 호칭
FROM emp;