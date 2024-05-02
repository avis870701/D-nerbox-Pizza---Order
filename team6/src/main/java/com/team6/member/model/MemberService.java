package com.team6.member.model;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
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
		String dCSV = "maid,mAccount,mPassword,permissions\n";
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
