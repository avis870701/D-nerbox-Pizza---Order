<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.*,com.team6.reservation.model.*" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>歷史訂位紀錄</title>
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
                    <h2 style="text-align: start;">歷史訂位紀錄</h2>
<table>
    <thead>
        <tr>
            <th>編號</th>
            <th>預訂姓名</th>
            <th>預訂日期</th>
            <th>預訂時間</th>
            <th>電話號碼</th>
            <th>人數</th>
            <th>備註</th>
            <th>狀態</th>
        </tr>
    </thead>
    <tbody>
        <% 
        List<Reserve> selectHistoryReservationByCustomer = (ArrayList<Reserve>) request.getAttribute("selectHistoryReservationByCustomer");
        int i = 1; // 初始化編號從 1 開始
        for (Reserve selectNames : selectHistoryReservationByCustomer) { 
        %>
        <tr>
            <td>
                <%= i++ %>
            </td>
            <td>
                <%= selectNames.getReservationName() %>
            </td>
            <td>
                <%= selectNames.getReservationDate() %>
            </td>
            <td>
                <%= selectNames.getReservationTime() %>
            </td>
            <td>
                <%= selectNames.getPhone() %>
            </td>
            <td>
                <%= selectNames.getNumberOfPeople() %>
            </td>
            <td>
                <%= selectNames.getNote() %>
            </td>
            <td>
                <%= selectNames.getReservationStatus() %>
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

    </body>

    </html>