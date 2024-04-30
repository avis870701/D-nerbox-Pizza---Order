package com.team6.member.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface RepositoryMemberDetail extends JpaRepository<MemberDetailBean, Integer> {

	@Query(value = "select * from memberDetail where fk_maId = ?1 ORDER BY mdid",nativeQuery = true)
	public Optional<MemberDetailBean> findDetailByAccount(String account);
	
	@Query(value = "from MemberDetailBean where mName like concat('%',?1,'%')")
	public List<MemberDetailBean> findDetailByName(String name);
}
