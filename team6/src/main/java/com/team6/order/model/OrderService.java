package com.team6.order.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrderRepository oRepos;
	
	@Autowired
	private DetailsRepository dReops;
	
	
}
