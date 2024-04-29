<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Details data</title>
<link rel="stylesheet" href="/css/detailsInsert.css">

</head>
<body style="background-color: #f8f8f8">

	<h1>Dönerbox Pizza</h1>


	<div align="center">
		<h2>員工點餐頁面</h2>
			<p>
				<input id="orderId" type="hidden" name="orderId" value="" readonly> <br>
		<div class="form-container">
			<p>
				產品編號:<input id="productId" type="text" value="" readonly><br>
			<p>
				產品名稱: <select id="productNameSelect"
					onchange="updateProductDetails()">
					<option value="1"></option>
					<option value="2">香菇意大利比薩</option>
					<option value="3">夏威夷德國比薩</option>
					<option value="4">起司義大利比薩</option>
					<option value="5">義大利雞肉焗烤麵</option>
					<option value="6">蘋果肉桂德國烤餅</option>
					<option value="7">炸雞塊(6塊)</option>
					<option value="8">炸起司條(5條)</option>
				</select>
			<p>
				單價: <input id="unitPrice" type="text" value="" readonly><br>
			<p>
				數量: <input id="quantity" type="text" value="" /><br>
			<p>
				餐點備註:
				<textarea id="note" name="note" rows="2" col="50"
					placeholder="輸入訂單備註"></textarea>
				<br> <br>
				<br>
				<button onclick="addOrder()">新增餐點</button>
		</div>
		<br>
		
		<div class="detail-container">
			<form method="post" action="insertController">

			<div>
				<h3>訂單資訊</h3>
				<p>
					客人選項:<select name="customerName">
						<option value="內用客人">內用客人</option>
						<option value="外帶客人">外帶客人</option>
					</select><br>
				<p>
					付款方式: <select name="payment">
						<option value="現金">現金</option>
						<option value="信用卡">信用卡</option>
					</select><br>
				<p>
					取餐方式: <select name="pickup">
						<option value="內用">內用</option>
						<option value="外帶">外帶</option>
					</select><br>
					<input type="hidden" name="orderStatus" value="已下單">
					<input type="hidden" name="amount" value="${orderBean.amount}">
			</div>
				<h3>餐點明細</h3>
				<table border="1">
					<thead>
						<tr>
							<th>產品編號</th>
							<th>產品名稱</th>
							<th>數量</th>
							<th>單價</th>
							<th>餐點備註</th>
						</tr>
					</thead>
			</form>
		</div>
					<tbody id="orderDetailsTable">
						<!-- 这里是用JavaScript添加的行 -->
					</tbody>
				</table>
				<button type="submit">點餐結束</button>
			</form>

			<form method="post" action="order.action">
				<button>回訂單首頁</button>
		
		
		<script>

			function updateProductDetails() {
				var productNameSelect = document
						.getElementById("productNameSelect");
				var productIdInput = document.getElementById("productId");
				var unitPriceInput = document.getElementById("unitPrice");

				// 获取选中的产品名和对应的产品信息
				var productName = productNameSelect.options[productNameSelect.selectedIndex].text;
				var productId;
				var unitPrice;
				switch (productName) {
				case "香菇意大利比薩":
					productId = 1;
					unitPrice = 150;
					break;
				case "夏威夷德國比薩":
					productId = 2;
					unitPrice = 130;
					break;
				case "起司義大利比薩":
					productId = 3;
					unitPrice = 180;
					break;
				case "義大利雞肉焗烤麵":
					productId = 4;
					unitPrice = 220;
					break;
				case "蘋果肉桂德國烤餅":
					productId = 5;
					unitPrice = 130;
					break;
				case "炸雞塊(6塊)":
					productId = 6;
					unitPrice = 60;
					break;
				case "炸起司條(5條)":
					productId = 7;
					unitPrice = 60;
					break;
				}

				// 更新產品編號和單價輸入框的值
				productIdInput.value = productId;
				unitPriceInput.value = unitPrice;

			}

			function addOrder() {
		        var productId = document.getElementById("productId").value;
		        var productName = document.getElementById("productNameSelect").options[document
		                .getElementById("productNameSelect").selectedIndex].text;
		        var quantity = document.getElementById("quantity").value;
		        var unitPrice = document.getElementById("unitPrice").value;
		        var note = document.getElementById("note").value;

		        // 創建新的訂單明細行
		        var newRow = document.createElement("tr");
		        newRow.innerHTML ="<td><input type='text' name='productId' value='" + productId + "' readonly></td>"
		                + "<td><input type='text' name='product' value='" + productName + "' readonly></td>"
		                + "<td><input type='text' name='quantity' value='" + quantity + "' readonly></td>"
		                + "<td><input type='text' name='unitPrice' value='" + unitPrice + "' readonly></td>"
		                + "<td><input type='text' name='note' value='" + note + "' readonly></td>";

		        // 添加新行到表格中
		        document.getElementById("orderDetailsTable")
		                .appendChild(newRow);

		        // 計算並更新總金額
		        calculateTotalAmount();
		    }
			function calculateTotalAmount() {
			    var totalAmount = 0;
			    var rows = document.getElementById("orderDetailsTable").getElementsByTagName("tr");
			    for (var i = 0; i < rows.length; i++) {
			        var quantity = parseInt(rows[i].getElementsByTagName("td")[2].getElementsByTagName("input")[0].value);
			        var unitPrice = parseFloat(rows[i].getElementsByTagName("td")[3].getElementsByTagName("input")[0].value);
			        totalAmount += quantity * unitPrice;
			    }
			    totalAmount = Math.floor(totalAmount); // 將總金額向下取整
			    document.getElementsByName("amount")[0].value = totalAmount;
			}
			
		</script>
</body>
</html>