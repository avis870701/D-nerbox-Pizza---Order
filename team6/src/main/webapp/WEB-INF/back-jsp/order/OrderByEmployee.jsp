<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.team6.order.model.Order,com.team6.order.model.OrderDetails,com.team6.promotions.model.Promotions"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Order Management</title>

<link rel="shortcut icon" type="image/png"
	href="../../../static/images/logos/favicon.png" />

<link rel="stylesheet" href="../../../static/back/css/styles.min.css" />

<style>
.updateNote-btn:hover {
	font-weight: bold;
}

.updateDiscount-btn:hover {
	font-weight: blod;
}
</style>

<!-- Font Awesome-->
<script src="https://kit.fontawesome.com/60e7a8ebe3.js"
	crossorigin="anonymous"></script>



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<body>
	<!--  Body Wrapper -->
	<div class="page-wrapper" id="main-wrapper" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed">
		<!-- Sidebar Start -->
		<aside class="left-sidebar">
			<!-- Sidebar scroll-->
			<div>
				<div
					class="brand-logo d-flex align-items-center justify-content-between">
					<a href="./index.html" class="text-nowrap logo-img"> <img
						src="../../../static/images/indexImages/DonerPizzaSmall.png"
						width="180" alt="" />
					</a>
					<div
						class="close-btn d-xl-none d-block sidebartoggler cursor-pointer"
						id="sidebarCollapse">
						<i class="ti ti-x fs-8"></i>
					</div>
				</div>
				<!-- Sidebar navigation-->
				<nav class="sidebar-nav scroll-sidebar" data-simplebar="">
					<ul id="sidebarnav">


						<li class="nav-small-cap"><i
							class="ti ti-dots nav-small-cap-icon fs-4"></i> <span
							class="hide-menu">後臺功能</span></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./ui-buttons.html" aria-expanded="false"> <span>
									<i class="ti ti-article"></i>
							</span> <span class="hide-menu">會員</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./ui-alerts.html" aria-expanded="false"> <span>
									<i class="ti ti-alert-circle"></i>
							</span> <span class="hide-menu">產品</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./ui-card.html" aria-expanded="false"> <span> <i
									class="ti ti-cards"></i>
							</span> <span class="hide-menu">訂單</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./ui-forms.html" aria-expanded="false"> <span> <i
									class="ti ti-file-description"></i>
							</span> <span class="hide-menu">訂位</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./ui-forms.html" aria-expanded="false"> <span> <i
									class="ti ti-file-description"></i>
							</span> <span class="hide-menu">外送</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="/promotions/promotionsMain" aria-expanded="false"> <span>
									<i class="ti ti-typography"></i>
							</span> <span class="hide-menu">活動</span>
						</a></li>
						<li class="nav-small-cap"><i
							class="ti ti-dots nav-small-cap-icon fs-4"></i> <span
							class="hide-menu">AUTH</span></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./authentication-login.html" aria-expanded="false"> <span>
									<i class="ti ti-login"></i>
							</span> <span class="hide-menu">Login</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./authentication-register.html" aria-expanded="false">
								<span> <i class="ti ti-user-plus"></i>
							</span> <span class="hide-menu">Register</span>
						</a></li>
						<li class="nav-small-cap"><i
							class="ti ti-dots nav-small-cap-icon fs-4"></i> <span
							class="hide-menu">EXTRA</span></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./icon-tabler.html" aria-expanded="false"> <span>
									<i class="ti ti-mood-happy"></i>
							</span> <span class="hide-menu">Icons</span>
						</a></li>
						<li class="sidebar-item"><a class="sidebar-link"
							href="./sample-page.html" aria-expanded="false"> <span>
									<i class="ti ti-aperture"></i>
							</span> <span class="hide-menu">Sample Page</span>
						</a></li>
					</ul>
					<div
						class="unlimited-access hide-menu bg-light-primary position-relative mb-7 mt-5 rounded">
						<div class="d-flex">
							<div class="unlimited-access-title me-3">
								<h6 class="fw-semibold fs-4 mb-6 text-dark w-85">Upgrade to
									pro</h6>
								<a
									href="https://adminmart.com/product/modernize-bootstrap-5-admin-template/"
									target="_blank" class="btn btn-primary fs-2 fw-semibold lh-sm">Buy
									Pro</a>
							</div>
							<div class="unlimited-access-img">
								<img src="../../../static/back/images/backgrounds/rocket.png"
									alt="" class="img-fluid">
							</div>
						</div>
					</div>
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
						<li class="nav-item d-block d-xl-none"><a
							class="nav-link sidebartoggler nav-icon-hover"
							id="headerCollapse" href="javascript:void(0)"> <i
								class="ti ti-menu-2"></i>
						</a></li>
						<li class="nav-item"><a class="nav-link nav-icon-hover"
							href="javascript:void(0)"> <i class="ti ti-bell-ringing"></i>
								<div class="notification bg-primary rounded-circle"></div>
						</a></li>
					</ul>
					<div class="navbar-collapse justify-content-end px-0"
						id="navbarNav">
						<ul
							class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
							<a
								href="https://adminmart.com/product/modernize-free-bootstrap-admin-dashboard/"
								target="_blank" class="btn btn-primary">Download Free</a>
							<li class="nav-item dropdown"><a
								class="nav-link nav-icon-hover" href="javascript:void(0)"
								id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
									<img src="../../../static/back/images/profile/user-1.jpg"
									alt="" width="35" height="35" class="rounded-circle">
							</a>
								<div
									class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up"
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
										</a> <a href="javascript:void(0)"
											class="d-flex align-items-center gap-2 dropdown-item"> <i
											class="ti ti-list-check fs-6"></i>
											<p class="mb-0 fs-3">My Task</p>
										</a> <a href="./authentication-login.html"
											class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
									</div>
								</div></li>
						</ul>
					</div>
				</nav>
			</header>
			<!--  Header End -->
			<div class="container-fluid">
				<!-- 返回訂單主要的按鈕 -->
				<button class="btn btn-dark backToOrderIndex m-2"
					onclick="goToOrderIndex()">
					<i class="ti ti-cards">返回訂單</i>
				</button>

				<div class="card">
					<div class="card-body">
						<!-- order div -->

						<div class="row shadow">
							<div class="col-md-6">
								<!-- 左边的容器，放置订单信息 -->
								<div class="left-container">
									<input id="orderId" type="hidden" name="orderId" value="">
									<br>
									<div class="row">
										<h5>
											<i class="fa-solid fa-list-ul"></i>
										</h5>
										<div class="col-auto">
											<div class="form-group">
												<label class="fw-semibold mb-0">客人選項：</label><select name="customerName"
													class="form-select">
													<option value="內用客人">內用客人</option>
													<option value="外帶客人">外帶客人</option>
												</select>
											</div>
										</div>
										<div class="col-auto">
											<div class="form-group">
												<label class="fw-semibold mb-0">付款方式：</label> <select name="payment"
													class="form-select">
													<option value="現金">現金</option>
													<option value="LinePay">LinePay</option>
												</select>
											</div>
										</div>
										<div class="col-auto">
											<div class="form-group">
												<label class="fw-semibold mb-0">取餐方式：</label> <select name="pickup"
													class="form-select">
													<option value="內用">內用</option>
													<option value="外帶">外帶</option>
												</select>
											</div>
											<br> <input type="hidden" name="orderStatus" value="已下單">
										</div>
									</div>
									<div class="form-container shadow p-3">
										<h4>
											<i class="fa-solid fa-utensils"></i>
										</h4>
										<div class="form-group">
											<label for="productCategorySelect" class="p-1 fw-semibold mb-0">餐點類別：</label>
											<select class="form-control" id="productCategorySelect">
											</select>
										</div>
										<br>
										<div class="form-group">
											<label for="orderProductSelect" class="p-1 fw-semibold mb-0">選擇餐點：</label> <select
												class="form-control" id="orderProductSelect" disabled>
											</select>
										</div>
										<br>
										<div class="form-group">
											<label for="quantityInput" class="p-1 fw-semibold mb-0">數量：</label> <input
												type="number" class="form-control" id="quantityInput"
												placeholder="" min="1" max="10">
										</div>
										<br>
										<div class="form-group">
											<label for="noteInput" class="p-1 fw-semibold mb-0" disabled>餐點備註：</label> <input
												type="text" class="form-control" id="noteInput"
												placeholder="">
										</div>
										<br>
										<div>
											<label class="fw-semibold mb-0">醬料選擇：</label> <input type="radio" name="sauce"
												value="紅醬" disabled> 紅醬 <input type="radio"
												name="sauce" value="白醬" disabled> 白醬
										</div>
										<br>
										<div>
											<label class="fw-semibold mb-0">加料選擇：</label> <input type="checkbox" id="cheese"
												value="加起司" disabled> 加起司 <input type="checkbox"
												id="mushroom" value="加洋菇" disabled> 加洋菇
										</div>
										<button onclick="addOrder()" class="btn btn-dark"
											style="float: right">新增餐點</button>
										<br>
										<br>
										<br>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<!-- 右边的容器，放置餐点明细 -->
								<div class="right-container">


									<input type="hidden" name="amount" value="${orderBean.amount}">
									<div class="table-responsive shadow m-3">
										<table
											class="table table-striped text-nowrap mb-0 align-middle">
											<thead class="text-dark fs-4">
												<tr>
													<td class="fw-semibold mb-0">餐點</td>
													<td class="fw-semibold mb-0">數量</td>
													<td class="fw-semibold mb-0">單價</td>
													<td class="fw-semibold mb-0">備註</td>
													<!-- 这里继续添加其他表头 -->
												</tr>
											</thead>
											<tbody id="orderDetailsTable">
												<!-- 这里是用JavaScript添加的行 -->
											</tbody>
										</table>
										<button type="submit" class="btn btn-dark m-3"
											style="float: right">點餐結束</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>










	<script src="../../../static/back/libs/jquery/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script
		src="../../../static/back/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../../../static/back/js/sidebarmenu.js"></script>
	<script src="../../../static/back/js/app.min.js"></script>
	<script src="../../../static/back/libs/simplebar/dist/simplebar.js"></script>


	<script src="../../../static/back/js/order/employeeOrder.js"></script>
</body>

</html>