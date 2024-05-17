package com.team6.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.member.model.EmployeeAccountBean;
import com.team6.member.model.EmployeeService;
import com.team6.member.model.MemberAccountBean;
import com.team6.member.model.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Autowired
	private EmployeeService eService;
	@Autowired
	private MemberService mService;

	// 登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpMain(SessionStatus status, HttpSession session) {
		status.isComplete();
		session.removeAttribute("emp");
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@RequestMapping(path = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpOutMain(SessionStatus status, HttpSession session) {
		status.isComplete();
		session.removeAttribute("emp");
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@PostMapping("/emplogin.controller")
	public String login(@RequestParam("account") String account, @RequestParam("password") String pwd, Model model,
			HttpSession session) {
		EmployeeAccountBean bean = eService.login(account, pwd);
		if (bean != null) {
			System.out.println(bean.getEmpAccount());
			if (bean.getEmpPermissions() == "0") {
				System.out.println(bean.getEmpAccount()+"0");
				model.addAttribute("err", "此帳號已無權限!!");
				return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
			} else {
				System.out.println(bean.getEmpAccount()+"1");
				session.setAttribute("emp", bean);
				return "forward:/WEB-INF/back-jsp/EmpIndex.jsp";
			}

		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}
	// ===================================================================================================

	// 後台從會員功能返回主頁
	@RequestMapping(path = "/EmpGoBackToEmpIndex", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpGoBackToEmpIndex(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			HttpSession session) {
		if (bean != null) {
			session.setAttribute("emp", bean);
			return "forward:/WEB-INF/back-jsp/EmpIndex.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}
	// ===================================================================================================

	// 查詢系列--單筆
	@GetMapping("/Member.SelectOneByID")
	public String SelectByOne(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean accountBean,
			@RequestParam("id") int id, Model model) {
		if (accountBean != null) {
			MemberAccountBean bean = mService.findById(id);
			model.addAttribute("bean", bean);
			return "forward:/WEB-INF/back-jsp/member/MemberGetOne.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@GetMapping("/Member.SelectOneByAccount")
	public String SelectByOne(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean accountBean,
			@RequestParam("account") String account, Model model) {
		if (accountBean != null) {
			MemberAccountBean bean = mService.findAccountByAccount(account);
			model.addAttribute("bean", bean);
			return "forward:/WEB-INF/back-jsp/member/MemberGetOne.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}
	// ===================================================================================================

	// 查詢系列--模糊
	@GetMapping("/Member.SelectByName")
	@ResponseBody
	public String SelectByName(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@RequestParam("mName") String mName, Model model, HttpSession session) {
		if (bean != null) {
			List<MemberAccountBean> beans = mService.findByName(mName);
			if (beans.isEmpty()) {
				model.addAttribute("err", "查無資料");
				session.setAttribute("mName", mName);
				return "forward:/WEB-INF/back-jsp/member/MemberGetByName.jsp";
			} else {
				model.addAttribute("beans", beans);
				model.addAttribute("totalElements", beans.size());
				session.setAttribute("mName", mName);
				return "forward:/WEB-INF/back-jsp/member/MemberGetByName.jsp";
			}
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@RequestMapping(path = "/MemberSelectByName/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryByNameByPage(
			@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@PathVariable("pageNo") int pageNo, Model m, HttpServletRequest request) {
		if (bean != null) {
			HttpSession session = request.getSession();
			String name = String.valueOf(session.getAttribute("mName"));
			int pageSize = 10;
			Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
			/*
			 * switch (type){ case "mName": { Page<MemberAccountBean> page =
			 * service.findByNameByPage(p1,"detailBean.mName",name); } case "account":{
			 * Page<MemberAccountBean> page = service.findByNameByPage(p1,"mAccount",name);
			 * } default: throw new IllegalArgumentException("Unexpected value: " + type); }
			 */
			Page<MemberAccountBean> page = mService.findByNameByPage(p1, name);

			int totalPages = page.getTotalPages();
			long totalElements = page.getTotalElements();
			session.setAttribute("totalPages", totalPages);
			session.setAttribute("totalElements", totalElements);
			session.setAttribute("emp", bean);

			return page.getContent();
		}
		return null;
	}
	// ===================================================================================================

	// 查詢系列--全部(假刪除以外)
	@RequestMapping(path = "/Member.SelectAllByNotHidden/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST,
			RequestMethod.PUT, RequestMethod.DELETE })
	public String SelectAllByNotHidden(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@PathVariable("pageNo") int pageNo, Model model, HttpSession session) {
		if (bean != null) {
			int pageSize = 10;
			if (pageNo <= 0) {
				pageNo = 1;
			}
			Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
			Page<MemberAccountBean> page = mService.findAllByNotHiddenByPage(pageable);
			int totalPages = page.getTotalPages();
			long totalElements = page.getTotalElements();
			if (totalElements == 0) {
				model.addAttribute("err", "查無資料");
				model.addAttribute("totalElements", totalElements);
				return "forward:/WEB-INF/back-jsp/member/EmpHiddenMemberGetAll.jsp";
			}
			model.addAttribute("totalPages", totalPages);
			model.addAttribute("totalElements", totalElements);
			model.addAttribute(page.getContent());

			session.setAttribute("emp", bean);

			return "forward:/WEB-INF/back-jsp/member/EmpHiddenMemberGetAll.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@RequestMapping(path = "/MemberGetAllByNotHidden/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryAllByNotHiddenByPage(
			@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@PathVariable("pageNo") int pageNo, Model m, HttpServletRequest request) {
		if (bean != null) {
			int pageSize = 10;
			Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
			Page<MemberAccountBean> page = mService.findAllByNotHiddenByPage(p1);

			int totalPages = page.getTotalPages();
			long totalElements = page.getTotalElements();

			HttpSession session = request.getSession();
			session.setAttribute("emp", bean);
			session.setAttribute("totalPages", totalPages);
			session.setAttribute("totalElements", totalElements);

			return page.getContent();
		}
		return null;
	}

	// 查詢系列--全部
	@RequestMapping(path = "/Member.SelectAll/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST,
			RequestMethod.PUT, RequestMethod.DELETE })
	public String GetAllByPage(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@PathVariable("pageNo") int pageNo, Model m, HttpSession session) {
		if (bean != null) {
			int pageSize = 10;
			if (pageNo <= 0) {
				pageNo = 1;
			}
			Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
			Page<MemberAccountBean> page = mService.findAllByPage(pageable);
			int totalPages = page.getTotalPages();
			long totalElements = page.getTotalElements();

			session.setAttribute("emp", bean);

			m.addAttribute("totalPages", totalPages);
			m.addAttribute("totalElements", totalElements);
			m.addAttribute(page.getContent());
			return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@RequestMapping(path = "/MemberGetAll/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryAllByPage(
			@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@PathVariable("pageNo") int pageNo, Model m, HttpServletRequest request) {
		if (bean != null) {
			int pageSize = 10;
			Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
			Page<MemberAccountBean> page = mService.findAllByPage(p1);

			int totalPages = page.getTotalPages();
			long totalElements = page.getTotalElements();

			HttpSession session = request.getSession();
			session.setAttribute("emp", bean);
			session.setAttribute("totalPages", totalPages);
			session.setAttribute("totalElements", totalElements);

			return page.getContent();
		}
		return null;
	}
	// ===================================================================================================

	// 更新權限
	@PutMapping("/Member.UpdatePermissions")
	@ResponseBody
	public String UpdatePermissions(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@RequestParam("account") String account, @RequestParam("permissions") int permissions,
			@RequestParam("empPermissions") int empPermissions, Model model) {
		if (bean != null) {
			boolean result = mService.updateToPermissions(account, permissions);
			if (result) {
				return "redirect:Member.SelectAll/1";
			}
			model.addAttribute("err", "更新失敗");
			return "forward:/WEB-INF/back-jsp/EmpIndex.jsp";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	// ===================================================================================================
	// 假刪除 ok
	@DeleteMapping("/Member.Delete")
	@ResponseBody
	public String Delete(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@RequestParam("account") String account) {
		if (bean != null) {
			mService.delete(account);
			return "redirect:Member.SelectAll/1";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	@PutMapping("/Member.Reback")
	@ResponseBody
	public String Reback(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean,
			@RequestParam("account") String account) {
		if (bean != null) {
			mService.Reback(account);
			return "redirect:Member.SelectAll/1";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}

	// ===================================================================================================
	// 存檔會員資料表
	@GetMapping("/Member.Save")
	public String Save(@SessionAttribute(value = "emp", required = false) EmployeeAccountBean bean) {
		if (bean != null) {
			mService.saveAccountToCSV();
			mService.saveDetailToCSV();
			mService.saveAccountToXML();
			mService.saveDetailToXML();
			mService.saveAccountToJSON();
			mService.saveDetailToJSON();
			return "redirect:Member.SelectAll/1";
		}
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";

	}
	// 單筆查詢
	// 模糊查詢
	// 全部查詢
	// 新增員工
	// 更新員工密碼
	// 更新員工細項
	// 更新員工權限
	// 假刪除? 真刪除?
	// 存檔員工資料表
}
