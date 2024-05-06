package com.team6.member.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.team6.member.model.MemberAccountBean;
import com.team6.member.model.MemberDetailBean;
import com.team6.member.model.MemberService;

import jakarta.mail.internet.ParseException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;

	// 會員自行登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberMain(SessionStatus status, HttpSession session) {
		status.isComplete();
		session.removeAttribute("member");
		return "forward:/WEB-INF/Login.jsp";
	}

	@PostMapping("/memberlogin.controller")
	public String login(@RequestParam("account") String account, @RequestParam("password") String pwd, Model model,
			HttpSession session) {
		MemberAccountBean bean = service.login(account, pwd);
		if (bean != null) {
			if (bean.getPermissions() == 1) {
				model.addAttribute("name", bean.getDetailBean().getmName());
				session.setAttribute("member", bean);
				return "forward:/WEB-INF/front-jsp/member/MemberIndex.jsp";
			} else if (bean.getPermissions() == 0) {
				model.addAttribute("err", "此帳號已凍結!!");
				return "forward:/WEB-INF/Login.jsp";
			}

		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/Login.jsp";
	}
	@RequestMapping(path = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String Memberlogout(SessionStatus status, HttpSession session) {
		status.isComplete();
		session.removeAttribute("member");
		return "forward:/WEB-INF/Index.jsp";
	}
	// ===================================================================================================

	@RequestMapping(path = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoBackToIndex() {
		return "forward:/WEB-INF/Index.jsp";
	}
	
	@RequestMapping(path = "/forgot", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToForgotPwd() {
		return "forward:/WEB-INF/front-jsp/member/ForgotPwd.jsp";
	}

	// 來到 後台登入畫面
	@RequestMapping(path = "/emplogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpMain(SessionStatus status) {
		status.isComplete();
		return "forward:/WEB-INF/EmpLogin.jsp";
	}
	// ===================================================================================================

	// 查詢系列--單筆
	@GetMapping("/Member.SelectOneByID")
	public String SelectByOne(@RequestParam("id") int id, Model model) {
		MemberAccountBean bean = service.findById(id);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/back-jsp/member/MemberGetOne.jsp";
	}

	@GetMapping("/Member.SelectOneByAccount")
	public String SelectByOne(@RequestParam("account") String account, Model model) {
		MemberAccountBean bean = service.findAccountByAccount(account);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/back-jsp/member/MemberGetOne.jsp";
	}
	// ===================================================================================================

	// 查詢系列--模糊
	@GetMapping("/Member.SelectByName")
	public String SelectByName(@RequestParam("mName") String mName, Model model, HttpSession session) {
		List<MemberAccountBean> beans = service.findByName(mName);
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

	@RequestMapping(path = "/MemberSelectByName/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<MemberAccountBean> processQueryByNameByPage(@PathVariable("pageNo") int pageNo,
			/* @RequestParam("type")String type, */ Model m, HttpServletRequest request) {
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
		Page<MemberAccountBean> page = service.findByNameByPage(p1, name);

		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);

		return page.getContent();
	}
	// ===================================================================================================

	// 查詢系列--全部
	@GetMapping("/Member.SelectAll")
	public String SelectAll(Model model) {
		List<MemberAccountBean> beans = service.findAll();
		if (beans.isEmpty()) {
			model.addAttribute("err", "查無資料");
			model.addAttribute("totalElements", beans.size());
			return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
		}
		model.addAttribute("beans", beans);
		model.addAttribute("totalElements", beans.size());
		return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
	}
	@GetMapping("/Member.SelectAllByNotHidden")
	public String SelectAllByNotHidden(Model model) {
		List<MemberAccountBean> beans = service.findAllByNotHidden();
		if (beans.isEmpty()) {
			model.addAttribute("err", "查無資料");
			model.addAttribute("totalElements", beans.size());
			return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
		}
		model.addAttribute("beans", beans);
		model.addAttribute("totalElements", beans.size());
		return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
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
	
	@RequestMapping(path = "/MemberGetAll2/{pageNo}", method = { RequestMethod.GET, RequestMethod.POST })
	public String GetAllByPage(@PathVariable("pageNo") int pageNo, Model m,HttpServletRequest request) {
		int pageSize = 10;
		if(pageNo<=0) {
			pageNo=1;
		}
		Pageable pageable=PageRequest.of(pageNo-1, pageSize);
		Page<MemberAccountBean> page = service.findAllByPage(pageable);
		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
		m.addAttribute("totalPages",totalPages);
		m.addAttribute("totalElements",totalElements);
		m.addAttribute(page.getContent());
		return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
	}
	// ===================================================================================================

	// 新增會員
	@RequestMapping(path = "/MemberGoToInsert", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToInsert() {
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}

	@PostMapping("/Member.Insert")
	public String Insert(@RequestParam("account") String mAccount, @RequestParam("password") String mPassword,
			@RequestParam("mEmail") String mEmail, Model model) throws ParseException {
//		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
//		bean.setBirthday(LocalDate.parse(birthday,formatter));
		LocalDate nowDate = LocalDate.now();
		MemberAccountBean bean = new MemberAccountBean();
		bean.setmAccount(mAccount);
		bean.setmPassword(mPassword);
		bean.setPermissions(1);
		bean.setHidden(1);
		MemberAccountBean returnBean = service.insertAccount(bean);
		MemberDetailBean detailBean = new MemberDetailBean();
		detailBean.setBean(returnBean);
		detailBean.setmName(returnBean.getmAccount());
		detailBean.setmEmail(mEmail);
		detailBean.setmPhone("");
		detailBean.setMbirthday(nowDate);
		detailBean.setRegistrationDate(nowDate);
		returnBean.setDetailBean(detailBean);
		MemberAccountBean result = service.insertDetail(returnBean);
		if (result != null) {
			return "redirect:Member.SelectAll";
		}
		model.addAttribute("err", "新增失敗!!");
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}
	// ===================================================================================================
	
	@RequestMapping(path = "/MemberGoToUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToUpdate(@RequestParam("account") String account, Model model) {
		MemberAccountBean bean = service.findAccountByAccount(account);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/front-jsp/member/jsp/MemberUpdate.jsp";
	}

	// 更新會員密碼
	@PostMapping("/Member.UpdatePwd")
	public String UpdatePwd(@RequestParam("account") String mAccount, @RequestParam("beforepwd") String beforePwd,
			@RequestParam("afterpwd") String afterPwd, Model model) throws ParseException {
//		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
//		bean.setBirthday(LocalDate.parse(birthday,formatter));
//		LocalDate nowDate = LocalDate.now();
		MemberAccountBean bean = service.updatePwd(mAccount, beforePwd, afterPwd);
		if (bean!=null) {
			return "redirect:Member.SelectAll";
		}
		model.addAttribute("err", "舊密碼輸入錯誤");
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}
	// 更新會員細項
	@PostMapping("/Member.UpdateDetail")
	public String UpdateDetail(@RequestParam("account") String mAccount, @RequestParam("mName") String mName,
			@RequestParam("mEmail") String mEmail, @RequestParam("mPhone") String mPhone, @RequestParam("mbirthday") String mbirthday, @RequestParam("mPhoto") String mPhoto, Model model) throws ParseException {
		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
		MemberAccountBean bean = service.updateDetail(mAccount, mName, mEmail, mPhone, mPhoto, LocalDate.parse(mbirthday,formatter));
		if (bean!=null) { 
			return "redirect:Member.SelectAll";
		}
		model.addAttribute("err", "修改時發生問題!");
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}
	// 更新權限
	@PostMapping("/Member.UpdatePermissions")
	public String UpdatePermissions(@RequestParam("account") String account,
			@RequestParam("permissions") int permissions, Model model) {
		service.updateToPermissions(account, permissions);
		return "redirect:Member.SelectAll";
	}
	// ===================================================================================================
	// 假刪除? 真刪除?
	@GetMapping("/Member.Delete")
	@ResponseBody
	public void Delete(@RequestParam("account") String account) {
//		System.out.println(account+"他在搞我");
		service.delete(account);
		System.out.println("123");
	}
	// ===================================================================================================
	// 存檔會員資料表
	@GetMapping("/Member.Save")
	public String Save() {
		service.saveAccountToCSV();
		service.saveDetailToCSV();
		service.saveAccountToXML();
		service.saveDetailToXML();
		service.saveAccountToJSON();
		service.saveDetailToJSON();
		return "redirect:Member.SelectAll";
	}
}
