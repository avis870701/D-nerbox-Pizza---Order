<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<title>後台系統</title>
			<link rel="shortcut icon" type="image/png" href="/images/member/pizzaQ.png" />
			<link rel="stylesheet" href="/back/css/member/EmpIndexGoToInsertMember.css" />
			<link rel="stylesheet" href="/back/css/styles.min.css" />
			<script src="/back/js/member/EmpIndexGoToInsertMember.js"></script>
		</head>

		<body>
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
								<li class="sidebar-item"><a class="sidebar-link" href="./ui-card.html"
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
						<nav class="navbar navbar-expand-lg navbar-light">
							<ul class="navbar-nav">
								<li class="nav-item d-block d-xl-none"><a class="nav-link sidebartoggler nav-icon-hover"
										id="headerCollapse" href="javascript:void(0)"> <i class="ti ti-menu-2"></i>
									</a></li>
								<li class="nav-item"><a class="nav-link nav-icon-hover" href="javascript:void(0)"> <i
											class="ti ti-bell-ringing"></i>
										<div class="notification bg-primary rounded-circle"></div>
									</a></li>
							</ul>
							<div class="navbar-collapse justify-content-end px-0" id="navbarNav">
								<ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
									<li class="nav-item dropdown"><button
											onclick="document.getElementById('memberInsert').style.display='block'"
											style="width: auto;" class="btn btn-primary">新憎會員</button></li>

									<li class="nav-item dropdown"><a class="nav-link nav-icon-hover"
											href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
											aria-expanded="false">
											<img src="/member/user.png" alt="" width="35" height="35"
												class="rounded-circle">${emp.detailBean.empName}
										</a>
										<div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up"
											aria-labelledby="drop2">
											<div class="message-body">
												<a href="javascript:void(0)"
													class="d-flex align-items-center gap-2 dropdown-item"> <i
														class="ti ti-user fs-6"></i>
													<p class="mb-0 fs-3">My Profile</p>
												</a> <a href="javascript:void(0)"
													class="d-flex align-items-center gap-2 dropdown-item"> <i
														class="ti ti-mail fs-6"></i>
													<p class="mb-0 fs-3">My Account</p>
												</a>
												</a> <a href="javascript:void(0)"
													class="d-flex align-items-center gap-2 dropdown-item"> <i
														class="ti ti-list-check fs-6"></i>
													<p class="mb-0 fs-3">My Task</p>
												</a> <a href="/emp/logout"
													class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</nav>
					</header>
					<!--  Header End -->
					<div class="container-fluid ">
						<!--  Row 1 -->
						<div class="row">
							<div class="col-lg-8 d-flex align-items-strech">
								<div class="card w-100">
									<div class="card-body">
										<div class="d-sm-flex d-block align-items-center justify-content-between mb-9">
											<div class="mb-3 mb-sm-0">
												<h5 class="card-title fw-semibold">Sales Overview</h5>
											</div>
											<div>
												<select class="form-select">
													<option value="1">March 2023</option>
													<option value="2">April 2023</option>
													<option value="3">May 2023</option>
													<option value="4">June 2023</option>
												</select>
											</div>
										</div>
										<div id="chart"></div>
									</div>
								</div>
							</div>
							<div class="col-lg-4">
								<div class="row">
									<div class="col-lg-12">
										<!-- Yearly Breakup -->
										<div class="card overflow-hidden">
											<div class="card-body p-4">
												<h5 class="card-title mb-9 fw-semibold">Yearly Breakup</h5>
												<div class="row align-items-center">
													<div class="col-8">
														<h4 class="fw-semibold mb-3">$36,358</h4>
														<div class="d-flex align-items-center mb-3">
															<span
																class="me-1 rounded-circle bg-light-success round-20 d-flex align-items-center justify-content-center">
																<i class="ti ti-arrow-up-left text-success"></i>
															</span>
															<p class="text-dark me-1 fs-3 mb-0">+9%</p>
															<p class="fs-3 mb-0">last year</p>
														</div>
														<div class="d-flex align-items-center">
															<div class="me-4">
																<span
																	class="round-8 bg-primary rounded-circle me-2 d-inline-block"></span>
																<span class="fs-2">2023</span>
															</div>
															<div>
																<span
																	class="round-8 bg-light-primary rounded-circle me-2 d-inline-block"></span>
																<span class="fs-2">2023</span>
															</div>
														</div>
													</div>
													<div class="col-4">
														<div class="d-flex justify-content-center">
															<div id="breakup"></div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-12">
										<!-- Monthly Earnings -->
										<div class="card">
											<div class="card-body">
												<div class="row alig n-items-start">
													<div class="col-8">
														<h5 class="card-title mb-9 fw-semibold">Monthly
															Earnings</h5>
														<h4 class="fw-semibold mb-3">$6,820</h4>
														<div class="d-flex align-items-center pb-1">
															<span
																class="me-2 rounded-circle bg-light-danger round-20 d-flex align-items-center justify-content-center">
																<i class="ti ti-arrow-down-right text-danger"></i>
															</span>
															<p class="text-dark me-1 fs-3 mb-0">+9%</p>
															<p class="fs-3 mb-0">last year</p>
														</div>
													</div>
													<div class="col-4">
														<div class="d-flex justify-content-end">
															<div
																class="text-white bg-secondary rounded-circle p-6 d-flex align-items-center justify-content-center">
																<i class="ti ti-currency-dollar fs-6"></i>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div id="earning"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12 d-flex align-items-stretch">
								<div class="card w-100">
									<div class="card-body p-4">
										<h5 class="card-title fw-semibold mb-4">所有會員</h5>
										<div class="table-responsive">
											<!-- table -->
											<table class="table text-nowrap mb-0 align-middle" id="showmember">

											</table>

											<table id="showpage" class="table text-nowrap mb-0 align-middle">
												<tr>
													<td class="border-bottom-0">總共 ${totalPages} 頁 有
														${totalElements} 筆資料</td>
													<td class="border-bottom-0">
														<nav>
															<ul class="pagination text-nowrap mb-0 align-middle"
																id="showpage">
																<li class="page-item"><span
																		class="page-link disabled">上一頁</span></li>
																<c:forEach var="i" begin="1" end="${totalPages}"
																	step="1">
																	<li class="page-item"><button
																			class="btn btn-primary page-link active"
																			id="myPage" type="button"
																			onclick="page(${i})">${i}</button></li>
																</c:forEach>
																<li class="page-item"><a class="page-link"
																		href="#">下一頁</a></li>
															</ul>
														</nav>

													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6 col-xl-3">
								<div class="card overflow-hidden rounded-2">
									<div class="position-relative">
										<a href="javascript:void(0)"><img src="/product/向日葵.jpg"
												class="card-img-top rounded-0" alt="..."></a> <a
											href="javascript:void(0)"
											class="bg-primary rounded-circle p-2 text-white d-inline-flex position-absolute bottom-0 end-0 mb-n3 me-3"
											data-bs-toggle="tooltip" data-bs-placement="top"
											data-bs-title="Add To Cart"><i class="ti ti-basket fs-4"></i></a>
									</div>
									<div class="card-body pt-3 p-4">
										<h6 class="fw-semibold fs-4">Boat Headphone</h6>
										<div class="d-flex align-items-center justify-content-between">
											<h6 class="fw-semibold fs-4 mb-0">
												$50 <span class="ms-2 fw-normal text-muted fs-3"><del>$65</del></span>
											</h6>
											<ul class="list-unstyled d-flex align-items-center mb-0">
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card overflow-hidden rounded-2">
									<div class="position-relative">
										<a href="javascript:void(0)"><img src="/product/向日葵.jpg"
												class="card-img-top rounded-0" alt="..."></a> <a
											href="javascript:void(0)"
											class="bg-primary rounded-circle p-2 text-white d-inline-flex position-absolute bottom-0 end-0 mb-n3 me-3"
											data-bs-toggle="tooltip" data-bs-placement="top"
											data-bs-title="Add To Cart"><i class="ti ti-basket fs-4"></i></a>
									</div>
									<div class="card-body pt-3 p-4">
										<h6 class="fw-semibold fs-4">MacBook Air Pro</h6>
										<div class="d-flex align-items-center justify-content-between">
											<h6 class="fw-semibold fs-4 mb-0">
												$650 <span class="ms-2 fw-normal text-muted fs-3"><del>$900</del></span>
											</h6>
											<ul class="list-unstyled d-flex align-items-center mb-0">
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card overflow-hidden rounded-2">
									<div class="position-relative">
										<a href="javascript:void(0)"><img src="/product/向日葵.jpg"
												class="card-img-top rounded-0" alt="..."></a> <a
											href="javascript:void(0)"
											class="bg-primary rounded-circle p-2 text-white d-inline-flex position-absolute bottom-0 end-0 mb-n3 me-3"
											data-bs-toggle="tooltip" data-bs-placement="top"
											data-bs-title="Add To Cart"><i class="ti ti-basket fs-4"></i></a>
									</div>
									<div class="card-body pt-3 p-4">
										<h6 class="fw-semibold fs-4">Red Valvet Dress</h6>
										<div class="d-flex align-items-center justify-content-between">
											<h6 class="fw-semibold fs-4 mb-0">
												$150 <span class="ms-2 fw-normal text-muted fs-3"><del>$200</del></span>
											</h6>
											<ul class="list-unstyled d-flex align-items-center mb-0">
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-3">
								<div class="card overflow-hidden rounded-2">
									<div class="position-relative">
										<a href="javascript:void(0)"><img src="/product/向日葵.jpg"
												class="card-img-top rounded-0" alt="..."></a> <a
											href="javascript:void(0)"
											class="bg-primary rounded-circle p-2 text-white d-inline-flex position-absolute bottom-0 end-0 mb-n3 me-3"
											data-bs-toggle="tooltip" data-bs-placement="top"
											data-bs-title="Add To Cart"><i class="ti ti-basket fs-4"></i></a>
									</div>
									<div class="card-body pt-3 p-4">
										<h6 class="fw-semibold fs-4">Cute Soft Teddybear</h6>
										<div class="d-flex align-items-center justify-content-between">
											<h6 class="fw-semibold fs-4 mb-0">
												$285 <span class="ms-2 fw-normal text-muted fs-3"><del>$345</del></span>
											</h6>
											<ul class="list-unstyled d-flex align-items-center mb-0">
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="me-1" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
												<li><a class="" href="javascript:void(0)"><i
															class="ti ti-star text-warning"></i></a></li>
											</ul>
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
			<div id="memberInsert" class="insertmodal small">
				<div class="w-100">
					<form class="modal-content animate" action="Member.Insert" method="post">
						<div class="imgcontainer">
							<span onclick="document.getElementById('memberInsert').style.display='none'" class="close"
								title="Close Modal">&times;</span> <img src="/images/member/DonerPizzaSmall.png"
								alt="Avatar" class="avatar">
						</div>
						<p class="text-center">請填寫下列資訊</p>
						<div class="container">
							<div class="mb-3">
								<label for="UserAccount" class="form-label">使用者帳號</label> <input type="text"
									class="form-control" id="UserAccount" aria-describedby="textHelp" name="account"
									required placeholder="請輸入帳號">
							</div>
							<div class="mb-3">
								<label for="UserEmail" class="form-label">電子信箱</label> <input type="email"
									class="form-control" id="UserEmail" aria-describedby="emailHelp" name="mEmail"
									required placeholder="請輸入電子信箱">
							</div>
							<div class="mb-4">
								<label for="password" class="form-label">密碼</label> <input type="password"
									class="form-control" id="password" name="password" required placeholder="請輸入密碼">
								<input type="checkbox" onclick="myFunction()">Show Password
							</div>
							<div>${err}</div>
							<button type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">註
								冊</button>
						</div>

						<div class="container">
							<button type="button" onclick="document.getElementById('memberInsert').style.display='none'"
								class="cancelbtn">Cancel</button>
						</div>
					</form>
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
		</body>

		</html>