package com.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private String user_id, user_name, user_pw, location, gender;
	private Timestamp regdate;
	private Timestamp updatedate;
	
	public MemberVO() {
		
	}
	

	public MemberVO(String user_id, String user_name, String user_pw, String location, String gender) {
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_pw = user_pw;
		this.location = location;
		this.gender = gender;
	}


	public MemberVO(String user_name, String user_pw, String location, String gender) {
		this.user_name = user_name;
		this.user_pw = user_pw;
		this.location = location;
		this.gender = gender;
	}
	
	public MemberVO(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}
	
	

}
