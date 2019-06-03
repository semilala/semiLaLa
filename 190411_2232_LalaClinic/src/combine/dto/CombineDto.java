package combine.dto;

import java.io.Serializable;

import member.dto.MemberDto;


public class CombineDto extends MemberDto implements Serializable {
	private int seq;
	private String id;
	private String inquire;
	private String medical;
	private String rdate;
	private String title;
	private String content;
	private String fileNameBf;
	private String fileNameAf;
	private int progress;
	private String wdate;
	private String tname;
//	private int ref;
//	private int step;
//	private int depth;
	public CombineDto() {
	}
	
	public CombineDto(int seq, String id, String inquire, String medical, String rdate, String title, String content,
		String fileNameBf, String fileNameAf, int progress, String wdate, String tname) {
	this.seq = seq;
	this.id = id;
	this.inquire = inquire;
	this.medical = medical;
	this.rdate = rdate;
	this.title = title;
	this.content = content;
	this.fileNameBf = fileNameBf;
	this.fileNameAf = fileNameAf;
	this.progress = progress;
	this.wdate = wdate;
	this.tname = tname;
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

	public String getInquire() {
		return inquire;
	}

	public void setInquire(String inquire) {
		this.inquire = inquire;
	}

	public String getMedical() {
		return medical;
	}

	public void setMedical(String medical) {
		this.medical = medical;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
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

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
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
		return "CombineDto [seq=" + seq + ", id=" + id + ", inquire=" + inquire + ", medical=" + medical + ", rdate="
				+ rdate + ", title=" + title + ", content=" + content + ", fileNameBf=" + fileNameBf + ", fileNameAf="
				+ fileNameAf + ", progress=" + progress + ", wdate=" + wdate + ", tname=" + tname + "]";
	}

}