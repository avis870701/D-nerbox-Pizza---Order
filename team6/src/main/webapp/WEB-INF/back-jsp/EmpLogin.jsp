<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>後台 登入</title>
  <link rel="shortcut icon" type="image/png" href="/images/member/pizzaQ.png" />
  <link rel="stylesheet" href="/back/css/styles.min.css" />
</head>

<body>
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <div
      class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
      <div class="d-flex align-items-center justify-content-center w-100">
        <div class="row justify-content-center w-100">
          <div class="col-md-8 col-lg-6 col-xxl-3">
            <div class="card mb-0">
              <div class="card-body">
                <a href="/member/index" class="text-nowrap logo-img text-center d-block py-3 w-100">
                  <img src="/images/member/DönerPizza.jpg" width="180" alt="">
                </a>
                <p class="text-center">公司後台登入系統</p>
                <form action="/emp/emplogin.controller" method="post">
                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">使用者帳號</label>
                    <input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="account">
                  </div>
                  <div class="mb-4">
                    <label for="exampleInputPassword1" class="form-label">密碼</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" name="password">
                  </div>
                  <button type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">登 入</button>
                  <div class="d-flex align-items-center justify-content-center">
                    <p class="fs-4 mb-0 fw-bold"></p>
                    <a class="text-primary fw-bold ms-2" href="#"></a>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="/back/libs/jquery/dist/jquery.min.js"></script>
  <script src="/back/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>