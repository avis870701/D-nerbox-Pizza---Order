package com.team6.delivery.model;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {

	//修改為已接單
	@Modifying
	@Transactional
	@Query(value = "UPDATE Delivery SET status = 2 WHERE delivery_id = ?", nativeQuery = true)
	public void upddeliverystate(Integer id);
	//修改為已取消
	@Modifying
	@Transactional
	@Query(value = "UPDATE Delivery SET status = 0 WHERE delivery_id = ?", nativeQuery = true)
	public void upddeliverystatezero(Integer id);
	
	
	//查詢 狀態!=0
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status != 0", nativeQuery = true)
	public List<Delivery> findallnotZero();
	//查詢 狀態為1
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status = 1", nativeQuery = true)
	public List<Delivery> findallOne();
	//查詢 狀態為2
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status = 2", nativeQuery = true)
	public List<Delivery> findallTwo();
	//查詢 狀態為3
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status = 3", nativeQuery = true)
	public List<Delivery> findallThree();
	//查詢 狀態為4
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status = 4", nativeQuery = true)
	public List<Delivery> findallFour();
	//查詢 狀態為0
	@Transactional
	@Query(value = "SELECT * FROM Delivery WHERE status = 0", nativeQuery = true)
	public List<Delivery> findallZero();
	
	@Transactional
	@Query(value = "INSERT INTO Delivery(order_id,date,address) VALUES ('?',GETDATE(),'?')", nativeQuery = true)
	public void  add(String orderid,String address);
}
