package com.team6.delivery.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


import com.team6.delivery.model.Data;
import com.team6.delivery.model.DeliveryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeliveryOrderController {

	@Autowired
	private DeliveryService dService;
	
//	http://localhost:8080/home
	@GetMapping("/home")
	public String Delivery() {
		return "/front-html/delivery/delivery";
	}

	@PostMapping("/address")
	public  ResponseEntity<String> Saveaddress(HttpSession session,@RequestBody Data Data) {
		
		try {
			String address = Data.getAddress();
//			dService.insert();
//			dService.add(address,"20240505200113","1");
			System.out.println(address);
			session.setAttribute("address",address);
			return new ResponseEntity<>("更新外送訂單成功", HttpStatus.CREATED);
		} catch(Exception e) {
			return new ResponseEntity<>("更新外送訂單失敗: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
}
