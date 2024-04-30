package com.team6.order.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import jakarta.transaction.Transactional;

public interface OrderRepository extends JpaRepository<OrderBean, String>{

	@Transactional
    @Modifying
    @Query("UPDATE OrderBean o SET o.payment = :payment WHERE o.orderId = :orderId")
    void updatePaymentByOrderId(String orderId,String payment);
	
	@Transactional
    @Modifying
    @Query("UPDATE OrderBean o SET o.pickup = :pickup WHERE o.orderId = :orderId")
    void updatePickupByOrderId(String orderId,String pickup);
	
	@Transactional
    @Modifying
    @Query("UPDATE OrderBean o SET o.orderStatus = :orderstatus WHERE o.orderId = :orderId")
    void updateOrderStatusByOrderId(String orderId,String orderstatus);
	
}
