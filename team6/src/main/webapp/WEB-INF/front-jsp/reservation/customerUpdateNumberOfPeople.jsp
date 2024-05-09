<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂位資料</title>
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
<jsp:useBean id="selectCustomerTommorowComeOrNot" class="com.team6.reservation.model.Reserve" scope="request"/>
</head>
<body>
<div class="container">
    <h1>以下是您的訂位資料</h1>
  <table>
        <tr>
            <th>項目</th>
            <th>內容</th>
        </tr>
        <tr>
            <td>訂位大名：</td>
            <td><%= selectCustomerTommorowComeOrNot.getReservationName()%></td>
        </tr>
        <tr>
            <td>訂位電話：</td>
            <td><%= selectCustomerTommorowComeOrNot.getPhone() %></td>
        </tr>
        <tr>
            <td>人數：</td>
            <td><%= selectCustomerTommorowComeOrNot.getNumberOfPeople() %></td>
        </tr>   
        <tr>
            <td>訂位日期：</td>
            <td><%= selectCustomerTommorowComeOrNot.getReservationDate() %></td>
        </tr>
        <tr>
            <td>訂位時間：</td>
            <td><%= selectCustomerTommorowComeOrNot.getReservationTime() %></td>
        </tr> 
        <tr>
            <td>UUID：</td>
            <td><%= selectCustomerTommorowComeOrNot.getReservationUUID() %></td>
        </tr> 
        
</div>       

    <form action="/reservation/updateNumberOfPeopleAndReservationStatusTo3" method="GET">
        <input type="hidden" name="reservationUuid" value="<%= selectCustomerTommorowComeOrNot.getReservationUUID() %>">
        <input type="number" name="newNumberOfPeople" placeholder="輸入新的人數">
        <button type="submit"><b>更新人數</b></button>
    </form>
    </table>
    <p>
    <div align="center">
		<a href="/reservation/customerreservemain.controller"><button><b>回首頁</b></button></a>	
	</div>
</div>


</body>
</html>
