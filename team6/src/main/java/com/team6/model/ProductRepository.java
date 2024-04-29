package com.team6.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProductRepository extends JpaRepository<ProductBean, Integer> {
	
	@Query(value = "from ProductBean where productName like concat('%',?1,'%')")
	public List<ProductBean> findByNameLike(String name);
	
}
