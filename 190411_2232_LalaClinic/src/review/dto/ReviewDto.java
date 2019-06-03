package review.dto;

import java.io.Serializable;

import member.dto.MemberDto;

/*
 -- 고객후기
DROP TABLE REVIEW
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_REVIEW;

CREATE TABLE REVIEW(
    SEQ NUMBER(8) PRIMARY KEY,          -- 시퀀스
    ID VARCHAR2(50) NOT NULL,           -- 아이디
    TITLE VARCHAR2(200) NOT NULL,       -- 제목
    CONTENT VARCHAR2(4000) NOT NULL,    -- 내용
    FILENAMEBF VARCHAR2(50),             -- 첨부파일(원본)
    FILENAMEAF VARCHAR2(50),             -- 첨부파일(바뀐후)
    MANAGEMENT VARCHAR2(50) NOT NULL,   -- 관리내용
    READCOUNT NUMBER(8) NOT NULL,       -- 조회수
    WDATE DATE NOT NULL,                -- 작성일
    TNAME VARCHAR2(50) NOT NULL        -- 테이블네임
);

CREATE SEQUENCE SEQ_REVIEW
START WITH 1
INCREMENT BY 1;

ALTER TABLE REVIEW
ADD CONSTRAINT FK_REVIEW_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);

 */
public class ReviewDto extends MemberDto implements Serializable{
	private int seq;			// 시퀀스
	private String id;			// 아이디
	private String title;		// 제목
	private String content;		// 내용
	private String fileNameBf;	// 첨부파일(원본)
	private String fileNameAf;	// 첨부파일(변경후)
	private String management; 	// 관리내용
	private int readcount;		// 조회수
	private String wdate;		// 작성일
	private String tname;		// 테이블이름
	
	// 생성자
	public ReviewDto() {
	}
	
	// 전체 입력 생성자
	public ReviewDto(int seq, String id, String title, String content, String fileNameBf, String fileNameAf,
			String management, int readcount, String wdate, String tname) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.fileNameBf = fileNameBf;
		this.fileNameAf = fileNameAf;
		this.management = management;
		this.readcount = readcount;
		this.wdate = wdate;
		this.tname = tname;
	}
	
	//유저가 입력하는 생성자
	public ReviewDto(int seq, String id, String title, String content, String fileNameBf, String fileNameAf, String management) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.fileNameBf = fileNameBf;
		this.fileNameAf = fileNameAf;
		this.management = management;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFileNameBf() {
		return fileNameBf;
	}

	public void setFileNameBf(String fileNameBf) {
		this.fileNameBf = fileNameBf;
	}

	public String getFileNameAf() {
		return fileNameAf;
	}

	public void setFileNameAf(String fileNameAf) {
		this.fileNameAf = fileNameAf;
	}

	public String getManagement() {
		return management;
	}

	public void setManagement(String management) {
		this.management = management;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	
	@Override
	public String toString() {
		return "ReviewDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", fileNameBf="
				+ fileNameBf + ", fileNameAf=" + fileNameAf + ", management=" + management + ", readcount=" + readcount
				+ ", wdate=" + wdate + ", tname=" + tname + "]";
	}
	
}
