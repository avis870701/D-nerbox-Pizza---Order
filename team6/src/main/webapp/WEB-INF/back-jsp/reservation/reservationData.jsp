<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,com.team6.reservation.model.*" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>訂位人數資料修改</title>
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

			input {
				height: 20px;
			}
		</style>
	</head>

	<body>
		<h2>訂位人數資料修改</h2>

		<!-- <a href="/reservation/reservemain.controller"><button><b>回首頁</b></button></a> -->

		<!--  Body Wrapper -->
		<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
			data-sidebar-position="fixed" data-header-position="fixed">
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
							<li class="sidebar-item"><a class="sidebar-link" href="/reservation/reservemain.controller"
									aria-expanded="false"> <span> <i class="ti ti-cards"></i>
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
								<th>預定狀態</th>
								<th>修改</th>
								<th>刪除</th>
							</tr>
						</thead>
						<tbody>
							<% List<Reserve> reservations = (ArrayList<Reserve>) request.getAttribute("reservations");
									int index = 1;
									for (Reserve reservation : reservations) {
									%>
									<tr>
										<td>
											<%=index++%>
										</td>
										<td>
											<%=reservation.getReservationDate()%>
										</td>
										<td>
											<%=reservation.getReservationTime()%>
										</td>
										<td>
											<%=reservation.getNumberOfPeople()%>
										</td>
										<td>
											<%=reservation.getReservationName()%>
										</td>
										<td>
											<%=reservation.getPhone()%>
										</td>
										<td>
											<%=reservation.getNote()%>
										</td>
										<td>
											<% int status=reservation.getReservationStatus(); if (status==1) {
												out.print("未確認"); } else if (status==2) { out.print("不會來"); } else if
												(status==3) { out.print("會來"); } else { out.print("其他狀態"); } %>
										</td>
										<td><input type="text" id="peopleInput<%=reservation.getReservationId()%>"
												style="width: 55px;" placeholder="人數修改">
											<button type="button"
												onclick="updatePeople('<%= reservation.getReservationId() %>')">人數修改</button>
											<input type="time" id="timeInput<%= reservation.getReservationId() %>">
											<button type="button"
												onclick="updateTime('<%= reservation.getReservationId() %>')">時間修改</button>
											<input type="date" id="dateInput<%= reservation.getReservationId() %>">
											<button type="button"
												onclick="updateDate('<%= reservation.getReservationId() %>')">日期修改</button>

											<input type="text" id="rsInput<%= reservation.getReservationId() %>"
												style="width: 30px;">
											<button type="button"
												onclick="updateRSto3('<%= reservation.getReservationId() %>')">預訂狀態修改</button>
										</td>
										<td><button type="button"
												onclick="deleteReservation('<%= reservation.getReservationId() %>')">刪除</button>
										</td>
									</tr>
									<% } %>
						</tbody>
					</table>

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
			function updatePeople(reservationId) {
				var peopleSelect = document.getElementById('peopleInput' + reservationId);
				var newNumberOfPeople = peopleSelect.value;
				if (newNumberOfPeople !== null && newNumberOfPeople !== '') {
					updateNumberOfPeople(reservationId, newNumberOfPeople);
				} else {
					alert("請輸入有效的人數");
				}
			}

			function updateTime(reservationId) {
				var timeSelect = document.getElementById('timeInput' + reservationId);
				var newTime = timeSelect.value;

				if (newTime !== null && newTime !== '') {
					updateReservationTime(reservationId, newTime);
				} else {
					alert("請選擇有效的時間");
				}
			}
			function updateDate(reservationId) {
				var dateSelect = document.getElementById('dateInput' + reservationId);
				var newDate = dateSelect.value;

				if (newDate !== null && newDate !== '') {
					updateReservationDate(reservationId, newDate);
				} else {
					alert("請輸入有效的日期");
				}
			}
			function updateRSto3(reservationId) {
				var rsSelect = document.getElementById('rsInput' + reservationId);
				var rs = rsSelect.value;
				updateReservationStatusTo3(reservationId, rs)
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

			function updateReservationStatusTo3(reservationId, reservationStatus) {
				if (confirm("確定要修改客人預訂狀態嗎？")) {
					var xhr = new XMLHttpRequest();
					xhr.open('GET', '/reservation/autoUpdateReservationStatus?reservationStatus=' + encodeURIComponent(reservationStatus) + '&reservationId=' + encodeURIComponent(reservationId), true);
					xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
					xhr.send();
					location.reload();
				}
			}

		</script>
	</body>

	</html>