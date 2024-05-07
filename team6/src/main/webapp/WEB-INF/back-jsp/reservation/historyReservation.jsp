<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.team6.reservation.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>歷史訂位紀錄</title>
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
            <th>預定狀態</th>
        </tr>
    </thead>
    <tbody>
	      <%
        List<Reserve> historyReservations = (ArrayList<Reserve>) request.getAttribute("historyReservation");
                           int index = 1;
                           for (Reserve historyReservation : historyReservations) {
        %>        
            <tr>
				<td><%=index++%></td>
				<td><%=historyReservation.getReservationDate()%></td>
				<td><%=historyReservation.getReservationTime()%></td>
				<td><%=historyReservation.getNumberOfPeople()%></td>
				<td><%=historyReservation.getReservationName()%></td>
				<td><%=historyReservation.getPhone()%></td>
				<td><%=historyReservation.getNote()%></td>
				<td>
					<%
					int status = historyReservation.getReservationStatus();

					if (status == 1) {
						out.print("未確認");
					} else if (status == 2) {
						out.print("不會來");
					} else if (status == 3) {
						out.print("會來");
					} else if (status == 4){
						out.print("現場客");
					} else if (status == 0){
						out.print("店家尚未確認");
					}					
					else {
						out.print("其他狀態"); 
					}
					%>
				</td>
				
            </tr>
        <% } %>
        </tbody>
        </table>
        		<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>	
        
</body>
</html>