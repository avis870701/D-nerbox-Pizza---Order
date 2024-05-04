package com.team6.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team6.delivery.model.Delivery;
import com.team6.delivery.model.DeliveryService;


@Controller
@RequestMapping("/delivery")
public class DeliveryController {

	@Autowired
	private DeliveryService dService;
	

	//delivery後台
	//網址 127.0.0.1:8080/delivery/
	@GetMapping("/")
	public String Delivery(Model model) {
		List<Delivery> delivery = dService.finall();
//		List<Delivery> delivery = dService.findstatus();
		model.addAttribute("delivery",delivery);
		return "/back-html/delivery/delivery";
	}
}
	





