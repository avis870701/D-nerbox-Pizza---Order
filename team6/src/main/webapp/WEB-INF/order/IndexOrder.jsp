<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Management</title>
<link rel="stylesheet" href="/css/header.css">
<style>
button {
    width: 30%;
    padding: 10px;
    background-color: lightgray; 
    color: black; 
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #0056b3;
}
</style>
</head>
<body style="background-color:whitesmoke">

 <div class="header">
        <div class="header-container">
            <div class="header-left">
                <img class="logo" src="/product/images/logo.jpg" alt="Dönerbox Pizza">
            </div>
            <div class="header-container">
                <div class="header-right">
                    <h1>Dönerbox Pizza</h1>
                </div>
            </div>
        </div>
    </div>



<div align="center">
<h2>訂單管理介面</h2>
<br><br>
<form method="get" action="orderSelectAll">
<button class="container">查詢訂單</button>
</form>
<br>
<form method="get" action="detailsIndex">
<button class="container">查詢訂單明細</button>
</form>
<br>
<form method="post" action="insertIndex">
<button class="container">員工點餐</button>
</form>
<br>
<a href="/member/MemberGoBackToIndex"><button>返回後台管理</button></a>
</div>
</body>
</html>