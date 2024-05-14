<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,com.team6.reservation.model.*" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>報到資訊(CheckIn)</title>
			<link rel="shortcut icon" type="image/png" href="/images/member/pizzaQ.png" />
			<link rel="stylesheet" href="/back/css/member/EmpIndexGoToInsertMember.css" />
			<link rel="stylesheet" href="/back/css/styles.min.css" />
			<script src="/back/js/member/EmpIndexGoToInsertMember.js"></script>
			<style>
				table {
					width: 100%;
					border-collapse: collapse;
				}

				thead th,
				tbody td {
					border: 1px solid #ddd;
					padding: 8px;
					text-align: left;
				}

				thead th {
					background-color: #f2f2f2;
				}

				tbody tr:nth-child(even) {
					background-color: #f2f2f2;
				}

				tbody tr:hover {
					background-color: #ddd;
				}

				button {
					padding: 6px 11px;
					border: none;
					background-color: #007bff;
					color: #fff;
					cursor: pointer;
					width: auto;
					border-radius: 5px;
				}

				button:hover {
					background-color: #0056b3;
				}
			</style>
		</head>

		<body>
			<h2>報到資訊(CheckIn)</h2>

			<!-- <a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a> -->

			<!--  Body Wrapper -->
			<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6"
				data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
				<!-- Sidebar Start -->
				<aside class="left-sidebar">
					<!-- Sidebar scroll-->
					<div>
						<div class="brand-logo d-flex align-items-center justify-content-between">
							<a href="#" class="text-nowrap logo-img"> <img src="/images/member/DonerPizzaSmall.png"
									width="180" alt="" />
							</a>
							<div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
								<i class="ti ti-x fs-8"></i>
							</div>
						</div>
						<!-- Sidebar navigation-->
						<nav class="sidebar-nav scroll-sidebar" data-simplebar="">
							<ul id="sidebarnav">
								<li class="nav-small-cap"><i class="ti ti-dots nav-small-cap-icon fs-4"></i> <span
										class="hide-menu">後台功能列表</span></li>
								<li class="sidebar-item"><a class="sidebar-link" href="/member/Member.SelectAll"
										aria-expanded="false"> <span>
											<i class="ti ti-layout-dashboard"></i>
										</span> <span class="hide-menu">會員管理功能</span>
									</a></li>
								<li class="nav-small-cap"><i class="ti ti-dots nav-small-cap-icon fs-4"></i> <span
										class="hide-menu">其他功能列表</span></li>
								<li class="sidebar-item"><a class="sidebar-link" href="#" aria-expanded="false"> <span>
											<i class="ti ti-article"></i>
										</span> <span class="hide-menu">產品管理功能</span>
									</a></li>
								<li class="sidebar-item"><a class="sidebar-link" href="#" aria-expanded="false"> <span>
											<i class="ti ti-alert-circle"></i>
										</span> <span class="hide-menu">訂單管理功能</span>
									</a></li>
								<li class="sidebar-item"><a class="sidebar-link"
										href="/reservation/reservemain.controller" aria-expanded="false"> <span> <i
												class="ti ti-cards"></i>
										</span> <span class="hide-menu">訂位管理功能</span>
									</a></li>
								<li class="sidebar-item"><a class="sidebar-link" href="./ui-forms.html"
										aria-expanded="false"> <span> <i class="ti ti-file-description"></i>
										</span> <span class="hide-menu">外送管理功能</span>
									</a></li>
								<li class="sidebar-item"><a class="sidebar-link" href="./ui-typography.html"
										aria-expanded="false"> <span>
											<i class="ti ti-typography"></i>
										</span> <span class="hide-menu">活動管理功能</span>
									</a></li>
								<li class="sidebar-item"><a class="sidebar-link" href="/emp/EmpGoBackToEmpIndex"
										aria-expanded="false"> <span>
											<i class="ti ti-typography"></i>
										</span> <span class="hide-menu">返回主頁</span>
									</a></li>
							</ul>
						</nav>
						<!-- End Sidebar navigation -->
					</div>
					<!-- End Sidebar scroll-->
				</aside>
				<!--  Sidebar End -->
				<!--  Main wrapper -->
				<div class="body-wrapper">
					<!--  Header Start -->
					<header class="app-header">
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
										<li
											class="page-item ${loop.index == historyReservation.number + 1 ? 'active' : ''}">
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
						<br>
						<form action="/reservation/saveDetailToCSV" method="get" style="text-align: center;">
							<button type="submit" id="saveToCSV">匯出成CSV</button>
							<input type="hidden" name="yearSelect" value="${year}"> <input type="hidden"
								name="monthSelect" value="${month}">
						</form>
					</header>
					<!--  Header End -->
				</div>

				<div class="row">
					<div class="col-lg-12 d-flex align-items-stretch">
						<div class="card w-100">
							<div class="card-body p-4">
								<h5 class="card-title fw-semibold mb-4">所有會員</h5>
								<div class="table-responsive">


								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="py-6 px-6 text-center">
				<p class="mb-0 fs-4">
					Design and Developed by <a href="https://adminmart.com/" target="_blank"
						class="pe-1 text-primary text-decoration-underline">AdminMart.com</a>
					Distributed by <a href="https://themewagon.com">ThemeWagon</a>
				</p>
			</div>
			</div>
			</div>
			</div>
			</div>
			<script src="/back/libs/jquery/dist/jquery.min.js"></script>
			<script src="/back/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
			<script src="/back/js/sidebarmenu.js"></script>
			<script src="/back/js/app.min.js"></script>
			<script src="/back/libs/apexcharts/dist/apexcharts.min.js"></script>
			<script src="/back/libs/simplebar/dist/simplebar.js"></script>
			<script src="/back/js/dashboard.js"></script>
			<script src="/back/js/member/EmpMemberGetAll.js"></script>
			<script>
				document.addEventListener('DOMContentLoaded', function () {
					document.getElementById('saveToCSV').addEventListener('click', function () {
						alert("匯出成功");
					});
				});
			</script>
		</body>

		</html>