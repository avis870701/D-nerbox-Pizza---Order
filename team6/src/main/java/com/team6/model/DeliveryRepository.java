package com.team6.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {
	
	//軟刪除
	@Transactional
	@Modifying
	@Query(value = "UPDATE delivery SET delstate = 'False'  WHERE id = ?", nativeQuery = true)
	public void UpdateDel(Integer id);
	//復原
	@Transactional
	@Modifying
	@Query(value = "UPDATE delivery SET delstate = 'TRUE'  WHERE id = ?", nativeQuery = true)
	public void RollbackDel(Integer id);
	
	//查詢未刪除
	@Transactional
	@Modifying
	@Query(value = "SELECT * FROM delivery WHERE delstate = 'FALSE';", nativeQuery = true)
	public List<Delivery> findFall();
	//查詢已刪除
	@Transactional
	@Modifying
	@Query(value = "SELECT * FROM delivery WHERE delstate = 'TRUE';", nativeQuery = true)
	public List<Delivery> findTall();
}