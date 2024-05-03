<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@page import="com.team6.product.model.ProductBean" %>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Counter</title>
			<style type="text/css">
				.counter {
					font-size: 48px;
				}

				a,
				a:visited {
					text-decoration: none;
					color: blue;
				}

				img {
					width: 12vw;
					height: 12vw;
				}

				/* 新增表格樣式 */
				table {
					border-collapse: separate;
					/* 重置border-collapse為separate */
					border-spacing: 0;
					/* 設置border-spacing為0 */
					width: 100%;
					margin-bottom: 1rem;
				}

				th,
				td {
					padding: 0.75rem;
					border: 1px solid black;
					/* 為th和td添加黑色邊框 */
				}

				th {
					background-color: #f8f9fa;
					font-weight: bold;
				}

				tr:nth-child(even) {
					background-color: #f8f9fa;
				}

				.counter-input {
					width: 80px;
					height: 40px;
					font-size: 18px;
				}
			</style>
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
			<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		</head>

		<body>
			<jsp:useBean id="productBean" scope="request" class="com.team6.product.model.ProductBean" />
			<div class="container py-5">
				<div id="product">
					<table border="1">
						<tr style="background-color: #a8fefa">
							<th>產品編號</th>
							<th>產品類別</th>
							<th>產品名稱</th>
							<th>產品介紹</th>
							<th>產品圖片</th>
							<th>產品價格</th>
							<th>產品數量</th>
							<th>產品狀態</th>
							<th>上架時間</th>
						</tr>
						<tr>
							<td>
								<%=productBean.getProductId() %>
							</td>
							<td>
								<%=productBean.getProductCategory().getCategoryName() %>
							</td>
							<td>
								<%=productBean.getProductName() %>
							</td>
							<td>
								<%=productBean.getProductDesc() %>
							</td>
							<td><img alt="暫無圖片" src="<%=productBean.getProductImg_url()%>"></td>
							<td>
								<%=productBean.getProductPrice() %>
							</td>
							<td>
								<%=productBean.getProductQuantity() %>
							</td>
							<td>
								<%=productBean.getProductState().getProductStateName() %>
							</td>
							<td>
								<%=productBean.getProductCreateDate() %>
							</td>
						</tr>
					</table>

				</div>
				<div class="counter d-flex justify-content-center align-items-center">
					<button class="btn btn-outline-secondary btn-lg" id="decrement">-</button>
					<input type="text" class="mx-3 display-5 fw-bold text-center fs-3 counter-input" id="count"
						value="0" min="0" max="<%= productBean.getProductQuantity() %>">
					<button class="btn btn-outline-secondary btn-lg" id="increment">+</button>
					<button class="mx-3 display-5 rounded-pill" id="submit"
						onclick="forCoQuantity('<%=productBean.getProductId()%>')">送出</button>
				</div>


			</div>

			<script>
				const countElement = document.getElementById('count');
				const decrementButton = document.getElementById('decrement');
				const incrementButton = document.getElementById('increment');
				const maxQuantity = <%= productBean.getProductQuantity() %>;
				const productElem = document.getElementById('product');




				decrementButton.addEventListener('click', () => {
					if (countElement.value > 0) {
						countElement.value--;
					}
				});

				incrementButton.addEventListener('click', () => {
					if (countElement.value < maxQuantity) {
						countElement.value++;
					} else {
						alert(`不能超過產品數量 ${maxQuantity}`);
					}

				});

				function forCoQuantity(productId) {
					const quantity = countElement.value;
					$.ajax({
						url: "Product_coQuantity",
						method: 'PUT',
						data: { "quantity": quantity, "productId": productId },
						success: function (response) {
							console.log(response);
							// order的設計模式因為畫面會重導，不需要處理hibernate的無限迴圈
							window.location.reload();

						},
						error: function (data, type, err) {
							console.log('status: ' + type);
							console.log('statuscontent : ' + err);
							console.log(data);
							alert('爆開');
						}

					});
				};






			</script>
		</body>

		</html>