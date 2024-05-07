package com.team6.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.member.model.EmployeeAccountBean;
import com.team6.member.model.EmployeeService;
import com.team6.member.model.MemberAccountBean;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Autowired
	private EmployeeService eService;

	// 登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpMain(SessionStatus status,HttpSession session) {
		status.isComplete();
		session.removeAttribute("emp");
		return "forward:/WEB-INF/EmpLogin.jsp";
	}
	@RequestMapping(path = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpOutMain(SessionStatus status,HttpSession session) {
		status.isComplete();
		session.removeAttribute("emp");
		return "forward:/WEB-INF/Login.jsp";
	}

	@PostMapping("/emplogin.controller")
	public String login(@RequestParam("account") String account, @RequestParam("password") String pwd, Model model,HttpSession session) {
		EmployeeAccountBean bean = eService.login(account, pwd);
		if (bean != null) {
			switch (bean.getEmpPermissions()) {
			case "0": {
				model.addAttribute("err", "此帳號已無權限!!");
				return "forward:/WEB-INF/EmpLogin.jsp";
			}
			case "1": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 老闆大人");
				session.setAttribute("emp", bean);
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			case "2": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 主管");
				session.setAttribute("emp", bean);
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			case "3": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 員工");
				session.setAttribute("emp", bean);
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			default:
			}
		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/EmpLogin.jsp";
	}
	// ===================================================================================================
	
	// 後台從會員功能返回主頁
		@RequestMapping(path = "/EmpGoBackToEmpIndex", method = { RequestMethod.GET, RequestMethod.POST })
		public String EmpGoBackToEmpIndex() {
			return "forward:/WEB-INF/EmpIndex.jsp";
		}	
	// ===================================================================================================

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
