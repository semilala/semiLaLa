package member.dto;

import java.io.Serializable;

public class MemberDto implements Serializable {
	private String id;
	private String pwd;
	private String name;
	private String gender;
	private String email;
	private String phone;
	private String birth;
	private String address;
	private int auth;
	
	public MemberDto() {
		
	}

	public MemberDto(String id, String pwd, String name, String gender, String email, String phone, String birth,
			String address, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.gender = gender;
		this.email = email;
		this.phone = phone;
		this.birth = birth;
		this.address = address;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", gender=" + gender + ", email=" + email
				+ ", phone=" + phone + ", birth=" + birth + ", address=" + address + ", auth=" + auth + "]";
	}
}
