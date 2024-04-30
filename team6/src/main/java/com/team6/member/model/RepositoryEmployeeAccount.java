package com.team6.member.model;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RepositoryEmployeeAccount extends JpaRepository<EmployeeAccountBean, Integer> {
	@Query(value ="from EmployeeAccountBean where empAccount= ?1 and empPassword = ?2")
	public Optional<EmployeeAccountBean> login(String acconut,String pwd);
	
	@Query(value ="from EmployeeAccountBean where empAccount= ?1 and empPassword = ?2")
	public Page<MemberAccountBean> findByNamePage(Pageable pageable);
}
