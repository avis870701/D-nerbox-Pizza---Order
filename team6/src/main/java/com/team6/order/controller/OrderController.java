package com.team6.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.Order;
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


}