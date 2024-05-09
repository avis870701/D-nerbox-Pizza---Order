package com.team6.order.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface OrderRepository extends JpaRepository<Order, String>{

	//前端查詢全部
	@Query(value = "SELECT o FROM Order o WHERE o.hideen = 0 ORDER BY o.orderId DESC", nativeQuery = true)
	List<Order> findAllByHiddenEqualsZero();
	
	//後端查詢全部
	@Query(value = "SELECT * FROM pizzaOrder", countQuery = "SELECT count(*) FROM pizzaOrder", nativeQuery = true)
	Page<Order> findOrderAll(Pageable pageable);
	
	//後端模糊查詢
	@Query(value = "SELECT * FROM pizzaOrder WHERE LOWER(orderId) LIKE %:keyword% OR LOWER(account) LIKE %:keyword% OR LOWER(orderStatus) LIKE %:keyword% OR LOWER(pickup) LIKE %:keyword% OR LOWER(payment) LIKE %:keyword%", nativeQuery = true)
    List<Order> findOrdersByKeyword(@Param("keyword") String keyword);
	
	//更新折扣碼
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.discount = :discount, o.discountPrice = :discountPrice WHERE o.orderId = :orderId")
    void updatDiscountByOrderId(String orderId,String discount);
	
	//更新付款方式
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.payment = :payment WHERE o.orderId = :orderId")
    void updatePaymentByOrderId(String orderId,String payment);
	
	//更新取餐方式
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.pickup = :pickup WHERE o.orderId = :orderId")
    void updatePickupByOrderId(String orderId,String pickup);
	
	//更新訂單狀態
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.orderStatus = :orderstatus WHERE o.orderId = :orderId")
    void updateOrderStatusByOrderId(String orderId,String orderstatus);
	
	//更新取消訂單備註
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.cancelNote = :cancelNote WHERE o.orderId = :orderId")
    void updateCancelNoteByOrderId(String orderId,String cancelNote);
	
	//假刪除
    @Query(value = "UPDATE Order o SET o.hide = :hide WHERE o.orderId = :orderId", nativeQuery = true)
    void hiddenToOne(String orderId,Integer hide);
}