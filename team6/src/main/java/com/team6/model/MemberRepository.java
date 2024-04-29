package com.team6.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface MemberRepository extends JpaRepository<MemberBean, String> {
	@Query(value = "from MemberBean where mName like concat('%',?1,'%')")
	public List<MemberBean> findBymName(String name);
	
//	@Query(value = "select * from member where mName like concat('%',?1,'%') ORDER BY account OFFSET ?2 *10 ROWS FETCH NEXT ?3 ROWS only",nativeQuery = true)
//	public List<MemberBean> findBymNameByPage(String name, int PageNumber,int PageSize);
}
