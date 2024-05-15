package com.team6.promotions.controller;

import com.team6.promotions.model.PromotionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FrontPromotionsController {

    @Autowired
    private PromotionsService promotionsService;

//    http://localhost:8080/templates/front-html/promotions/lottery.html

    //用於前端，回傳折扣碼
    //http://localhost:8080/aaa?promotionsName=array
    @GetMapping("/getDiscountCode")
    public String getDiscountCode(@RequestParam String promotionsName) {
        return promotionsService.getDiscountCode(promotionsName);
    }


//    function fetchDiscountCode(promotionsName) {
//        $.ajax({
//                url: '/getDiscountCode',
//                method: 'GET',
//                data: { promotionsName: promotionsName }, // 确保参数名为 'promotionsName'
//        success: function(response) {
//            if (response) {
//                alert('Your discount code is: ' + response);
//            } else {
//                alert('Discount code not found!');
//            }
//        },
//        error: function() {
//            alert('Error fetching discount code!');
//        }
//    });
//    }


}
