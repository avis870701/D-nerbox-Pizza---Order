package com.team6.delivery.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DeliveryService {
	
	@Autowired
	private DeliveryRepository dRepos;
	
	//查詢所有外送單資料
	public List<Delivery> findall(){
		return dRepos.findAll();
	}
	//刪除單筆
	public void DelDelivery(int id) {
		dRepos.deleteById(id);
	}
	//新增
	public Delivery insert(Delivery delivery){
		 return dRepos.save(delivery);
	}
	 
	
}
