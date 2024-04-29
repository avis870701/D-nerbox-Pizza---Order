package com.team6.model;

import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity		   
@Table(name = "productcategory")
@Component
public class ProductCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CATEGORYID")
	private Integer CategoryId;
	
	@Column(name = "CATEGORYNAME")
	private String CategoryName;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "productCategory", cascade = {CascadeType.PERSIST,CascadeType.MERGE})
	private Set<ProductBean> pBeans = new LinkedHashSet<>();
	
//	--------------------------
	public ProductCategory() {
	}
//	--------------------------

	public Integer getCategoryId() {
		return CategoryId;
	}

	public void setCategoryId(Integer categoryId) {
		CategoryId = categoryId;
	}

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	public Set<ProductBean> getpBeans() {
		return pBeans;
	}

	public void setpBeans(Set<ProductBean> pBeans) {
		this.pBeans = pBeans;
	}


	
	
}
