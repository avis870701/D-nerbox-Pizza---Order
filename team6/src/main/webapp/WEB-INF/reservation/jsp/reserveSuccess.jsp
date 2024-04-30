<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂位成功</title>
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
<jsp:useBean id="insertReservation" class="com.team6.reservation.model.Reserve" scope="request"/>
</head>
<body>
<div class="container">
    <h1>訂位成功</h1>
  <table>
        <tr>
            <th>項目</th>
            <th>內容</th>
        </tr>
        <tr>
            <td>訂位大名：</td>
            <td><%= insertReservation.getReservationName()%></td>
        </tr>
        <tr>
            <td>訂位電話：</td>
            <td><%= insertReservation.getPhone() %></td>
        </tr>
        <tr>
            <td>訂位日期：</td>
            <td><%= insertReservation.getReservationDate() %></td>
        </tr>
        <tr>
            <td>訂位時間：</td>
            <td><%= insertReservation.getReservationTime() %></td>
        </tr>
    </table>
    <p>
    <div align="center">
		<a href="/reservation/customerreservemain.controller"><button><b>回首頁</b></button></a>	
	</div>
</div>


</body>
</html>
