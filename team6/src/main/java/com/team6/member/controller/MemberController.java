package com.team6.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.member.model.MemberAccountBean;
import com.team6.member.model.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;

	// 會員自行登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberMain(SessionStatus status) {
		status.isComplete();
		return "forward:/WEB-INF/Login.jsp";
	}

	@PostMapping("/memberlogin.controller")
	public String login(@RequestParam String account, @RequestParam String pwd, Model model) {
		MemberAccountBean bean = service.login(account, pwd);
		if (bean != null) {
			if (bean.getPermissions() == 1) {
				model.addAttribute("boss", "Welcome! " + bean.getDetailBean().getmName());
				return "forward:/WEB-INF/Index.jsp";
			} else if (bean.getPermissions() == 0) {
				model.addAttribute("err", "此帳號已凍結!!");
				return "forward:/WEB-INF/Login.jsp";
			}

		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/Login.jsp";
	}
	// ===================================================================================================

	// 後台從會員功能返回主頁
	@RequestMapping(path = "/MemberGoBackToIndex", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoBackToIndex() {
		return "forward:/WEB-INF/EmpIndex.jsp";
	}
	// ===================================================================================================

	// 查詢系列--單筆
	@GetMapping("/Member.SelectOneByID")
	public String SelectByOne(@RequestParam("id") int id, Model model) {
		MemberAccountBean bean = service.findById(id);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/member/jsp/MemberGetOne.jsp";
	}
	@GetMapping("/Member.SelectOneByAccount")
	public String SelectByOne(@RequestParam("account") String account, Model model) {
		MemberAccountBean bean = service.findAccountByAccount(account);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/member/jsp/MemberGetOne.jsp";
	}
	
	// 查詢系列--模糊
	@GetMapping("/Member.SelectByName")
	public String SelectByName(@RequestParam("mName") String mName, Model model,HttpSession session) {
		List<MemberAccountBean> beans = service.findByName(mName);
		if (beans.isEmpty()) {
			model.addAttribute("err", "查無資料");
			session.setAttribute("mName", mName);
			return "forward:/WEB-INF/member/jsp/MemberGetByName.jsp";
		}else {
			model.addAttribute("beans", beans);
			model.addAttribute("totalElements", beans.size());
			session.setAttribute("mName", mName);
			return "forward:/WEB-INF/member/jsp/MemberGetByName.jsp";
		}
	}
	@RequestMapping(path = "/MemberSelectByName/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryByNameByPage(@PathVariable("pageNo") int pageNo,/*@RequestParam("type")String type,*/ Model m,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		String name=String.valueOf(session.getAttribute("mName"));
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		/*switch (type){
		case "mName": {
			Page<MemberAccountBean> page = service.findByNameByPage(p1,"detailBean.mName",name);
		}
		case "account":{
			Page<MemberAccountBean> page = service.findByNameByPage(p1,"mAccount",name);
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + type);
		}*/
		Page<MemberAccountBean> page = service.findByNameByPage(p1,name);
		
		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);

		return page.getContent();
	}
	
	// 查詢系列--全部
	@GetMapping("/Member.SelectAll")
	public String SelectAll(Model model) {
		List<MemberAccountBean> beans = service.findAll();
		if (beans.isEmpty()) {
			model.addAttribute("err", "查無資料");
			model.addAttribute("totalElements", beans.size());
			return "forward:/WEB-INF/member/jsp/MemberGetAll.jsp";
		}
		model.addAttribute("beans", beans);
		model.addAttribute("totalElements", beans.size());
		return "forward:/WEB-INF/member/jsp/MemberGetAll.jsp";
	}

	@RequestMapping(path = "/MemberGetAll/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m,
			HttpServletRequest request) {
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo - 1, pageSize);
		Page<MemberAccountBean> page = service.findAllByPage(p1);

		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();

		HttpSession session = request.getSession();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);
		
		return page.getContent();
	}
}
