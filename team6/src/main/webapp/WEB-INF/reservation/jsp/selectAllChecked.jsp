<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.team6.reservation.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>目前用餐客人資訊</title>
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
<h2>目前用餐客人資訊</h2>
<table>
    <thead>
        <tr>
            <th>用餐顧客姓名</th>
            <th>用餐日期</th>
            <th>用餐時間</th>
            <th>用餐人數</th>
            <th>電話號碼</th>
            <th>備註</th>
            <th>刪除</th>
        </tr>
    </thead>
    <tbody>
        <%
        List<Reserve> selectAllChecked = (ArrayList<Reserve>) request.getAttribute("selectAllChecked");
                        for (Reserve selectAllCheckeds : selectAllChecked) {
        %>
                <td><%= selectAllCheckeds.getReservationName() %></td>
                <td><%= selectAllCheckeds.getReservationDate() %></td>
                <td><%= selectAllCheckeds.getReservationTime() %></td>
                <td><%= selectAllCheckeds.getNumberOfPeople() %></td>                
                <td><%= selectAllCheckeds.getPhone() %></td>
                <td><%= selectAllCheckeds.getNote() %></td>                
   				<td><button type="button" onclick="confirmDelete('<%= selectAllCheckeds.getReservationId()%>')">已離開</button></td>
            </tr>
        <% } %>
    </tbody>

</table>
		<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>	

<script>
	function confirmDelete(reservationId) {
	    if (confirm("客人是否已離場？")) {
	        deleteCheckIn(reservationId);
	    }
	}

	function deleteCheckIn(reservationId) {
	    var xhr = new XMLHttpRequest();
	    xhr.open('DELETE', '/reservation/deleteCheckIn', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === XMLHttpRequest.DONE) {
	            location.reload();
	        }
	    }; 
	    xhr.send('action=deleteCheckIn&reservationId=' + encodeURIComponent(reservationId));
	}
</script>
</body>