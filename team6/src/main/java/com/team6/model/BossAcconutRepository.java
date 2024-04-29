package com.team6.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface BossAcconutRepository extends JpaRepository<BossAccountBean, String> {
	@Query(value ="from BossAccountBean where account= ?1 and password = ?2")
	public Optional<BossAccountBean> login(String acconut,String pwd);
}
