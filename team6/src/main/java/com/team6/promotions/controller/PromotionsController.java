package com.team6.promotions.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.team6.promotions.model.Promotions;
import com.team6.promotions.model.PromotionsService;

@Controller
@RequestMapping("/promotions")
public class PromotionsController {

    @Autowired
    private PromotionsService promotionsService;
    
    /*因為thymeleaf會搶路徑,所以要forward:*/

    // 查詢全部
    @GetMapping("/promotionsMain")
    public String getAllPromotions(Model model) {
        List<Promotions> promotions = promotionsService.selectAll();
        model.addAttribute("promotions", promotions);
        return "forward:/WEB-INF/Promotions/GetAllPromotions.jsp";
    }

    // 查詢單筆
    @GetMapping("/promotions/{id}")
    public String getPromotionsById(@PathVariable("id") String promotionsId, Model model) {
        Promotions promotions = promotionsService.selectOne(promotionsId);
        model.addAttribute("promotions", promotions);
        return "forward:/WEB-INF/Promotions/GetPromotions.jsp";
    }

    @GetMapping("/promotions/insert")
    public String insertPromotions() {
        return "forward:/WEB-INF/Promotions/InsertPromotions.jsp";
    }


    @PostMapping("/promotions/insert")
    public String insertPromotions(@RequestParam("Promotions_id") String Promotions_id, @RequestParam("Promotions_name") String Promotions_name, @RequestParam("Promotions_content") String Promotions_content, @RequestParam("Promotions_picture") MultipartFile mf, @RequestParam("Promotions_discount") String Promotions_discount, @RequestParam("Promotions_discountcode") String Promotions_discountcode, @RequestParam("Promotions_startdate") String Promotions_startdate, @RequestParam("Promotions_enddate") String Promotions_enddate) {

        if (!mf.isEmpty()) {
            try {
                String fileName = mf.getOriginalFilename();
                // 上传文件的保存路径 原版 54行是組長整合用的路徑
//                String fileDir = "C:/Users/User/Downloads/0424/SpringBoot版/team6/src/main/resources/static/images";
//                String fileDir = "C:/Action/workspace/team6/src/main/resources/static/promotions/images";
                String fileDir = "C:/Users/User/Documents/team6/team6/src/main/resources/static/promotions/images";
                File fileDirPath = new File(fileDir, fileName);

                mf.transferTo(fileDirPath);

                String Promotions_picture = "/promotions/images/" + fileName;

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
        return "forward:/WEB-INF/Promotions/DoUpdatePromotions.jsp";
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
