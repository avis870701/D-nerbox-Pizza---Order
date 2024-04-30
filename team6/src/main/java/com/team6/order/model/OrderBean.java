package com.team6.order.model;

import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name="pizzaorder")
@Component
public class OrderBean {
	
	@Id
	@Column(name="orderid")
	private String orderId;
	
	@Column(name="orderTime")
	@Transient
	private String orderTime;
		
	@Column(name="customername")
	private String customerName;
	
	@Column(name="amount")
	private String amount;
	
	@Column(name="payment")
	private String payment;
	
	@Column(name="pickup")
	private String pickup;
	
	@Column(name="orderstatus")
	private String orderStatus;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "orderBean", cascade = {CascadeType.PERSIST,CascadeType.MERGE,CascadeType.REMOVE})
	private Set<OrderDetailsBean> detailsBean = new LinkedHashSet<>();
	
	public OrderBean() {
		
	}
	
	//有orderId
	public OrderBean(String orderId, String customerName, String payment, String pickup, String orderStatus,
			Set<OrderDetailsBean> detailsBean) {
		this.orderId = orderId;
		this.customerName = customerName;
		this.payment = payment;
		this.pickup = pickup;
		this.orderStatus = orderStatus;
		this.detailsBean = detailsBean;
	}
	
	//沒orderId
	public OrderBean(String customerName, String payment, String pickup, String orderStatus,
			Set<OrderDetailsBean> detailsBean) {
		this.customerName = customerName;
		this.payment = payment;
		this.pickup = pickup;
		this.orderStatus = orderStatus;
		this.detailsBean = detailsBean;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getPickup() {
		return pickup;
	}

	public void setPickup(String pickup) {
		this.pickup = pickup;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	
	public Set<OrderDetailsBean> getDetailsBean() {
		return detailsBean;
	}

	public void setDetailsBean(Set<OrderDetailsBean> detailsBean) {
		this.detailsBean = detailsBean;
	}

	@Override
	public String toString() {
		return "OrderBean [orderId=" + orderId + ", orderTime=" + orderTime + ", customerName=" + customerName
				+ ", amount=" + amount + ", payment=" + payment + ", pickup=" + pickup + ", orderStatus=" + orderStatus
				+ ", detailsBean=" + detailsBean + "]";
	}

	

}