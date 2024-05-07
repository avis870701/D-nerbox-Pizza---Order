package com.team6.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.delivery.model.Delivery;
import com.team6.delivery.model.DeliveryService;


@Controller
@RequestMapping("/delivery")
public class DeliveryController {

	@Autowired
	private DeliveryService dService;
//	@Autowired
//	private DeliverystatusService dSService;


	//delivery後台
	//網址 127.0.0.1:8080/delivery/
	@GetMapping("/home")
	public String DeliveryHome(Model model) {
		List<Delivery> delivery = dService.findall();
		model.addAttribute("delivery",delivery);
		return "back-html/delivery/delivery";
	}		
	
	//新增
	@PostMapping("/insert")
	public ResponseEntity<String> addDelivery(@RequestBody Delivery delivery) {
		try {
			dService.insert(delivery);
			return new ResponseEntity<>("新增外送訂單成功", HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<>("新增外送訂單失敗: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@DeleteMapping("/delete/{id}")
	@ResponseBody
	public String delDelivery(@PathVariable("id") int id) {
		dService.DelDelivery(id);
		return	"Redirect:/delivery/";
	}
}
		
	






