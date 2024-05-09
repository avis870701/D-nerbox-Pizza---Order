<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DonerPizza</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        text-align: center;
    }

    h1 {
        font-size: 24px;
        color: #333;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>修改成功</h1>
        <p>感謝您的確認，即將為您導向google</p>
    </div>
</body>

    <script>
        setTimeout(function() {
            window.location.href = "https://www.google.com"; // 導向到 Google 首頁
        }, 3000);
    </script>
    
</html>
