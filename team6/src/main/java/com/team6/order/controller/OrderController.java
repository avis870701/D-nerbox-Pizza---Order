package com.team6.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.DetailsRepository;
import com.team6.order.model.Order;
import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderService;
import com.team6.promotions.model.Promotions;
import com.team6.promotions.model.PromotionsRepository;
import com.team6.promotions.model.PromotionsService;

//後段
@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;

	@Autowired
	private PromotionsService pService;

	// 後段進入點 http://localhost:8080/order/order.action
	@RequestMapping(path = "/order.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderMainprocess() {
		return "forward:/WEB-INF/back-jsp/order/OrderIndex.jsp";
	}

	// select all
	@GetMapping(path = "/orderSelectAll")
	@ResponseBody
	public Page<Order> orderSelectAll(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		Pageable pageable = PageRequest.of(page, size, Sort.by("orderId").descending());
		return oService.findOrderAll(pageable);
	}

	// select LIKE order
	@GetMapping(path = "/orderSelectLIKE")
	@ResponseBody
	public List<Order> orderSelectLIKE(@RequestParam(required = false) String keyword) {
		if (keyword != null && !keyword.isEmpty()) {
			// 如果有關鍵字，執行模糊查詢
			return oService.findOrdersByKeyword(keyword);
		} else {
			// 否則，獲取所有資料
			return oService.findAllOrders();
		}
	}

	// select Details by orderId
	@GetMapping("/detailsSelectByID")
	@ResponseBody
	public ResponseEntity<List<OrderDetails>> getOrderDetailsById(@RequestParam("orderId") String orderId) {
		List<OrderDetails> orderDetails = oService.findDetailsById(orderId);
		if (orderDetails != null && !orderDetails.isEmpty()) {
			return ResponseEntity.ok(orderDetails);
		} else {
			return ResponseEntity.notFound().build(); // no information back to 404 Not Found
		}
	}
	
	//order
	//select Promotions discountList first,then update discount
	@GetMapping("/getDiscountList")
	@ResponseBody
	 public List<Promotions> getDiscountList() {
        return pService.selectAllDiscount();
    }
	
	@PutMapping("/updateDiscount")
	public void updateDiscount(@RequestParam String orderId,@RequestParam String discount,Integer discountPrice) {
		oService.updateDiscount(orderId, discount, discountPrice);
	}
	
	//update payment,pickup,orderStatus
	@PutMapping("/updatePPO")
	public void updatePPO(@RequestParam String orderId,
			@RequestParam(required = false) String payment,
			@RequestParam(required = false) String pickup,
			@RequestParam(required = false) String orderStatus) {
		if(payment != null) {
			oService.updatePayment(orderId, payment);
		}else if(pickup != null){
			oService.updatePickup(orderId, pickup);
		}else {
			oService.updateOrderStatus(orderId, orderStatus);
		}
	}
	
	//update cancelNote
	@PutMapping("/updateCancelNote")
	public void updateCancelNote(@RequestParam String orderId,@RequestParam String cancelNote) {
		oService.updateCancelNote(orderId, cancelNote);
	}
	
	//details
	//update product
	
	
	//update note
	@PutMapping("/updateNote")
	public void updateNote(@RequestParam String detailsId,@RequestParam String note) {
		oService.updateNote(Integer.parseInt(detailsId), note);
	}
	

	// deleteDetails by detailsId
	@RequestMapping(value = "/orderDetails/{detailsId}", method = RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteOrderDetail(@PathVariable Integer detailsId) {
		oService.deleteOrderDetail(detailsId);
		Map<String, String> response = new HashMap<>();
		response.put("message", "Order detail deleted successfully.");
		return ResponseEntity.ok(response);
	}

	// update discount&dprice after delete
	@PutMapping("/clearDiscount")
	public void clearDiscount(@RequestParam String orderId) {
		Order order = oService.findOrderById(orderId);
		if(order != null & order.getDiscount() != "") {
			String discount = order.getDiscount() + " 已失效";
			Integer discountPrice = 0;
			oService.updateDiscount(orderId, discount, discountPrice);
		}
	}

}