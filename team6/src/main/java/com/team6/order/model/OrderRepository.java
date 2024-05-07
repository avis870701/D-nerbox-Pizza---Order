package com.team6.order.model;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface OrderRepository extends JpaRepository<Order, String>{

	//前端查詢全部
	@Query("SELECT o FROM Order o WHERE o.hideen = 0 ORDER BY o.orderId DESC")
	List<Order> findAllByHiddenEqualsZero();
	
	//後端查詢全部 sort:順序由大到小
	List<Order> findAll(Sort sort);
	
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
	@Transactional
    @Modifying
    @Query("UPDATE Order o SET o.hidden = :hidden WHERE o.orderId = :orderId")
    void hiddenToOne(String orderId,Integer hidden);
}
