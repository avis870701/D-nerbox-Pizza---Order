<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>註冊 會員</title>
  <link rel="shortcut icon" type="image/png" href="/member/images/pizzaQ.png" />
  <link rel="stylesheet" href="/css/styles.min.css" />
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
                <a href="./index.html" class="text-nowrap logo-img text-center d-block py-3 w-100">
                  <img src="/member/images/DonerPizzaSmall.png" width="180" alt="">
                </a>
                <p class="text-center">請填寫下列資訊</p>
                <form method="POST" action="Member.Insert">
                  <div class="mb-3">
                    <label for="exampleInputtext1" class="form-label">使用者帳號</label>
                    <input type="text" class="form-control" id="exampleInputtext1" aria-describedby="textHelp" name="account" required>
                  </div>
                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">電子信箱</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="mEmail">
                  </div>
                  <div class="mb-4">
                    <label for="exampleInputPassword1" class="form-label">密碼</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" name="password" required>
                  </div>
                  <div>${err}</div>
                  <button type="submit" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">註 冊</button>
                  <div class="d-flex align-items-center justify-content-center">
                    <p class="fs-4 mb-0 fw-bold">已有帳號 ?</p>
                    <a class="text-primary fw-bold ms-2" href="/member/login">登入</a>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="/libs/jquery/dist/jquery.min.js"></script>
  <script src="/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>