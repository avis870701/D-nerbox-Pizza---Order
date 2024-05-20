package com.team6.reservation.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
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

import com.team6.member.model.EmployeeAccountBean;
import com.team6.member.model.MemberAccountBean;
import com.team6.reservation.model.Reserve;
import com.team6.reservation.model.ReserveService;

import jakarta.servlet.http.HttpSession;

@SuppressWarnings("rawtypes")
@Controller
@RequestMapping("/reservation")
public class ReserveController {
	
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private Reserve reserve;

	/*=====================================================後台=====================================================*/
	
	//後台進入點&店家查詢待確認預訂訊息的總數
	@RequestMapping(path = "/reservemain.controller", method = { RequestMethod.GET, RequestMethod.POST})
	public String reserveMainAction(Model model) {
		int selectReservationStatusCounts = reserveService.selectReservationStatusCounts();
		reserveService.selectCustomerTommorowReservation();//明天是否有預定的客人?如果有我就寄信(html)
		model.addAttribute("selectReservationStatusCounts",selectReservationStatusCounts);		
		return "forward:/WEB-INF/back-jsp/reservation/reserveIndex.jsp";
	}
	
//	//後台進入點&店家查詢待確認預訂訊息的總數&要有session才能登入
//	@RequestMapping(path = "/reservemain.controller", method = { RequestMethod.GET, RequestMethod.POST})
//	public String reserveMainAction(@SessionAttribute(value = "emp",required = false)EmployeeAccountBean bean,HttpSession session,Model model) {
//		if(bean != null) {
//			int selectReservationStatusCounts = reserveService.selectReservationStatusCounts();
//			reserveService.selectCustomerTommorowReservation();//明天是否有預定的客人?如果有我就寄信(html)
//			model.addAttribute("selectReservationStatusCounts",selectReservationStatusCounts);		
//			return "forward:/WEB-INF/back-jsp/reservation/reserveIndex.jsp";
//		} return "forward:/WEB-INF/back-jsp/EmpLogin.jsp";
//	}
		
	
	//依姓名查詢ok
	@GetMapping("/checkInByName")
	public String checkInByName(@RequestParam("nameSelect") String nameSelect,
			Model model) {
		LocalDate currentDate = LocalDate.now();       
	    String currentDateAsString = currentDate.toString();
		List<Reserve> selectName = reserveService.checkInByName(nameSelect,currentDateAsString);
		model.addAttribute("selectName", selectName);
		return "forward:/WEB-INF/back-jsp/reservation/checkInByName.jsp";
	}
	
	//依電話查詢ok
	@GetMapping("/checkInByPhone")
	public String checkInByPhone(@RequestParam("phoneSelect") String phoneSelect,Model model) {
		List<Reserve> selectByPhone = reserveService.checkInByPhone(phoneSelect);
		model.addAttribute("selectPhone", selectByPhone);
		return "forward:/WEB-INF/back-jsp/reservation/checkInByPhone.jsp";
	}
	
	//店家查詢已確認後的訂位,依日期查詢(可更改人數,日期,時間)ok
	@GetMapping("/selectByDate")
	public String selectReservationData(@RequestParam("dateSelect") String dateSelect,
			Model model) {
		List<Reserve> dateReservations = reserveService.selectReservationData(dateSelect);
		model.addAttribute("reservations", dateReservations);
		return "forward:/WEB-INF/back-jsp/reservation/reservationData.jsp";
	}	
	
	//店家查詢尚未確認此訂位ok
	@GetMapping("/selectByStatus")
	public String selectByStatus(Model model) {
		List<Reserve> selectReservationStatus = reserveService.selectReservationStatus();
		model.addAttribute("selectReservationStatus", selectReservationStatus);
		return "forward:/WEB-INF/back-jsp/reservation/reservationDataConfirm.jsp";
	}
			
	//店家新增現場客人ok
	@PostMapping("/dineInCustomer")
	public String dineInCustomer(@RequestParam(value = "people", required = false/*可選的參數*/) int numberOfPeople,
				@RequestParam(value = "date", required = false) String reservationDate,
				@RequestParam(value = "phone", required = false) String phone,
				@RequestParam(value = "time", required = false) String reservationTime,
				@RequestParam(value = "note", required = false) String specialRequests,
				@RequestParam(value = "name", required = false) String reservationName,Model model) 
				{
			reserve =reserveService.InsertDineInCustomer("ispanTeam2", numberOfPeople, reservationDate, reservationTime,
			specialRequests);
			model.addAttribute("insertReservation", reserve);
			return "redirect:reservemain.controller";
		}
	
	//店家查詢用餐中的客人(rs=3~4,cs=1)ok
	@GetMapping("/selectAllChecked")
	public String selectAllChecked(Model model) {
		List<Reserve> selectAllChecked = reserveService.selectAllChecked();
		model.addAttribute("selectAllChecked", selectAllChecked);
		return "forward:/WEB-INF/back-jsp/reservation/selectAllChecked.jsp";
	}
	
	//目前用餐客人人數顯示
	@GetMapping("/selectAllCheckedCounts")
	@ResponseBody
	public int selectAllCheckedCounts() {
		int selectAllChecked = reserveService.selectAllCheckedCounts();
		return selectAllChecked;
	}
	
	//店家更新人數(來自reservationData.jsp)ok
	@PutMapping("/updateNumberOfPeople")
	@ResponseBody
	public ResponseEntity updateNumberOfPeople(@RequestParam(value="reservationId") int reservationId,@RequestParam(value="newNumberOfPeople") int newNumberOfPeople,Model model) {
		reserveService.updateNumberOfPeople(reservationId, newNumberOfPeople);
		return ResponseEntity.ok().body("good");
	}
	
	//店家更新日期(來自reservationData.jsp)ok
	@PutMapping("/updateReservationDate")
	@ResponseBody
	public ResponseEntity updateReservationDate(@RequestParam(value="reservationId") int reservationId,@RequestParam(value="newDate") String newDate,Model model){
		reserveService.updateReservationDate(reservationId, newDate);
		return ResponseEntity.ok().body("good");
	}
	
	//店家更新時間(來自reservationData.jsp)ok
	@PutMapping("/updateReservationTime")
	@ResponseBody
	public ResponseEntity updateReservationTime(@RequestParam(value="reservationId") int reservationId ,@RequestParam(value = "newTime") String newTime,Model model) {
		reserveService.updateReservationTime(reservationId, newTime);
		return ResponseEntity.ok().body("good");
	}
	
	//店家刪除預約(來自reservationData.jsp)ok
	@DeleteMapping("/deleteReservation")
	@ResponseBody
	public ResponseEntity deleteReservation(@RequestParam(value="reservationId") int reservationId,Model model){
		reserveService.deleteReservation(reservationId);
		return ResponseEntity.ok().body("good");
	}
	
	//店家更新預約狀態,將rs由0改為1(來自由reservationDataConfirm.jsp)ok
	@PutMapping("/confirmReservation")
	@ResponseBody
	public ResponseEntity confirmReservation(@RequestParam(value="reservationId")int reservationId,Model model) {
		reserveService.updateReservationStatus(reservationId);
		return ResponseEntity.ok().body("good");
	}
	
	//店家更新報到狀態,將cs由0改為1(來自checkInByName.jsp)ok
	@PutMapping("/checkInSuccess")
	@ResponseBody
	public ResponseEntity checkInSuccess(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.updateCheckInStatus(reservationId);
		return ResponseEntity.ok().body("good");
	}
	
	//客人預訂確認完但不來了:將rs=2(來自checkInByName.jsp)ok
	@PutMapping("/deleteCheckIn")
	@ResponseBody
	public ResponseEntity deleteCheckIn(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.deleteCheckInStatus(reservationId);	
		return ResponseEntity.ok().body("good");
	}
			
	//客人吃飽了:將cs由1改為2,rs=3~4
	@PutMapping("/deleteCheckInStatusTo2")
	@ResponseBody
	public ResponseEntity deleteCheckInStatusTo2(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.deleteCheckInStatusTo2(reservationId);
		return ResponseEntity.ok().body("good");
	}
		
	//店家不接該筆訂位(rs由0改為5)(來自reservationDataConfirm.jsp)
	@PutMapping("/updateReservationStatusTo5")
	@ResponseBody
	public ResponseEntity updateReservationStatusTo5(@RequestParam(value = "reservationId")int reservationId) {
		reserveService.updateReservationStatusTo5(reservationId);
		return ResponseEntity.ok().body("good");
	}
	
	//店家手動更改reservationStatus
	@GetMapping("/autoUpdateReservationStatus")
	@ResponseBody
	public ResponseEntity autoUpdateReservationStatus(@RequestParam(value = "reservationStatus")int reservationStatus,
							@RequestParam(value = "reservationId")int reservationId) {
		reserveService.autoUpdateReservationStatus(reservationStatus, reservationId);	
		return ResponseEntity.ok().body("good");
	}
	
	//分頁:搜尋歷史訂位紀錄(日期時間由小到大)
	@GetMapping("/selectByMonthAndYear/{pageNo}")
	public String selectHistoryReservation(@PathVariable("pageNo") int pageNo,@RequestParam(value = "monthSelect") String monthSelect,Model model) {
		int pageSize = 10;
		if(pageNo <= 0) {
			pageNo = 1;
		}
		Pageable pageable = PageRequest.of(pageNo-1, pageSize);
		
		String[] yearAndMonth = monthSelect.split("-");
		String year = yearAndMonth[0];
		String month = yearAndMonth[1];
		Page<Reserve> historyReservation = reserveService.selectPageHistoryReservation(year, month, pageable);
		
		int totalPages = historyReservation.getTotalPages();
		long totalElements = historyReservation.getTotalElements();
		
		model.addAttribute("totalPages",totalPages);
		model.addAttribute("totalElements",totalElements);
		model.addAttribute("historyReservation",historyReservation);
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		return "forward:/WEB-INF/back-jsp/reservation/historyReservation.jsp";
	}
		
	//匯出歷史訂位(依年月)成csv
	@GetMapping("/saveDetailToCSV")
	public String saveDetailToCSV(@RequestParam(value = "yearSelect") String yearSelect,@RequestParam(value = "monthSelect") String monthSelect) {
		reserveService.saveDetailToCSV(yearSelect, monthSelect);
		return "redirect:selectByMonthAndYear/1?monthSelect=" + yearSelect + "-" + monthSelect;
		//return "redirect:selectByMonthAndYear?monthSelect=" + yearSelect+"-"+monthSelect;
	}
	
	/*=====================================================前台=====================================================*/
	
	//客人預訂進入點
	@GetMapping("/customerreservemain.controller")
	public String customerreserveMainAction() {
		return "forward:/WEB-INF/front-jsp/reservation/cutomerReservePage.jsp";
	}
		
	//客人新增預訂ok(含訂位完畢寄信功能)html信
	@PostMapping("/customerReserve")
	public String customerReserve(@RequestParam(value = "people", required = false/*可選的參數*/) int numberOfPeople,
				@RequestParam(value = "date", required = false) String reservationDate,
				@RequestParam(value = "phone", required = false) String phone,
				@RequestParam(value = "time", required = false) String reservationTime,
				@RequestParam(value = "note", required = false) String specialRequests,
				@RequestParam(value = "name", required = false) String reservationName,
				@RequestParam(value = "email", required = false) String mail,
				Model model) 
				{
			UUID uuid = UUID.randomUUID();
			reserve =reserveService.InsertReservation("ispan6",uuid,numberOfPeople, reservationDate, phone,mail, reservationTime,
			specialRequests, reservationName);			
			
			String link = "http://localhost:8080/reservation/cutomerReserveCheck?reservationUuid=" + uuid;
			String receivers = mail;
			String subject ="訂位成功通知信";
			String from = "DonerPizza<h60915@gmail.com>";
			String content = "<html><body style=\"font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px;\">" +
	                "<div style=\"max-width: 600px; margin: auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\">" +
	                "<h2 style=\"text-align: center; color: #333;\">訂位成功通知信</h2>" +
	                "<p>親愛的 <strong>" + reservationName + " 先生/小姐</strong>，您好！</p>" +
	                "<p>感謝您選擇 DonerPizza，以下是您的訂位資訊：</p>" +
	                "<table style=\"width: 100%; border-collapse: collapse; margin: 20px 0;\">" +
	                "<tr>" +
	                "<th style=\"border: 1px solid #ddd; padding: 8px; background-color: #f2f2f2;\">項目</th>" +
	                "<th style=\"border: 1px solid #ddd; padding: 8px; background-color: #f2f2f2;\">內容</th>" +
	                "</tr>" +
	                "<tr>" +
	                "<td style=\"border: 1px solid #ddd; padding: 8px;\">預訂時間</td>" +
	                "<td style=\"border: 1px solid #ddd; padding: 8px;\">" + reservationDate + " " + reservationTime + "</td>" +
	                "</tr>" +
	                "<tr>" +
	                "<td style=\"border: 1px solid #ddd; padding: 8px;\">用餐人數</td>" +
	                "<td style=\"border: 1px solid #ddd; padding: 8px;\">" + numberOfPeople + " 位</td>" +
	                "</tr>" +
	                "</table>" +
	                "<p>若有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。</p>" +
	                "<p>祝您用餐愉快！</p>" +
	                "<div style=\"text-align: center; margin-top: 20px;\">" +
	                "<a href=\"" + link + "\" style=\"background-color: #ff6347; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;\">確認訂位資訊</a>" +
	                "</div>" +
	                "</div>" +
	                "<div style=\"text-align: center;\">" +
	                "<img src=\"cid:menu\" alt=\"menu\" style=\"max-width: 33.33%;\">" +
	                "</div>" +
	                "</body></html>";



			
			reserveService.sendSimpleHtml(from,receivers,subject,content);
					
			model.addAttribute("insertReservation", reserve);
			return "forward:/WEB-INF/front-jsp/reservation/reserveSuccess.jsp";
		}

	//顯示給客人看他目前的訂位狀態
	@GetMapping("/cutomerReserveCheck")
	 public String customerReserveCheck(@RequestParam(value = "reservationUuid") UUID reservationUuid, Model model) {
		Reserve customerReserveCheck = reserveService.customerReserveCheck(reservationUuid);
		model.addAttribute("customerReserveCheck", customerReserveCheck);
		return "forward:/WEB-INF/front-jsp/reservation/customerReserveCheck.jsp";
	}
	
	//客人前一天點選確認,將rs由1改為3
	@GetMapping("/customerComfirmto3")
	public String customerComfirmto3(@RequestParam(value = "reservationUuid") UUID reservationUuid) {
		Reserve reserve = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
		if (reserve != null) {
			int reserveStatus = reserve.getReservationStatus();
			if (reserveStatus == 1) {
				reserveService.updateReservationStatusTo3(reservationUuid);
				return "forward:/WEB-INF/back-jsp/reservation/success.jsp";
			} else {
				return "forward:/WEB-INF/back-jsp/reservation/fail.jsp";
			}
		} else {
			return "forward:/WEB-INF/front-jsp/reservation/fail.jsp";
		}
	}
	
	//客人前一天點選確認不會去,將rs由1改為2
	@GetMapping("/customerComfirmto2")
	public String customerComfirmto2(@RequestParam(value = "reservationUuid") UUID reservationUuid) {

		Reserve reserve = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
		if(reserve!=null) {
			int reserveStatus = reserve.getReservationStatus();			
			if(reserveStatus==1) {
				reserveService.updateReservationStatusTo2(reservationUuid);		
				return "forward:/WEB-INF/front-jsp/reservation/success.jsp";}
			else {
				return "forward:/WEB-INF/front-jsp/reservation/fail.jsp";
				}
			}	
		else {
			return "forward:/WEB-INF/front-jsp/reservation/fail.jsp";
		}
	}
	
	//查詢客人的預訂資訊並顯示在確認信件中(rs=1,cs=0)
	@GetMapping("/selectCustomerTommorowComeOrNot")
	public String selectCustomerTommorowComeOrNot(@RequestParam(value = "reservationUuid") UUID reservationUuid, Model model) {

		Reserve selectCustomerTommorowComeOrNot = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
	    if (selectCustomerTommorowComeOrNot == null) {
	    	return "forward:/WEB-INF/front-jsp/reservation/fail.jsp";
	    }
	    model.addAttribute("selectCustomerTommorowComeOrNot", selectCustomerTommorowComeOrNot);
	    return "forward:/WEB-INF/front-jsp/reservation/customerUpdateNumberOfPeople.jsp";    
	}
	
	//客人前一天想更改人數,並將rs由1改為3
	@GetMapping("/updateNumberOfPeopleAndReservationStatusTo3")
	public String updateNumberOfPeopleAndReservationStatusTo3(@RequestParam(value = "reservationUuid") UUID reservationUuid,@RequestParam(value="newNumberOfPeople") int newNumberOfPeople,Model model) {
		reserveService.updateNumberOfPeopleAndReservationStatusTo3(reservationUuid, newNumberOfPeople);
	    return "forward:/WEB-INF/front-jsp/reservation/success.jsp"; 
	}
	
	// 會員端:給客人查詢歷史地位紀錄(排除accountBean=null)
	@GetMapping("/selectHistoryReservationByCustomer")
	@ResponseBody
	public ResponseEntity<?> selectHistoryReservationByCustomer(HttpSession session, Model model) {
	    MemberAccountBean accountBean = (MemberAccountBean) session.getAttribute("member");
	    if (accountBean == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("777");
	    }

	    String account = accountBean.getmAccount();
	    System.out.println("印啦:" + account);

	    List<Reserve> selectHistoryReservationByCustomer = reserveService.selectHistoryReservationByCustomer(account);
	    model.addAttribute("selectHistoryReservationByCustomer", selectHistoryReservationByCustomer);
	    return ResponseEntity.ok(selectHistoryReservationByCustomer);
	}

	
	
	
	
	/*暫時未用到*/
	
//	//session測試
//	@GetMapping("/testtttt")
//	@ResponseBody
//	public String test(HttpSession session) {
//		
//		MemberAccountBean accountBean = (MemberAccountBean)session.getAttribute("member");
//		System.out.println(accountBean.getDetailBean().getmEmail());
//		
//		return accountBean.getDetailBean().getmEmail();
//	}
	
//	//分頁:搜尋歷史訂位紀錄(日期時間由大到小)
//	@GetMapping("/selectByMonthAndYear/{pageNo}")
//	public String selectPageHistoryReservationByDESC(@PathVariable("pageNo") int pageNo,@RequestParam(value = "monthSelect") String monthSelect,Model model) {
//		int pageSize = 10;
//		if(pageNo <= 0) {
//			pageNo = 1;
//		}
//		Pageable pageable = PageRequest.of(pageNo-1, pageSize);
//		
//		String[] yearAndMonth = monthSelect.split("-");
//		String year = yearAndMonth[0];
//		String month = yearAndMonth[1];
//		Page<Reserve> historyReservation = reserveService.selectPageHistoryReservationByDESC(year, month, pageable);
//		
//		int totalPages = historyReservation.getTotalPages();
//		long totalElements = historyReservation.getTotalElements();
//		
//		model.addAttribute("totalPages",totalPages);
//		model.addAttribute("totalElements",totalElements);
//		model.addAttribute("historyReservation",historyReservation);
//		model.addAttribute("year",year);
//		model.addAttribute("month",month);
//		return "forward:/WEB-INF/back-jsp/reservation/historyReservation.jsp";
//	}
	
	//搜尋歷史訂位紀錄
//	@GetMapping("/selectByMonthAndYear")
//	public String selectHistoryReservation(@RequestParam(value = "monthSelect") String monthSelect,Model model) {
//		
//		String[] yearAndMonth = monthSelect.split("-");
//		String year = yearAndMonth[0];
//		String month = yearAndMonth[1];
//		List<Reserve> historyReservation = reserveService.selectHistoryReservation(year,month);
//		model.addAttribute("historyReservation",historyReservation);
//		model.addAttribute("year",year);
//		model.addAttribute("month",month);
//		return "forward:/WEB-INF/back-jsp/reservation/historyReservation.jsp";
//	}
	
//	//客人新增預訂ok(含訂位完畢寄信功能)純文字信
//	@PostMapping("/customerReserve")
//	public String customerReserve(@RequestParam(value = "people", required = false/*可選的參數*/) int numberOfPeople,
//				@RequestParam(value = "date", required = false) String reservationDate,
//				@RequestParam(value = "phone", required = false) String phone,
//				@RequestParam(value = "time", required = false) String reservationTime,
//				@RequestParam(value = "note", required = false) String specialRequests,
//				@RequestParam(value = "name", required = false) String reservationName,
//				@RequestParam(value = "email", required = false) String mail,
//				Model model) 
//				{
//			UUID uuid = UUID.randomUUID();
//			reserve =reserveService.InsertReservation("ispan6",uuid,numberOfPeople, reservationDate, phone,mail, reservationTime,
//			specialRequests, reservationName);			
//			
//			String link = "http://localhost:8080/reservation/cutomerReserveCheck?reservationUuid=" + uuid;
//			String receivers = mail;
//			String subject ="訂位成功通知信";
//			String content = "親愛的" + reservationName + "先生/小姐，您好！\n感謝您選擇 DonerPizza，預訂時間為：" + reservationDate + " " + reservationTime + "，共計" + numberOfPeople + "位用餐。\n以下是您的訂位資訊"+link+"\n若有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。\n祝您用餐愉快！";
//			String from = "DonerPizza<h60915@gmail.com>";
//			reserveService.sendPlainText(receivers, subject, content,from);
//						
//			model.addAttribute("insertReservation", reserve);
//			return "forward:/WEB-INF/front-jsp/reservation/reserveSuccess.jsp";
//		}
	
//	//會員端:給客人查詢歷史地位紀錄
//	@GetMapping("/selectHistoryReservationByCustomer")
//	@ResponseBody
//	public List<Reserve> selectHistoryReservationByCustomer(String account, HttpSession session, Model model) {
//	    MemberAccountBean accountBean = (MemberAccountBean) session.getAttribute("member");	    	
//	        account = accountBean.getmAccount();
//	        
//	        System.out.println("印啦"+account);
//	        List<Reserve> selectHistoryReservationByCustomer = reserveService.selectHistoryReservationByCustomer(account);
//	        
//	        model.addAttribute("selectHistoryReservationByCustomer", selectHistoryReservationByCustomer);
//	        return selectHistoryReservationByCustomer;
//	}
}

