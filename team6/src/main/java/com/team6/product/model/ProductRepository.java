package com.team6.product.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProductRepository extends JpaRepository<ProductBean, Integer> {
	
	@Query(value = "from ProductBean where productName like concat('%',?1,'%') order by productCreateDate DESC, productId DESC")
	public List<ProductBean> findByNameLike(String name);
	
	
	@Query(value = "from ProductBean order by productCreateDate DESC, productId DESC")
	public List<ProductBean> findAll();
	
	//訂單 查詢所有上架商品
	@Query(value = "SELECT * from Product p WHERE p.ProductStateId = 1", nativeQuery = true)
	public List<ProductBean> findProductIsOn();
}
