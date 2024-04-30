package com.team6.reservation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.team6.reservation.model.Reserve;
import com.team6.reservation.model.ReserveService;

@Controller
@RequestMapping("/reservation")
public class ReserveController {
	
	@Autowired
	private ReserveService reserveService;
	@Autowired
	private Reserve reserve;
	
	/*因為thymeleaf會搶路徑,所以要forward:*/

	//後台進入點&店家查詢待確認預訂訊息的總數
	@RequestMapping(path = "/reservemain.controller", method = { RequestMethod.GET, RequestMethod.POST})
	public String reserveMainAction(Model model) {
		int selectReservationStatusCounts = reserveService.selectReservationStatusCounts();
		int selectAllChecked = reserveService.selectAllCheckedCounts();		
		model.addAttribute("selectReservationStatusCounts",selectReservationStatusCounts);		
		model.addAttribute("selectAllChecked",selectAllChecked);	
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
		List<Reserve> selectName = reserveService.checkInByName(nameSelect);
		model.addAttribute("selectName", selectName);
		return "forward:/WEB-INF/reservation/jsp/checkInByName.jsp";
	}
	
	//依電話查詢ok
	@GetMapping("/checkInByPhone")
	public String checkInByPhone(@RequestParam("phoneSelect") String phoneSelect,Model model) {
		List<Reserve> selectByPhone = reserveService.checkInByPhone(phoneSelect);
		model.addAttribute("selectName", selectByPhone);
		return "forward:/WEB-INF/reservation/jsp/checkInByName.jsp";
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
			reserve =reserveService.InsertReservation("ispanTeam2", numberOfPeople, reservationDate, phone, reservationTime,
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
	
	//店家查詢用餐中的客人(rs=1,cs=1)ok
	@GetMapping("/selectAllChecked")
	public String selectAllChecked(Model model) {
		List<Reserve> selectAllChecked = reserveService.selectAllChecked();
		model.addAttribute("selectAllChecked", selectAllChecked);
		return "forward:/WEB-INF/reservation/jsp/selectAllChecked.jsp";
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
	
	//店家刪除用餐狀態,客人用餐完畢後已離開(來自checkInByName.jsp)ok
	@DeleteMapping("/deleteCheckIn")
	public void deleteCheckIn(@RequestParam(value = "reservationId")int reservationId,Model model) {
		reserveService.deleteCheckInStatus(reservationId);		
	}
	
}
