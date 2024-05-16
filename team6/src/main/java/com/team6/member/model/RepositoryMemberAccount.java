package com.team6.member.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface RepositoryMemberAccount extends JpaRepository<MemberAccountBean, Integer> {

	@Query(value ="from MemberAccountBean where mAccount= ?1 and mPassword = ?2")
	public Optional<MemberAccountBean> login(String acconut,String pwd);
	
	@Query(value ="from MemberAccountBean where mAccount= ?1")
	public Optional<MemberAccountBean> findAccountByAccount(String account);
	
	@Query(value ="from MemberAccountBean where detailBean.mName like %:n% or mAccount like %:n% or maid = :n  ORDER BY maid")
	public List<MemberAccountBean> findByName(@Param("n")String name);
	
	@Query(value ="SELECT * FROM memberAccount where hidden =1",nativeQuery = true)
	public List<MemberAccountBean> findAllByNotHidden();
	
	@Query(value ="SELECT * FROM memberAccount a join memberDetail d on a.maid = d.fk_maId WHERE d.mName like %:n%",nativeQuery = true)
	public Page<MemberAccountBean> findByNamePage(Pageable pageable, @Param("n")String empName);
	
	@Query(value ="SELECT * FROM memberAccount where hidden =1",nativeQuery = true)
	public Page<MemberAccountBean> findAllByNotHiddenByPage(Pageable pageable);
	
//	@Query(value ="from MemberAccountBean where :type like %:name% ORDER BY maid")
//	public Page<MemberAccountBean> findByNamePage(Pageable pageable, @Param("type")String type, @Param("name")String empName);
}
