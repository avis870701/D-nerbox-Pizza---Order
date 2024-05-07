package com.team6.member.model;

import java.util.List;

import org.springframework.stereotype.Component;

import com.team6.reservation.model.Reserve;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity @Table(name = "memberaccount")
@Component
public class MemberAccountBean {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "maid")
	private int maid;
	@Column(name = "maccount")
	private String mAccount; 
	@Column(name = "mpassword")
	private String mPassword; 
	@Column(name = "permissions")
	private int permissions;
	
	@OneToOne(mappedBy = "accountBean",cascade = CascadeType.ALL)
	private MemberDetailBean detailBean;
	
//	//測試用
//	@OneToMany(mappedBy = "memberAccountBean",cascade = {CascadeType.REFRESH,CascadeType.MERGE})
//	private List<Reserve> reserve;
//	
//	public List<Reserve> getReserve() {
//		return reserve;
//	}
//	public void setReserve(List<Reserve> reserve) {
//		this.reserve = reserve;
//	}	
//	
//	public MemberAccountBean(int maid, String mAccount, String mPassword, int permissions, int hidden,
//			MemberDetailBean detailBean, List<Reserve> reserve) {
//		this.maid = maid;
//		this.mAccount = mAccount;
//		this.mPassword = mPassword;
//		this.permissions = permissions;
//		this.hidden = hidden;
//		this.detailBean = detailBean;
//		this.reserve = reserve;
//	}
//	//測試用
	
	// 方法----------------------------------------------------------------
	public MemberAccountBean() {}
	public MemberAccountBean(int maid, String mAccount, String mPassword, int permissions,
			MemberDetailBean detailBean) {
		this.maid = maid;
		this.mAccount = mAccount;
		this.mPassword = mPassword;
		this.permissions = permissions;
		this.detailBean = detailBean;
	}
	public String saveToCsv() {
		String csv = maid +","+ mAccount+","+mPassword+","+permissions;
		return csv;
	}
	public String saveToXml() {
//		String xml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+"\n"+"<Root>"+"\n";
		String xml="<Row>\n"
				   +"<maid>"+maid+"</maid>\n"
				   +"<mAccount>"+mAccount+"</mAccount>\n"
				   +"<mPassword>"+mPassword+"</mPassword>\n"
				   +"<permissions>"+permissions+"</permissions>\n"
				   +"</Row>\n";
		return xml;
	}
	public String saveToJson() {
//		String json="[";
		String json="{\n\"maid\":\""+maid+"\",\n"
					+"\"mAccount\":\""+mAccount+"\",\n"
					+"\"mPassword\":\""+mPassword+"\",\n"
					+"\"permissions\":\""+permissions+"\"\n},";
//		json=json.substring(1, json.length()-1)+"\n]";
		return json;
	}

	// set and get----------------------------------------------------------------
	public int getMaid() {
		return maid;
	}
	public void setMaid(int maid) {
		this.maid = maid;
	}
	public String getmAccount() {
		return mAccount;
	}
	public void setmAccount(String mAccount) {
		this.mAccount = mAccount;
	}
	public String getmPassword() {
		return mPassword;
	}
	public void setmPassword(String mPassword) {
		this.mPassword = mPassword;
	}
	public MemberDetailBean getDetailBean() {
		return detailBean;
	}
	public void setDetailBean(MemberDetailBean detailBean) {
		this.detailBean = detailBean;
	}
	public int getPermissions() {
		return permissions;
	}
	public void setPermissions(int permissions) {
		this.permissions = permissions;
	}
	
}
