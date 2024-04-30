package com.team6.member.model;

import java.time.LocalDate;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity @Table(name = "member")
@Component
public class MemberBean {

	@Id
	private String account;
	@Column(name = "MNAME")
	private String mName;
	private String password;
	@Column(name = "MEMAIL")
	private String mEmail;
	@Column(name = "MPHONE")
	private String mPhone;
	private LocalDate birthday;
	private int permissions;
	
	public MemberBean() {	}

	public MemberBean(String account, String mName, String password, String mEmail, String mPhone, LocalDate birthday,
			int permissions) {
		this.account = account;
		this.mName = mName;
		this.password = password;
		this.mEmail = mEmail;
		this.mPhone = mPhone;
		this.birthday = birthday;
		this.permissions = permissions;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	public String getmPhone() {
		return mPhone;
	}

	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}

	public LocalDate getBirthday() {
		return birthday;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}

	public int getPermissions() {
		return permissions;
	}

	public void setPermissions(int permissions) {
		this.permissions = permissions;
	}

	public String saveToCsv() {
		String csv = account +","+ mName+","+password+","+mEmail+","+mPhone+","+birthday+","+permissions;
		return csv;
	}
	
	public String saveToXml() {
//		String xml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+"\n"+"<Root>"+"\n";
		String xml="<Row>\n"
				   +"<account>"+account+"</account>\n"
				   +"<mName>"+mName+"</mName>\n"
				   +"<password>"+password+"</password>\n"
				   +"<mEmail>"+mEmail+"</mEmail>\n"
				   +"<mPhone>"+mPhone+"</mPhone>\n"
				   +"<birthday>"+birthday+"</birthday>\n"
				   +"<permissions>"+permissions+"</permissions>\n"
				   +"</Row>\n";
		return xml;
	}
	
	public String saveToJson() {
//		String json="[";
		String json="{\n\"account\":\""+account+"\",\n"
					+"\"mName\":\""+mName+"\",\n"
					+"\"password\":\""+password+"\",\n"
					+"\"mEmail\":\""+mEmail+"\",\n"
					+"\"mPhone\":\""+mPhone+"\",\n"
					+"\"birthday\":\""+birthday+"\",\n"
					+"\"permissions\":\""+permissions+"\"\n},";
//		json=json.substring(1, json.length()-1)+"\n]";
		return json;
	}
}
