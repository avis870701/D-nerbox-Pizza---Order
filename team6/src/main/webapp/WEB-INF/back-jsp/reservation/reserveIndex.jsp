<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.util.List,com.team6.reservation.model.*"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>訂位系統管理後台</title>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

#header {
	text-align: center;
	border: 1px solid black;
	padding: 10px;
}

#container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top: 10px0;
}

#left-column, #right-column {
	border: 1px solid black;
	padding: 10px;
}

#right-column {
	margin-left: 200px;
}

input[type="text"], input[type="date"], table {
	width: 100%;
	margin-top: 10px;
}

th, td {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
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
	font-size: 14px;
	margin: 4px 2px;
	cursor: pointer;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 添加陰影效果 */
	transition-duration: 0.4s;
}

button:hover {
	background-color: #2980b9;
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2); /* 滑鼠懸停時的陰影效果 */
}

table {
	font-size: xx-small;
	width: 100%;
	/* 9 5 */
}
</style>
</head>

<body>
	<div id="userName" style="font-size: smaller;">
		<p>會員______您好</p>
	</div>
	<a id="reserveNow" href="/reservation/customerreservemain.controller">立即訂位</a>
	<div id="header">
		<h1>訂位系統管理後台</h1>
	</div>
	<div id="container">
		<div id="left-column">
			<div id="CheckIn">
				<h3>報到</h3>
				<form method="get" action="/reservation/checkInByName">
					<div>
						姓名：<input type="text" placeholder="若未輸入則顯示當日所有未報到客人資訊"
							name="nameSelect">
					</div>
					<button value="selectByName" name="checkin">姓名查詢</button>
					</form>
				<br/>
				<h3>查詢(不分日期)</h3>
				<form method="get" action="/reservation/checkInByPhone">	
					<div>
						電話：<input type="text" placeholder="將顯示該客人的所有未報到資訊" name="phoneSelect">
					</div>
					<button value="selectByPhone" name="checkin">電話查詢</button>
				</form>
				
				<form method="get" action="/reservation/selectAllChecked">
					<div>
						<button value="selectAllChecked" name="checkin">目前用餐客人資訊</button>
						<p>目前共 <span id="result" style="font-weight: bold; color: red;"></span> 位客人正在用餐</p>		
					</div>
				</form>	
			
				<form method="post" action="/reservation/dineInCustomer" onsubmit="return submitForm()">   
				    <h2 style="margin-bottom: 20px;">新增現場用餐客人</h2>  
				    <div style="margin-bottom: 10px;">
				        <label for="date" style="margin-right: 10px;">用餐日期：</label>
				        <input type="date" id="date" name="date" style="background-color: #b8f083" required>
				    </div>   
				    <div style="margin-bottom: 10px;">
				        <label for="time" style="margin-right: 10px;">用餐時間：</label>
				        <input id="time" type="text" name="time" style=width:60px;background-color:#b8f083 required >
				    </div>      
				    <div style="margin-bottom: 10px;">
				        <label for="people" style="margin-right: 10px;">用餐人數：</label>
				        <input type="number" id="people" name="people" min="1" style=width:60px required>
				    </div>
				    <div style="margin-bottom: 20px;">
				        <label for="note" style="margin-bottom: 10px;">備註：</label>
				        <textarea id="note" name="note" rows="1"></textarea>
				    </div>  
				    <button type="submit" name="checkin" value="customerReserve" style="background-color: #4CAF50; color: white; border: none; border-radius: 4px; padding: 10px 20px; cursor: pointer;">送出</button>
				</form>
 

			</div>
			
		</div>

		<div style="margin-top:500px">					
			<a href="/member/MemberGoBackToIndex"><button>回主頁</button></a> 
		</div>
		<div id="right-column">
			<h3>依日期查詢預訂訊息</h3>
			<form method="get" action="/reservation/selectByDate">
				<div id="reservationStatus">
					<input id="dateSelect" type="date" name="dateSelect"
						style="background-color: #b8f083;">
					<div>
						<button value="selectByDate" name="checkin">查詢</button>
			</form>
			
			<h3>依月份查詢預訂訊息</h3>
			<form method="get" action="/reservation/selectByMonthAndYear">
				<div id="reservationStatus">
					<input id="monthSelect" type="month" name="monthSelect" required="required"
						style="background-color: #b8f083;">
					<div>
						<button value="selectByMonth" name="checkin">查詢</button>
			</form>
						
		</div>

	</div>
		<div id="ReservationComfirm">
		    <div style="margin-bottom: 20px;">
		        <h3 style="margin-bottom: 10px;">待確認預訂訊息</h3>
		        <p>共 <span style="font-weight: bold; color: red;">
		            <%= request.getAttribute("selectReservationStatusCounts") %>
		        </span> 筆</p>
		    </div>
		    <form action="/reservation/selectByStatus" method="get">
		        <button class="btn btn-primary" type="submit">查詢</button>
		    </form>
		</div>
	</div>




	<script>
	    // 獲取當前日期和時間
	    var now = new Date();
	    var currentDate = now.toISOString().split('T')[0];
	    var currentTime = now.toTimeString().split(' ')[0].substring(0, 5); // 只保留時和分

	    document.getElementById('date').value = currentDate;
	    document.getElementById('time').value = currentTime;
	    document.getElementById('dateSelect').value = currentDate;
	    
	        
	    function submitForm() {
	        var numberOfPeople = parseInt(document.getElementById("people").value);

	        if (numberOfPeople + <%= request.getAttribute("selectAllChecked") %> > 20) {
	            alert("用餐人數超過限制，最多只能容納20人。");
	            return false;
	        }
	        alert("新增成功")
	        return true;
	    }
	    
	    jQuery('#time').datetimepicker({
	    	  datepicker:false,
	    	  format:'H:i'
	    	});
	    
	    function updateCheckedInfo() {
	        var xhr = new XMLHttpRequest();
	        xhr.open('GET', '/reservation/selectAllCheckedCounts', true); 
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                document.getElementById('result').innerHTML = xhr.responseText;
	            }
	        };
	        xhr.send();
	    }
	    window.onload = updateCheckedInfo;

	</script>
</body>
</html>