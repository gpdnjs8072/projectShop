package com.test.project01.users.Dto;

import java.util.Date;

public class UsersDto {
	
	private String userId;
	private String userPass;
	private String userName;
	private String userPhon;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private Date regiDate;
	private int verify;
		
	public UsersDto() {}
	
	public UsersDto(String userId, String userPass, String userName, String userPhon, String userAdd1, String userAdd2,
			String userAdd3) {
		super();
		this.userId = userId;
		this.userPass = userPass;
		this.userName = userName;
		this.userPhon = userPhon;
		this.userAddr1 = userAdd1;
		this.userAddr2 = userAdd2;
		this.userAddr3 = userAdd3;
	}


	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPhon() {
		return userPhon;
	}
	public void setUserPhon(String userPhon) {
		this.userPhon = userPhon;
	}
	public String getUserAddr1() {
		return userAddr1;
	}
	public void setUserAddr1(String userAdd1) {
		this.userAddr1 = userAdd1;
	}
	public String getUserAddr2() {
		return userAddr2;
	}
	public void setUserAddr2(String userAdd2) {
		this.userAddr2 = userAdd2;
	}
	public String getUserAddr3() {
		return userAddr3;
	}
	public void setUserAddr3(String userAdd3) {
		this.userAddr3 = userAdd3;
	}
	public Date getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}
	public int getVerify() {
		return verify;
	}
	public void setVerify(int verify) {
		this.verify = verify;
	}
	
	
}
