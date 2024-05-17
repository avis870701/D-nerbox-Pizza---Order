package com.team6.delivery.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.team6.delivery.model.Data;
import com.team6.delivery.model.Delivery;
import com.team6.delivery.model.DeliveryService;

import jakarta.servlet.http.HttpSession;



@Controller
public class DeliveryOrderController {

	@Autowired
	private DeliveryService dService;
	
//	http://localhost:8080/home
	@GetMapping("/home")
	public String Deliveryhome() {
		return "/front-html/delivery/address";
	}
//	http://localhost:8080/test
	@GetMapping("/test")
	public String home() {
		return "/front-html/delivery/20240517";
	}
	
	@PostMapping("/save")
	@ResponseBody
	public String saveaddress(HttpSession session,@RequestBody Data data) {
//		System.out.println(delivery);
		String address = data.getAddress();
		String date = data.getDate();
		System.out.println(address);
		System.out.println(date);
		session.setAttribute("address", address);
		session.setAttribute("date", date);
		return "成功";
	}
	@GetMapping("/clear")
	@ResponseBody
	public String clearaddress(HttpSession session) {
		
		session.removeAttribute("address");
		session.removeAttribute("date");
		
		return "清除";
	}
	
	@GetMapping("/load")
	@ResponseBody
	public String loadaddress(HttpSession session,Delivery delivery) {
		
		String address	 = (String)session.getAttribute("address");
		String date	 = (String)session.getAttribute("date");
		delivery.setOrderid("20240505125426");
		delivery.setAddress(address);
		delivery.setDate(date);
//		dService.insert(delivery);
		return "地址:" + address + "," +  "日期:" + date ;
	}

	

	
}
