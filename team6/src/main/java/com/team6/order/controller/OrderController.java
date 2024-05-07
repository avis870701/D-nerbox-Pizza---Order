package com.team6.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.order.model.OrderService;

//後段
@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;
	
	//後段進入點
	@RequestMapping(path = "/order.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderMainprocess() {
		return "forward:/WEB-INF/back-jsp/order/IndexOrder.jsp";
	}
	
	

	
	
	

}