package com.team6.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.Order;
import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderService;
import com.team6.product.model.ProductBean;
import com.team6.product.model.ProductCategory;
import com.team6.product.model.ProductCategoryService;
import com.team6.product.model.ProductService;
import com.team6.promotions.model.Promotions;
import com.team6.promotions.model.PromotionsService;

//後段
@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;

	@Autowired
	private PromotionsService promotionsService;

	@Autowired
	private ProductService productService;

	@Autowired
	private ProductCategoryService productCategoryService;

	// 後端進入點 http://localhost:8080/order/order.action
	@RequestMapping(path = "/order.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderMainprocess() {
		return "forward:/WEB-INF/back-jsp/order/OrderIndex.jsp";
	}

	// 後端員工點餐進入點 http://localhost:8080/order/orderByEmployee
	@RequestMapping(path = "/orderByEmployee", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderByEmployee() {
		return "forward:/WEB-INF/back-jsp/order/OrderByEmployee.jsp";
	}

	// select all
	@GetMapping(path = "/orderSelectAll")
	@ResponseBody
	public Page<Order> orderSelectAll(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		Pageable pageable = PageRequest.of(page, size, Sort.by("orderId").descending());
		return oService.findOrderAll(pageable);
	}

	// select LIKE order
	@GetMapping(path = "/orderSelectLIKE")
	@ResponseBody
	public List<Order> orderSelectLIKE(@RequestParam(required = false) String keyword) {
		if (keyword != null && !keyword.isEmpty()) {
			// 如果有關鍵字，執行模糊查詢
			return oService.findOrdersByKeyword(keyword);
		} else {
			// 否則，獲取所有資料
			return oService.findAllOrders();
		}
	}

	// select Details by orderId
	@GetMapping("/detailsSelectByID")
	@ResponseBody
	public ResponseEntity<List<OrderDetails>> getOrderDetailsById(@RequestParam("orderId") String orderId) {
		List<OrderDetails> orderDetails = oService.findDetailsById(orderId);
		if (orderDetails != null && !orderDetails.isEmpty()) {
			return ResponseEntity.ok(orderDetails);
		} else {
			return ResponseEntity.notFound().build(); // no information back to 404 Not Found
		}
	}

	// order
	// select Promotions discountList first,then update discount
	@GetMapping("/getDiscountList")
	@ResponseBody
	public List<Promotions> getDiscountList() {
		return promotionsService.selectAllDiscount();
	}

	@PutMapping("/updateDiscount")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updateDiscount(@RequestParam String orderId,
			@RequestParam String discount, Integer discountPrice) {
		oService.updateDiscount(orderId, discount, discountPrice);
		Map<String, String> response = new HashMap<>();
		response.put("message", "Order discount updated successfully.");
		return ResponseEntity.ok(response);
	}

	// update payment,pickup,orderStatus
	@PutMapping("/updatePPO")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updatePPO(@RequestParam String orderId,
			@RequestParam(required = false) String payment, @RequestParam(required = false) String pickup,
			@RequestParam(required = false) String orderStatus) {
		if (payment != null) {
			oService.updatePayment(orderId, payment);
		} else if (pickup != null) {
			oService.updatePickup(orderId, pickup);
		} else {
			oService.updateOrderStatus(orderId, orderStatus);
		}
		Map<String, String> response = new HashMap<>();
		response.put("message", "Order PPO updated successfully.");
		return ResponseEntity.ok(response);
	}

	// update cancelNote
	@PutMapping("/updateCancelNote")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updateCancelNote(@RequestParam String orderId,
			@RequestParam String cancelNote) {
		oService.updateCancelNote(orderId, cancelNote);
		Map<String, String> response = new HashMap<>();
		response.put("message", "Order cancelNote updated successfully.");
		return ResponseEntity.ok(response);
	}

	// details
	// update quantity
	@PutMapping("/updateQuantity")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updateQuantity(@RequestParam Integer detailsId,
			@RequestParam String quantity) {
		oService.updateQuantity(detailsId, quantity);
		System.out.println("detailsId::" + detailsId);
		System.out.println("quantity::" + quantity);

		Map<String, String> response = new HashMap<>();
		response.put("message", "Details quantity updated successfully.");
		return ResponseEntity.ok(response);
	}

	// update note
	@PutMapping("/updateDetailsNote")
	@ResponseBody
	public ResponseEntity<Map<String, String>> updateNote(@RequestParam Integer detailsId, @RequestParam String note) {
		oService.updateNote(detailsId, note);
		Map<String, String> response = new HashMap<>();
		response.put("message", "Details note updated successfully.");
		return ResponseEntity.ok(response);
	}

	// insert one detail
	// select product information first
	@GetMapping("/findProduct")
	@ResponseBody
	public Map<String, Object> findProduct() {
		List<ProductCategory> categories = productCategoryService.findAllProductCategory();
		List<ProductBean> product = productService.SelectAll();
		Map<String, Object> response = new HashMap<>();
		response.put("categories", categories);
		response.put("product", product);
		return response;
	}

	// after select, insert detail
	@PostMapping("/addDetail")
	@ResponseBody
	public OrderDetails insertDetail(@RequestBody OrderDetails orderDetails) {
		return oService.insertDetails(orderDetails);
	}

	// employee order
	@PostMapping("/employeeOrder")
	@ResponseBody
	public ResponseEntity<String> handleEmployeeOrder(@RequestBody Map<String, Object> orderData) {
		String orderId = generateOrderId();
		String account = (String) orderData.get("account");
		String discount = (String) orderData.get("discount");
		Integer discountPrice = (Integer) orderData.get("discountPrice");
		String payment = (String) orderData.get("payment");
		String pickup = (String) orderData.get("pickup");
		String orderStatus = (String) orderData.get("orderStatus");

		if (discount == "") {
			oService.insertOrderWithoutDiscount(orderId, account, payment, pickup, orderStatus);
		} else {
			oService.insertOrderWithDiscount(orderId, account, discount, discountPrice, payment, pickup, orderStatus);
		}

		// 如果订单插入成功，则处理订单详情
		List<Map<String, Object>> orderDetailsList = (List<Map<String, Object>>) orderData.get("orderDetails");
		if (orderDetailsList != null) {
		    for (Map<String, Object> detailData : orderDetailsList) {
		        OrderDetails detail = new OrderDetails();
		        detail.setOrderId(orderId);
		        detail.setProductId((String) detailData.get("productId"));
		        detail.setProduct((String) detailData.get("productName"));
		        detail.setUnitPrice((String) detailData.get("unitPrice"));
		        detail.setQuantity((String) detailData.get("quantity"));
		        detail.setNote((String) detailData.get("note"));

		        // 在这里进行订单详情的处理
		        oService.insertDetails(detail); // 确保 insertDetails 方法正常运行
		    }
		    return ResponseEntity.ok("Order inserted successfully.");
		} else {
		    // 如果订单详情列表为空，可以返回相应的错误消息或者进行其他处理
		    return ResponseEntity.badRequest().body("Order details list is null or empty.");
		}
	}

// 生成订单ID的方法
	private String generateOrderId() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		return sdf.format(new Date());
	}

	// deleteDetails by detailsId
	@RequestMapping(value = "/orderDetails/{detailsId}", method = RequestMethod.DELETE)
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteOrderDetail(@PathVariable Integer detailsId) {
		oService.deleteOrderDetail(detailsId);
		Map<String, String> response = new HashMap<>();
		response.put("message", "Order detail deleted successfully.");
		return ResponseEntity.ok(response);
	}

	// update discount & dprice after delete
	@PutMapping("/clearDiscount")
	@ResponseBody
	public ResponseEntity<Map<String, String>> clearDiscount(@RequestParam String orderId) {
		Order order = oService.findOrderById(orderId);
		if (order != null & order.getDiscount().length() > 0) {
			String discount = order.getDiscount() + " 已失效";
			Integer discountPrice = 0;
			oService.updateDiscount(orderId, discount, discountPrice);
		}
		Map<String, String> response = new HashMap<>();
		response.put("message", "After deleted details updated discount successfully.");
		return ResponseEntity.ok(response);
	}

}