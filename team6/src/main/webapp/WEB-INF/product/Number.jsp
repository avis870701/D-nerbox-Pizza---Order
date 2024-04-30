<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.team6.product.model.ProductBean" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counter</title>
    <style type="text/css">
        .counter {
            font-size: 48px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container py-5">
        <div class="counter d-flex justify-content-center align-items-center">
            <button class="btn btn-outline-secondary btn-lg" id="decrement">-</button>
            <div class="mx-3 display-5 fw-bold" id="count">0</div>
            <button class="btn btn-outline-secondary btn-lg" id="increment">+</button>
        </div>
    </div>
    <script>
        const countElement = document.getElementById('count');
        const decrementButton = document.getElementById('decrement');
        const incrementButton = document.getElementById('increment');

        let count = 0;

        decrementButton.addEventListener('click', () => {
            if (count > 0) {
                count--;
                countElement.textContent = count;
            }
        });

        incrementButton.addEventListener('click', () => {
            count++;
            countElement.textContent = count;
        });
    </script>
</body>

</html>