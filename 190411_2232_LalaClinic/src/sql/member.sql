-- 회원가입(멤버)
DROP TABLE MEMBER2
CASCADE CONSTRAINTS;

CREATE TABLE MEMBER2(
    ID VARCHAR2(50) PRIMARY KEY,    -- 아이디
    NAME VARCHAR2(50) NOT NULL,     -- 이름
    PWD VARCHAR2(50) NOT NULL,      -- 비밀번호
    BIRTH VARCHAR2(50) NOT NULL,    -- 생일
    GENDER VARCHAR2(10) NOT NULL,   -- 성별
    EMAIL VARCHAR2(50) NOT NULL,    -- 이메일
    PHONE VARCHAR2(20) NOT NULL,    -- 전화번호
    ADDRESS VARCHAR2(100) NOT NULL, -- 주소
    AUTH NUMBER(1) NOT NULL         -- 회원등급(관리자)
);
INSERT INTO MEMBER(ID, NAME, PWD, BIRTH, GENDER, EMAIL, PHONE, ADDRESS, AUTH)
VALUES ('rkt','라경태','admin','950418','M','ktra0@naver.com','010-9098-2871','서울','1')