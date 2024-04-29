package com.team6.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.team6.model.Delivery;
import com.team6.model.DeliveryService;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {

	@Autowired
	private DeliveryService dService;

	// delivery首頁
	//查詢全部	 http://localhost:8080/delivery/findTall 
		@GetMapping("/findTall")
		public String Home(Model model) {
			List<Delivery> delivery = dService.findTall();
			model.addAttribute("delivery",delivery);  	
			return "delivery";
		}
		
		//查詢全部	 http://localhost:8080/delivery/findFall
		@GetMapping("/findFall")
		public String Orderdel(Model model) {
			List<Delivery> delivery = dService.findFall();
			model.addAttribute("delivery",delivery);  	
			return "Orderdel";
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


	//修改
	@PutMapping("/upd")
	public String Upd(@ModelAttribute("delivery") Delivery delivery) {
		dService.update(delivery);
		return "redirect:/delivery/findTall ";		
	}
	
	//復原
	@PutMapping("/rollback/{id}")
	public ResponseEntity<String> Rollback(@PathVariable("id") int id) {	
		dService.rollback(id);
		return ResponseEntity.ok().build();
		}
		
	//刪除
	@DeleteMapping("/del/{id}")
	public ResponseEntity<String> Delete(@PathVariable("id") int id) {		
		dService.updateDel(id);
//		dService.deleteById(id);
		return ResponseEntity.ok().build();
	}
	

	//查詢單筆，導向修改表單
	@GetMapping("/update/{id}")
	public	String Update(@PathVariable("id") int id ,Model m){
		Delivery delivery = dService.findById(id);
		m.addAttribute("delivery",delivery);
		return "update";
	}

	
	



}





