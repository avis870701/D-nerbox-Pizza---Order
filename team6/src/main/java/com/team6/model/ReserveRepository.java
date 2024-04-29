package com.team6.model;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReserveRepository extends JpaRepository<Reserve, Integer> {

	@Query(value = "from Reserve where reservationName like concat('%',?1,'%') and reservationStatus = 1 and checkInStatus = 0 order by reservationDate asc, reservationTime asc")
	public List<Reserve> checkInByName(String name);
	
	@Query(value = "from Reserve where phone like concat('%',?1,'%') and reservationStatus = 1 and checkInStatus = 0 order by reservationDate asc, reservationTime asc")
	public List<Reserve> checkInByPhone(String phone);

	@Query(value = "from Reserve where reservationDate = ?1 and reservationStatus = 1 and checkInStatus = 0 ORDER BY reservationDate ASC, reservationTime ASC")
	public List<Reserve> selectReservationData(String date);
	
	@Query(value = "from Reserve where reservationStatus = 0 and checkInStatus = 0 ORDER BY reservationDate ASC, reservationTime ASC")
	public List<Reserve> selectReservationStatus();
	
	@Query(value = "SELECT COUNT(*) FROM Reserve WHERE reservationStatus = 0 AND checkInStatus = 0")
	public int selectReservationStatusCounts();

	@Query(value = "from Reserve where checkInStatus= 1 AND reservationStatus= 1 AND reservationDate = ?1 ORDER BY reservationTime ASC" )
	public List<Reserve> selectAllChecked(String reservationDate);

	@Query(value = "SELECT SUM(numberOfPeople) FROM Reserve WHERE reservationStatus = 1 AND checkInStatus = 1 AND reservationDate = ?1")
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

	@Modifying
	@Query(value = "delete FROM Reserve WHERE reservationId= ?1")
	public void deleteCheckInStatus(int reservation_id);

	
}
