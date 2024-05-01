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

@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Autowired
	private EmployeeService eService;

	// 登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpMain(SessionStatus status) {
		status.isComplete();
		return "forward:/WEB-INF/EmpLogin.jsp";
	}

	@PostMapping("/emplogin.controller")
	public String login(@RequestParam String account, @RequestParam String pwd, Model model) {
		EmployeeAccountBean bean = eService.login(account, pwd);
		if (bean != null) {
			switch (bean.getEmpPermissions()) {
			case "0": {
				model.addAttribute("err", "此帳號已無權限!!");
				return "forward:/WEB-INF/EmpLogin.jsp";
			}
			case "1": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 老闆大人");
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			case "2": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 主管");
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			case "3": {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getEmpName() + " 員工");
				return "forward:/WEB-INF/EmpIndex.jsp";
			}
			default:
			}
		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/EmpLogin.jsp";
	}
	//===================================================================================================
	
}
