package com.team6.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity @Table(name = "bossaccount")
@Component
public class BossAccountBean {

	@Id
	private String account;
	@Column(name = "MNAME")
	private String mName;
	private String password;
	
	public BossAccountBean() {	}

	public BossAccountBean(String account, String mName, String password) {
		this.account = account;
		this.mName = mName;
		this.password = password;
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

}
