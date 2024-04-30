package com.team6.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.member.model.MemberAccountBean;
import com.team6.member.model.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;
	
	// 登入系列
		@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
		public String MemberMain(SessionStatus status) {
			status.isComplete();
			return "forward:/WEB-INF/Login.jsp";
		}
		
		@PostMapping("/memberlogin.controller")
		public String login(@RequestParam String account,@RequestParam String pwd,Model model) {
			MemberAccountBean bean = service.login(account, pwd);
			if(bean!=null) {
				if(bean.getPermissions()==1) {
					model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getmName());
					return "forward:/WEB-INF/Index.jsp";
				}else if(bean.getPermissions()==0){
					model.addAttribute("err", "此帳號已凍結!!");
					return "forward:/WEB-INF/Login.jsp"; 
				}
				
			}
			model.addAttribute("err", "帳號或密碼不正確!!");
			return "forward:/WEB-INF/Login.jsp";
		}
}
