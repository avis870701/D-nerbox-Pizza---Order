package com.team6.product.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductService {

	@Autowired
	private ProductRepository pRespository;
	
	// 新增
	public ProductBean InsertProduct(ProductBean productBean) {
		ProductBean insert = pRespository.save(productBean);
		return insert;
	}
	
	// Delete
	public void DeleteProduct(Integer productId) {
		pRespository.deleteById(productId);
	}
	
	// 偽刪除，修改																	
	public ProductBean ChangeProductState(Integer productId, ProductState pState) {  
//		找出要更新狀態的Productbean物件
		ProductBean changeStatebyId = pRespository.findById(productId).get();
//		
//		把stateId所對應到的ProductState表格資料(及pState)set給要更新狀態的bean物件(changeStatebyId)
		changeStatebyId.setProductState(pState);
		ProductBean save = pRespository.save(changeStatebyId);
		return save;
	}
	
	// 修改								
	public void UpdateProduct(ProductBean productBean) {
		pRespository.save(productBean);
	}
	
	
	// 查詢單筆ById
	public ProductBean SelectById(Integer productId) {
		Optional<ProductBean> findById = pRespository.findById(productId);
		return findById.orElse(null);
	}
	
	// 模糊查詢
	public List<ProductBean> SelectName(String name) {
		return pRespository.findByNameLike(name);
	}
	
	// 查詢全部
	public List<ProductBean> SelectAll() {
		return pRespository.findAll();
	}
	
	
	

}
