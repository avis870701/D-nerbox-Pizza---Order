<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.team6.reservation.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>訂位人數資料修改</title>
<style>
    body {
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
<h2>訂位人數資料修改</h2>
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
            <th>修改</th>
            <th>刪除</th>
        </tr>
    </thead>
    <tbody>
        <%
        List<Reserve> reservations = (ArrayList<Reserve>) request.getAttribute("reservations");
                           int index = 1;
                           for (Reserve reservation : reservations) {
        %>        
            <tr>
                <td><%= index++ %></td>
                <td><%= reservation.getReservationDate() %></td>
                <td><%= reservation.getReservationTime()%></td>
                <td><%= reservation.getNumberOfPeople() %></td>
                <td><%= reservation.getReservationName() %></td>
                <td><%= reservation.getPhone() %></td>
                <td><%= reservation.getNote() %></td>
				<td>
					<input type="text" id="peopleInput<%= reservation.getReservationId() %>" style="width: 55px;" placeholder="人數修改"> 		
					<button type="button" onclick="updatePeople('<%= reservation.getReservationId() %>')">人數修改</button>
					<input type="time" id="timeInput<%= reservation.getReservationId() %>"  >		
					<button type="button" onclick="updateTime('<%= reservation.getReservationId() %>')">時間修改</button>
					<input type="date" id="dateInput<%= reservation.getReservationId() %>" > 		
					<button type="button" onclick="updateDate('<%= reservation.getReservationId() %>')">日期修改</button>
			    </td>
				<td><button type="button" onclick="deleteReservation('<%= reservation.getReservationId() %>')">刪除</button></td>
            </tr>
        <% } %>
    </tbody>
</table>

		<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>	

<script>

		function updatePeople(reservationId) {		    	    
				    var peopleSelect = document.getElementById('peopleInput' + reservationId);
				    var newNumberOfPeople = peopleSelect.value;
		            if(newNumberOfPeople !== null && newNumberOfPeople !== '') {
		                updateNumberOfPeople(reservationId, newNumberOfPeople);
		            } else {
		                alert("請輸入有效的人數");
		            }    
		    }
		
		function updateTime(reservationId) {  	    
		    var timeSelect = document.getElementById('timeInput' + reservationId);
		    var newTime = timeSelect.value;
		    
		    if(newTime !== null && newTime !== '') {
		        updateReservationTime(reservationId, newTime);
		    } else {
		        alert("請選擇有效的時間");
		    }  
		}
		function updateDate(reservationId) {  	    
		    var dateSelect = document.getElementById('dateInput' + reservationId);
		    var newDate = dateSelect.value;

            if(newDate !== null && newDate !== '') {
                updateReservationDate(reservationId, newDate);
            } else {
                alert("請輸入有效的日期");
            }    
    }
		

		
		function updateNumberOfPeople(reservationId, newNumberOfPeople) {
		    var xhr = new XMLHttpRequest();
		    xhr.open('PUT', '/reservation/updateNumberOfPeople', true);
		    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		    xhr.send('action=updateNumberOfPeople&reservationId=' + encodeURIComponent(reservationId) + '&newNumberOfPeople=' + encodeURIComponent(newNumberOfPeople));
			location.reload();
	
		}
		
		function updateReservationDate(reservationId, newDate) {
		    var xhr = new XMLHttpRequest();
		    xhr.open('PUT', '/reservation/updateReservationDate', true);
		    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		    xhr.send('action=updateReservationDate&reservationId=' + encodeURIComponent(reservationId) + '&newDate=' + encodeURIComponent(newDate));
		    location.reload();

		}
		function updateReservationTime(reservationId, newTime) {
		    var xhr = new XMLHttpRequest();
		    xhr.open('PUT', '/reservation/updateReservationTime', true);
		    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		    xhr.send('action=updateReservationTime&reservationId=' + encodeURIComponent(reservationId) + '&newTime=' + encodeURIComponent(newTime));
			location.reload();

		}
		
		function deleteReservation(reservationId) {
		    if (confirm("確定要刪除此訂位資訊嗎？")) {
		        var xhr = new XMLHttpRequest();
		        xhr.open('DELETE', '/reservation/deleteReservation', true);
		        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		        xhr.send('action=deleteReservation&reservationId=' + encodeURIComponent(reservationId));
		        location.reload();

		    }
		}


</script>
</body>
</html>
