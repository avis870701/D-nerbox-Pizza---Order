package com.team6.product.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.team6.product.dto.ProductBeanDto;
import com.team6.product.dto.ProductCategoryDto;
import com.team6.product.dto.ProductStateDto;
import com.team6.product.dto.ProductTest;
import com.team6.product.model.ProductBean;
import com.team6.product.model.ProductCategory;
import com.team6.product.model.ProductCategoryService;
import com.team6.product.model.ProductService;
import com.team6.product.model.ProductState;
import com.team6.product.model.ProductStateService;

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
	
	
	// Product_Index主進入點
	@GetMapping("/product.atcion")
	public String productMainprocess() {
		return "forward:/WEB-INF/back-jsp/product/Product_Index.jsp";
		
	}
	
	// 查全部
	@GetMapping("/Product_SelectAll")
	public String productSelectAll(Model model) {
		
		List<ProductBean> selectAll = productService.SelectAll();
		model.addAttribute("productBeans", selectAll);
		return "forward:/WEB-INF/back-jsp/product/GetAllProducts.jsp";
	}
	
	// 模糊查詢
	@GetMapping("/Product_SelectByName")
	public String product_SelectOneByName(@RequestParam("productName") String productName, Model model) {
		
		List<ProductBean> selectName = productService.SelectName(productName);
		
		model.addAttribute("productBeans", selectName);
		return "forward:/WEB-INF/back-jsp/product/GetAllProducts.jsp";
	}
	
	// 查單筆byId
	@GetMapping("/Product_SelectOneById")
	public String product_SelectOneById(@RequestParam("productId") Integer productId, Model model) {
		
		ProductBean selectById = productService.SelectById(productId);
		model.addAttribute("productBean", selectById);
		
		return "forward:/WEB-INF/back-jsp/product/GetProduct.jsp";
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
		
		return "forward:/WEB-INF/back-jsp/product/GetUpdateProduct.jsp";
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
			@RequestParam("productStateId") Integer productStateId,
			@RequestParam("productQuantity") Integer productQuantity) throws IllegalStateException, IOException {
		// 找產品狀態的bean
		ProductState productState = pStateService.findProductStateById(productStateId);
		// 有一些舊資料不需要更新先抓出來等等塞回去
		ProductBean oldProductBean = productService.SelectById(productId);
		// 不給修改日期上架日期
		LocalDate oldproductCreateDate = oldProductBean.getProductCreateDate();
		
		if (!mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
//			String fileDir = "C:/Action/workspace/team6/src/main/resources/static/product/images";
			String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/product";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);
			
			String productImg_url = "/images/product/" + fileName;
			ProductBean productBean = new ProductBean(productId, categoryId, productName, productDesc, productImg_url, productPrice, productState, productQuantity, oldproductCreateDate);
			productService.UpdateProduct(productBean);
			
			return "redirect:Product_SelectAll";
		} else {
			
			ProductBean productBeanNoImg = new ProductBean(productId, categoryId, productName, productDesc, oldProductBean.getProductImg_url(), productPrice, productState, productQuantity, oldproductCreateDate);
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
		
		return "forward:/WEB-INF/back-jsp/product/InsertProduct.jsp";
	}
	
	// 新增
	@PostMapping("/Product_Insert")
	public String product_Insert(
			@RequestParam("categoryId") Integer categoryId,
			@RequestParam("productName") String productName, 
			@RequestParam("productDesc") String productDesc,
			@RequestParam("productImg_url") MultipartFile mf, 
			@RequestParam("productPrice") Integer productPrice,
			@RequestParam("productQuantity") Integer productQuantity) throws IllegalStateException, IOException {
		// 加入產品狀態預設值為1(已上架)
		ProductState productStateDefault = pStateService.findProductStateById(1);
		// 加一個現在的日期(商品上架日期)
		LocalDate productCreateDate = LocalDate.now();
		System.out.println("商品上架日期: " + productCreateDate);
		
		if (!mf.isEmpty()) {
			String fileName = mf.getOriginalFilename();
//			String fileDir = "C:/Action/workspace/team6/src/main/resources/static/product/images";
			String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/product";
			File fileDirPath = new File(fileDir, fileName);
			mf.transferTo(fileDirPath);

			String productImg_url = "/images/product/" + fileName;
			
			ProductBean productBean = new ProductBean(categoryId, productName, productDesc, productImg_url,
					productPrice, productStateDefault, productQuantity, productCreateDate);
			productService.InsertProduct(productBean);
			return "redirect:Product_SelectAll";
		} else {

			ProductBean productBean = new ProductBean(categoryId, productName, productDesc, productPrice,
					productStateDefault, productQuantity, productCreateDate);
			productService.InsertProduct(productBean);
			return "redirect:Product_SelectAll";
		}

	}
	
	// 刪除主進入點
	@GetMapping("/DeleteInsertProductMain")
	public String deleteInsertProductMain() {
		return "forward:/WEB-INF/back-jsp/product/DeleteProduct.jsp";
	}
	
	// 刪除
	@DeleteMapping("/Product_Delete")
	public String product_Delete(@RequestParam("productId") Integer productId) {
		productService.DeleteProduct(productId);
		return "redirect:Product_SelectAll";
	}
	
//--------------------------------測試套版---------------------------------------
	
	//進入主畫面
	@GetMapping("/Product_Test_Main")
	public String productTestMain(Model model) {
		
		List<ProductBean> selectAll = productService.SelectAll();
		model.addAttribute("productBeans", selectAll);

		return "forward:/WEB-INF/back-jsp/product/EmpProductIndex.jsp";
	}
	
	
	// 查全部
	@GetMapping("/Product_Test_SelectAll")
	@ResponseBody
	public ResponseEntity<List<ProductBeanDto>> productTestSelectAll(Model model) {

		List<ProductBean> selectAll = productService.SelectAll();
		List<ProductBeanDto> selectAllDto = new ArrayList<>();
		
		for (ProductBean pBean : selectAll) {
			
			ProductCategoryDto pCategoryDto = new ProductCategoryDto(
					pBean.getProductCategory().getCategoryId(),
					pBean.getProductCategory().getCategoryName()
					);
			
			ProductStateDto pStateDto = new ProductStateDto(
					pBean.getProductState().getProductStateId(),
					pBean.getProductState().getProductStateName());
			
			ProductBeanDto pBeanDto = new ProductBeanDto(
					pBean.getProductId(),
					pBean.getCategoryId(),
					pBean.getProductName(),
					pBean.getProductDesc(),
					pBean.getProductImg_url(),
					pBean.getProductPrice(),
					pBean.getProductQuantity(),
					pBean.getProductCreateDate(),
					pCategoryDto,
					pStateDto
					);
			
			selectAllDto.add(pBeanDto);		
		}
		
		List<ProductCategory> findAllProductCategory = pCategoryService.findAllProductCategory();
		model.addAttribute("findAllProductCategory", findAllProductCategory);
		
		return ResponseEntity.ok().body(selectAllDto);
	}
	
	
	// 查出後更新資料
		@PutMapping("/product_Test_DoUpdate")
		@ResponseBody
		public ResponseEntity<ProductBeanDto> product_Test_DoUpdate(
				@RequestParam("productId") Integer productId,
				@RequestParam("categoryId") Integer categoryId,
				@RequestParam("productName") String productName,
				@RequestParam("productDesc") String productDesc,
				@RequestPart(value = "productImg_url", required = false) MultipartFile mf,
				@RequestParam("productPrice") Integer productPrice,
				@RequestParam("productStateId") Integer productStateId,
				@RequestParam("productQuantity") Integer productQuantity) throws IllegalStateException, IOException {
			// 找產品狀態的bean
			ProductState productState = pStateService.findProductStateById(productStateId);
			// 找產品類別的bean
			ProductCategory productCategory = pCategoryService.findProductCategoryById(categoryId);
			// 有一些舊資料不需要更新先抓出來等等塞回去
			ProductBean oldProductBean = productService.SelectById(productId);
			// 不給修改日期上架日期
			LocalDate oldproductCreateDate = oldProductBean.getProductCreateDate();
			
			if (mf != null && !mf.isEmpty()) {
				String fileName = mf.getOriginalFilename();
//				String fileDir = "C:/Action/workspace/team6/src/main/resources/static/product/images";
				String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/product";
				File fileDirPath = new File(fileDir, fileName);
				mf.transferTo(fileDirPath);
				
				String productImg_url = "/images/product/" + fileName;
				
				ProductBean productBean = new ProductBean(
						productId, categoryId, productName, 
						productDesc, productImg_url, productPrice, 
						productQuantity, oldproductCreateDate, productCategory, productState);
				
				productService.UpdateProduct(productBean);
				
				ProductBean newPbean = productService.SelectById(productBean.getProductId());
				
				ProductCategoryDto pCategoryDto = new ProductCategoryDto(
						newPbean.getProductCategory().getCategoryId(),
						newPbean.getProductCategory().getCategoryName()
						);
				
				ProductStateDto pStateDto = new ProductStateDto(
						newPbean.getProductState().getProductStateId(),
						newPbean.getProductState().getProductStateName());
				
				
				ProductBeanDto pBeanDto = new ProductBeanDto(
						newPbean.getProductId(),
						newPbean.getCategoryId(),
						newPbean.getProductName(),
						newPbean.getProductDesc(),
						newPbean.getProductImg_url(),
						newPbean.getProductPrice(),
						newPbean.getProductQuantity(),
						newPbean.getProductCreateDate(),
						pCategoryDto,
						pStateDto );
				
				return ResponseEntity.ok(pBeanDto);
			} else {
				
//				ProductBean productBeanNoImg = new ProductBean(productId, categoryId, productName, productDesc, oldProductBean.getProductImg_url(), productPrice, productState, productQuantity, oldproductCreateDate);
				ProductBean productBeanNoImg = new ProductBean(
						productId, categoryId, productName, 
						productDesc, oldProductBean.getProductImg_url(), 
						productPrice, productQuantity, oldproductCreateDate, 
						productCategory, productState);
				
				productService.UpdateProduct(productBeanNoImg);
				
				ProductBean newPbean = productService.SelectById(productBeanNoImg.getProductId());
				
				ProductCategoryDto pCategoryDto = new ProductCategoryDto(
						newPbean.getProductCategory().getCategoryId(),
						newPbean.getProductCategory().getCategoryName()
						);
				
				ProductStateDto pStateDto = new ProductStateDto(
						newPbean.getProductState().getProductStateId(),
						newPbean.getProductState().getProductStateName());
				
				
				ProductBeanDto pBeanDto = new ProductBeanDto(
						newPbean.getProductId(),
						newPbean.getCategoryId(),
						newPbean.getProductName(),
						newPbean.getProductDesc(),
						newPbean.getProductImg_url(),
						newPbean.getProductPrice(),
						newPbean.getProductQuantity(),
						newPbean.getProductCreateDate(),
						pCategoryDto,
						pStateDto );
				
				return ResponseEntity.ok(pBeanDto);
			}
			
		}
		
	
	
	
	
}
