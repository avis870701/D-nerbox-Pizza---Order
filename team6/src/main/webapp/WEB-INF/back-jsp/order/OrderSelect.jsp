<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.team6.order.model.Order,com.team6.order.model.OrderDetails"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單資料</title>
<link rel="stylesheet" href="/css/header.css">
</head>
<body style="background-color:whitesmoke">

    <h1>Dönerbox Pizza</h1>
    
	<div align="center">
		<table border="1">
		<tr style="background-color:#007bff">
			<th colspan="9">訂單明細
		</tr>
		<tr style="background-color:#007bff">
			<th>訂單編號
			<th>訂購人姓名
			<th>總金額
			<th>付款方式
			<th>取餐方式
			<th>訂單狀態
			<th>餐點明細
			<th>刪除
		</tr>
				
	 <%
					 Order order = (Order)request.getAttribute("orderBean");
					 %>
	
		<tr>
			<td><%=order.getOrderId() %></td>
			<td><%=order.getCustomerName() %></td>
			<td><%=order.getAmount()%></td>
			
<td>
    <form id="paymentForm" method="post" action="updateOrder">
    <input type="hidden" name="method" value="PUT">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <select name="payment" onchange="this.form.submit()">
            <option value="現金" <%= order.getPayment().equals("現金") ? "selected" : "" %>>現金</option>
            <option value="信用卡" <%= order.getPayment().equals("信用卡") ? "selected" : "" %>>信用卡</option>
        </select>
    </form>
</td>
			

<form id="pickupForm" method="post" action="updateOrder">
<input type="hidden" name="method" value="PUT">
<td>
    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
    <select name="pickup" onchange="this.form.submit()">
        <option value="內用" <%= order.getPickup().equals("內用") ? "selected" : "" %>>內用</option>
                <option value="外帶" <%= order.getPickup().equals("外帶") ? "selected" : "" %>>外帶</option>
                <option value="外送" <%= order.getPickup().equals("外送") ? "selected" : "" %>>外送</option>
    </select>
    </td>
</form>


<td>
    <form id="orderStatusForm" method="post" action="updateOrder">
    <input type="hidden" name="method" value="PUT">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <select name="orderStatus" onchange="this.form.submit()">
            <option value="已下單" <%= order.getOrderStatus().equals("已下單") ? "selected" : "" %>>已下單</option>
            <option value="餐點製作中" <%= order.getOrderStatus().equals("餐點製作中") ? "selected" : "" %>>餐點製作中</option>
            <option value="製作完成" <%= order.getOrderStatus().equals("製作完成") ? "selected" : "" %>>製作完成</option>
            <option value="外送中" <%= order.getOrderStatus().equals("外送中") ? "selected" : "" %>>外送中</option>
            <option value="已完成" <%= order.getOrderStatus().equals("已完成") ? "selected" : "" %>>已完成</option>
        </select>
    </form>
</td>

			<td>
		<form method="get" action="detailsSelectAll">
			<input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
        	<button type="submit">餐點明細</button>
			</td>
		</form>
		
		   
			<td>
        <form action="orderDelete">
        <input type="hidden" name="method" value="DELETE">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
           <button type="submit" onclick="confirmDelete('<%=order.getOrderId() %>')">刪除</button>
        </form>
        	</td>
		</tr>

	</table>
	<form method="post" action="order.action">
	<button class="t2">回訂單首頁</button>
	</form>
</div>

<script>
function confirmDelete(orderId) {
    var confirmation = confirm("確定要刪除訂單編號為 " + orderId + " 的訂單嗎？");
    if (confirmation) {
        document.getElementById("deleteForm_" + orderId).submit();
    }
}

</script>

</body>
</html>
