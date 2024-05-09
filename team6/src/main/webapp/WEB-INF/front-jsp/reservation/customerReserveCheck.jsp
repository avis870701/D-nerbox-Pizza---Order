<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂位資訊</title>
<style>
    body {
        background-color: #f2f2f2;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 80%;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    p {
        margin-bottom: 10px;
    }
</style>
<jsp:useBean id="customerReserveCheck" class="com.team6.reservation.model.Reserve" scope="request"/>
</head>
<body>
<div class="container">
    <h1>訂位資訊</h1>
    <p>以下是您的訂位資訊，如有問題歡迎撥打電話查詢。</p>
  <table>
        <tr>
            <th>項目</th>
            <th>內容</th>
        </tr>
        <tr>
            <td>訂位大名：</td>
            <td><%= customerReserveCheck.getReservationName()%></td>
        </tr>
        <tr>
            <td>訂位電話：</td>
            <td><%= customerReserveCheck.getPhone() %></td>
        </tr>
        <tr>
        	<td>人數：</td>
        	<td><%= customerReserveCheck.getNumberOfPeople() %></td>
        </tr>
        <tr>
            <td>訂位日期：</td>
            <td><%= customerReserveCheck.getReservationDate() %></td>
        </tr>
        <tr>
            <td>訂位時間：</td>
            <td><%= customerReserveCheck.getReservationTime() %></td>
        </tr>
        <tr>
        	<td>訂位狀態：</td>
        	<td><%
					int rstatus = customerReserveCheck.getReservationStatus();

					if (rstatus == 0) {
						out.print("店家尚未確認訂位，請稍後再查看或撥打電話詢問");
					}else if(rstatus == 1 ){
						out.print("店家已確認訂位");
					}else if(rstatus == 2 ){
						out.print("您已取消訂位");
					}else if(rstatus == 3 ){
						out.print("您已確認訂位");
					}else if(rstatus == 5){
						out.print("店家已取消訂位，如有疑問請撥打電話詢問");
					}else{
						out.print("其他狀態");
					}
					%></td>
        </tr>
        <tr>
        	<td>用餐狀態：</td>
        	<td><%
        			int cstatus	= customerReserveCheck.getCheckInStatus();
        		
        			if(cstatus == 1){
        				out.print("用餐中，請享受您的餐點😎");
        			}else if(cstatus == 2){
        				out.print("用餐完畢");
        			}else if(cstatus == 0){
        				out.print("尚未報到");
        			}
        	
        	%></td>
        </tr>
    </table>
    
    <p>

</div>


</body>
</html>
