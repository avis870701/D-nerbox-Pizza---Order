package com.team6.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.eclipse.tags.shaded.org.apache.bcel.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
import org.springframework.web.bind.support.SessionStatus;

import com.team6.model.BossAccountBean;
import com.team6.model.MemberBean;
import com.team6.model.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;
	
	/*因為thymeleaf會搶路徑,所以要forward:*/
	
	// 登入系列
	@RequestMapping(path = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberMain(SessionStatus status) {
		status.isComplete();
		return "forward:/WEB-INF/Login.jsp";
	}
	
	@PostMapping("/login.controller")
	public String login(@RequestParam String account,@RequestParam String pwd,Model model) {
		BossAccountBean bean = service.login(account, pwd);
		if(bean!=null) {
			model.addAttribute("boss", "Welcome! " + bean.getmName());
			return "forward:/WEB-INF/Index.jsp";
		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/Login.jsp";
	}
	
	@RequestMapping(path = "/MemberGoBackToIndex", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoBackToIndex() {
		return "forward:/WEB-INF/Index.jsp";
	}
	
	@RequestMapping(path = "/Member/{pageNo}",method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<MemberBean> processQueryAllByPage(@PathVariable("pageNo") int pageNo, Model m,HttpServletRequest request){
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo-1, pageSize);
		Page<MemberBean> page = service.findAllByPage(p1);
		
		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
//		m.addAttribute("totalPages", totalPages);
//		m.addAttribute("totalElements", totalElements);
		
		HttpSession session=request.getSession(); 
//		System.out.println(totalPages);
//		System.out.println(totalElements);
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);
		
		return page.getContent();
	}
	/*@RequestMapping(path = "/MemberByName/{pageNo}",method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<MemberBean> processQueryByNameByPage(@PathVariable("pageNo") int pageNo,@RequestParam("mName")String name , Model m,HttpServletRequest request){
		int pageSize = 10;
		Pageable p1 = PageRequest.of(pageNo-1, pageSize);
		Page<MemberBean> page = service.findByNameByPage(p1,name);
		
		int totalPages = page.getTotalPages();
		long totalElements = page.getTotalElements();
//		m.addAttribute("totalPages", totalPages);
//		m.addAttribute("totalElements", totalElements);
		
		HttpSession session=request.getSession(); 
//		System.out.println(totalPages);
//		System.out.println(totalElements);
		session.setAttribute("totalPages", totalPages);
		session.setAttribute("totalElements", totalElements);
		
		return page.getContent();
	}*/
//	================================================================================
	
	// 查詢系列
	@GetMapping("/Member.SelectAll")
	public String SelectAll(Model model) {
		List<MemberBean> beans = service.findAll();
		model.addAttribute("beans", beans);
		model.addAttribute("totalElements",beans.size());
		return "forward:/WEB-INF/member/jsp/MemberGetAll.jsp";
	}

	@GetMapping("/Member.SelectByName")
	public String SelectByName(@RequestParam("mName") String mName, Model model) {
		List<MemberBean> beans = service.findByName(mName);
		model.addAttribute("beans", beans);
		return "forward:/WEB-INF/member/jsp/MemberGetByName.jsp";
	}

	@GetMapping("/Member.SelectByOne")
	public String SelectByOne(@RequestParam("account") String account, Model model) {
		MemberBean bean = service.findById(account);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/member/jsp/MemberGetOne.jsp";
	}
	
	// 新增系列
	@RequestMapping(path = "/MemberGoToInsert", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToInsert() {
		return "forward:/WEB-INF/member/jsp/MemberInsert.jsp";
	}
	@PostMapping("/Member.Insert")
	public String Insert(@RequestParam("account") String account, @RequestParam("mName") String mName,
			@RequestParam("password") String password, @RequestParam("mEmail") String mEmail,
			@RequestParam("mPhone") String mPhone, @RequestParam("birthday") String birthday, Model model) throws ParseException {
		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
		MemberBean bean = new MemberBean();
		bean.setAccount(account);
		bean.setmName(mName);
		bean.setPassword(password);
		bean.setmEmail(mEmail);
		bean.setmPhone(mPhone);
		bean.setBirthday(LocalDate.parse(birthday,formatter));
		bean.setPermissions(1);
		MemberBean result = service.insert(bean);
		if (result != null) {
			return "redirect:Member.SelectAll";
		}
		model.addAttribute("err", "新增失敗!!");
		return "forward:/WEB-INF/member/jsp/MemberInsert.jsp";
	}

	// 更新系列
	@RequestMapping(path = "/MemberGoToUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToUpdate(@RequestParam("account") String account, Model model) {
		MemberBean bean = service.findById(account);
		model.addAttribute("bean", bean);
		return "forward:/WEB-INF/member/jsp/MemberUpdate.jsp";
	}
	@PutMapping("/Member.Update")
	public String Update(@RequestParam("account") String account, @RequestParam("mName") String mName,
			@RequestParam("password") String password, @RequestParam("mEmail") String mEmail,
			@RequestParam("mPhone") String mPhone, @RequestParam("birthday") String birthday,
			@RequestParam("permissions") int permissions, Model model) {
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyy-MM-dd");
		MemberBean bean = new MemberBean();
		bean.setAccount(account);
		bean.setmName(mName);
		bean.setPassword(password);
		bean.setmEmail(mEmail);
		bean.setmPhone(mPhone);
		bean.setBirthday(LocalDate.parse(birthday,formatter));
		bean.setPermissions(permissions);
		MemberBean result = service.update(bean);
		if (result != null) {
			return "redirect:Member.SelectAll";
		}
		model.addAttribute("err", "更新失敗!!");
		return "forward:/WEB-INF/member/jsp/MemberUpdate.jsp";
	}

	@PutMapping("/Member.UpdatePermissions")
	public String UpdatePermissions(@RequestParam("account") String account,
			@RequestParam("permissions") int permissions, Model model) {
		service.updateToPermissions(account, permissions);
		return "redirect:Member.SelectAll";
	}

	// 刪除
	@DeleteMapping("/Member.Delete")
	@ResponseBody
	public void Delete(@RequestParam("account") String account) {
		System.out.println(account+"他在搞我");
		service.delete(account);
		System.out.println("123");
	}

	// 存檔
	@GetMapping("/Member.Save")
	public String Save() {
		service.saveToCSV();
		service.saveToXML();
		service.saveToJSON();
		return "redirect:Member.SelectAll";
	}
}
