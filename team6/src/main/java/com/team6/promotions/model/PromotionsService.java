package com.team6.promotions.model;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class PromotionsService {

    @Autowired
    private PromotionsRepository promotionsRepository;


    // 新增
    public Promotions insertPromotions(Promotions promotions) {
        return promotionsRepository.save(promotions);
    }

    // 刪除
    public boolean deletePromotions(String promotionsId) {
        if (promotionsRepository.existsById(promotionsId)) {
            promotionsRepository.deleteById(promotionsId);
            return true;
        }
        return false;
    }

    // 修改
    public boolean updatePromotions(Promotions promotions) {
        if (promotionsRepository.existsById(promotions.getPromotions_id())) {
            promotionsRepository.save(promotions);
            return true;
        }
        return false;
    }

    // 查詢單個
    public Promotions selectOne(String promotionsId) {
        return promotionsRepository.findById(promotionsId).orElse(null);
    }

    // 查詢全部
    public List<Promotions> selectAll() {
        return promotionsRepository.findAll();
    }


    //查詢本月
    public List<Promotions> getPromotionsForCurrentMonth() {
        return promotionsRepository.findPromotionsForCurrentMonth();
    }


    //獲取折扣碼
    public String getDiscountCode(String promotionsName) {
        Promotions promotions = promotionsRepository.findPromotionsByPromotionsName(promotionsName);
        if (promotions != null) {
            return promotions.getPromotions_discountcode();
        }
        return null;
    }

}