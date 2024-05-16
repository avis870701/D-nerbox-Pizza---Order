<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <title>訂位頁面</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Playfair+Display:wght@700;900&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="/front/lib/animate/animate.min.css" rel="stylesheet">
        <link href="/front/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="/front/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="/front/css/style.css" rel="stylesheet">



    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner"
            class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;"></div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <div class="container-fluid bg-white sticky-top">
            <div class="container">
                <nav class="navbar navbar-expand-lg bg-white navbar-light py-2 py-lg-0">
                    <a href="index.html" class="navbar-brand">
                        <img class="img-fluid" src="/images/indexImages/DonerPizzaLogo.png" alt="Logo">
                    </a>
                    <button type="button" class="navbar-toggler ms-auto me-0" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto">
                            <a href="index.html" class="nav-item nav-link">Home</a>
                            <a href="about.html" class="nav-item nav-link">About</a>
                            <a href="product.html" class="nav-item nav-link">Products</a>
                            <a href="store.html" class="nav-item nav-link">Store</a>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu bg-light rounded-0 m-0">
                                    <a href="feature.html" class="dropdown-item">Features</a>
                                    <a href="blog.html" class="dropdown-item">Blog Article</a>
                                    <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                                    <a href="404.html" class="dropdown-item">404 Page</a>
                                </div>
                            </div>
                            <a href="contact.html" class="nav-item nav-link active">Reserve</a>
                        </div>
                        <div class="border-start ps-4 d-none d-lg-block">
                            <button type="button" class="btn btn-sm p-0"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->


        <!-- Page Header Start -->
        <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container text-center py-5">
                <h1 class="display-2 text-dark mb-4 animated slideInDown">訂位資訊</h1>
                <!-- <nav aria-label="breadcrumb animated slideInDown">
               <ol class="breadcrumb justify-content-center mb-0">
                   <li class="breadcrumb-item"><a href="#">Home</a></li>
                   <li class="breadcrumb-item"><a href="#">Reserve</a></li>
                   <li class="breadcrumb-item text-dark" aria-current="page">ReserveSuccess</li>
               </ol>
           </nav> -->
            </div>
        </div>
        <!-- Page Header End -->


        <!-- Contact Start -->
        <div class="container-xxl contact py-5"
            style="background-image: url(/front/img/product-bg.png);background-size:auto ;">
            <div class="container">
                <div class="row g-5 mb-5">
                    <!-- 
               <div class="col-md-6 text-center wow fadeInUp" data-wow-delay="0.4s">
                   <div class="btn-square mx-auto mb-3">
                       <i class="fa fa-phone fa-2x text-white"></i>
                   </div>
                   <p class="mb-2">03-34567008</p>
               </div> -->
                    <!-- <div class="col-md-6 text-center wow fadeInUp" data-wow-delay="0.5s">
                   <i class="fa fa-phone fa-2x text-white"></i>
               </div>
               <p class="mb-2">大仁街51號</p>
               <p class="mb-0">桃園市中壢區</p> -->
                </div>
            </div>
            <div class="row g-5" style=" margin-left: 440px;">
                <div class=" wow fadeInUp" data-wow-delay="0.1s">
                    <form method="post" action="/reservation/customerReserve" id="reservationForm">
                        <input type="hidden" name="_method" value="POST" />
                        <h1>Doner Pizza 訂位</h1>
                        <div class="form-group">
                            <label for="name" class="col-sm-6 col-form-label">訂位姓名：</label>
                            <div class="col-sm-6">
                                <input type="text" id="name" name="name" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone" class="col-sm-6 col-form-label">訂位電話：</label>
                            <div class="col-sm-6">
                                <input type="text" id="phone" name="phone" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="date" class="col-sm-6 col-form-label">訂位日期：</label>
                            <div class="col-sm-6">
                                <input type="date" id="date" name="date" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="col-sm-6 col-form-label">電子信箱：</label>
                            <div class="col-sm-6">
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="time" class="col-sm-6 col-form-label">訂位時間：</label>
                            <div class="col-sm-6">
                                <select id="time" name="time" class="form-control" required>
                                    <option value="">未選擇</option>
                                    <option value="12:00">12:00</option>
                                    <option value="12:30">12:30</option>
                                    <option value="18:00">18:00</option>
                                    <option value="18:30">18:30</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="people" class="col-sm-6 col-form-label">訂位人數：</label>
                            <div class="col-sm-6">
                                <input type="number" id="people" name="people" class="form-control" min="1" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="note" class="col-sm-6 col-form-label">備註：</label>
                            <div class="col-sm-6">
                                <textarea id="note" name="note" class="form-control" rows="3"></textarea>
                            </div>
                        </div>

                        <div class="form-group" style="margin-top: 5px;">
                            <div class="col-sm-6">
                                <button type="submit" name="checkin" value="customerReserve"
                                    class="btn btn-primary">送出</button>
                                <button type="button" class="btn btn-primary"
                                    onclick="fillDefaultValues()">一鍵輸入</button>
                                <a href="reservemain.controller"><button type="button"
                                        class="btn btn-primary"><b>訂位系統管理後台</b></button></a>

                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        </div>
        <!-- Contact End -->


        <!-- Footer Start -->
        <div class="container-fluid bg-dark footer mt-5 py-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-primary mb-4">Our Office</h4>
                        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary me-3"></i>123 Street, New York, USA
                        </p>
                        <p class="mb-2"><i class="fa fa-phone-alt text-primary me-3"></i>+012 345 67890</p>
                        <p class="mb-2"><i class="fa fa-envelope text-primary me-3"></i>info@example.com</p>
                        <div class="d-flex pt-3">
                            <a class="btn btn-square btn-primary rounded-circle me-2" href=""><i
                                    class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle me-2" href=""><i
                                    class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle me-2" href=""><i
                                    class="fab fa-youtube"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle me-2" href=""><i
                                    class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-primary mb-4">Quick Links</h4>
                        <a class="btn btn-link" href="">About Us</a>
                        <a class="btn btn-link" href="">Contact Us</a>
                        <a class="btn btn-link" href="">Our Services</a>
                        <a class="btn btn-link" href="">Terms & Condition</a>
                        <a class="btn btn-link" href="">Support</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-primary mb-4">Business Hours</h4>
                        <p class="mb-1">Monday - Friday</p>
                        <h6 class="text-light">09:00 am - 07:00 pm</h6>
                        <p class="mb-1">Saturday</p>
                        <h6 class="text-light">09:00 am - 12:00 pm</h6>
                        <p class="mb-1">Sunday</p>
                        <h6 class="text-light">Closed</h6>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-primary mb-4">Newsletter</h4>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative w-100">
                            <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text"
                                placeholder="Your email">
                            <button type="button"
                                class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Copyright Start -->
        <div class="container-fluid copyright py-4">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        &copy; <a class="fw-medium" href="#">Your Site Name</a>, All Right Reserved.
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a class="fw-medium" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a
                            class="fw-medium" href="https://themewagon.com">ThemeWagon</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Copyright End -->

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/front/lib/wow/wow.min.js"></script>
        <script src="/front/lib/easing/easing.min.js"></script>
        <script src="/front/lib/waypoints/waypoints.min.js"></script>
        <script src="/front/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="/front/js/main.js"></script>

        <script>

            function displayDateTime() {

                var x = document.getElementById('date').value;//選擇的日期
                var selectDate = new Date(x);

                var selectYear = selectDate.getFullYear();
                var selectMonth = selectDate.getMonth() + 1;
                var selectDay = selectDate.getDate();

                var y = document.getElementById('time').value;//選擇的時間
                var selectHour = parseInt(y.split(":")[0]);
                var selectMinutes = parseInt(y.split(":")[1])


                var currentDate = new Date();//現在日期

                var nowYear = currentDate.getFullYear();
                var nowDate = currentDate.getDate();
                var nowMonth = currentDate.getMonth() + 1;

                var nowHour = parseInt(currentDate.getHours());
                var nowMinutes = parseInt(currentDate.getMinutes());

                if (nowYear > selectYear) {
                    event.preventDefault();
                    alert("選擇的時間無法預訂，請重新選擇。");
                } else if (nowYear < selectYear) {
                    console.log('預訂了明年');
                } else {//2024
                    if (nowMonth > selectMonth) {
                        event.preventDefault();
                        alert("選擇的時間無法預訂，請重新選擇。");
                    } else if (nowMonth == selectMonth) {//2024-05

                        if (nowDate > selectDay) {//2024-05-02
                            event.preventDefault();
                            alert("選擇的時間無法預訂，請重新選擇。");
                        } else if (nowDate == selectDay) {//2024-05-03
                            event.preventDefault();
                            alert("選擇的時間無法預訂，請重新選擇。");
                        }
                    }
                }
            }

            document.getElementById('time').addEventListener('change', function () {
                var y = document.getElementById('time').value;//選擇的時間
                var currentDate = new Date();//現在日期
                var nowHour = parseInt(currentDate.getHours());
                var nowMinutes = parseInt(currentDate.getMinutes());

                var y = document.getElementById('time').value;//選擇的時間
                var selectHour = parseInt(y.split(":")[0]);
                var selectMinutes = parseInt(y.split(":")[1])
            });

            document.getElementById('reservationForm').addEventListener('submit', displayDateTime);

            function fillDefaultValues() {
                document.getElementById("name").value = "王大同";
                document.getElementById("phone").value = "0912345678";
                document.getElementById("date").value = defautDate;
                document.getElementById("time").value = "12:00";
                document.getElementById("people").value = "2";
                document.getElementById("note").value = "吃素";
                document.getElementById("email").value = "ispanteam6@gmail.com";
            }

            var currentDate = new Date();//現在日期
            var nowYear = currentDate.getFullYear();
            var nowDate = currentDate.getDate();
            var nowMonth = currentDate.getMonth() + 1;

            var defautYear = String(nowYear).padStart(2, '0');
            var defautMonth = String(nowMonth).padStart(2, '0');
            var defautDay = String(nowDate + 1).padStart(2, '0');

            var defautDate = defautYear + '-' + defautMonth + '-' + defautDay;
        </script>

    </body>

    </html>