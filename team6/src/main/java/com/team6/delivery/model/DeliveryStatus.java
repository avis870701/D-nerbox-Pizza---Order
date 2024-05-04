package com.team6.delivery.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Component
@Table(name = "deliverystatus")
public class DeliveryStatus {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "statusid")
	private byte statusid;
	@Column(name = "statusname")
	private String statusname;
	

	public DeliveryStatus() {
	}
	public DeliveryStatus(byte statusid, String statusname) {
		super();
		this.statusid = statusid;
		this.statusname = statusname;
	}
	public byte getStatusid() {
		return statusid;
	}
	public void setStatusid(byte statusid) {
		this.statusid = statusid;
	}
	public String getStatusname() {
		return statusname;
	}
	public void setStatusname(String statusname) {
		this.statusname = statusname;
	}
	

}
