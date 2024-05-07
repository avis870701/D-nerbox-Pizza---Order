package com.team6.order.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrderRepository oRepos;

	@Autowired
	private DetailsRepository dRepos;

	//前端查詢訂單全部
	public List<Order> findAllByHiddenEqualsZero(){
		return oRepos.findAllByHiddenEqualsZero();
	}
	
	//後端查詢訂單全部
	public List<Order> findOrderAll() {
		return oRepos.findAll();
	}

	// 查詢單筆訂單
	public Order findOrderById(String orderId) {
		Optional<Order> op1 = oRepos.findById(orderId);

		if (op1.isPresent()) {
			return op1.get();
		}

		return null;
	}

	// 查詢單筆訂單明細
	public List<OrderDetails> findDetailsById(String orderId) {
		List<OrderDetails> details = dRepos.findByOrderId(orderId);

		if (!details.isEmpty()) {
			return details;
		}
		return null;
	}

	// 新增訂單
	public Order insertOrder(Order order) {
		return oRepos.save(order);
	}

	// 新增餐點
	public OrderDetails insertDetails(OrderDetails orderDetails) {
		return dRepos.save(orderDetails);
	}
	
	// 更新折扣碼 discount
	public void updateDiscountByOrderId(String orderId,String discount) {
		oRepos.updatDiscountByOrderId(orderId, discount);
	}
	
	// 更新訂單 payment
	public void updatePaymentByOrderId(String orderId, String payment) {
		oRepos.updatePaymentByOrderId(orderId, payment);
	}

	// 更新訂單 pickup
	public void updatePickupByOrderId(String orderId, String pickup) {
		oRepos.updatePickupByOrderId(orderId, pickup);
	}

	// 更新訂單 orderstatus
	public void updateOrderStatusByOrderId(String orderId, String orderStatus) {
		oRepos.updateOrderStatusByOrderId(orderId, orderStatus);
	}
	
	//更新訂單取消備註
	public void updateCancelNoteByOrderId(String orderId,String cancelNote) {
		oRepos.updateCancelNoteByOrderId(orderId, cancelNote);
	}

	// 提供給客人 假刪除訂單
	public void hiddenToOne(String orderId, Integer hidden) {
		oRepos.hiddenToOne(orderId, hidden);
	}
	// 更新餐點明細 product
	public void updateProductByDetailsId(Integer detailsId, String product, String productId, String unitPrice) {
		dRepos.updateProductByDetailsId(detailsId, product, productId, unitPrice);
	}

	// 更新餐點明細 quantity
	public void updateQuantityByDetailsId(Integer detailsId, String quantity) {
		dRepos.updateQuantityByDetailsId(detailsId, quantity);
	}

	// 更新餐點明細 note
	public void updateNoteByDetailsId(Integer detailsId, String note) {
		dRepos.updateNoteByDetailsId(detailsId, note);
	}

	// 刪除餐點明細
	public void deleteDetailsById(Integer detailsId) {
		dRepos.deleteById(detailsId);
	}

	// 刪除訂單+明細 預計不會用到
		public void deleteBothById(String orderId) {
			dRepos.deleteByOrderId(orderId);
			oRepos.deleteById(orderId);
		}

}
