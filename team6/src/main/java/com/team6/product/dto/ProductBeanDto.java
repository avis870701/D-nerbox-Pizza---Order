package com.team6.product.dto;

import java.time.LocalDate;

public class ProductBeanDto {

	private Integer productId;

	private String CategoryName;

	private String productName;

	private String productDesc;

	private String productImg_url;

	private Integer productPrice;

	private Integer productQuantity;

	private LocalDate productCreateDate;

	private String ProductStateName;
	
//	----------------------------------

	public ProductBeanDto() {
	}

	public ProductBeanDto(Integer productId, String categoryName, String productName, String productDesc,
			String productImg_url, Integer productPrice, Integer productQuantity, LocalDate productCreateDate,
			String productStateName) {
		this.productId = productId;
		this.CategoryName = categoryName;
		this.productName = productName;
		this.productDesc = productDesc;
		this.productImg_url = productImg_url;
		this.productPrice = productPrice;
		this.productQuantity = productQuantity;
		this.productCreateDate = productCreateDate;
		this.ProductStateName = productStateName;
	}

//	----------------------------------
	
	
	public Integer getProductId() {
		return productId;
	}


	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public String getProductImg_url() {
		return productImg_url;
	}

	public void setProductImg_url(String productImg_url) {
		this.productImg_url = productImg_url;
	}

	public Integer getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Integer productPrice) {
		this.productPrice = productPrice;
	}

	public Integer getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(Integer productQuantity) {
		this.productQuantity = productQuantity;
	}

	public LocalDate getProductCreateDate() {
		return productCreateDate;
	}

	public void setProductCreateDate(LocalDate productCreateDate) {
		this.productCreateDate = productCreateDate;
	}

	public String getProductStateName() {
		return ProductStateName;
	}

	public void setProductStateName(String productStateName) {
		ProductStateName = productStateName;
	}

}
