package com.team6.reservation.model;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.team6.member.model.MemberDetailBean;

public interface ReserveRepository extends JpaRepository<Reserve, Integer> {

	@Query(value = "from Reserve where reservationName like concat('%',?1,'%') and reservationStatus = 3 and checkInStatus = 0 and reservationDate = ?2 order by reservationDate asc, reservationTime asc")
	public List<Reserve> checkInByName(String name,String date);
	
	@Query(value = "from Reserve where phone = ?1 and reservationStatus = 3 and checkInStatus = 0 order by reservationDate asc, reservationTime asc")
	public List<Reserve> checkInByPhone(String phone);

	@Query(value = "from Reserve where reservationDate = ?1 and reservationStatus IN (1, 2, 3) and checkInStatus = 0 ORDER BY reservationDate ASC, reservationTime ASC")
	public List<Reserve> selectReservationData(String date);
	
	@Query(value = "from Reserve where reservationStatus = 0 and checkInStatus = 0 ORDER BY reservationDate ASC, reservationTime ASC")
	public List<Reserve> selectReservationStatus();
	
	@Query(value = "SELECT COUNT(*) FROM Reserve WHERE reservationStatus = 0 AND checkInStatus = 0")
	public int selectReservationStatusCounts();

	@Query(value = "from Reserve where checkInStatus= 1 AND reservationStatus IN (3,4) AND reservationDate = ?1 ORDER BY reservationTime ASC" )
	public List<Reserve> selectAllChecked(String reservationDate);

	@Query(value = "SELECT SUM(numberOfPeople) FROM Reserve WHERE reservationStatus IN (3,4) AND checkInStatus = 1 AND reservationDate = ?1")
	public Integer selectAllCheckedCounts(String reservationDate);
		
	@Modifying
	@Query(value = "update Reserve set numberOfPeople = ?2 WHERE reservationId = ?1" )
	public void updateNumberOfPeople(int reservationId, int newNumberOfPeople);
	
	@Modifying
	@Query(value = "update Reserve SET reservationDate = ?2 WHERE reservationId = ?1" )
	public void updateReservationDate(int reservationId, String reservationDate);
	
	@Modifying
	@Query(value = "update Reserve SET reservationTime = ?2 WHERE reservationId = ?1" )
	public void updateReservationTime(int reservationId, String reservationTime);
	
	@Modifying
	@Query(value = "delete FROM Reserve WHERE reservationId = ?1")
	public void deleteReservation(int reservationId);

	@Modifying
	@Query(value = "update Reserve SET reservationStatus = 1 WHERE reservationId= ?1")
	public void updateReservationStatus(int reservationId);
	
	@Modifying
	@Query(value = "update Reserve SET checkInStatus = 1 WHERE reservationId= ?1")
	public void updateCheckInStatus(int reservationId);

	//客人預訂確認完但不來了:將rs=2
	@Modifying
	@Query(value = "update Reserve SET reservationStatus = 2 WHERE reservationId= ?1")
	public void deleteCheckInStatus(int reservation_id);
	
	//客人吃飽了:將cs由1改為2,rs=3~4
	@Modifying
	@Query(value = "update Reserve SET checkInStatus = 2 WHERE reservationId= ?1")
	public void deleteCheckInStatusTo2(int reservation_id);
	

	//待確認預訂訊息-刪除:將rs=5(店家不接該筆預定)
	@Modifying
	@Query(value = "update Reserve SET reservationStatus = 5 WHERE reservationId= ?1" )
	public void updateReservationStatusTo5(int reservationId);
	
	//customerConfirm.html(客人點選:明天會報到)
	@Modifying
	@Query(value = "update Reserve SET reservationStatus = 3 WHERE reservationId= ?1 and reservationStatus = 1")
	public void updateReservationStatusTo3(int reservationId);
	
	//customerConfirm.html(客人點選:明天不會報到或無回應)
	@Modifying
	@Query(value = "update Reserve SET reservationStatus = 2 WHERE reservationId= ?1 and reservationStatus = 1")
	public void updateReservationStatusTo2(int reservationId);
	
	//customerConfirm.html(客人點選:明天要更改人數而且會報到)
	@Modifying
	@Query(value = "update Reserve set numberOfPeople = ?2 , reservationStatus = 3 WHERE reservationId = ?1" )
	public void updateNumberOfPeopleAndReservationStatusTo3(int reservationId, int newNumberOfPeople);
		
	//comfirm.html(呈現客人訂位資訊讓客人確認)
	@Query(value = "from Reserve where reservationId = ?1 and reservationStatus = 1 and checkInStatus = 0 ")
	public Reserve selectCustomerTommorowComeOrNot(int reservationId);
	
	//系統掃描rs=1,cs=0的客人是否有 reservationDate - localdate = 1 的客人
	@Query(value = "FROM Reserve WHERE CAST(reservationDate AS DATE) = DATEADD(day, 1, CAST(GETDATE() AS DATE)) and reservationStatus=1")	
	public List<Reserve> selectCustomerTommorowReservation();
	
	
	//測試用(抓的到mail嗎)
	@Query(value = "SELECT md.mEmail FROM reservation r JOIN memberAccount ma ON r.reservationId = ma.maid JOIN memberDetail md ON ma.maid = md.fk_maId" , nativeQuery = true)
	public List<String> test();
}
