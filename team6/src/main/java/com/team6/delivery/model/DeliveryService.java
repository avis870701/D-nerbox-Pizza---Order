package com.team6.delivery.model;

import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import java.util.Optional;

import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.team6.order.model.DetailsRepository;
import com.team6.order.model.OrderDetails;
import com.team6.order.model.OrderRepository;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


@Service
@Transactional
public class DeliveryService {
	
	@Autowired
	private DeliveryRepository dRepos;
	
	
	
	//查詢所有外送單資料
	public List<Delivery> findall(){
		return dRepos.findAll();
	}
	//查詢單筆
	public Delivery findById(Integer id) {
		Optional<Delivery> op1 = dRepos.findById(id);
		if(op1.isPresent()) {
			return op1.get();
		}
			return null;	
	}
	
	// 查詢單筆訂單明細
//	public List<OrderDetails> findDetailsById(int orderId) {
//		List<OrderDetails> details = dRepos.findByOrderId(orderId);
//
//		if (!details.isEmpty()) {
//			return details;
//		}
//		return null;
//	}
	
	//修改
	public Delivery update(Delivery delivery) {
		return dRepos.save(delivery);
	}
	
	
	//刪除單筆
	public void DelDelivery(int id) {
		dRepos.deleteById(id);
	}
	//新增
	public Delivery insert(Delivery delivery){
		 return dRepos.save(delivery);
	}
	//創建JSON檔案
	public void saveJson() {
	    Gson gson = new GsonBuilder().setPrettyPrinting().create();
	    List<Delivery> deliveries = dRepos.findAll();
	    String json = gson.toJson(deliveries);

	    String folderPath = "C:/JSON";
	    String fileName = "外送單資料.json";

	    // 檢查並創建目標文件夾
	    try {
	        Path path = Paths.get(folderPath);
	        if (!Files.exists(path)) {
	            Files.createDirectories(path);
	        }

	        // 構建完整的文件路徑
	        String filePath = folderPath + "/" + fileName;

	        // 寫入JSON數據到文件
	        try (FileWriter writer = new FileWriter(filePath)) {
	            writer.write(json);
	            System.out.println("JSON數據已成功寫入到文件：" + filePath);
	        } catch (IOException e) {
	            System.err.println("無法寫入JSON數據到文件：" + filePath);
	            e.printStackTrace();
	        }

	    } catch (IOException e) {
	        System.err.println("無法創建目標文件夾：" + folderPath);
	        e.printStackTrace();
	    }
	}
	//創建xml檔案
	public void saveXml() {
	    XStream xstream = new XStream(new DomDriver());
	    List<Delivery> deliveries = dRepos.findAll();

	    // 設定別名 (alias) 以便在 XML 中使用指定的標籤名稱
	    xstream.alias("delivery", Delivery.class);

	    String xml = xstream.toXML(deliveries);

	    String folderPath = "C:/XML";
	    String fileName = "外送單資料.xml";

	    // 檢查並創建目標文件夾
	    try {
	        Path path = Paths.get(folderPath);
	        if (!Files.exists(path)) {
	            Files.createDirectories(path);
	        }

	        // 構建完整的文件路徑
	        String filePath = folderPath + "/" + fileName;

	        // 寫入 XML 數據到文件
	        try (FileWriter writer = new FileWriter(filePath)) {
	            writer.write(xml);
	            System.out.println("XML 數據已成功寫入到文件：" + filePath);
	        } catch (IOException e) {
	            System.err.println("無法寫入 XML 數據到文件：" + filePath);
	            e.printStackTrace();
	        }

	    } catch (IOException e) {
	        System.err.println("無法創建目標文件夾：" + folderPath);
	        e.printStackTrace();
	    }
	}
	//創建Excel檔案
	public void saveExcel() {
	    List<Delivery> deliveries = dRepos.findAll();

	    String folderPath = "C:/EXCEL";
	    String fileName = "外送單資料.xlsx";

	    // 檢查並創建目標文件夾
	    try {
	        Path path = Paths.get(folderPath);
	        if (!Files.exists(path)) {
	            Files.createDirectories(path);
	        }

	        // 構建完整的文件路徑
	        String filePath = folderPath + "/" + fileName;

	        // 建立新的 Excel 工作簿
	   
	        Workbook workbook = new XSSFWorkbook();
	        Sheet sheet = workbook.createSheet("Delivery Data");

	        // 創建標題行
	        Row headerRow = sheet.createRow(0);
	        headerRow.createCell(0).setCellValue("外送訂單");
	        headerRow.createCell(1).setCellValue("日期");
	        headerRow.createCell(2).setCellValue("地址");
//	        headerRow.createCell(3).setCellValue("Status");

	        // 填入資料
	        int rowNum = 1;
	        for (Delivery delivery : deliveries) {
	            Row row = sheet.createRow(rowNum++);
	            row.createCell(0).setCellValue(delivery.getId());
	            row.createCell(1).setCellValue(delivery.getDate());
	            row.createCell(2).setCellValue(delivery.getAddress());
//	            row.createCell(3).setCellValue(delivery.getStatus());
	        }

	        // 將 Excel 工作簿寫入到文件
	        try (FileOutputStream outputStream = new FileOutputStream(filePath)) {
	            workbook.write(outputStream);
	            System.out.println("Excel 檔案已成功儲存：" + filePath);
	        } catch (IOException e) {
	            System.err.println("無法寫入 Excel 檔案：" + filePath);
	            e.printStackTrace();
	        }

	    } catch (IOException e) {
	        System.err.println("無法創建目標文件夾：" + folderPath);
	        e.printStackTrace();
	    }
	}
	 
	
}