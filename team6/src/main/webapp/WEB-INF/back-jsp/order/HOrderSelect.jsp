<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Order data</title>
<link rel="stylesheet" href="/css/orderSelect.css">
</head>
<body>

    <h1>Dönerbox Pizza</h1>

<div style="background-color:whitesmoke" align="center">
    <h2>查詢管理</h2>
    
	<h3>查詢餐點明細</h3>
    <button id="orderIdButton">使用訂單編號查詢</button>
    <form id="orderIdForm" method="get" action="detailsSelectAll" style="display: none;">
        輸入訂單編號 : <input type="text" name="orderId"/><p>
        <button type="submit">確定</button>
    </form>
    <br><br>
    <br><br>
    <div class="button-container">
        <form method="post" action="order.action">
            <button>回上一頁</button>
        </form>
    </div>
</div>

<script>
var orderIdButton = document.getElementById("orderIdButton");

var orderIdForm = document.getElementById("orderIdForm");

orderIdButton.addEventListener("click", function() {

	orderIdForm.style.display = "block";
});

</script>

</body>
</html>