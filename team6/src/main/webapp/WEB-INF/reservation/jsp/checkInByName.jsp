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
        List<Reserve> selectName = (ArrayList<Reserve>) request.getAttribute("selectName");
                        for (Reserve selectNames : selectName) {
        %>
                <td><%= selectNames.getReservationName() %></td>
                <td><%= selectNames.getReservationDate() %></td>
                <td><%= selectNames.getReservationTime() %></td>
                <td><%= selectNames.getPhone() %></td>
                <td><%= selectNames.getNumberOfPeople() %></td>
                <td><%= selectNames.getNote() %></td>
                <td><button type="button" onclick="checkInSuccess('<%= selectNames.getReservationId() %>')">報到完成</button></td>
                <td><button type="button" onclick="deleteCheckIn('<%= selectNames.getReservationId() %>')">刪除</button></td>
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
	    xhr.open('DELETE', '/reservation/deleteCheckIn', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    xhr.onreadystatechange = function() {
	    location.reload(); 
	    };
	    xhr.send('action=deleteCheckIn&reservationId=' + encodeURIComponent(reservationId));
	}
	
</script>
</body>
</html>
