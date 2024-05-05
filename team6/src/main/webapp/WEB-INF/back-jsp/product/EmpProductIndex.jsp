<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dönerbox Pizza 後臺管理系統</title>
    <link rel="shortcut icon" type="image/png" href="/images/member/pizzaQ.png" />
    <link rel="stylesheet" href="/back/css/styles.min.css" />
    <link rel="stylesheet" href="/back/css/member/EmpIndexGoToInsertMember.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
  </head>

  <body>
    <!--  Body Wrapper -->
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
      data-sidebar-position="fixed" data-header-position="fixed">
      <!-- Sidebar Start -->
      <aside class="left-sidebar">
        <!-- Sidebar scroll-->
        <div>
          <div class="brand-logo d-flex align-items-center justify-content-between">
            <a href="#" class="text-nowrap logo-img">
              <img src="/images/indexImages/DonerPizzaSmall.png" width="180" alt="" />
            </a>
            <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
              <i class="ti ti-x fs-8"></i>
            </div>
          </div>
          <!-- Sidebar navigation-->
          <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
            <ul id="sidebarnav">


              <li class="nav-small-cap">
                <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                <span class="hide-menu">後臺功能</span>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./ui-buttons.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-article"></i>
                  </span>
                  <span class="hide-menu">會員</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="/product/Product_Test_SelectAll" aria-expanded="false">
                  <span>
                    <i class="ti ti-alert-circle"></i>
                  </span>
                  <span class="hide-menu">產品</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./ui-card.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-cards"></i>
                  </span>
                  <span class="hide-menu">訂單</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./ui-forms.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-file-description"></i>
                  </span>
                  <span class="hide-menu">訂位</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./ui-forms.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-file-description"></i>
                  </span>
                  <span class="hide-menu">外送</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="/promotions/promotionsMain" aria-expanded="false">
                  <span>
                    <i class="ti ti-typography"></i>
                  </span>
                  <span class="hide-menu">活動</span>
                </a>
              </li>
              <li class="nav-small-cap">
                <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                <span class="hide-menu">AUTH</span>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./authentication-login.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-login"></i>
                  </span>
                  <span class="hide-menu">Login</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./authentication-register.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-user-plus"></i>
                  </span>
                  <span class="hide-menu">Register</span>
                </a>
              </li>
              <li class="nav-small-cap">
                <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
                <span class="hide-menu">EXTRA</span>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./icon-tabler.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-mood-happy"></i>
                  </span>
                  <span class="hide-menu">Icons</span>
                </a>
              </li>
              <li class="sidebar-item">
                <a class="sidebar-link" href="./sample-page.html" aria-expanded="false">
                  <span>
                    <i class="ti ti-aperture"></i>
                  </span>
                  <span class="hide-menu">Sample Page</span>
                </a>
              </li>
            </ul>
            <div class="unlimited-access hide-menu bg-light-primary position-relative mb-7 mt-5 rounded">
              <div class="d-flex">
                <div class="unlimited-access-title me-3">
                  <h6 class="fw-semibold fs-4 mb-6 text-dark w-85">Upgrade to pro</h6>
                  <a href="https://adminmart.com/product/modernize-bootstrap-5-admin-template/" target="_blank"
                    class="btn btn-primary fs-2 fw-semibold lh-sm">Buy
                    Pro</a>
                </div>
                <div class="unlimited-access-img">
                  <img src="../../../static/back/images/backgrounds/rocket.png" alt="" class="img-fluid">
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
              <li class="nav-item d-block d-xl-none">
                <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse" href="javascript:void(0)">
                  <i class="ti ti-menu-2"></i>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link nav-icon-hover" href="javascript:void(0)">
                  <i class="ti ti-bell-ringing"></i>
                  <div class="notification bg-primary rounded-circle"></div>
                </a>
              </li>
            </ul>
            <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
              <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
                <button style="width:auto;" class="btn btn-primary">沒用到</button>
                <li class="nav-item dropdown">
                  <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    <img src="/images/member/user.png" alt="" width="35" height="35" class="rounded-circle">
                  </a>
                  <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                    <div class="message-body">
                      <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                        <i class="ti ti-user fs-6"></i>
                        <p class="mb-0 fs-3">My Profile</p>
                      </a>
                      <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                        <i class="ti ti-mail fs-6"></i>
                        <p class="mb-0 fs-3">My Account</p>
                      </a>
                      <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                        <i class="ti ti-list-check fs-6"></i>
                        <p class="mb-0 fs-3">My Task</p>
                      </a>
                      <a href="./authentication-login.html" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
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
                      <h5 class="card-title fw-semibold">銷售概況</h5>
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
                      <h5 class="card-title mb-9 fw-semibold">年度總額</h5>
                      <div class="row align-items-center">
                        <div class="col-8">
                          <h4 class="fw-semibold mb-3">$1,786,358</h4>
                          <div class="d-flex align-items-center mb-3">
                            <span
                              class="me-1 rounded-circle bg-light-success round-20 d-flex align-items-center justify-content-center">
                              <i class="ti ti-arrow-up-left text-success"></i>
                            </span>
                            <p class="text-dark me-1 fs-3 mb-0">+13%</p>
                            <p class="fs-3 mb-0">last year</p>
                          </div>
                          <div class="d-flex align-items-center">
                            <div class="me-4">
                              <span class="round-8 bg-primary rounded-circle me-2 d-inline-block"></span>
                              <span class="fs-2">2023</span>
                            </div>
                            <div>
                              <span class="round-8 bg-light-primary rounded-circle me-2 d-inline-block"></span>
                              <span class="fs-2">2022</span>
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
                          <h5 class="card-title mb-9 fw-semibold"> 當月營收 </h5>
                          <h4 class="fw-semibold mb-3">$126,820</h4>
                          <div class="d-flex align-items-center pb-1">
                            <span
                              class="me-2 rounded-circle bg-light-danger round-20 d-flex align-items-center justify-content-center">
                              <i class="ti ti-arrow-down-right text-danger"></i>
                            </span>
                            <p class="text-dark me-1 fs-3 mb-0">-7%</p>
                            <p class="fs-3 mb-0">last month</p>
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
                  <h5 class="card-title fw-semibold mb-4">所有產品資料</h5>
                  <div class="table-responsive">
                    <table id="example" class="table table-striped" style="width:100%">
                      <thead>
                        <tr>
                          <th>編號</th>
                          <th>類別</th>
                          <th>名稱</th>
                          <th>介紹</th>
                          <th>圖片</th>
                          <th>價格</th>
                          <th>數量</th>
                          <th>狀態</th>
                          <th>上架時間</th>
                          <th>修改狀態</th>
                          <th>功能區</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
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
          <script src="/back/js/member/EmpIndexGoToInsertMember.js"></script>
          <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
          <script>

            $(document).ready(function () {
              $('#example').DataTable({
                language: {
                  "lengthMenu": "顯示 _MENU_ 筆資料",
                  "sProcessing": "處理中...",
                  "sZeroRecords": "没有匹配结果",
                  "sInfo": "目前有 _MAX_ 筆資料",
                  "sInfoEmpty": "目前共有 0 筆紀錄",
                  "sInfoFiltered": " ",
                  "sInfoPostFix": "",
                  "sSearch": "搜尋:",
                  "sUrl": "",
                  "sEmptyTable": "尚未有資料紀錄存在",
                  "sLoadingRecords": "載入資料中...",
                  "sInfoThousands": ",",
                  "oPaginate": {
                    "sFirst": "首頁",
                    "sPrevious": "上一頁",
                    "sNext": "下一頁",
                    "sLast": "末頁"
                  },
                  "order": [[8, "desc"], [0, "asc"]], // 先按上架日期遞減排序,再按產品ID遞增排序
                  "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                  }
                },
                "ajax": {
                  "url": "Product_Test_SelectAll",
                  "method": "GET",
                  "dataSrc": ""
                },
                "columns": [
                  { "data": "productId" },
                  { "data": "productCategory.categoryName" },
                  { "data": "productName" },
                  { "data": "productDesc" },
                  {
                    "data": "productImg_url",
                    "render": function (data, type, row) {
                      return '<div style="width: 12vw; height: 12vw; overflow: hidden;">' +
                        '<img src="' + data + '" alt="沒有頭貼" style="width: 100%; height: 100%; object-fit: cover; object-position: center;">' +
                        '</div>';
                    }
                  },
                  { "data": "productPrice" },
                  { "data": "productQuantity" },
                  { "data": "productState.productStateName" },
                  { "data": "productCreateDate" },
                  {
                    "data": "productState.productStateId",
                    "render": function (data, type, row) {
                      let productId = row.productId;
                      let changeState = `<select onchange="change(` + productId + `, this.value)">
                        <option value="">修改狀態</option>
                        <option value="1">上架中</option>
                        <option value="0">已下架</option>
                       </select>`;
                      return changeState;
                    }
                  },
                  {
                    "data": null,
                    "render": function (data, type, row) {
                      return '<button type="button" class="btn btn-warning btn-sm editBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">修改</button>';
                    }
                  }
                ]
              });
            });

          </script>

          <script>

            function change(productId, productStateId) {
              // let path = "${pageContext.request.contextPath}/Product_ChangeState?productId="
              // 	+ productId + "&productStateId=" + productStateId;
              // window.location.href = path;
              // 分隔
              $.ajax({
                url: "Product_ChangeState",
                method: 'PUT',
                data: { "productId": productId, "productStateId": productStateId },
                success: function (response) {
                  // 根據服務器回應的新狀態名稱更新對應行的productState.productStateName欄位
                  let table = $('#example').DataTable();
                  let row = table.row(function (index, data, node) {
                    return data.productId === productId;
                  });

                  if (row.length) {
                    row.data().productState = {
                      productStateId: productStateId,
                      productStateName: response
                    };
                    row.invalidate(); // 重新渲染
                  }
                },
                error: (xhr, status, error) => console.log(error)
              });
            }
          </script>
  </body>

  </html>