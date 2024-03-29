-- 상담 글쓰기
DROP TABLE COMBINE
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_COMBINE;

CREATE TABLE COMBINE(
   SEQ NUMBER(8) PRIMARY KEY,           -- 시퀀스
   ID VARCHAR2(50) NOT NULL,            -- 아이디
   INQUIRE VARCHAR2(50) NOT NULL,          -- 문의항목
   MEDICAL VARCHAR2(50) NOT NULL,       -- 시술항목
   RDATE VARCHAR2(12) NOT NULL,         -- 예약날짜
   TITLE VARCHAR2(200) NOT NULL,        -- 글 제목
   CONTENT VARCHAR2(4000) NOT NULL,     -- 내용
   FILENAMEBF VARCHAR2(50),      -- 첨부파일(원본)
   FILENAMEAF VARCHAR2(50),		 -- 첨부파일(바뀐후)
   PROGRESS NUMBER(1) NOT NULL,         -- 답변확인용
   WDATE DATE NOT NULL,                 -- 등록일
   TNAME VARCHAR2(50) NOT NULL,         -- 테이블네임
-- REF NUMBER(8) NOT NULL,              -- 답글용
-- STEP NUMBER(8) NOT NULL,             -- 답글용
-- DEPTH NUMBER(8) NOT NULL             -- 답글용
);
ALTER TABLE COMBINE
DROP COLUMN DEPTH;

CREATE SEQUENCE SEQ_COMBINE
START WITH 1
INCREMENT BY 1;

ALTER TABLE COMBINE
ADD CONSTRAINT FK_COMBINE_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);