package com.team6.delivery.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.delivery.model.Delivery;
import com.team6.delivery.model.DeliveryService;
import com.team6.order.model.DetailsRepository;
import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderRepository;
import com.team6.order.model.OrderService;
import com.team6.promotions.model.Promotions;


@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	

	@Autowired
	private DeliveryService dService;
	@Autowired
	private DetailsRepository dRepos;
	



	//delivery後台
	//網址 http://127.0.0.1:8080/delivery/home
	
	
	//匯出json
	@PostMapping("/json")
	public ResponseEntity<String> saveJson() {
		try {
			dService.saveJson();
			return ResponseEntity.ok("JSON數據已成功寫入");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("無法保存JSON數據：" + e.getMessage());
		}
	}
	//匯出xml
	@PostMapping("/xml")
	public ResponseEntity<String> savexml() {
		try {
			dService.saveXml();
			return ResponseEntity.ok("xml數據已成功寫入");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("無法保存xml數據：" + e.getMessage());
		}
	}
	//匯出excel
	@PostMapping("/excel")
	public ResponseEntity<String> saveexcel() {
		try {
			dService.saveExcel();
			return ResponseEntity.ok("Excel數據已成功寫入");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("無法保存Excel數據：" + e.getMessage());
		}
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
	//刪除
	@DeleteMapping("/delete/{id}")
	@ResponseBody
	public  String delDelivery(@PathVariable("id") int id) {
		dService.DelDelivery(id);
		return "success";
	}
	
	//修改
	@PutMapping("/upd")
	public ResponseEntity<String> upddelivery(@RequestBody Delivery delivery) {
		try {
				dService.update(delivery);
				return new ResponseEntity<>("更新外送訂單成功", HttpStatus.CREATED);
			} catch (Exception e) {
				return new ResponseEntity<>("更新外送訂單失敗: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
	//查詢全部
	@GetMapping("/home")
	public String DeliveryHome(Model m) {
		List<Delivery> delivery = dService.findall();
		m.addAttribute("delivery",delivery);
		return "/back-html/delivery/delivery";
	}

	//	查詢單筆
	@GetMapping("/update/{id}")
	public	String Update(@PathVariable("id") int id ,Model m){
		Delivery delivery = dService.findById(id);
		m.addAttribute("delivery",delivery);
		return "/back-html/delivery/update";
	}
	
//	查詢單筆
//	@GetMapping("/findbyorder/{id}")
//	public	String findbyorder(@PathVariable("id") int id ,Model m){
//	public String findbyorder(@PathVariable("id") int id){
//		Delivery delivery = dService.findById(id);
//		m.addAttribute("delivery",delivery);
//		OrderDetails orderDetails =	dRepos.findById(id);
//		return orderDetails;
//		return "/back-html/delivery/update";
}
//}











