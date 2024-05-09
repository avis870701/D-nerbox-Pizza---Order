//package com.team6.reservation.model;
//
//import java.util.LinkedHashSet;
//import java.util.List;
//import java.util.Set;
//
//import org.springframework.stereotype.Component;
//
//import jakarta.persistence.CascadeType;
//import jakarta.persistence.Column;
//import jakarta.persistence.Entity;
//import jakarta.persistence.FetchType;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.ManyToOne;
//import jakarta.persistence.OneToMany;
//import jakarta.persistence.Table;
//
//@Entity @Table(name = "memberaccount")
//@Component
//public class ReserveMemberAccount {
//
//	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
//	@Column(name = "MAID")
//	private int maid;
//	@Column(name = "MACCOUNT")
//	private String mAccount; 
//	@Column(name = "MPASSWORD")
//	private String mPassword; 
//	@Column(name = "PERMISSIONS")
//	private int permissions;
//	@Column(name = "HIDDEN")
//	private int hidden;
//	@OneToMany(mappedBy = "memberAccount",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
//	private Set<Reserve> reserves = new LinkedHashSet<Reserve>();
//	
//		
//	public ReserveMemberAccount() {
//	}
//
//	public ReserveMemberAccount(int maid, String mAccount, String mPassword, int permissions, int hidden) {
//		super();
//		this.maid = maid;
//		this.mAccount = mAccount;
//		this.mPassword = mPassword;
//		this.permissions = permissions;
//		this.hidden = hidden;
//	}
//
//	public int getMaid() {
//		return maid;
//	}
//
//	public void setMaid(int maid) {
//		this.maid = maid;
//	}
//
//	public String getmAccount() {
//		return mAccount;
//	}
//
//	public void setmAccount(String mAccount) {
//		this.mAccount = mAccount;
//	}
//
//	public String getmPassword() {
//		return mPassword;
//	}
//
//	public void setmPassword(String mPassword) {
//		this.mPassword = mPassword;
//	}
//
//	public int getPermissions() {
//		return permissions;
//	}
//
//	public void setPermissions(int permissions) {
//		this.permissions = permissions;
//	}
//
//	public int getHidden() {
//		return hidden;
//	}
//
//	public void setHidden(int hidden) {
//		this.hidden = hidden;
//	}	
//}
