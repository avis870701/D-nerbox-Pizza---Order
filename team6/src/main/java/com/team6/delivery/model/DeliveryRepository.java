package com.team6.delivery.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {

	
	
	@Query(value =  "SELECT delivery_id,order_id,date,address ,status_name FROM delivery d JOIN DeliveryStatus ds ON d.status = ds.statusid WHERE d.status = 1", nativeQuery = true)
	public List<Delivery> findstatus();
}
