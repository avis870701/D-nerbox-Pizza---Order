package com.team6.promotions.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface PromotionsRepository extends JpaRepository<Promotions, String> {
    @Query("SELECT p FROM Promotions p WHERE MONTH(p.Promotions_startdate) = MONTH(CURRENT_DATE) AND YEAR(p.Promotions_startdate) = YEAR(CURRENT_DATE)")
    List<Promotions> findPromotionsForCurrentMonth();

}
