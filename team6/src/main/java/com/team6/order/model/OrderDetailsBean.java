package com.team6.order.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="orderdetails")
@Component
public class OrderDetailsBean {
	
	@Column(name="detailsid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private Integer detailsId;
	
	@Column(name="orderid")
	private String orderId;
	
	@Column(name="productid")
	private String productId;
	
	@Column(name="product")
	private String product;
	
	@Column(name="unitprice")
	private String unitPrice;
	
	@Column(name="quantity")
	private String quantity;
	
	@Column(name="subtotal")
	private String subtotal;
	
	@Column(name="note")
	private String note;
	
	@JoinColumn(name="orderid", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.EAGER)
	private OrderBean orderBean;

	public OrderDetailsBean(Integer detailsId, String orderId, String productId, String product, String unitPrice,
			String quantity, String subtotal, String note, OrderBean orderBean) {
		this.detailsId = detailsId;
		this.orderId = orderId;
		this.productId = productId;
		this.product = product;
		this.unitPrice = unitPrice;
		this.quantity = quantity;
		this.subtotal = subtotal;
		this.note = note;
		this.orderBean = orderBean;
	}

	public OrderDetailsBean(String orderId, String productId, String product, String unitPrice, String quantity,
			String subtotal, String note, OrderBean orderBean) {
		this.orderId = orderId;
		this.productId = productId;
		this.product = product;
		this.unitPrice = unitPrice;
		this.quantity = quantity;
		this.subtotal = subtotal;
		this.note = note;
		this.orderBean = orderBean;
	}

	public OrderDetailsBean() {
		
	}
	
	public Integer getDetailsId() {
		return detailsId;
	}

	public void setDetailsId(Integer detailsId) {
		this.detailsId = detailsId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(String subtotal) {
		this.subtotal = subtotal;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public OrderBean getOrderBean() {
		return orderBean;
	}

	public void setOrderBean(OrderBean orderBean) {
		this.orderBean = orderBean;
	}

	@Override
	public String toString() {
		return "OrderDetailsBean [detailsId=" + detailsId + ", orderId=" + orderId + ", productId=" + productId
				+ ", product=" + product + ", unitPrice=" + unitPrice + ", quantity=" + quantity + ", subtotal="
				+ subtotal + ", note=" + note + ", orderBean=" + orderBean + "]";
	}
	
}