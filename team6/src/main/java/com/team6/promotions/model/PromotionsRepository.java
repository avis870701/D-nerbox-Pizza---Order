package com.team6.promotions.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;

@Repository
public interface PromotionsRepository extends JpaRepository<Promotions, String> {

	@Transactional
	@Modifying
	@Query(value = "SELECT * from Promotions p WHERE p.Promotions_startDate >= GETDATE();",nativeQuery = true)
	List<Promotions> findEfficientDiscountList();

}
