package com.team6.promotions.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.team6.promotions.model.Promotions;
import com.team6.promotions.model.PromotionsService;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/promotions")
public class PromotionsController {

    @Autowired

    private PromotionsService promotionsService;

    // 查詢全部
    @GetMapping("/promotionsMain")
    public String getAllPromotions(Model model) {
        List<Promotions> promotions = promotionsService.selectAll();
        model.addAttribute("promotions", promotions);
//        return "GetAllPromotions";
          return "promotions/test123" ;
    }

    // 查詢單筆
    @GetMapping("/promotions/{id}")
    public String getPromotionsById(@PathVariable("id") String promotionsId, Model model) {
        Promotions promotions = promotionsService.selectOne(promotionsId);
        model.addAttribute("promotions", promotions);
        return "GetPromotions";
    }

    @GetMapping("/promotions/insert")
    public String insertPromotions() {
        return "InsertPromotions";
    }


    @PostMapping("/promotions/insert")
    public String insertPromotions(@RequestParam("Promotions_id") String Promotions_id, @RequestParam("Promotions_name") String Promotions_name, @RequestParam("Promotions_content") String Promotions_content, @RequestParam("Promotions_picture") MultipartFile mf, @RequestParam("Promotions_discount") String Promotions_discount, @RequestParam("Promotions_discountcode") String Promotions_discountcode, @RequestParam("Promotions_startdate") String Promotions_startdate, @RequestParam("Promotions_enddate") String Promotions_enddate) {

        if (!mf.isEmpty()) {
            try {
                String fileName = mf.getOriginalFilename();
                // 上传文件的保存路径
//                String fileDir = "C:/Users/User/Downloads/0424/SpringBoot版/team6/src/main/resources/static/images";
                String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/images/promotions";
                File fileDirPath = new File(fileDir, fileName);

                mf.transferTo(fileDirPath);

                String Promotions_picture = "/images/promotions/" + fileName;

                Promotions result = new Promotions(Promotions_id, Promotions_name, Promotions_content, Promotions_picture, Promotions_discount, Promotions_discountcode, Promotions_startdate, Promotions_enddate);
                promotionsService.insertPromotions(result);
                return "redirect:/promotions/promotionsMain";
            } catch (IOException e) {
                e.printStackTrace();
                return "redirect:/error";
            }
        } else {
            Promotions result = new Promotions(Promotions_id, Promotions_name, Promotions_content, "", Promotions_discount, Promotions_discountcode, Promotions_startdate, Promotions_enddate);
            promotionsService.insertPromotions(result);
            return "redirect:/promotions/promotionsMain";
        }
    }


    // ID更新單筆
    @GetMapping("/promotions/update/{id}")
    public String showUpdateForm(@PathVariable("id") String promotionsId, Model model) {
        Promotions promotions = promotionsService.selectOne(promotionsId);
        model.addAttribute("promotions", promotions);
        return "DoUpdatePromotions";
    }

    //更新
    @PutMapping("/promotions/update")
    public String updatePromotions(Promotions promotions) {
        boolean isSuccess = promotionsService.updatePromotions(promotions);
        return isSuccess ? "redirect:/promotions/promotionsMain" : "/FailPromotions";
    }

    //刪除
    @DeleteMapping("/promotions/delete/{id}")
    @ResponseBody
    public String deletePromotions(@PathVariable("id") String promotionsId) {
        boolean isSuccess = promotionsService.deletePromotions(promotionsId);
//		return isSuccess ? "redirect:/promotions/promotionsMain" : "FailPromotions";
        return "success";
    }
}
