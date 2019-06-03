package custom.dto;

import java.io.Serializable;
import member.dto.MemberDto;
public class CustomDto extends MemberDto implements Serializable {

	private int seq;
	private String id;
	private String title;
	private String content;
	private String fileNameBf;
	private String fileNameAf;
	private String wdate;
	private String tname;
	private int progress;
	
	public CustomDto() {}


	public CustomDto(int seq, String id, String title, String content, String fileNameBf, String fileNameAf,
			String wdate, String tname, int progress) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.fileNameBf = fileNameBf;
		this.fileNameAf = fileNameAf;
		this.wdate = wdate;
		this.tname = tname;
		this.progress = progress;
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

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}


	@Override
	public String toString() {
		return "CustomDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", fileNameBf="
				+ fileNameBf + ", fileNameAf=" + fileNameAf + ", wdate=" + wdate + ", tname=" + tname + ", progress="
				+ progress + "]";
	}
	
	
	
}
