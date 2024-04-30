package com.team6.product.model;

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
@Table(name = "productstate")
@Component
public class ProductState {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PRODUCTSTATEID")
	private Integer ProductStateId;
	
	@Column(name = "PRODUCTSTATENAME")
	private String ProductStateName;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "productState", cascade = {CascadeType.PERSIST, CascadeType.MERGE})
	private Set<ProductBean> pBeans = new LinkedHashSet<>();
	
	
//	------------------------
	public ProductState() {
	}
//	------------------------


	public Integer getProductStateId() {
		return ProductStateId;
	}


	public void setProductStateId(Integer productStateId) {
		ProductStateId = productStateId;
	}


	public String getProductStateName() {
		return ProductStateName;
	}


	public void setProductStateName(String productStateName) {
		ProductStateName = productStateName;
	}


	public Set<ProductBean> getpBeans() {
		return pBeans;
	}


	public void setpBeans(Set<ProductBean> pBeans) {
		this.pBeans = pBeans;
	}



	
	
	
}
