package com.team6.member.model;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MemberService {

	@Autowired
	private RepositoryMemberAccount rma;
	@Autowired
	private RepositoryMemberDetail rmd;

	// 會員登入
	public MemberAccountBean login(String account, String pwd) {
		Optional<MemberAccountBean> optional = rma.login(account, pwd);
		if (!optional.isEmpty()) {
			return optional.get();
		}
		return null;
	}
	// =================================================================

	// 查詢單筆
	public MemberAccountBean findAccountByAccount(String account) {
		Optional<MemberAccountBean> optional = rma.findAccountByAccount(account);
		if (!optional.isEmpty()) {
			return optional.get();
		}
		return null;
	}

	public MemberAccountBean findById(int maid) {
		Optional<MemberAccountBean> optional = rma.findById(maid);
		if (!optional.isEmpty()) {
			return optional.get();
		}
		return null;
	}

	// 模糊查詢
	public List<MemberAccountBean> findByName(String name) {
		return rma.findByName(name);
	}

	// 全部查詢
	public List<MemberAccountBean> findAll() {
		return rma.findAll();
	}
	public List<MemberAccountBean> findAllByNotHidden() {
		return rma.findAllByNotHidden();
	}

	// 回傳搜尋頁面筆數
	public Page<MemberAccountBean> findAllByPage(Pageable pageable) {
		return rma.findAll(pageable);
	}
	public Page<MemberAccountBean> findByNameByPage(Pageable pageable,/*String type,*/String name) {
		return rma.findByNamePage(pageable,/*type,*/name);
	}
	// =================================================================

	// 新增會員帳號
	public MemberAccountBean insertAccount(MemberAccountBean accountBean) {
		Optional<MemberAccountBean> optional = rma.findAccountByAccount(accountBean.getmAccount());
		if (optional.isEmpty()) {
			return rma.save(accountBean);
		}
		return null;
	}

	// 新增?更新?會員細項
	public MemberAccountBean insertDetail(MemberAccountBean accountBean) {
		Optional<MemberAccountBean> optional = rma.findById(accountBean.getMaid());
		if (!optional.isEmpty()) {
			MemberAccountBean aBean = optional.get();
			MemberDetailBean detailBean = aBean.getDetailBean();
			rmd.save(detailBean);
			return aBean;
		}
		return null;
	}
	// =================================================================

	// 更改權限
	public boolean updateToPermissions(String account, int permissions) {
		Optional<MemberAccountBean> optional = rma.findAccountByAccount(account);
		if (!optional.isEmpty()) {
			MemberAccountBean accountBean = optional.get();
			accountBean.setPermissions(permissions);
			rma.save(accountBean);
			return true;
		}
		return false;
	}
	
	// 更改密碼
	public MemberAccountBean updatePwd(String account, String beforePwd, String afterPwd) {
		Optional<MemberAccountBean> optional = rma.findAccountByAccount(account);
		MemberAccountBean bean =optional.get();
		if (beforePwd == bean.getmPassword()) {
			bean.setmPassword(afterPwd);
			rma.save(bean);
			return bean;
		}
		return null;
	}
	
	// 更改細項
	public MemberAccountBean updateDetail(String account, String name, String email, String phone, String photo, LocalDate birthday) {
		Optional<MemberAccountBean> optional=rma.findAccountByAccount(account);
		if(!optional.isEmpty()) {
			MemberAccountBean accountBean = optional.get();
			accountBean.getDetailBean().setmName(name);
			accountBean.getDetailBean().setmEmail(email);
			accountBean.getDetailBean().setmPhone(phone);
			accountBean.getDetailBean().setmPhoto(photo);
			accountBean.getDetailBean().setMbirthday(birthday);
			rma.save(accountBean);
			return accountBean;
		}
		return null;
	}
	// =================================================================
	
	// 假刪除: 藏起來
	public void delete(String account) {
		Optional<MemberAccountBean> optional = rma.findAccountByAccount(account);
		if(!optional.isEmpty()) {
			MemberAccountBean bean = optional.get();
			bean.setHidden(0);
		}
	}
	// =================================================================

	// 存檔Account CSV
	public void saveAccountToCSV() {
		String file = "C:\\Users\\User\\Downloads\\memberAccount.csv";
		String accountCSV = "maid,mAccount,mPassword,permissions\n";
		List<MemberAccountBean> beans = rma.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberAccountBean bean : beans) {
				accountCSV += bean.saveToCsv() + "\n";
			}
			byte[] bytes = accountCSV.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}

	// 存檔 CSV
	public void saveDetailToCSV() {
		String file = "C:\\Users\\User\\Downloads\\memberDetail.csv";
		String dCSV = "maid,mAccount,mPassword,permissions,hidden\n";
		List<MemberDetailBean> beans = rmd.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberDetailBean bean : beans) {
				dCSV += bean.saveToCsv() + "\n";
			}
			byte[] bytes = dCSV.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}

	// 存檔Account XML
	public void saveAccountToXML() {
		String file = "C:\\Users\\User\\Downloads\\memberAccount.xml";
		String accountxml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "\n" + "<Root>" + "\n";
		List<MemberDetailBean> beans = rmd.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberDetailBean bean : beans) {
				accountxml += bean.saveToXml();
			}
			accountxml += "</Root>";
			byte[] bytes = accountxml.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}

	// 存檔 XML
	public void saveDetailToXML() {
		String file = "C:\\Users\\User\\Downloads\\memberDetail.xml";
		String dxml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "\n" + "<Root>" + "\n";
		List<MemberDetailBean> beans = rmd.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberDetailBean bean : beans) {
				dxml += bean.saveToXml();
			}
			dxml += "</Root>";
			byte[] bytes = dxml.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}

	// 存檔Account JSON
	public void saveAccountToJSON() {
		String file = "C:\\Users\\User\\Downloads\\memberAccount.json";
		String accountjson = "[";
		List<MemberAccountBean> beans = rma.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberAccountBean bean : beans) {
				accountjson += bean.saveToJson() + "\n";
			}
			accountjson = accountjson.substring(0, accountjson.length() - 2) + "\n]";
			byte[] bytes = accountjson.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}

	// 存檔 JSON
	public void saveDetailToJSON() {
		String file = "C:\\Users\\User\\Downloads\\memberDetail.json";
		String djson = "[";
		List<MemberAccountBean> beans = rma.findAll();
		try (FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos);) {
			for (MemberAccountBean bean : beans) {
				djson += bean.saveToJson() + "\n";
			}
			djson = djson.substring(0, djson.length() - 2) + "\n]";
			byte[] bytes = djson.getBytes();
			bos.write(bytes);
		} catch (Exception e) {
		}
	}
}
