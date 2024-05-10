package com.team6.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;

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
		return "forward:/WEB-INF/front-jsp/Login.jsp";
	}

	@PostMapping("/memberlogin.controller")
	public String login(@RequestParam("account") String account, @RequestParam("password") String pwd, Model model,
			HttpSession session) {
		MemberAccountBean bean = service.login(account, pwd);
		if (bean != null) {
			if (bean.getPermissions() == 1) {
				session.setAttribute("member", bean);
				return "forward:/WEB-INF/front-jsp/member/MemberIndex.jsp";
			} else if (bean.getPermissions() == 0) {
				model.addAttribute("err", "此帳號已凍結!!");
				return "forward:/WEB-INF/front-jsp/Login.jsp";
			}

		}
		model.addAttribute("err", "帳號或密碼不正確!!");
		return "forward:/WEB-INF/front-jsp/Login.jsp";
	}

	// 進入忘記密碼頁(沒登入)
	@RequestMapping(path = "/forgot", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToForgotPwd() {
		return "forward:/WEB-INF/front-jsp/ForgotPwd.jsp";
	}

	@RequestMapping(path = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String Memberlogout(SessionStatus status, HttpSession session) {
		status.isComplete();
		session.removeAttribute("member");
		return "forward:/WEB-INF/front-jsp/Index.jsp";
	}
	// ===================================================================================================

	// 進入官網(無登入)
	@RequestMapping(path = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public String GoToIndex() {
		return "forward:/WEB-INF/front-jsp/Index.jsp";
	}

	// 來到 後台登入畫面
	@RequestMapping(path = "/emplogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String EmpMain(SessionStatus status) {
		status.isComplete();
		return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
	}
	// ===================================================================================================

	// 進入官網(登入後)
	@RequestMapping(path = "/MemberIndex", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoBackToIndex(HttpSession session) {
		MemberAccountBean bean = (MemberAccountBean) session.getAttribute("member");
		session.setAttribute("member", bean);
		return "forward:/WEB-INF/front-jsp/member/MemberIndex.jsp";
	}
	// ===================================================================================================

	// 新增會員(無登入)(註冊會員) ok
	@RequestMapping(path = "/MemberGoToInsert", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberGoToInsert() {
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}

	@PostMapping("/Member.Insert")
	public String Insert(@RequestParam("account") String mAccount, @RequestParam("password") String mPassword,
			@RequestParam("mEmail") String mEmail, Model model, HttpSession session) throws ParseException {
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
		detailBean.setmPhoto("/images/member/user.png");
		detailBean.setMbirthday(nowDate);
		detailBean.setRegistrationDate(nowDate);
		returnBean.setDetailBean(detailBean);
		MemberAccountBean result = service.insertDetail(returnBean);
		
		session.setAttribute("member", result);
		// 加自動寄信 ok
		String receivers = detailBean.getmEmail();
		String subject = "成為會員通知信";
		String content = "親愛的" + detailBean.getmName()
				+ "會員，您好！\n感謝您成為 DonerPizza 的會員。\n若有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。\n祝您用餐愉快！";
		String from = "DonerPizza<h60915@gmail.com>";
		service.sendPlainText(receivers, subject, content, from);
		// -------------------------------------------------------
			return "redirect:MemberIndex";
//			return "redirect:Member.SelectAll/1";
	}
	// ===================================================================================================

	// 去會員資訊畫面(登入後)
	@RequestMapping(path = "/MemberAboutMe", method = { RequestMethod.GET, RequestMethod.POST })
	public String MemberAboutMe(HttpSession session) {
		MemberAccountBean bean = (MemberAccountBean) session.getAttribute("member");
		session.setAttribute("member", bean);
		return "forward:/WEB-INF/front-jsp/member/MemberAboutMe.jsp";
	}

	// 更新會員密碼 OK
	@PostMapping("/Member.UpdatePwd")
	public String UpdatePwd(@RequestParam("account") String mAccount, @RequestParam("beforePwd") String beforePwd,
			@RequestParam("afterPwd") String afterPwd, Model model,HttpSession session) throws ParseException {
//		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
//		bean.setBirthday(LocalDate.parse(birthday,formatter));
//		LocalDate nowDate = LocalDate.now();
		MemberAccountBean bean = service.updatePwd(mAccount, beforePwd, afterPwd);
		if (bean != null) {
			// 加自動寄信 ok
			String receivers = bean.getDetailBean().getmEmail();
			String subject = "重置密碼通知信";
			String content = "親愛的" + bean.getDetailBean().getmName()
					+ "會員，您好！\n會員密碼已經重置完畢。\n若此為非您本人或有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。\n祝您用餐愉快！";
			String from = "DonerPizza<h60915@gmail.com>";
			service.sendPlainText(receivers, subject, content, from);
			session.setAttribute("member", bean);
			return "redirect:MemberAboutMe";
		}
		model.addAttribute("err", "舊密碼輸入錯誤");
		return "forward:/WEB-INF/front-jsp/member/MemberInsert.jsp";
	}

	// 更新會員細項 ok
	@PostMapping("/Member.UpdateDetail")
	public String UpdateDetail(
			@RequestParam("account") String mAccount, 
			@RequestParam("mName") String mName,
			@RequestParam("mEmail") String mEmail, 
			@RequestParam("mPhone") String mPhone,
			@RequestParam("mbirthday") String mbirthday,
			@RequestParam(value = "mPhoto", required = false) MultipartFile mf, 
			Model model,HttpSession session)
			throws ParseException, IllegalStateException, IOException {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		MemberAccountBean bean = service.findAccountByAccount(mAccount);
		MemberAccountBean oldbean = service.findAccountByAccount(mAccount);
		String mPhoto = "";
		if (  mf != null&&!mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
			String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/member/users";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);
			mPhoto = "/images/member/users/" + fileName;

			MemberAccountBean resultBean = service.updateDetail(bean, mName, mEmail, mPhone, mPhoto,LocalDate.parse(mbirthday, formatter));
			session.setAttribute("member", resultBean);
			return "redirect:MemberAboutMe";
		}else {
			mPhoto = oldbean.getDetailBean().getmPhoto();
			MemberAccountBean resultBean = service.updateDetail(bean, mName, mEmail, mPhone, mPhoto,LocalDate.parse(mbirthday, formatter));
			session.setAttribute("member", resultBean);
			return "redirect:MemberAboutMe";
		}
	}

}

//	@GetMapping("/Member.SelectAll")
//	public String SelectAll(Model model) {
//		List<MemberAccountBean> beans = service.findAll();
//		if (beans.isEmpty()) {
//			model.addAttribute("err", "查無資料");
//			model.addAttribute("totalElements", beans.size());
//			return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
//		}
//		model.addAttribute("beans", beans);
//		model.addAttribute("totalElements", beans.size());
//		return "forward:/WEB-INF/back-jsp/member/EmpMemberGetAll.jsp";
//	}

// 去更新會員資料畫面(登入後)
//	@RequestMapping(path = "/MemberGoToUpdate", method = { RequestMethod.GET, RequestMethod.POST })
//	public String MemberGoToUpdate(/*@RequestParam("account") String account,*/HttpSession session) {
//		MemberAccountBean bean=(MemberAccountBean)session.getAttribute("member");
////		MemberAccountBean accountBean = service.findAccountByAccount(account);
////		model.addAttribute("bean", bean);
//		session.setAttribute("member", bean);
//		return "forward:/WEB-INF/front-jsp/member/MemberUpdate.jsp";
//	}

// 去更新密碼畫面(登入後)
//	@RequestMapping(path = "/MemberGoToUpdatePwd", method = { RequestMethod.GET, RequestMethod.POST })
//	public String MemberGoToUpdatePwd(/*@RequestParam("member") MemberAccountBean accountBean,*/HttpSession session,Model model) {
//		MemberAccountBean accountBean=(MemberAccountBean) session.getAttribute("member");
////		MemberAccountBean bean = service.findAccountByAccount(accountBean.getmAccount());
////		model.addAttribute("bean", bean);
//		session.setAttribute("member", accountBean);
//		return "forward:/WEB-INF/front-jsp/member/MemberUpdatePwd.jsp";
//	}