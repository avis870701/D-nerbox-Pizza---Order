package com.team6.order.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrderRepository oRepos;

	@Autowired
	private DetailsRepository dRepos;

	// 後端 查詢訂單全部
	public Page<Order> findOrderAll(Pageable pageable) {
		return oRepos.findOrderAll(pageable);
	}

	// 後端 一般查詢全部
	public List<Order> findAllOrders() {
		return oRepos.findAll();
	}

	// 後端 模糊查詢
	public List<Order> findOrdersByKeyword(String keyword) {
		return oRepos.findOrdersByKeyword(keyword);
	}

	// 後端 查詢單筆訂單明細
	public Order findOrderById(String orderId) {
		Optional<Order> op1 = oRepos.findById(orderId);

		if (op1.isPresent()) {
			return op1.get();
		}

		return null;
	}

	// 後端 查詢單筆餐點明細
	public List<OrderDetails> findDetailsById(String orderId) {
		List<OrderDetails> details = dRepos.findByOrderId(orderId);

		if (!details.isEmpty()) {
			return details;
		}
		return null;
	}

	// 後端 更新折扣碼、金額
	public void updateDiscount(String orderId, String discount, Integer discountPrice) {
		oRepos.updatDiscountByOrderId(orderId, discount, discountPrice);
	}

	// 後端 更新付款方式
	public void updatePayment(String orderId, String payment) {
		oRepos.updatePaymentByOrderId(orderId, payment);
	}

	// 後端 更新取餐方式
	public void updatePickup(String orderId, String pickup) {
		oRepos.updatePickupByOrderId(orderId, pickup);
	}

	// 後端 更新訂單狀態
	public void updateOrderStatus(String orderId, String orderStatus) {
		oRepos.updateOrderStatusByOrderId(orderId, orderStatus);
	}
	
	//後端 更新取消訂單備註
	public void updateCancelNote(String orderId, String cancelNote) {
		oRepos.updateCancelNoteByOrderId(orderId, cancelNote);
	}
	
	//後端 更新商品
	public void updateProduct(Integer detailsId,String productId,String product,String unitPrice) {
		dRepos.updateProductByDetailsId(detailsId, productId, product, unitPrice);
	}
	
	//後端 更新數量
	public void updateQuantity(Integer detailsId,String quantity) {
		dRepos.updateQuantityByDetailsId(detailsId, quantity);
	}
	
	//後端 更新餐點備註
	public void updateNote(Integer detailsId,String note) {
		dRepos.updateNoteByDetailsId(detailsId, note);
	}

	// 後端 刪除餐點明細
	public void deleteOrderDetail(Integer detailsId) {
		dRepos.deleteByDetailsId(detailsId);
	}

	// 新增訂單
	public Order insertOrder(Order order) {
		return oRepos.save(order);
	}

	// 新增餐點
	public OrderDetails insertDetails(OrderDetails orderDetails) {
		return dRepos.save(orderDetails);
	}

}
