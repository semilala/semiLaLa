-- 자료게시판 
DROP TABLE DOWN
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_DOWN;

CREATE TABLE DOWN(
    SEQ NUMBER(8) PRIMARY KEY,           -- 시퀀스 
    ID VARCHAR2(50) NOT NULL,            -- 아이디
    TITLE VARCHAR2(200) NOT NULL,        -- 제목   
    CONTENT VARCHAR2(4000) NOT NULL,     -- 내용
  	FILENAMEBF VARCHAR2(50),      -- 첨부파일(원본)
  	FILENAMEAF VARCHAR2(50),		 -- 첨부파일(바뀐후)
    READCOUNT NUMBER(8) NOT NULL,        -- 조회수
    WDATE DATE NOT NULL,                 -- 등록일
    TNAME VARCHAR2(50) NOT NULL         -- 테이블네임
);
CREATE SEQUENCE SEQ_DOWN
START WITH 1
INCREMENT BY 1;

ALTER TABLE DOWN
ADD CONSTRAINT FK_DOWN_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);