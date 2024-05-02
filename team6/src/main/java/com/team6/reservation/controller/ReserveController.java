package com.team6.reservation.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.reservation.model.Reserve;
import com.team6.reservation.model.ReserveService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/reservation")
public class ReserveController {
	
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private Reserve reserve;

	//後台進入點&店家查詢待確認預訂訊息的總數
	@RequestMapping(path = "/reservemain.controller", method = { RequestMethod.GET, RequestMethod.POST})
	public String reserveMainAction(Model model) {
		int selectReservationStatusCounts = reserveService.selectReservationStatusCounts();
		reserveService.selectCustomerTommorowReservation();//明天是否有預定的客人?如果有我就寄信
		model.addAttribute("selectReservationStatusCounts",selectReservationStatusCounts);		
		return "forward:/WEB-INF/reservation/jsp/reserveIndex.jsp";
	}
		
	//客人預訂進入點
	@RequestMapping(path = "/customerreservemain.controller", method = RequestMethod.GET)
	public String customerreserveMainAction() {
		return "forward:/WEB-INF/reservation/jsp/cutomerReservePage.jsp";
	}
	
	//依姓名查詢ok
	@GetMapping("/checkInByName")
	public String checkInByName(@RequestParam("nameSelect") String nameSelect,
			Model model) {
		LocalDate currentDate = LocalDate.now();       
	    String currentDateAsString = currentDate.toString();
		List<Reserve> selectName = reserveService.checkInByName(nameSelect,currentDateAsString);
		model.addAttribute("selectName", selectName);
		return "forward:/WEB-INF/reservation/jsp/checkInByName.jsp";
	}
	
	//依電話查詢ok
	@GetMapping("/checkInByPhone")
	public String checkInByPhone(@RequestParam("phoneSelect") String phoneSelect,Model model) {
		List<Reserve> selectByPhone = reserveService.checkInByPhone(phoneSelect);
		model.addAttribute("selectPhone", selectByPhone);
		return "forward:/WEB-INF/reservation/jsp/checkInByPhone.jsp";
	}
	
	//店家查詢已確認後的訂位,依日期查詢(可更改人數,日期,時間)ok
	@GetMapping("/selectByDate")
	public String selectReservationData(@RequestParam("dateSelect") String dateSelect,
			Model model) {
		List<Reserve> dateReservations = reserveService.selectReservationData(dateSelect);
		model.addAttribute("reservations", dateReservations);
		return "forward:/WEB-INF/reservation/jsp/reservationData.jsp";
	}	
	
	//店家查詢尚未確認此訂位ok
	@GetMapping("/selectByStatus")
	public String selectByStatus(Model model) {
		List<Reserve> selectReservationStatus = reserveService.selectReservationStatus();
		model.addAttribute("selectReservationStatus", selectReservationStatus);
		return "forward:/WEB-INF/reservation/jsp/reservationDataConfirm.jsp";
	}
	
	
	//客人新增預訂ok(含訂位完畢寄信功能)
	@PostMapping("/customerReserve")
	public String customerReserve(@RequestParam(value = "people", required = false/*可選的參數*/) int numberOfPeople,
				@RequestParam(value = "date", required = false) String reservationDate,
				@RequestParam(value = "phone", required = false) String phone,
				@RequestParam(value = "time", required = false) String reservationTime,
				@RequestParam(value = "note", required = false) String specialRequests,
				@RequestParam(value = "name", required = false) String reservationName,Model model) 
				{
			UUID uuid = UUID.randomUUID();
			reserve =reserveService.InsertReservation("ispanTeam2",uuid,numberOfPeople, reservationDate, phone, reservationTime,
			specialRequests, reservationName);
			
			String receivers = "ispanteam6@gmail.com";
			String subject ="訂位成功通知信";
			String content = "親愛的" + reservationName + "先生/小姐，您好！\n感謝您選擇 DonerPizza，預訂時間為：" + reservationDate + " " + reservationTime + "，共計" + numberOfPeople + "位用餐。\n若有任何問題或需要協助，歡迎隨時與我們聯繫，客服專線：033345678 。\n祝您用餐愉快！";
			String from = "DonerPizza<h60915@gmail.com>";
			reserveService.sendPlainText(receivers, subject, content,from);
						
			model.addAttribute("insertReservation", reserve);
			return "forward:/WEB-INF/reservation/jsp/reserveSuccess.jsp";
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
		return "forward:/WEB-INF/reservation/jsp/selectAllChecked.jsp";
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
	public void updateNumberOfPeople(@RequestParam(value="reservationId") int reservationId,@RequestParam(value="newNumberOfPeople") int newNumberOfPeople,Model model) {
		//int newNumberOfPeople = Integer.parseInt(newNumberOfPeopleStr);
		reserveService.updateNumberOfPeople(reservationId, newNumberOfPeople);	
	}
	
	//店家更新日期(來自reservationData.jsp)ok
	@PutMapping("/updateReservationDate")
	public void updateReservationDate(@RequestParam(value="reservationId") int reservationId,@RequestParam(value="newDate") String newDate,Model model){
		reserveService.updateReservationDate(reservationId, newDate);
	}
	
	//店家更新時間(來自reservationData.jsp)ok
	@PutMapping("/updateReservationTime")
	public void updateReservationTime(@RequestParam(value="reservationId") int reservationId ,@RequestParam(value = "newTime") String newTime,Model model) {
		reserveService.updateReservationTime(reservationId, newTime);
	}
	
	//店家刪除預約(來自reservationData.jsp)ok
	@DeleteMapping("/deleteReservation")
	public void deleteReservation(@RequestParam(value="reservationId") int reservationId,Model model){
		reserveService.deleteReservation(reservationId);
	}
	
	//店家更新預約狀態,將rs由0改為1(來自由reservationDataConfirm.jsp)ok
	@PutMapping("/confirmReservation")
	public void confirmReservation(@RequestParam(value="reservationId")int reservationId,Model model) {
		reserveService.updateReservationStatus(reservationId);
	}
	
	//店家更新報到狀態,將cs由0改為1(來自checkInByName.jsp)ok
	@PutMapping("/checkInSuccess")
	public void checkInSuccess(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.updateCheckInStatus(reservationId);
	}
	
	//客人預訂確認完但不來了:將rs=2(來自checkInByName.jsp)ok
	@PutMapping("/deleteCheckIn")
	public void deleteCheckIn(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.deleteCheckInStatus(reservationId);		
	}
			
	//客人吃飽了:將cs由1改為2,rs=3~4
	@PutMapping("/deleteCheckInStatusTo2")
	public void deleteCheckInStatusTo2(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.deleteCheckInStatusTo2(reservationId);
	}
		
	//店家不接該筆訂位(rs由0改為5)(來自reservationDataConfirm.jsp)
	@PutMapping("/updateReservationStatusTo5")
	public void updateReservationStatusTo5(@RequestParam(value = "reservationId")int reservationId) {
		reserveService.updateReservationStatusTo5(reservationId);
	}
	
	
	//客人前一天點選確認,將rs由1改為3
	@GetMapping("/customerComfirmto3")
	@ResponseBody
	public String customerComfirmto3(@RequestParam(value = "reservationUuid") UUID reservationUuid) {
		Reserve reserve = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
		if (reserve != null) {
			int reserveStatus = reserve.getReservationStatus();
			if (reserveStatus == 1) {
				reserveService.updateReservationStatusTo3(reservationUuid);
				return "感謝您的確認，明天見😀😀";
			} else {
				return "連結已失效";
			}
		} else {
			return "連結已失效";
		}
	}
	
	//客人前一天點選確認不會去,將rs由1改為2
	@GetMapping("/customerComfirmto2")
	@ResponseBody
	public String customerComfirmto2(@RequestParam(value = "reservationUuid") UUID reservationUuid) {

		Reserve reserve = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
		if(reserve!=null) {
			int reserveStatus = reserve.getReservationStatus();			
			if(reserveStatus==1) {
				reserveService.updateReservationStatusTo2(reservationUuid);		
				return "感謝您的確認，希望下次能再次為您服務😄😄";}
			else {
				return "連結已失效";
				}
			}	
		else {
			return "連結已失效";
		}
	}

	//查詢客人的預訂資訊並顯示在確認信件中(rs=1,cs=0)
	@GetMapping("/selectCustomerTommorowComeOrNot")
	public String selectCustomerTommorowComeOrNot(@RequestParam(value = "reservationUuid") UUID reservationUuid, Model model) {

		Reserve selectCustomerTommorowComeOrNot = reserveService.selectCustomerTommorowComeOrNot(reservationUuid);
	    if (selectCustomerTommorowComeOrNot == null) {
	        return "forward:/WEB-INF/reservation/jsp/fail.jsp";
	    }
	    model.addAttribute("selectCustomerTommorowComeOrNot", selectCustomerTommorowComeOrNot);
	    return "forward:/WEB-INF/reservation/jsp/customerUpdateNumberOfPeople.jsp";    
	}

	//客人前一天想更改人數,並將rs由1改為3
	@GetMapping("/updateNumberOfPeopleAndReservationStatusTo3")
	@ResponseBody
	public String updateNumberOfPeopleAndReservationStatusTo3(@RequestParam(value = "reservationUuid") UUID reservationUuid,@RequestParam(value="newNumberOfPeople") int newNumberOfPeople,Model model) {
		reserveService.updateNumberOfPeopleAndReservationStatusTo3(reservationUuid, newNumberOfPeople);
		return "修改成功";
	}
	
}

