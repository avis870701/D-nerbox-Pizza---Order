package com.team6.member.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface RepositoryMemberAccount extends JpaRepository<MemberAccountBean, Integer> {

	@Query(value ="from MemberAccountBean where mAccount= ?1 and mPassword = ?2")
	public Optional<MemberAccountBean> login(String acconut,String pwd);
	
	@Query(value ="from MemberAccountBean where mAccount= ?1")
	public Optional<MemberAccountBean> findAccountByAccount(String account);
}
