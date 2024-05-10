package com.team6.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.Order;
import com.team6.product.dto.ProductBeanDto;
import com.team6.product.dto.ProductTest;
import com.team6.product.model.ProductBean;
import com.team6.product.model.ProductCategoryService;
import com.team6.product.model.ProductService;
import com.team6.product.model.ProductStateService;
import com.team6.product.model.TestPage;
import com.team6.product.model.TestPageService;
// 2024/5/9 marge後確定沒問題
//@SessionAttributes(names = {})
@Controller
@RequestMapping(path = "/product")
public class FrontProductController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductStateService pStateService;
	@Autowired
	private ProductCategoryService pCategoryService;
	@Autowired
	private TestPageService tService;
	
//	SessionStatus status
//	status.isComplete();
	
	/*因為thymeleaf會搶路徑,所以要forward:*/
	
	
	// 測試扣產品數量進入點
	@GetMapping("/product.test")
	public String testProductQuantity(Model model) {
		// 18號測試用
		ProductBean productBean = productService.SelectById(31);
		model.addAttribute("productBean", productBean);
		return "forward:/WEB-INF/front-jsp/product/Number.jsp";
	}
	
	// 測試扣產品數量2，用@RequestBody接 然後使用DTO傳輸資料
	@PutMapping("/Product_coQuantity")
	@ResponseBody
	public ResponseEntity<ProductBean> testCoProductQuantity(
			@RequestBody ProductTest productTest){
		ProductBean productBean = productService.SelectById(productTest.getProductId());
		Integer pQuantity = productBean.getProductQuantity();
		
		
		pQuantity -= productTest.getQuantity();
		productBean.setProductQuantity(pQuantity);
		productService.UpdateProduct(productBean);
		
		ProductBean newPbean = productService.SelectById(productBean.getProductId());
		
		return ResponseEntity.ok().body(newPbean);
	}
	
	
	// 測試 分頁
	@GetMapping("/TestPage")
	public String testMain() {
		return "forward:/WEB-INF/front-jsp/product/TestPage.jsp";
	}
	
	// 測試 分頁
	@GetMapping(path = "/TestPageSelectAll")
	@ResponseBody
	public Page<TestPage> orderSelectAll(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "5") int size) {
		Pageable pageable = PageRequest.of(page, size, Sort.by("tid").ascending());
		return tService.findTestPageAll(pageable);
	}
	
	// 測試 分頁帶查詢
	@GetMapping(path = "/TestPage2")
	@ResponseBody
	public Page<TestPage> testPageWithState(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "5") int size) {
		
		Pageable pageable = PageRequest.of(page, size, Sort.by("tid").ascending());
		
		int state = 1;
		String name = "噁";
		
		return tService.findTestPageWithState(state, name, pageable);
	}
	
	
	// 前端畫面main
	@GetMapping("/product.front")
	public String frontPageMain() {
		return "forward:/WEB-INF/front-jsp/product/product.jsp";
	}
	
	
	
	
	
	
	
	
	
	
}
