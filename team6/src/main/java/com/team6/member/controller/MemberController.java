package com.team6.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;

import javax.swing.text.AbstractDocument.Content;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.team6.member.model.MemberAccountBean;
import com.team6.member.model.MemberDetailBean;
import com.team6.member.model.MemberService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.ParseException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService service;

	// Google 第三方登入
//	@PostMapping("/MemberLoginByGoogle")
//	public String MemberLoginByGoogle(@RequestParam("credential") String credential) {
//		// pom.xml => google
//		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
//				// Specify the CLIENT_ID of the app that accesses the backend:
//				// 放憑證的金鑰 "client_id"。
//				.setAudience(Collections.singletonList("1061052456304-fvgb2fc831flpr7na6faddbf91ngi0r0.apps.googleusercontent.com"))
//				// Or, if multiple clients access the backend:
//				// .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
//				.build();
//
//		// (Receive idTokenString by HTTPS POST)
//		// 这里验证登录回调的credential完整性
//		// 注意: 要選的是 com.google.api.client.googleapis.auth.oauth2 這組路徑。
//		GoogleIdToken idToken = verifier.verify(credential);
//		Payload payload = idToken.getPayload();
//
//		// Get profile information from payload
//		String email = payload.getEmail();
//
//		// 紀錄金鑰
//		String thirdPartyId = payload.getSubject();
//
//		String name = (String) payload.get("name");
//		String pictureUrl = (String) payload.get("picture");
////			    String locale = (String) payload.get("locale");
//		String familyName = (String) payload.get("family_name");
//		String givenName = (String) payload.get("given_name");
//		String[] splitAccount = email.split("@");
//		String account = splitAccount[0];
//		if (idToken != null) {
////			            int level = 1;
//
////					System.out.println("獨家金鑰: " + thirdPartyId);
////					System.out.println("第三方登入方式: " + thirdPartyProvider);
////					System.out.println("信箱: " + email);
////					System.out.println("帳號: " + account);
////					System.out.println("全名: " + name);
////					System.out.println("照片: " + pictureUrl);
////					System.out.println("姓氏: " + givenName);
////					System.out.println("名字: " + familyName);
//
//			if (mService.findByAccount(account).isPresent()) {
//				if (mService.checkLogin(account, thirdPartyId)) {
//					System.out.println("登入成功");
//					// 儲存登入會員的bean物件
//					MemberBean memberInformation = mService.selectByAccountBean(account);
//					System.out.println(memberInformation);
//					// 設定session
//					httpSession.setAttribute("member", memberInformation);
//					System.out.println("session設定成功");
//					// 檢查會員等級
//					return "/good/jsp/EZBuyindex";
//				}
//			} else {
//				/* 紀錄當前時間 */
//				LocalDate now = LocalDate.now();
//				System.out.println(now);
//				MemberBean memBean = new MemberBean(account, thirdPartyId, email, name, thirdPartyProvider, now);
//				mService.insert(memBean);
//				httpSession.setAttribute("member", memBean);
//				System.out.println("有創建帳號");
//				return "/good/jsp/EZBuyindex";
//			}
//		}
//		return "失敗";
//	}

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
			@RequestParam("mEmail") String mEmail, Model model, HttpSession session) throws MessagingException {
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
		String content = mailContent(detailBean.getmName(),	"感謝您成為 DonerPizza 的會員。");
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
	public String UpdatePwd(@SessionAttribute("member") MemberAccountBean accountBean,
			@RequestParam("beforePwd") String beforePwd, @RequestParam("afterPwd") String afterPwd, Model model,
			HttpSession session) throws MessagingException {
//		DateTimeFormatter formatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
//		bean.setBirthday(LocalDate.parse(birthday,formatter));
//		LocalDate nowDate = LocalDate.now();
//		MemberAccountBean bean = service.updatePwd(mAccount, beforePwd, afterPwd);
		MemberAccountBean bean = service.updatePwd(accountBean.getmAccount(), beforePwd, afterPwd);
		if (bean != null) {
			// 加自動寄信 ok
			String receivers = bean.getDetailBean().getmEmail();
			String subject = "重置密碼通知信";
			String content = mailContent(bean.getDetailBean().getmName(), "會員密碼已經重置完畢。");
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
	public String UpdateDetail(@RequestParam("account") String mAccount, @RequestParam("mName") String mName,
			@RequestParam("mEmail") String mEmail, @RequestParam("mPhone") String mPhone,
			@RequestParam("mbirthday") String mbirthday,
			@RequestParam(value = "mPhoto", required = false) MultipartFile mf, Model model, HttpSession session)
			throws ParseException, IllegalStateException, IOException {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		MemberAccountBean bean = service.findAccountByAccount(mAccount);
		MemberAccountBean oldbean = service.findAccountByAccount(mAccount);
		String mPhoto = "";
		if (mf != null && !mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
			String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/member/users";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);
			mPhoto = "/images/member/users/" + fileName;

			MemberAccountBean resultBean = service.updateDetail(bean, mName, mEmail, mPhone, mPhoto,
					LocalDate.parse(mbirthday, formatter));
			session.setAttribute("member", resultBean);
			return "redirect:MemberAboutMe";
		} else {
			mPhoto = oldbean.getDetailBean().getmPhoto();
			MemberAccountBean resultBean = service.updateDetail(bean, mName, mEmail, mPhone, mPhoto,
					LocalDate.parse(mbirthday, formatter));
			session.setAttribute("member", resultBean);
			return "redirect:MemberAboutMe";
		}
	}
	
	public String mailContent(String memberName, String content) {
		String MailContent ="<html>"
				+ "<body>"
				+ "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"max-width:600px\">"
				+ " <tbody>"
				+ " <tr height=\"16\"></tr>"
				+ " <tr><td>"
				+ "<table bgcolor=\"#4184F3\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"　style=\"min-width:332px;max-width:600px;border:1px solid #e0e0e0;border-bottom:0;border-top-left-radius:3px;border-top-right-radius:3px\">"
				+ "<tbody> <tr><td height=\"72px\" colspan=\"3\"></td></tr>"
				+ "<tr><td width=\"32px\"></td><td style=\"font-family:Roboto-Regular,Helvetica,Arial,sans-serif;font-size:24px;color:#ffffff;line-height:1.25\"> Döner Box - Döner&Pizza</td><td width=\"32px\"></td></tr>"
				+ "<tr><td height=\"18px\" colspan=\"3\"></td></tr></tbody></table></td></tr>"
				+ "<tr><td><table bgcolor=\"#FAFAFA\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"min-width:332px;max-width:600px;border:1px solid #f0f0f0;border-bottom:1px solid #c0c0c0;border-top:0;border-bottom-left-radius:3px;border-bottom-right-radius:3px\">"
				+ "<tbody> <tr height=\"16px\"><td width=\"32px\" rowspan=\"3\"></td><td></td><td width=\"32px\" rowspan=\"3\"></td> </tr>"
				+ "<tr><td><p>親愛的 "+ memberName +" 會員,</p><p>"+ content +"</p><p>若有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。 或者是寄電子郵件:　DonerPizza　<span style=\"color:#659cef\" dir=\"ltr\"><a href=\"mailto:h60915@gmail.com\" target=\"_blank\">&lt;h60915@gmail.com&gt;</a></span></p></td></tr>"
				+ " <tr height=\"32px\"></tr></tbody></table></td></tr> <tr height=\"16\"></tr></tbody></table>";
		return MailContent;
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