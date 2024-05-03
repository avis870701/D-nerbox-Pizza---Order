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
			<th colspan="7">訂單明細
		</tr>
		<tr style="background-color:#007bff">
			<th>訂單編號
			<th>產品編號
			<th>產品名稱
			<th>單價
			<th>數量
			<th>餐點備註
			<th>刪除
		</tr>
				
	<%
					List<OrderDetails> details = (ArrayList<OrderDetails>)request.getAttribute("details");
						for(OrderDetails detail : details) {
					%>
	
		<input type="hidden" value="<%=detail.getDetailsId() %>">
		<tr>
		
			<td><%=detail.getOrderId() %></td>
			
			
<form id="productForm" method="post" action="updateDetails">
<input type="hidden" name="method" value="PUT">
			<td>
				<input type="hidden" value="<%=detail.getDetailsId()%>">
				<input type="text" name="productId" value="<%= detail.getProductId() %>" readonly>
			</td>
			<td>
	 <input type="hidden" name="detailsId" value="<%= detail.getDetailsId() %>">
     <input type="hidden" name="orderId" value="<%= detail.getOrderId() %>">    
         <select name="product" onchange="this.form.submit()">
	     <option value="香菇意大利比薩" <%= detail.getProduct().equals("香菇意大利比薩") ? "selected" : "" %>>香菇意大利比薩</option>
	     <option value="夏威夷德國比薩" <%= detail.getProduct().equals("夏威夷德國比薩") ? "selected" : "" %>>夏威夷德國比薩</option>
	     <option value="起司義大利比薩" <%= detail.getProduct().equals("起司義大利比薩") ? "selected" : "" %>>起司義大利比薩</option>
	     <option value="義大利雞肉焗烤麵" <%= detail.getProduct().equals("義大利雞肉焗烤麵") ? "selected" : "" %>>義大利雞肉焗烤麵</option>
	     <option value="蘋果肉桂德國烤餅" <%= detail.getProduct().equals("蘋果肉桂德國烤餅") ? "selected" : "" %>>蘋果肉桂德國烤餅</option>
	     <option value="炸雞塊(6塊)" <%= detail.getProduct().equals("炸雞塊(6塊)") ? "selected" : "" %>>炸雞塊(6塊)</option>
	     <option value="炸起司條(5條)" <%= detail.getProduct().equals("炸起司條(5條)") ? "selected" : "" %>>炸起司條(5條)</option>
	</select>
			<td>
			<input type="text" name="unitPrice" value="<%= detail.getUnitPrice() %>" readonly>
			</td>
</form>


<td>			
	<form id="quantityForm" method="post" action="updateDetails">
	<input type="hidden" name="method" value="PUT">
  		<input type="hidden" name="detailsId" value="<%= detail.getDetailsId() %>">
   	 	<input type="hidden" name="orderId" value="<%= detail.getOrderId() %>">
   	 	<input type="number" name="quantity" value="<%=detail.getQuantity() %>" min="0">
	</form>
</td>

			
<td>
    <form id="noteForm" method="post" action="updateDetails" >
    <input type="hidden" name="method" value="PUT">
        <input type="hidden" name="detailsId" value="<%= detail.getDetailsId() %>">
        <input type="hidden" name="orderId" value="<%= detail.getOrderId() %>">
        <input type="text" name="note" value="<%= detail.getNote() %>" placeholder="未填寫備註">
    </form>
</td>
<td>
    <form action="detailsDelete" id="deleteForm_<%=detail.getDetailsId() %>">
    <input type="hidden" name="method" value="DELETE">
        <input type="hidden" name="detailsId" value="<%=detail.getDetailsId() %>">
                <input type="hidden" name="orderId" value="<%= detail.getOrderId() %>">
        <button type="button" onclick="confirmDelete('<%=detail.getDetailsId() %>')">刪除</button>
    </form>
</td>
		</tr>
	<% } %>	
	</table>
	<h3> 共<%=details.size() %>筆餐點明細</h3>
	<form method="post" action="order.action">
	<button class="t2">回訂單首頁</button>
	</form>
</div>


<script>
function confirmDelete(formId) {
    var confirmation = confirm("確定要刪除嗎？");
    if (confirmation) {
        document.getElementById("deleteForm_" + formId).submit();
    } else {
        return false;
    }
}

</script>

</body>
</html>
