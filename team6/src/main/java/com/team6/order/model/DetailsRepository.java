package com.team6.order.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import jakarta.transaction.Transactional;

public interface DetailsRepository extends JpaRepository<OrderDetails, Integer> {

	// find by orderid
	List<OrderDetails> findByOrderId(String orderId);

	// delete by orderid
	void deleteByOrderId(String orderId);

	// update product
	@Transactional
	@Modifying
	@Query("UPDATE OrderDetails o SET o.productId = :productId, o.product = :product, o.unitPrice = :unitPrice WHERE o.detailsId = :detailsId")
	void updateProductByDetailsId(Integer detailsId, String productId, String product, String unitPrice);

	// update quantity
	@Transactional
	@Modifying
	@Query("UPDATE OrderDetails o SET o.quantity = :quantity WHERE o.detailsId = :detailsId")
	void updateQuantityByDetailsId(Integer detailsId, String quantity);

	// update note
	@Transactional
	@Modifying
	@Query("UPDATE OrderDetails o SET o.note = :note WHERE o.detailsId = :detailsId")
	void updateNoteByDetailsId(Integer detailsId, String note);

}
