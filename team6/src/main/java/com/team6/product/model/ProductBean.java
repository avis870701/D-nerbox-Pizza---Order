package com.team6.product.model;

import java.time.LocalDate;

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
@Table(name = "product")
@Component
public class ProductBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PRODUCTID")
	private Integer productId;

	@Column(name = "CATEGORYID")
	private Integer CategoryId;

	@Column(name = "PRODUCTNAME")
	private String productName;

	@Column(name = "PRODUCTDESC")
	private String productDesc;

	@Column(name = "PRODUCTIMG_URL")
	private String productImg_url;

	@Column(name = "PRODUCTPRICE")
	private Integer productPrice;

	@Column(name = "PRODUCTQUANTITY")
	private Integer productQuantity;

	@Column(name = "PRODUCTCREATEDATE")
	private LocalDate productCreateDate;

	@JoinColumn(name = "CATEGORYID", insertable = false, updatable = false)
	@ManyToOne(fetch = FetchType.LAZY)
	private ProductCategory productCategory;

	@JoinColumn(name = "PRODUCTSTATEID", insertable = false, updatable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private ProductState productState;

//	----------------------
	public ProductBean() {
	}

//	新增有圖案用的
	public ProductBean(Integer categoryId, String productName, String productDesc, String productImg_url,
			Integer productPrice, ProductState productState, Integer productQuantity, LocalDate productCreateDate) {
		this.CategoryId = categoryId;
		this.productName = productName;
		this.productDesc = productDesc;
		this.productImg_url = productImg_url;
		this.productPrice = productPrice;
		this.productState = productState;
		this.productQuantity = productQuantity;
		this.productCreateDate = productCreateDate;
	}

//	新增沒圖案用的
	public ProductBean(Integer categoryId, String productName, String productDesc, Integer productPrice,
			ProductState productState, Integer productQuantity, LocalDate productCreateDate) {
		this.CategoryId = categoryId;
		this.productName = productName;
		this.productDesc = productDesc;
		this.productPrice = productPrice;
		this.productState = productState;
		this.productQuantity = productQuantity;
		this.productCreateDate = productCreateDate;
	}

//	修改用的	
	public ProductBean(Integer productId, Integer categoryId, String productName, String productDesc,
			String productImg_url, Integer productPrice, ProductState productState, Integer productQuantity, LocalDate productCreateDate) {
		this.productId = productId;
		this.CategoryId = categoryId;
		this.productName = productName;
		this.productDesc = productDesc;
		this.productImg_url = productImg_url;
		this.productPrice = productPrice;
		this.productState = productState;
		this.productQuantity = productQuantity;
		this.productCreateDate = productCreateDate;
	}

//	----------------------

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getCategoryId() {
		return CategoryId;
	}

	public void setCategoryId(Integer categoryId) {
		CategoryId = categoryId;
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

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public ProductState getProductState() {
		return productState;
	}

	public void setProductState(ProductState productState) {
		this.productState = productState;
	}

	public LocalDate getProductCreateDate() {
		return productCreateDate;
	}

	public void setProductCreateDate(LocalDate productCreateDate) {
		this.productCreateDate = productCreateDate;
	}

	public Integer getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(Integer productQuantity) {
		this.productQuantity = productQuantity;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ProductBean [productId=");
		builder.append(productId);
		builder.append(", CategoryId=");
		builder.append(CategoryId);
		builder.append(", productName=");
		builder.append(productName);
		builder.append(", productDesc=");
		builder.append(productDesc);
		builder.append(", productImg_url=");
		builder.append(productImg_url);
		builder.append(", productPrice=");
		builder.append(productPrice);
		builder.append(", productQuantity=");
		builder.append(productQuantity);
		builder.append(", productCreateDate=");
		builder.append(productCreateDate);
		builder.append(", productCategory=");
		builder.append(productCategory);
		builder.append(", productState=");
		builder.append(productState);
		builder.append("]");
		return builder.toString();
	}

}
