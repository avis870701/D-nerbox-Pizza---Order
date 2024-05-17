package com.team6.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderService;
import com.team6.product.model.ProductBean;
import com.team6.product.model.ProductCategory;
import com.team6.product.model.ProductCategoryService;
import com.team6.product.model.ProductService;
import com.team6.promotions.model.Promotions;
import com.team6.promotions.model.PromotionsService;

//前端
@Controller
@RequestMapping("/order")
public class PizzaOrderController {

	@Autowired
	private OrderService oService;

	@Autowired
	private PromotionsService promotionsService;

	// 前端store進入點 http://localhost:8080/order/pizzaOrder
	@RequestMapping(path = "/pizzaOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public String PizzaOrderIndex() {
		return "forward:/WEB-INF/front-jsp/order/pizzaOrder.jsp";
	}

	// 前端 外送storer進入點 http://localhost:8080/order/deliveryOrder.jsp
	@RequestMapping(path = "/deliveryOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public String DeliveryOrderIndex() {
		return "forward:/WEB-INF/front-jsp/order/deliveryOrder.jsp";
	}

	// 點餐insert
	@PostMapping("/createPizzaOrder")
	@ResponseBody
	public ResponseEntity<String> createPizzaOrder(@RequestBody Map<String, Object> orderData) {
		String orderId = generateOrderId();
		String account = (String) orderData.get("account");
		String discount = orderData.get("discount") != null ? orderData.get("discount").toString() : "";
		String payment = (String) orderData.get("payment");
		String pickup = (String) orderData.get("pickup");
		String orderStatus = (String) orderData.get("orderStatus");

		// 查询可用折扣码列表
		List<Promotions> discountList = promotionsService.selectAllDiscount();

		if ("".equals(discount)) {
			oService.insertOrderWithoutDiscount(orderId, account, payment, pickup, orderStatus);
		} else {
			Integer discountPrice = null;
			// 在 discountList 中查找相应折扣码的折扣价格
			for (Promotions promo : discountList) {
				if (promo.getPromotions_discountcode().equals(discount)) {
					try {
						discountPrice = Integer.valueOf(promo.getPromotions_discount());
					} catch (NumberFormatException e) {
						return ResponseEntity.badRequest().body("Discount price can not be found.");
					}
					break;
				}
			}
			// 如果找到了折扣码，则插入带折扣的订单
			if (discountPrice != null) {
				oService.insertOrderWithDiscount(orderId, account, discount, discountPrice, payment, pickup,
						orderStatus);
			}
		}

		List<Map<String, Object>> orderDetailsList = (List<Map<String, Object>>) orderData.get("orderDetails");
		if (orderDetailsList != null) {
			for (Map<String, Object> detailData : orderDetailsList) {
				OrderDetails detail = new OrderDetails();
				detail.setOrderId(orderId);
				detail.setProductId(detailData.get("productId") != null ? detailData.get("productId").toString() : "");
				detail.setProduct(detailData.get("product") != null ? detailData.get("product").toString() : "");
				detail.setUnitPrice(detailData.get("totalPrice") != null ? detailData.get("totalPrice").toString() : "");
				detail.setQuantity(detailData.get("quantity") != null ? detailData.get("quantity").toString() : "");
				detail.setNote(detailData.get("note") != null ? detailData.get("note").toString() : "");

				oService.insertDetails(detail);
			}

			oService.findOrderById(orderId);
			oService.findDetailsById(orderId);

			return ResponseEntity.ok("{\"message\": \"Order inserted successfully.\"}");
		} else {
			return ResponseEntity.badRequest().body("Order details list is null or empty.");
		}

	}

	// 生成orderId
	private String generateOrderId() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		return sdf.format(new Date());
	}
}
