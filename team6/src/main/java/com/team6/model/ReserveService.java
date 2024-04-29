package com.team6.model;

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
	
	public List<Reserve> checkInByName(String name){
		return reserveRepository.checkInByName(name);
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

    public void sendPlainText(String receivers, String subject, String content, String from) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(receivers);
        message.setSubject(subject);
        message.setText(content);
        message.setFrom(from);

        mailSender.send(message);
    } 
	
}