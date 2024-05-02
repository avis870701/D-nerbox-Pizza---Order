<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.util.List,com.team6.reservation.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>確認訂位資訊</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        text-align: center;
    }
    table {
        border-collapse: collapse;
        width: 80%;
        margin: 0 auto;
    }
    th, td {
        border: 1px solid #dddddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <h1>確認訂位資訊</h1>
    <table>
        <thead>
            <tr>
                <th>編號</th>
                <th>日期</th>
                <th>時間</th>
                <th>人數</th>
                <th>姓名</th>
                <th>電話</th>
                <th>備註</th>
                <th>確認</th>
                <th>刪除</th>
                
            </tr>
        </thead>
        <tbody>
            <%
            List<Reserve> reservations = (ArrayList<Reserve>) request.getAttribute("selectReservationStatus");
                                       int index = 1;
                                       for (Reserve reservation : reservations) {
            %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= reservation.getReservationDate() %></td>
                    <td><%= reservation.getReservationTime() %></td>
                    <td><%= reservation.getNumberOfPeople()%></td>
                    <td><%= reservation.getReservationName() %></td>
                    <td><%= reservation.getPhone() %></td>
                    <td><%= reservation.getNote() %></td>
                    <td><button onclick="confirmReservation('<%= reservation.getReservationId() %>')">確認</button></td>
                    <td><button onclick="deleteReservation('<%= reservation.getReservationId() %>')">刪除</button></td>
                    
                </tr>
            <% } %>
        </tbody>
    </table>
   		<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>	
    
	<script>
		function confirmReservation(reservationId) {
		    var confirmed = confirm("確定要確認此訂位嗎？");
		    if (confirmed) {
		        var xhr = new XMLHttpRequest();
		        xhr.open('PUT', '/reservation/confirmReservation', true);
		        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		        xhr.onreadystatechange = function() {
				location.reload();
		        };
		        xhr.send('action=confirmReservation&reservationId=' + reservationId);
		    }
		}
	
		function deleteReservation(reservationId) {
		    var confirmed = confirm("確定要刪除此訂位嗎？");
		    if (confirmed) {
		        var xhr = new XMLHttpRequest();
		        xhr.open('DELETE', '/reservation/deleteCheckIn', true);
		        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		        xhr.onreadystatechange = function() {
				location.reload();
		        };
		        xhr.send('action=deleteReservation&reservationId=' + reservationId);
		    }
		}	
	</script>
</body>
</html>
