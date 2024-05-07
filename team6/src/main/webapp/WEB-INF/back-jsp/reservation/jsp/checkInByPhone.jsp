<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.team6.reservation.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>報到資訊(CheckIn)</title>
<style>
    body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif; 
        text-align: center; 
    }
    table {
        width: 80%;
        margin: 0 auto; 
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd; 
        padding: 8px; 
        text-align: left; 
    }
    th {
        background-color: #f2f2f2; 
    }
        button {
	border: none;
	border-radius: 8px;
	padding: 10px 20px;
	background-color: #3498db;
	color: white;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 12px;
	margin: 4px 2px;
	cursor: pointer;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 添加陰影效果 */
	transition-duration: 0.4s;
}

button:hover {
	background-color: #2980b9;
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2); /* 滑鼠懸停時的陰影效果 */
}
</style>
</head>

<body>
<h2>報到資訊(CheckIn)</h2>
<table>
    <thead>
        <tr>
            <th>預訂姓名</th>
            <th>預訂日期</th>
            <th>預訂時間</th>
            <th>電話號碼</th>
            <th>人數</th>
            <th>備註</th>
            <th>報到完成</th>
            <th>刪除</th>
        </tr>
    </thead>
    <tbody>
    <tr>
        <%
        List<Reserve> selectPhone = (ArrayList<Reserve>) request.getAttribute("selectPhone");
                        for (Reserve selectPhones : selectPhone) {
        %>
                <td><%= selectPhones.getReservationName() %></td>
                <td><%= selectPhones.getReservationDate() %></td>
                <td><%= selectPhones.getReservationTime() %></td>
                <td><%= selectPhones.getPhone() %></td>
                <td><%= selectPhones.getNumberOfPeople() %></td>
                <td><%= selectPhones.getNote() %></td>
                <td><button type="button" onclick="checkInSuccess('<%= selectPhones.getReservationId() %>')">報到完成</button></td>
                <td><button type="button" onclick="deleteCheckIn('<%= selectPhones.getReservationId() %>')">刪除</button></td>
            </tr>
        <% } %>
    </tbody>
</table>
		<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>	

<script>
	function checkInSuccess(reservationId) {
	    var xhr = new XMLHttpRequest();
	    xhr.open('PUT', '/reservation/checkInSuccess', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    xhr.onreadystatechange = function() {
		location.reload(); 
	    };
	    xhr.send('action=checkInSuccess&reservationId=' + encodeURIComponent(reservationId));
	}
	
	function deleteCheckIn(reservationId) {
	    var xhr = new XMLHttpRequest();
	    xhr.open('PUT', '/reservation/deleteCheckIn', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    xhr.onreadystatechange = function() {
	    location.reload(); 
	    };
	    xhr.send('action=deleteCheckIn&reservationId=' + encodeURIComponent(reservationId));
	}
	
</script>
</body>
</html>