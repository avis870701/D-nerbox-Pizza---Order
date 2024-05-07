//package com.team6.reservation.model;
//
//import java.util.List;
//
//import com.team6.member.model.MemberDetailBean;
//
//import jakarta.persistence.CascadeType;
//import jakarta.persistence.Column;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.OneToMany;
//import jakarta.persistence.OneToOne;
//
//public class ReserveMemberAccount {
//
//	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
//	@Column(name = "maid")
//	private int maid;
//	@Column(name = "maccount")
//	private String mAccount; 
//	@Column(name = "mpassword")
//	private String mPassword; 
//	@Column(name = "permissions")
//	private int permissions;
//	@Column(name = "hidden")
//	private int hidden;
//	
//	@OneToMany(mappedBy = "memberAccountBean",cascade = {CascadeType.REFRESH,CascadeType.MERGE})
//	private List<Reserve> reserve;
//	
//	
//	
//	public int getMaid() {
//		return maid;
//	}
//
//
//
//	public void setMaid(int maid) {
//		this.maid = maid;
//	}
//
//
//
//	public String getmAccount() {
//		return mAccount;
//	}
//
//
//
//	public void setmAccount(String mAccount) {
//		this.mAccount = mAccount;
//	}
//
//
//
//	public String getmPassword() {
//		return mPassword;
//	}
//
//
//
//	public void setmPassword(String mPassword) {
//		this.mPassword = mPassword;
//	}
//
//
//
//	public int getPermissions() {
//		return permissions;
//	}
//
//
//
//	public void setPermissions(int permissions) {
//		this.permissions = permissions;
//	}
//
//
//
//	public int getHidden() {
//		return hidden;
//	}
//
//
//
//	public void setHidden(int hidden) {
//		this.hidden = hidden;
//	}
//
//
//
//	public List<Reserve> getReserve() {
//		return reserve;
//	}
//
//
//
//	public void setReserve(List<Reserve> reserve) {
//		this.reserve = reserve;
//	}
//
//
//
//	public ReserveMemberAccount() {
//	}
//
//}
