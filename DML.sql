/*
    INSERT INTO <TABLE_NAME>(COL1,COL2,...)
    VALUES(VAL1,VAL2,...)
*/
SELECT * FROM EMP;
SELECT * FROM DEPT;
INSERT INTO EMP
VALUES(7701,'JW KANG','MANAGER',7839
        ,TO_DATE('2023-01-01','YYYY-MM-DD'),3000,NULL,50);
INSERT INTO DEPT 
VALUES(50,'SECURITY','SEOUL');
INSERT INTO EMP(JOB,ENAME,SAL,EMPNO)
VALUES('CLERK','RONALDO',100,7702);
/*
    SELECT COL1,COL2,...
    FROM <TABLE_NAME>
    WHERE CONDITION
    ORDER BY COL1,COL2 ASC|DESC;
*/
SELECT EMPNO,JOB,MGR,ENAME,SAL,COMM
FROM EMP;
SELECT * FROM EMP;
SELECT DISTINCT JOB FROM EMP;
SELECT * FROM EMP
WHERE JOB<>'CLERK';
-- = > < >= <=  <>!= BETWEEN LIKE IN
-- AND OR NOT
SELECT * FROM EMP
WHERE NOT JOB='CLERK'
AND SAL>=3000;
SELECT * FROM EMP
WHERE JOB='CLERK'
AND SAL>=1000
OR NOT JOB='MANAGER'
AND SAL>=3000;
SELECT * FROM EMP
ORDER BY JOB DESC,ENAME DESC;
SELECT DISTINCT JOB FROM EMP
ORDER BY JOB;
SELECT * FROM EMP
WHERE SAL BETWEEN 1300 AND 3000;
SELECT * FROM EMP
WHERE JOB IN('CLERK','MANAGER');
SELECT ENAME FROM EMP
WHERE SAL<1500;
SELECT * FROM EMP
WHERE ENAME IN(
    SELECT ENAME FROM EMP
    WHERE SAL<1500
);
--LIKE % 0,1,여러개인 문자 _ 하나의 문자
SELECT ENAME FROM EMP
WHERE ENAME LIKE '%A%';
/*
    UPDATE <TABLE_NAME>
    SET COL1=VAL1,COL2=VAL2,...
    WHERE CONDITION;
*/
UPDATE EMP
SET JOB='MANAGER',SAL=NULL
WHERE EMPNO=7702;
SELECT * FROM EMP WHERE EMPNO=7701;
UPDATE EMP
SET COMM=100
WHERE EMPNO=7701;
/*
    DELETE FROM <TABLE_NAME>
    WHERE CONDITION;
*/
DELETE FROM EMP
WHERE EMPNO=7702;
SELECT * FROM EMP;
/*계산 함수
    MIN() MAX() COUNT() AVG() SUM()
별칭 별명(Aliases)
*/
SELECT COUNT(*) AS 개수 FROM EMP
WHERE SAL>=3000;
SELECT E.ENAME 이름,E.SAL 급여 FROM EMP E;
SELECT MAX(SAL) AS MAXSAL,MIN(SAL),MAX(ENAME)
FROM EMP;
SELECT AVG(SAL), SUM(SAL)
FROM EMP;
/* GROUP BY
    SELECT COLS(COUNT MAX MIN SUM AVG)
    FROM <TABLE_NAME>
    WHERE CONDITION
    GROUP BY <COLS>
    HAVING CONDITION
    ORDER BY <COLS>
*/
SELECT JOB,COUNT(*),MAX(SAL),MIN(SAL),AVG(SAL),SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING MIN(SAL)>1000;

SELECT JOB,COUNT(*),MAX(SAL),MIN(SAL),AVG(SAL),SUM(SAL)
FROM EMP
GROUP BY JOB
HAVING MAX(COMM) IS NULL
ORDER BY JOB;

/*CASE*/
SELECT ENAME,DEPTNO,COMM,SAL
    ,CASE
        WHEN SAL>2000 THEN '고연봉자'
        WHEN SAL>=1000 THEN '평균연봉자'
        ELSE '저연봉자'
    END AS STATE
FROM EMP;
SELECT ENAME,SAL
FROM EMP
WHERE JOB=(CASE
            WHEN SAL<1000 THEN 'CLERK'
            WHEN SAL>2000 THEN 'MANAGER'
            ELSE 'BOSS'
            END);
/*NULL FUNCTION
    DB NVL() COALESCE()
*/
SELECT ENAME,SAL,COMM
    ,SAL+NVL(COMM,0) AS PAY
    ,SAL+COALESCE(COMM,0) AS PAY2
FROM EMP;

--======================================
SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
ORDER BY DEPTNO,JOB;

SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY DEPTNO,JOB;

SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

SELECT DEPTNO,
       LISTAGG(ENAME, ', ')
       WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
  FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO,
    LISTAGG(ENAME,'/')WITHIN GROUP(ORDER BY ENAME) 
  FROM EMP
GROUP BY DEPTNO;

SELECT *
  FROM(SELECT DEPTNO, JOB, SAL
         FROM EMP)
PIVOT(MAX(SAL)
      FOR DEPTNO IN (10, 20, 30)
      )
ORDER BY JOB;
SELECT *
  FROM(SELECT JOB, DEPTNO, SAL
         FROM EMP)
PIVOT(MAX(SAL)
     FOR JOB IN ('CLERK' AS CLERK1,
                 'SALESMAN' AS SALESMAN1,
                 'PRESIDENT' AS PRESIDENT1,
                 'MANAGER' AS MANAGER1,
                 'ANALYST' AS ANALYST1)
     )
ORDER BY DEPTNO;
--=============================================
--TRUNC(VALUE,OPTION) TIME NUMBER
SELECT NVL(TO_CHAR(DEPTNO),'부서없음') AS DEPT
    ,NVL( TRUNC(AVG(SAL),1) ,0) AS AVG_SAL
    ,NVL(MAX(SAL),0) AS MAX_SAL
    ,NVL(MIN(SAL),0) AS MIN_SAL
    ,COUNT(*) AS CNT
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
SELECT * FROM EMP;
INSERT INTO EMP(EMPNO) VALUES(7703);
-- FROM DUAL
SELECT SYSDATE FROM DUAL;
--3명 이상 존재하는 직급
SELECT JOB,COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*)>=3;
--각 입사년도별 부서별 입사자 수
SELECT TO_CHAR(HIREDATE,'YYYY') AS HIRE_YEAR
    ,DEPTNO
    ,COUNT(*) AS CNT
FROM EMP
WHERE DEPTNO IS NOT NULL
GROUP BY TO_CHAR(HIREDATE,'YYYY'),DEPTNO;
--NVL2(COL,RES1 NO,RES2 YES)
SELECT ENAME,COMM,NVL2(COMM,'O','X')
FROM EMP;

SELECT NVL2(COMM,'O','X'),COUNT(*)
FROM EMP
GROUP BY NVL2(COMM,'O','X');

--CREATE INSERT SELECT 활용
DROP TABLE SAL_DDL;
DROP TABLE SAL_DML;
DROP TABLE SAL_TCL;
CREATE TABLE SAL_DDL AS SELECT * FROM SALGRADE WHERE 1<>1;
CREATE TABLE SAL_DML AS SELECT * FROM SALGRADE WHERE 1<>1;
CREATE TABLE SAL_TCL AS SELECT * FROM SALGRADE WHERE 1<>1;

INSERT INTO SAL_DDL(GRADE,LOSAL)
SELECT GRADE,LOSAL
FROM SALGRADE
WHERE GRADE=2;
INSERT INTO SAL_DDL(GRADE,HISAL)
SELECT 3,1000 FROM DUAL;

INSERT ALL
    WHEN LOSAL>=2001 THEN
        INTO SAL_DML VALUES(GRADE,LOSAL,HISAL)
    WHEN LOSAL>=1000 THEN
        INTO SAL_TCL VALUES(GRADE,LOSAL,HISAL)
    ELSE
        INTO SAL_DDL VALUES(GRADE,LOSAL,HISAL)
SELECT GRADE,LOSAL,HISAL
FROM SALGRADE;
SELECT * FROM SAL_DML;
SELECT * FROM SAL_TCL;
SELECT * FROM SAL_DDL;







