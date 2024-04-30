package com.team6.delivery.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DeliveryService {
	
	@Autowired
	private DeliveryRepository dRepos;
	
	public Delivery insert(Delivery delivery) {
		return dRepos.save(delivery);
	}
	public Delivery update(Delivery delivery) {
		return dRepos.save(delivery);
	}

	public void deleteById(Integer id) {
		dRepos.deleteById(id);
	}
	
	public List<Delivery> findAll(){
		return dRepos.findAll();
	}
	//查詢未刪除
	public List<Delivery> findTall(){
		return dRepos.findTall();
	}
	//查詢已刪除
	public List<Delivery> findFall(){
		return dRepos.findFall();
	}
	
	public Delivery findById(Integer id) {
		Optional<Delivery> op1 = dRepos.findById(id);
	if(op1.isPresent()) {
		return op1.get();
	}
		return null;
	
	}
	
	public void updateDel(Integer id) {
		dRepos.UpdateDel(id);
	}
	
	public void rollback(Integer id) {
		dRepos.RollbackDel(id);
	}
}
