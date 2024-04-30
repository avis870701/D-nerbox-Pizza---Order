package com.team6.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.team6.order.model.OrderBean;
import com.team6.order.model.OrderDetailsBean;
import com.team6.order.model.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService oService;
	
	/*因為thymeleaf會搶路徑,所以要forward:*/

	// IndexOrder 進入點
	// 打開首頁 http://localhost:8080/order/order.action
	@RequestMapping(path = "/order.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderMainprocess() {
		return "forward:/WEB-INF/order/IndexOrder.jsp";
	}

	// 餐點查詢進入點
	@GetMapping(path = "/detailsIndex")
	public String detailsSelectIndex() {
		return "forward:/WEB-INF/order/HOrderSelect.jsp";
	}

	// 點餐進入點
	@PostMapping(path = "/insertIndex")
	public String insertIndex() {
		return "forward:/WEB-INF/order/HDetailsInsert.jsp";
	}

	// 查詢全部訂單
	@GetMapping(path = "/orderSelectAll")
	public String orderSelectAll(Model model) {
		List<OrderBean> orders = oService.findOrderAll();
		model.addAttribute("orders", orders);
		return "forward:/WEB-INF/order/OrderSelectAll.jsp";
	}

	// 查詢訂單餐點
	@GetMapping(path = "/detailsSelectAll")
	public String detailSelect(@RequestParam("orderId") String orderId, Model model) {
		List<OrderDetailsBean> details = oService.findDetailsById(orderId);
		if (details == null) {	
			System.out.println("此訂單已無餐點明細");
			return "forward:/WEB-INF/order/error.jsp";
		}
		    model.addAttribute("details", details);
		    return "forward:/WEB-INF/order/DetailsSelect.jsp";
	}

	// Order delete button
	@GetMapping(path = "/orderDelete")
	public String deleteOrderButton(@RequestParam("orderId") String orderId, Model model) {
		oService.deleteBothById(orderId);
		return orderSelectAll(model);
	}

	// Details delete button
	@GetMapping(path = "/detailsDelete")
	public String deleteDetailsButton(@RequestParam("detailsId") Integer detailsId,
			@RequestParam("orderId") String orderId, Model model) {
		oService.deleteDetailsById(detailsId);
		return detailSelect(orderId, model);
	}

	// Update Order	
	@PostMapping(path = "/updateOrder")
	public String UpdateOrder(@RequestParam("orderId") String orderId,
			@RequestParam(value = "payment", required = false) String payment,
			@RequestParam(value = "pickup", required = false) String pickup,
			@RequestParam(value = "orderStatus", required = false) String orderStatus, Model model) {	
		System.out.println("tesr1");
		if (payment != null && orderId != null) {
			System.out.println("tesr2");
			oService.updatePaymentByOrderId(orderId, payment);
		}
		else if (pickup != null && orderId != null) {
			System.out.println("tesr3");
			oService.updatePickupByOrderId(orderId, pickup);
		}
		else if (orderStatus != null && orderId != null) {
			System.out.println("tesr4");
			oService.updateOrderStatusByOrderId(orderId, orderStatus);
		}else {
			System.out.println("tesr爆開");
			System.out.println("訂單更新失敗");
			return "forward:/WEB-INF/order/error.jsp";
		}
		
		return UpdateOrderSelect(model);
	}

	@PutMapping("/updateOrderSelect")
	public String UpdateOrderSelect(Model model) {
		System.out.println("金來嗎?");
		List<OrderBean> orders = oService.findOrderAll();
		model.addAttribute("orders", orders);
		return "forward:/WEB-INF/order/OrderUpdateSelect.jsp";
	}

	// Update Details
	@PostMapping(path = "/updateDetails")
	public String UpdateDetails(@RequestParam("detailsId") Integer detailsId, @RequestParam("orderId") String orderId,
			@RequestParam(value = "productId", required = false) String productId,
			@RequestParam(value = "product", required = false) String product,
			@RequestParam(value = "unitPrice", required = false) String unitPrice,
			@RequestParam(value = "quantity", required = false) String quantity,
			@RequestParam(value = "note", required = false) String note, Model model) {

		if (product != null && detailsId != null) {

			if (product.equals("香菇意大利比薩")) {
				productId = "1";
				unitPrice = "150";
			} else if (product.equals("夏威夷德國比薩")) {
				productId = "2";
				unitPrice = "130";
			} else if (product.equals("起司義大利比薩")) {
				productId = "3";
				unitPrice = "180";
			} else if (product.equals("義大利雞肉焗烤麵")) {
				productId = "4";
				unitPrice = "220";
			} else if (product.equals("蘋果肉桂德國烤餅")) {
				productId = "5";
				unitPrice = "130";
			} else if (product.equals("炸雞塊(6塊)")) {
				productId = "6";
				unitPrice = "60";
			} else {
				product = "炸起司條(5條)";
				productId = "7";
				unitPrice = "60";
			}

			oService.updateProductByDetailsId(detailsId, productId, product, unitPrice);
		}
		if (quantity != null && detailsId != null) {
			oService.updateQuantityByDetailsId(detailsId, quantity);
		}
		if (note != null && detailsId != null) {
			oService.updateNoteByDetailsId(detailsId, note);
		}
		
		if(detailsId == null) {
			System.out.println("餐點明細更新失敗");
			return "forward:/WEB-INF/order/error.jsp";
		}

		return UpdateDetailsSelect(orderId, model);
	}

	@PutMapping("/updateDetailsSelect")
	public String UpdateDetailsSelect(@RequestParam("orderId") String orderId, Model model) {
		List<OrderDetailsBean> details = oService.findDetailsById(orderId);
		model.addAttribute("details", details);
		return "forward:/WEB-INF/order/DetailsUpdateSelect.jsp";
	}

	// Insert Order
	@PostMapping(path = "/insertController")
	public String insertOrder(@RequestParam("customerName") String customerName,
			@RequestParam(value = "amount", required = false) String amount, @RequestParam("payment") String payment,
			@RequestParam("pickup") String pickup, @RequestParam("orderStatus") String orderStatus,
			@RequestParam(value = "detailsId", required = false) Integer[] detailsIds,
			@RequestParam("productId") String[] productIds, @RequestParam("product") String[] products,
			@RequestParam("unitPrice") String[] unitPrices, @RequestParam("quantity") String[] quantitys,
			@RequestParam(value = "subtotal", required = false) String[] subtotals,
			@RequestParam("note") String[] notes, Model model) throws NullPointerException, InterruptedException {

		String orderId = generateOrderId();

		OrderBean orderBean = new OrderBean();
		orderBean.setOrderId(orderId);
		orderBean.setCustomerName(customerName);
		orderBean.setAmount(amount);
		orderBean.setPayment(payment);
		orderBean.setPickup(pickup);
		orderBean.setOrderStatus(orderStatus);

		OrderBean insertedOrder = oService.insertOrder(orderBean);

		if (insertedOrder != null) {
			for (int i = 0; i < products.length; i++) {
				OrderDetailsBean detail = new OrderDetailsBean();
				detail.setOrderId(orderId);
				detail.setProductId(i < productIds.length ? productIds[i] : "");
				detail.setProduct(i < products.length ? products[i] : "");
				detail.setUnitPrice(i < unitPrices.length ? unitPrices[i] : "");
				detail.setQuantity(i < quantitys.length ? quantitys[i] : "");
				detail.setNote(i < notes.length ? notes[i] : "");

				oService.insertDetails(detail);
			}
			OrderBean updatedOrder = oService.findOrderById(orderId);
			model.addAttribute("orderBean", updatedOrder);

		}else {
			System.out.println("訂單新增失敗");
			return "forward:/WEB-INF/order/error.jsp";
		}
		
		return "forward:/WEB-INF/order/OrderSelect.jsp";
	}

	private String generateOrderId() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		return sdf.format(new Date());
	}

}