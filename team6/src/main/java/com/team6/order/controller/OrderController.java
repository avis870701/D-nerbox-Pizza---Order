package com.team6.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.team6.order.model.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;
	
	//前端store進入點
	@RequestMapping(path = "/pizzaOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public String PizzaOrderIndex() {
		return "forward:/WEB-INF/front-jsp/order/store.jsp";
	}
	

}