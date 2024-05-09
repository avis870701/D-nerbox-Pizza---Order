<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,com.team6.reservation.model.*" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

				th,
				td {
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
					box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
					/* 添加陰影效果 */
					transition-duration: 0.4s;
				}

				button:hover {
					background-color: #2980b9;
					box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
					/* 滑鼠懸停時的陰影效果 */
				}

				.pagination {
					display: inline-block;
					padding-left: 0;
					margin: 20px 0;
					border-radius: 4px;
				}

				.pagination>li {
					display: inline;
				}

				.pagination>li>a,
				.pagination>li>span {
					position: relative;
					float: left;
					padding: 6px 12px;
					margin-left: -1px;
					line-height: 1.42857143;
					color: #337ab7;
					text-decoration: none;
					background-color: #fff;
					border: 1px solid #ddd;
				}

				.pagination>li:first-child>a,
				.pagination>li:first-child>span {
					margin-left: 0;
					border-top-left-radius: 4px;
					border-bottom-left-radius: 4px;
				}

				.pagination>li:last-child>a,
				.pagination>li:last-child>span {
					border-top-right-radius: 4px;
					border-bottom-right-radius: 4px;
				}

				.pagination>.active>a,
				.pagination>.active>span,
				.pagination>.active>a:hover,
				.pagination>.active>span:hover,
				.pagination>.active>a:focus,
				.pagination>.active>span:focus {
					z-index: 2;
					color: #fff;
					background-color: #337ab7;
					border-color: #337ab7;
					cursor: default;
				}

				.pagination>.disabled>span,
				.pagination>.disabled>span:hover,
				.pagination>.disabled>span:focus,
				.pagination>.disabled>a,
				.pagination>.disabled>a:hover,
				.pagination>.disabled>a:focus {
					color: #777;
					cursor: not-allowed;
					background-color: #fff;
					border-color: #ddd;
				}
			</style>
		</head>

		<body>
			<h1>${year} 年 ${month} 月 歷史訂位紀錄</h1>
			<table>
				<thead>
					<tr>
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
					<c:forEach items="${historyReservation.content}" var="reservation">
						<tr>
							<td>${reservation.reservationDate}</td>
							<td>${reservation.reservationTime}</td>
							<td>${reservation.numberOfPeople}</td>
							<td>${reservation.reservationName}</td>
							<td>${reservation.phone}</td>
							<td>${reservation.note}</td>
							<td>${reservation.reservationStatus}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="pagination-container">
				<c:if test="${historyReservation.totalPages > 1}">
					<ul class="pagination">
						<li class="page-item">
							<c:if test="${!historyReservation.first}">
								<a class="page-link"
									href="/reservation/selectByMonthAndYear/${historyReservation.number}?monthSelect=${year}-${month}"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a>
							</c:if>
						</li>
						<c:forEach begin="1" end="${historyReservation.totalPages}" varStatus="loop">
							<li class="page-item ${loop.index == historyReservation.number + 1 ? 'active' : ''}">
								<a class="page-link"
									href="/reservation/selectByMonthAndYear/${loop.index}?monthSelect=${year}-${month}">${loop.index}</a>
							</li>
						</c:forEach>
						<li class="page-item">
							<c:if test="${!historyReservation.last}">
								<a class="page-link"
									href="/reservation/selectByMonthAndYear/${historyReservation.number + 2}?monthSelect=${year}-${month}"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a>
							</c:if>
						</li>
					</ul>
				</c:if>
			</div>

			<form action="/reservation/saveDetailToCSV" method="get">
				<button type="submit" id="saveToCSV">匯出成CSV</button>
				<input type="hidden" name="yearSelect" value="${year}"> <input type="hidden" name="monthSelect"
					value="${month}">
			</form>


			<a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a>

			<script>
			document.addEventListener('DOMContentLoaded', function () {
				document.getElementById('saveToCSV').addEventListener('click', function () {
					alert("匯出成功");
				});
			});
			
			
			</script>
		</body>

		</html>