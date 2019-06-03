package reply.dto;

import java.io.Serializable;

import member.dto.MemberDto;

/*
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
    REF NUMBER(8) NOT NULL,              -- 답글용
    STEP NUMBER(8) NOT NULL,             -- 답글용
    DEPTH NUMBER(8) NOT NULL             -- 답글용    
);

CREATE SEQUENCE SEQ_REPLY
START WITH 1
INCREMENT BY 1;

ALTER TABLE REPLY
ADD CONSTRAINT FK_REPLY_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);
 */
public class ReplyDto extends MemberDto implements Serializable{
	private int seq;
	private String id;
	private String content;
	private String tname;
	private String wdate;
	private int del;
	private int pseq;
	private int ref;
	private int step;
	private int depth;
	
	// 생성자
	public ReplyDto() {
	}
	
	// 전체 입력 생성자
	public ReplyDto(int seq, String id, String content, String tname, String wdate,int del, int pseq, int ref, int step,
			int depth) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.tname = tname;
		this.wdate = wdate;
		this.del = del;
		this.pseq = pseq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
	}
	
	// 입력 받는 생성자
	public ReplyDto(String id, String content, String tname, int pseq) {
		super();
		this.id = id;
		this.content = content;
		this.tname = tname;
		this.pseq = pseq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	@Override
	public String toString() {
		return "ReplyDto [seq=" + seq + ", id=" + id + ", content=" + content + ", tname=" + tname + ", wdate=" + wdate
				+ ", del=" + del + ", pseq=" + pseq + ", ref=" + ref + ", step=" + step + ", depth=" + depth + "]";
	}

	
}
