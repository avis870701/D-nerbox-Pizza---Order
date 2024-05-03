package com.team6.order.model;

import java.util.LinkedHashSet;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "PIZZAORDER")
public class Order {

	@Id
	@Column(name = "ORDERID")
	private String orderId;

	@Column(name = "ORDERTIME")
	private String orderTime;

	@Column(name = "ACCOUNT")
	private String account;

	@Column(name = "MEMAIL")
	private String mEmail;

	@Column(name = "ORIAMOUNT")
	private Integer oriAmount;

	@Column(name = "DISCOUNT")
	private String discount;

	@Column(name = "DISCOUNTPRICE")
	private Integer discountPrice;

	@Column(name = "PAIDAMOUNT")
	private Integer paidAmount;

	@Column(name = "PAYMENT")
	private String payment;

	@Column(name = "PICKUP")
	private String pickup;

	@Column(name = "ORDERSTATUS")
	private String orderStatus;
	
	@Column(name = "CANCELNOTE")
	private String cancelNote;
	
	@Column(name = "HIDE")
	private Integer hide;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "order", cascade = {CascadeType.PERSIST,CascadeType.MERGE})
	private Set<OrderDetails> details = new LinkedHashSet<>();
	
	public Order() {
		
	}

}
