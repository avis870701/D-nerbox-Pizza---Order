package com.team6.order.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrderRepository oRepos;
	
	@Autowired
	private DetailsRepository dRepos;
	
	//後端查詢訂單全部
	public Page<Order> findOrderAll(Pageable pageable) {
	    return oRepos.findOrderAll(pageable);
	}
	
    // 後端一般查詢全部
    public List<Order> findAllOrders() {
        return oRepos.findAll();
    }
	
	//後端模糊查詢
    public List<Order> findOrdersByKeyword(String keyword) {
        return oRepos.findOrdersByKeyword(keyword);
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
	
	// 刪除餐點明細
	public void deleteOrderDetail(Integer detailId) {
        dRepos.deleteById(detailId);
    } 
}
