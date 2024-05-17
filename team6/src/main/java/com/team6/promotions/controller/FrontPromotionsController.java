package com.team6.promotions.controller;

import com.team6.promotions.model.PromotionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class FrontPromotionsController {

    @Autowired
    private PromotionsService promotionsService;

//    http://localhost:8080/templates/front-html/promotions/lottery.html

    //用於前端，回傳折扣碼
    //http://localhost:8080/aaa?promotionsName={}
    @GetMapping("/getDiscountCode")
    public String getDiscountCode(@RequestParam String promotionsName) {
        return promotionsService.getDiscountCode(promotionsName);
    }

}
