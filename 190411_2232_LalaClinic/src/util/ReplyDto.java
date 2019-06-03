package util;

import java.io.Serializable;

import member.dto.MemberDto;

public class ReplyDto extends MemberDto implements Serializable {
	
	private int seq;
	private String id;
	private String content;
	private String tname;
	private String wdate;
	private int pseq;
	private int ref;
	private int step;
	private int depth; 
	private int del;
	
	public ReplyDto() {
	}
	public ReplyDto(int pseq, String id, String content) {
		this.id = id;
		this.content = content;
		this.pseq = pseq;
	}
	public ReplyDto(int pseq, String id, String content, int depth) {
		this.id = id;
		this.content = content;
		this.pseq = pseq;
		this.depth = depth;
	}
	public ReplyDto(String id, String content,int pseq, int ref, int step, int depth) {
		this.id = id;
		this.content = content;
		this.pseq = pseq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
	}

	public ReplyDto(int seq, String id, String content, String tname, String wdate, int pseq, int ref, int step,
			int depth, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.tname = tname;
		this.wdate = wdate;
		this.pseq = pseq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.del = del;
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

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "ReplyDto [seq=" + seq + ", id=" + id + ", content=" + content + ", tname=" + tname + ", wdate=" + wdate
				+ ", pseq=" + pseq + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", del=" + del + "]";
	}
}

