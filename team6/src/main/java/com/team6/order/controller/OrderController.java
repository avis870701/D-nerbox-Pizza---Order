package com.team6.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.Order;
import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderDetailsDto;
import com.team6.order.model.OrderService;

//後段
@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;

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
        if (orderDetails != null) {
            return ResponseEntity.ok(orderDetails);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
	
	
	//deleteDetails by detailsId
	@DeleteMapping("/orderDetails/{detailId}")
	@ResponseBody
	public ResponseEntity<Integer> deleteOrderDetail(@PathVariable Integer detailId) {
	    oService.deleteOrderDetail(detailId);
	    return ResponseEntity.ok().build();
	}
	
	@GetMapping(path = "/detailsDelete")
	public String deleteDetailsButton(@RequestParam("detailsId") Integer detailsId,
	        @RequestParam("orderId") String orderId, Model model) {
	    oService.deleteOrderDetail(detailsId);
	    return "";
	}
	
}