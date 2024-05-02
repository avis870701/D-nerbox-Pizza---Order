package com.team6.reservation.model;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ReserveService {
	
	@Autowired
	private ReserveRepository reserveRepository;
	@Autowired
	private JavaMailSender mailSender; 
	
	public List<Reserve> checkInByName(String name,String date){	
		return reserveRepository.checkInByName(name,date);
	}
	
	public List<Reserve> checkInByPhone(String phone){
		return reserveRepository.checkInByPhone(phone);
	}
	
	public List<Reserve> selectReservationData(String date){
		return reserveRepository.selectReservationData(date);
	}
	
	public List<Reserve> selectReservationStatus(){
		return reserveRepository.selectReservationStatus();
	}
	
	public int selectAllCheckedCounts() {
	    LocalDate currentDate = LocalDate.now();       
	    String currentDateAsString = currentDate.toString();
	    Integer result = reserveRepository.selectAllCheckedCounts(currentDateAsString);
	    return (result != null) ? result : 0;
	}
	
	public List<Reserve> selectAllChecked(){
	    LocalDate currentDate = LocalDate.now();       
	    String currentDateAsString = currentDate.toString();
	    return reserveRepository.selectAllChecked(currentDateAsString);
	}
	
	public int selectReservationStatusCounts() {
		return reserveRepository.selectReservationStatusCounts();
	}
	
	public void updateNumberOfPeople(int reservationId, int newNumberOfPeople) {
		reserveRepository.updateNumberOfPeople(reservationId, newNumberOfPeople);
	}

	public void updateReservationDate(int reservationId, String reservation_date) {
		reserveRepository.updateReservationDate(reservationId, reservation_date);
	}
		
	public void updateReservationTime(int reservationId, String reservation_time) {		
		reserveRepository.updateReservationTime(reservationId, reservation_time);
	}
	
	public void deleteReservation(int reservationId) {
		reserveRepository.deleteReservation(reservationId);
	}
	
	public void updateReservationStatus(int reservation_id) {
		reserveRepository.updateReservationStatus(reservation_id);		
	}
	
	
	
	
	//客人點選:明天會報到
	public void updateReservationStatusTo3(int reservationId) {
		reserveRepository.updateReservationStatusTo3(reservationId);
	}
	
	//客人點選:明天不會報到或無回應
	public void updateReservationStatusTo2(int reservationId) {
		reserveRepository.updateReservationStatusTo2(reservationId);
	}
	
	//customerConfirm.html
	public void updateNumberOfPeopleAndReservationStatusTo3(int reservationId, int newNumberOfPeople) {
		reserveRepository.updateNumberOfPeopleAndReservationStatusTo3(reservationId, newNumberOfPeople);
	}

	
	//customerConfirm.html(呈現客人rs=1,cs=0訂位資訊讓客人確認)
	public Reserve selectCustomerTommorowComeOrNot(int reservationId) {
		return reserveRepository.selectCustomerTommorowComeOrNot(reservationId);	 
	}

	//系統掃描rs=1,cs=0的客人是否有 reservationDate - localdate = 1 的客人
	public void selectCustomerTommorowReservation() {
		List<Reserve> tomorrowReservations = reserveRepository.selectCustomerTommorowReservation();
	    if (!tomorrowReservations.isEmpty()) {
	        for (Reserve reservation : tomorrowReservations) {  
	            System.out.println("我要寄信🤑");
				String reservationName = reservation.getReservationName();
				String reservationDate = reservation.getReservationDate();
				String reservationTime = reservation.getReservationTime();
				int numberOfPeople = reservation.getNumberOfPeople();
	            int reservationId= reservation.getReservationId();
				
	            String confirmationLink = "http://localhost:8080/reservation/customerComfirmto3?reservationId=" + reservationId;
	            String updateNumberOfPeopleAndConfirmLink = "http://localhost:8080/reservation/selectCustomerTommorowComeOrNot?reservationId=" + reservationId;
	            String rejectionLink = "http://localhost:8080/reservation/customerComfirmto2?reservationId=" + reservationId;
				
	            String receivers = "ispanteam6@gmail.com";
				String subject ="請確認明日訂位";
	            String content = "親愛的" + reservationName + "先生/小姐，您好！\n感謝您選擇 DonerPizza，預訂時間為：" + reservationDate + " " + reservationTime + "，共計" + numberOfPeople + "位用餐。\n若您確定會前來用餐，請點擊以下連結進行確認：\n" + confirmationLink + "\n若您無法前來用餐，請點擊以下連結進行取消訂位：\n" + rejectionLink + "\n如果有要更改人數，請點擊該連結：\n" + updateNumberOfPeopleAndConfirmLink;
				String from = "DonerPizza<h60915@gmail.com>";
				sendPlainText(receivers, subject, content,from);
	        }
	    } else {
	    	System.out.println("我不要寄信🤯");
	        return;
	    }
	}
	
	
	

	//ispanTeam2要改成會員帳號
	public Reserve InsertReservation(String ispanTeam2, int numberOfPeople, String reservationDate, String phone, String reservationTime, String note, String reservationName) {
		Reserve reserve = new Reserve();
        try {
            reserve.setAccount(ispanTeam2);
            reserve.setNumberOfPeople(numberOfPeople);
            reserve.setReservationName(reservationName);
            reserve.setPhone(phone);
            reserve.setReservationTime(reservationTime);
            reserve.setReservationDate(reservationDate);
            reserve.setNote(note);
            reserve.setReservationStatus(0);
            reserve.setCheckInStatus(0);
            reserve = reserveRepository.save(reserve);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reserve;
    }
	
	//為現場客人新增資料
	public Reserve InsertDineInCustomer(String ispanTeam2, int numberOfPeople, String reservationDate, String reservationTime, String note) {
		Reserve reserve = new Reserve();
        try {
            reserve.setAccount(ispanTeam2);
            reserve.setNumberOfPeople(numberOfPeople);
            reserve.setReservationName("dineInCustomer");
            reserve.setPhone("dineInCustomer");
            reserve.setReservationTime(reservationTime);
            reserve.setReservationDate(reservationDate);
            reserve.setNote(note);
            reserve.setReservationStatus(1);
            reserve.setCheckInStatus(1);
            reserve = reserveRepository.save(reserve);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reserve;
    }
			
	public void updateCheckInStatus(int reservation_id) {
		reserveRepository.updateCheckInStatus(reservation_id);
	}
	public void deleteCheckInStatus(int reservation_id) {
		reserveRepository.deleteCheckInStatus(reservation_id);
	}

	//自動寄信用
    public void sendPlainText(String receivers, String subject, String content, String from) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(receivers);
        message.setSubject(subject);
        message.setText(content);
        message.setFrom(from);

        mailSender.send(message);
    } 
	
}