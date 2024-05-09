package com.team6.product.model;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TestPageRepository extends JpaRepository<TestPage, Integer> {

	//後端查詢全部
		@Query(value = "SELECT * FROM TestPage", countQuery = "SELECT count(*) FROM TestPage", nativeQuery = true)
		Page<TestPage> findTestPageAll(Pageable pageable);
	
	
}
