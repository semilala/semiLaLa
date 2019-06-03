-- 댓글 테이블
DROP TABLE REPLY
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_REPLY;

CREATE TABLE REPLY(
    SEQ NUMBER(8) PRIMARY KEY,           -- 시퀀스
    ID VARCHAR2(50) NOT NULL,            -- 아이디
    CONTENT VARCHAR2(4000),              -- 내용
    TNAME VARCHAR2(50) NOT NULL,         -- 테이블네임
    WDATE DATE NOT NULL,                 -- 작성일
    PSEQ NUMBER(8) NOT NULL,
    REF NUMBER(8) NOT NULL,              -- 답글용
    STEP NUMBER(8) NOT NULL,             -- 답글용
    DEPTH NUMBER(8) NOT NULL,             -- 답글용
    DEL NUMBER(1) NOT NULL    			-- 삭제확인용
);


CREATE SEQUENCE SEQ_REPLY
START WITH 1
INCREMENT BY 1;

ALTER TABLE REPLY
ADD CONSTRAINT FK_REPLY_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

CREATE OR REPLACE TRIGGER STRI
AFTER UPDATE ON MEMBER
FOR EACH ROW
BEGIN
	UPDATE REPLY
	SET ID=:new.ID
	WHERE ID=:old.ID;
END;
/

UPDATE MEMBER
SET ID='TRUSH'
WHERE ID='TEST'

select * from reply;
select * from member;
select * from custom;