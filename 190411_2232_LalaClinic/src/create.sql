
-- 회원가입(멤버)
DROP TABLE MEMBER
CASCADE CONSTRAINTS;

CREATE TABLE MEMBER(
    ID VARCHAR2(50) PRIMARY KEY,    -- 아이디
    NAME VARCHAR2(50) NOT NULL,     -- 이름
    PWD VARCHAR2(50) NOT NULL,      -- 비밀번호
    BIRTH VARCHAR2(50) NOT NULL,    -- 생일 (19850111)
    GENDER VARCHAR2(10) NOT NULL,   -- 성별 (남성, 여성)
    EMAIL VARCHAR2(50) NOT NULL,    -- 이메일
    PHONE VARCHAR2(20) NOT NULL,    -- 전화번호
    ADDRESS VARCHAR2(100) NOT NULL, -- 주소
    AUTH NUMBER(1) NOT NULL         -- 회원등급(관리자) 0:일반, 1:관리자
);



 -- 고객후기
DROP TABLE REVIEW
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_REVIEW;

CREATE TABLE REVIEW(
    SEQ NUMBER(8) PRIMARY KEY,          -- 시퀀스
    ID VARCHAR2(50) NOT NULL,           -- 아이디
    TITLE VARCHAR2(200) NOT NULL,       -- 제목
    CONTENT VARCHAR2(4000) NOT NULL,    -- 내용
    FILENAME VARCHAR2(50) ,     		-- 첨부파일
    MANAGEMENT VARCHAR2(50) NOT NULL,   -- 관리내용
    READCOUNT NUMBER(8) NOT NULL,       -- 조회수
    WDATE DATE NOT NULL,                -- 작성일
    TNAME VARCHAR2(50) NOT NULL        -- 테이블네임
);

CREATE SEQUENCE SEQ_REVIEW
START WITH 1
INCREMENT BY 1;

ALTER TABLE REVIEW
ADD CONSTRAINT FK_MEMBER_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);



-- 상담 글쓰기
DROP TABLE COMBINE
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_COMBINE;

CREATE TABLE COMBINE(
   SEQ NUMBER(8) PRIMARY KEY,           -- 시퀀스
   ID VARCHAR2(50) NOT NULL,            -- 아이디
   INQUIRE VARCHAR2(50) NOT NULL,       -- 문의항목 (상담, 예약)
   MEDICAL VARCHAR2(50) NOT NULL,       -- 시술항목
   RDATE VARCHAR2(12) NOT NULL,         -- 예약날짜 (2019033012) 년월일시 10자리
   TITLE VARCHAR2(200) NOT NULL,        -- 글 제목
   CONTENT VARCHAR2(4000) NOT NULL,     -- 내용
   FILENAMEBF VARCHAR2(50),      		-- 첨부파일(원본)
   FILENAMEAF VARCHAR2(50),       		-- 첨부파일(바뀐후)
   PROGRESS NUMBER(1) NOT NULL,         -- 답변확인용(답변대기:0, 답변완료:1)
   WDATE DATE NOT NULL,                 -- 등록일
   TNAME VARCHAR2(50) NOT NULL         -- 테이블네임(대문자)
);
--ALTER TABLE COMBINE
--DROP COLUMN DEPTH;

-- 출처: https://hyeonstorage.tistory.com/292 [개발이 하고 싶어요]
CREATE SEQUENCE SEQ_COMBINE
START WITH 1
INCREMENT BY 1;

ALTER TABLE COMBINE
ADD CONSTRAINT FK_COMBINE_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);



-- 고객 소리함
DROP TABLE CUSTOM
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_CUSTOM;

CREATE TABLE CUSTOM(
   SEQ NUMBER(8) PRIMARY KEY,           -- 시퀀스
   ID VARCHAR2(50) NOT NULL,            -- 아이디
   
   TITLE VARCHAR2(200) NOT NULL,        -- 제목
   CONTENT VARCHAR2(4000) NOT NULL,     -- 내용
   FILENAMEBF VARCHAR2(50),      		-- 첨부파일(원본)
   FILENAMEAF VARCHAR2(50),       		-- 첨부파일(바뀐후)
   WDATE DATE NOT NULL,                 -- 등록일
   TNAME VARCHAR2(50) NOT NULL,         -- 테이블네임
   PROGRESS NUMBER(1) NOT NULL			-- 답변대기0, 답변완료1
);

CREATE SEQUENCE SEQ_CUSTOM
START WITH 1
INCREMENT BY 1;

ALTER TABLE CUSTOM
ADD CONSTRAINT FK_CUSTOM_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);



-- 자료게시판 
DROP TABLE DOWN
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_DOWN;

CREATE TABLE DOWN(
    SEQ NUMBER(8) PRIMARY KEY,          -- 시퀀스 
    ID VARCHAR2(50) NOT NULL,           -- 아이디
    TITLE VARCHAR2(200) NOT NULL,       -- 제목   
    CONTENT VARCHAR2(4000) NOT NULL,    -- 내용
    FILENAMEBF VARCHAR2(50),      		-- 첨부파일(원본)
  	FILENAMEAF VARCHAR2(50),		 	-- 첨부파일(바뀐후)
    READCOUNT NUMBER(8) NOT NULL,       -- 조회수
    WDATE DATE NOT NULL,                -- 등록일
    TNAME VARCHAR2(50) NOT NULL         -- 테이블네임
);
CREATE SEQUENCE SEQ_DOWN
START WITH 1
INCREMENT BY 1;

ALTER TABLE DOWN
ADD CONSTRAINT FK_DOWN_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

select * from member;
delete from member where id='ojh'

SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
				+ " FROM MEMBER "
				+ " WHERE AUTH=1 "
				+ " ORDER BY ID ASC

update member set auth=1 where id='admin'
SELECT * FROM REPLY;

delete from reply;

SELECT * FROM 
	(SELECT * FROM  
		(SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.PSEQ, R.REF, R.STEP, R.DEPTH, R.DEL, M.NAME 
		FROM DOWN D, REPLY R, MEMBER M  
		WHERE D.SEQ = R.PSEQ  
		AND D.TNAME = R.TNAME  
		AND R.ID = M.ID  
		AND R.PSEQ = '4'  
		ORDER BY REF ASC, STEP DESC, DEPTH ASC) 
	WHERE ROWNUM <=5  
	ORDER BY REF ASC, STEP DESC, DEPTH ASC )  	
WHERE ROWNUM <=10 	
ORDER BY SEQ ASC 


SELECT * FROM  	
	(SELECT * FROM  
		(SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.PSEQ, R.REF, R.STEP, R.DEPTH, R.DEL, M.NAME  
		FROM DOWN D, REPLY R, MEMBER M  
		WHERE D.SEQ = R.PSEQ  
		AND D.TNAME = R.TNAME  	
		AND R.ID = M.ID  
		AND R.PSEQ = 4  
		ORDER BY REF ASC, STEP ASC) 
	WHERE ROWNUM <=3  
	ORDER BY REF ASC, STEP ASC) 
WHERE ROWNUM <=10

SELECT NVL(MAX(STEP),0)+1 FROM REPLY WHERE PSEQ=4 AND REF=32 AND DEPTH>0

SELECT * FROM  		
	(SELECT * FROM  			
		(SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.PSEQ, R.REF, R.STEP, R.DEPTH, R.DEL, M.NAME  			
		FROM DOWN D, REPLY R, MEMBER M  			
		WHERE D.SEQ = R.PSEQ  			
		AND D.TNAME = R.TNAME  			
		AND R.ID = M.ID  			
		AND R.PSEQ = 4  			
		ORDER BY REF DESC, STEP DESC)  		
	WHERE ROWNUM <=3  		
	ORDER BY REF ASC, STEP ASC)  	
WHERE ROWNUM <=10 	
ORDER BY REF ASC, STEP ASC

select * from member;

select * from reply;

SELECT *
FROM MEMBER M, COMBINE CO
WHERE M.ID = CO.ID+

SELECT *
FROM COMBINE CO, CUSTOM CU, REVIEW R
WHERE CO.ID = CU.ID+
AND M.ID = CU.ID+
AND M.ID = R.ID+;

SELECT * 
FROM REPLY
WHERE PSEQ IN (SELECT SEQ FROM COMBINE WHERE ID='test');

SELECT * 
FROM REPLY
WHERE PSEQ=11;

--1번
INSERT INTO MEMBER(ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH)
VALUES('trash01','1111', 'trashUser01', '남성', 'trashUser@trash.com', '000-0000-0000', '20000101', '[000-000] 탈퇴시 탈퇴동 탈퇴빌라 탈퇴호', 0)

--2번
 UPDATE REPLY 
 SET DEL=1,
 ID='trash01' 
 WHERE ID='rkt'
 
 --2-1
 UPDATE COMBINE
 SET ID = 'trash01'
 WHERE ID='rkt'
 
 --3-1번
 
 UPDATE REPLY 
 SET DEL=1
 WHERE SEQ IN ( SELECT SEQ 
                FROM REPLY 
                WHERE PSEQ IN ( SELECT SEQ 
                                FROM COMBINE 
                                WHERE ID='trash01'))

 SELECT * FROM REPLY
 ORDER BY SEQ DESC
 
 SELECT * FROM COMBINE
 ORDER BY SEQ DESC
 -- 4번
  DELETE FROM COMBINE WHERE ID='trash01'

--5
DELETE FROM MEMBER
WHERE ID = 'rkt'

--6
COMMIT



UPDATE REPLY SET ID='ktra0' WHERE ID='test';

select * from reply where id='test';




INSERT INTO CUSTOM
VALUES (SEQ_CUSTOM.NEXTVAL,'ktra0','타이틀11','컨텐츠',null,null,SYSDATE,'CUSTOM',0)