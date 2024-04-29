package com.team6.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.team6.model.ProductBean;
import com.team6.model.ProductCategory;
import com.team6.model.ProductCategoryService;
import com.team6.model.ProductService;
import com.team6.model.ProductState;
import com.team6.model.ProductStateService;

//@SessionAttributes(names = {})
@Controller
@RequestMapping(path = "/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductStateService pStateService;
	@Autowired
	private ProductCategoryService pCategoryService;
	
//	SessionStatus status
//	status.isComplete();
	
	/*因為thymeleaf會搶路徑,所以要forward:*/
	
	@GetMapping("/123.atcion")
	public String testMainprocess() {
		return "ForTest";
		
	}
	
	
	
	// Product_Index主進入點
	@GetMapping("/product.atcion")
	public String productMainprocess() {
		return "forward:/WEB-INF/product/Product_Index.jsp";
		
	}
	
	// 查全部
	@GetMapping("/Product_SelectAll")
	public String productSelectAll(Model model) {
		
		List<ProductBean> selectAll = productService.SelectAll();
		model.addAttribute("productBeans", selectAll);
		return "forward:/WEB-INF/product/GetAllProducts.jsp";
	}
	
	// 模糊查詢
	@GetMapping("/Product_SelectByName")
	public String product_SelectOneByName(@RequestParam("productName") String productName, Model model) {
		
		List<ProductBean> selectName = productService.SelectName(productName);
		
		model.addAttribute("productBeans", selectName);
		return "forward:/WEB-INF/product/GetAllProducts.jsp";
	}
	
	// 查單筆byId
	@GetMapping("/Product_SelectOneById")
	public String product_SelectOneById(@RequestParam("productId") Integer productId, Model model) {
		
		ProductBean selectById = productService.SelectById(productId);
		model.addAttribute("productBean", selectById);
		
		return "forward:/WEB-INF/product/GetProduct.jsp";
	}
	
	// 更新資料先查出該筆
	@GetMapping("/Product_GetpProductById")
	public String product_GetpProductById(@RequestParam("productId") Integer productId, Model model) {
	
		// 抓出所有的類別
		List<ProductCategory> findAllProductCategory = pCategoryService.findAllProductCategory();
		model.addAttribute("findAllProductCategory", findAllProductCategory);
		
		// 抓出所有的產品狀態
		List<ProductState> allProductState = pStateService.findAllProductState();
		model.addAttribute("allProductState", allProductState);
		
		ProductBean selectById = productService.SelectById(productId);
		model.addAttribute("productBean", selectById);
		
		return "forward:/WEB-INF/product/GetUpdateProduct.jsp";
	}
	
	// 查出後更新資料
	@PutMapping("/Product_DoUpdate")
	public String product_DoUpdate(
			@RequestParam("productId") Integer productId,
			@RequestParam("categoryId") Integer categoryId,
			@RequestParam("productName") String productName,
			@RequestParam("productDesc") String productDesc,
			@RequestParam("productImg_url") MultipartFile mf,
			@RequestParam("productPrice") Integer productPrice,
			@RequestParam("productStateId") Integer productStateId) throws IllegalStateException, IOException {
		
		ProductState productState = pStateService.findProductStateById(productStateId);
		
		if (!mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
			String fileDir = "C:/Action/workspace/team6/src/main/resources/static/images";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);
			
			String productImg_url = "/images/" + fileName;
			ProductBean productBean = new ProductBean(productId, categoryId, productName, productDesc, productImg_url, productPrice, productState);
			productService.UpdateProduct(productBean);
			
			return "redirect:Product_SelectAll";
		} else {
			ProductBean oldProductBean = productService.SelectById(productId);
			ProductBean productBeanNoImg = new ProductBean(productId, categoryId, productName, productDesc, oldProductBean.getProductImg_url(), productPrice, productState);
			productService.UpdateProduct(productBeanNoImg);
			return "redirect:Product_SelectAll";
		}
		
	}
	
	// 更新狀態
	@PutMapping("/Product_ChangeState")
	@ResponseBody
	public String product_ChangeState(
			@RequestParam("productId") Integer productId,
			@RequestParam("productStateId") Integer productStateId) {
		
		ProductState forChangeStateBean = pStateService.findProductStateById(productStateId);
		//							 save
		ProductBean changedProduct = productService.ChangeProductState(productId, forChangeStateBean);
		
		return changedProduct.getProductState().getProductStateName();
	}
	
	// 新增主進入點
	@GetMapping("/InsertProductMain")
	public String insertProductMain(Model model) {
		// 抓出所有的類別
		List<ProductCategory> findAllProductCategory = pCategoryService.findAllProductCategory();
		model.addAttribute("findAllProductCategory", findAllProductCategory);
		
		return "forward:/WEB-INF/product/InsertProduct.jsp";
	}
	
	// 新增
	@PostMapping("/Product_Insert")
	public String product_Insert(
			@RequestParam("categoryId") Integer categoryId,
			@RequestParam("productName") String productName, 
			@RequestParam("productDesc") String productDesc,
			@RequestParam("productImg_url") MultipartFile mf, 
			@RequestParam("productPrice") Integer productPrice) throws IllegalStateException, IOException {
		
		ProductState productStateDefault = pStateService.findProductStateById(1);

		if (!mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
			String fileDir = "C:/Action/workspace/team6/src/main/resources/static/images";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);

			String productImg_url = "/images/" + fileName;
			
			ProductBean productBean = new ProductBean(categoryId, productName, productDesc, productImg_url,
					productPrice, productStateDefault);
			productService.InsertProduct(productBean);
			return "redirect:Product_SelectAll";
		} else {

			ProductBean productBean = new ProductBean(categoryId, productName, productDesc, productPrice,
					productStateDefault);
			productService.InsertProduct(productBean);
			return "redirect:Product_SelectAll";
		}

	}
	
	// 刪除主進入點
	@GetMapping("/DeleteInsertProductMain")
	public String deleteInsertProductMain() {
		return "forward:/WEB-INF/product/DeleteProduct.jsp";
	}
	
	// 刪除
	@DeleteMapping("/Product_Delete")
	public String Product_Delete(@RequestParam("productId") Integer productId) {
		productService.DeleteProduct(productId);
		return "redirect:Product_SelectAll";
	}
	
	
}
