package com.team6.delivery.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class DeliveryService {
	
	@Autowired
	private DeliveryRepository dRepos;
	
	 
	public List<Delivery> finall(){
		return dRepos.findAll();
	}
	public List<Delivery> findstatus(){
		return dRepos.findstatus();
	}


	
}
