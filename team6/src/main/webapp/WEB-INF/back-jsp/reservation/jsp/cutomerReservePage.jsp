<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂位頁面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <form method="post" action="/reservation/customerReserve" id="reservationForm">   
    <input type="hidden" name="_method" value="POST"/> 
        <h1>Doner Pizza訂位</h1>
        <label for="name">訂位姓名：</label>
        <input type="text" id="name" name="name" required>

        <label for="phone">訂位電話：</label>
        <input type="text" id="phone" name="phone" required>

        <label for="date">訂位日期：</label>
        <input type="date" id="date" name="date" required>
        
        <label for="time">訂位時間：</label>
        <select id="time" name="time" required>
        	<option value="">未選擇</option>
            <option value="12:00">12:00</option>
            <option value="12:30">12:30</option>
            <option value="18:00">18:00</option>
            <option value="18:30">18:30</option>
        </select>

        <label for="people">訂位人數：</label>
        <input type="number" id="people" name="people" min="1" required>

        <label for="note">備註：</label>
        <textarea id="note" name="note" rows="1"></textarea>

        <button type="submit" name="checkin" value="customerReserve">送出</button>
        
        
       <p> 
        <button type="button" onclick="fillDefaultValues()">一鍵輸入</button>
       </p> 
       
       <p>
       <a href="reservemain.controller"><button type="button"><b>訂位系統管理後台</b></button></a>	
       </p>
    </form>

<script>
    // 獲取當前日期
    var today = new Date();

    // 轉換日期為YYYY-MM-DD格式
    var year = today.getFullYear();
    var month = (today.getMonth() + 1).toString().padStart(2, '0'); // 月份需補零
    var day = today.getDate().toString().padStart(2, '0'); // 日需補零

    var minDate = `${year}-${month}-${day}`;

    // 設置min屬性為當前日期
    document.getElementById('date').setAttribute('min', minDate);

    function updateDisabledTimes() {
        var selectedDate = document.getElementById('date').value;
        var currentDate = new Date();
        var selectedDateTime = new Date(selectedDate);

        // 如果選擇日期為當前日期，則禁用過去時間
        if (selectedDateTime.getFullYear() === currentDate.getFullYear() &&
            selectedDateTime.getMonth() === currentDate.getMonth() &&
            selectedDateTime.getDate() === currentDate.getDate()) {
            var currentHour = currentDate.getHours();
            var currentMinute = currentDate.getMinutes();
            var options = document.getElementById('time').options;

            // 遍歷所有選項，並根據現在時間決定是否禁用
            for (var i = 0; i < options.length; i++) {
                var optionHour = parseInt(options[i].value.split(':')[0]);
                var optionMinute = parseInt(options[i].value.split(':')[1]);

                if (currentHour > optionHour || (currentHour === optionHour && currentMinute >= optionMinute)) {
                    options[i].disabled = true; // 如果現在時間超過或等於該選項的時間，則禁用該選項
                } else {
                    options[i].disabled = false; // 否則啟用該選項
                }
            }
        } else {
            // 如果選擇的日期是未來日期，則啟用所有時間選項
            var options = document.getElementById('time').options;
            for (var i = 0; i < options.length; i++) {
                options[i].disabled = false;
            }
        }
    }

    document.getElementById('date').addEventListener('change', updateDisabledTimes);
    updateDisabledTimes();

    function validateForm() {
        var selectedTime = document.getElementById("time").value;
        if (selectedTime === "") {
            alert("請選擇時間");
            return false; 
        } else if (selectedTime === null) {
            alert("請重新選擇日期");
            return false; 
        }
        return true; 
    }       
    
    
    function fillDefaultValues() {
        document.getElementById("name").value = "王大同";
        document.getElementById("phone").value = "0912345678";
        document.getElementById("date").value = "2024-04-30";
        document.getElementById("time").value = "12:00";
        document.getElementById("people").value = "2";
        document.getElementById("note").value = "茹素者";
    }
    
    function removeSpaces(textarea) {
        textarea.value = textarea.value.replace(/\s/g, '');
    }
    
    document.getElementById("reservationForm").addEventListener("submit", function(event) {
        var selectedDate = new Date(document.getElementById("date").value);
        var selectedTime = document.getElementById("time").value;
        var now = new Date();
        
        // 檢查選擇的日期是否等於今天且選擇的時間是否小於現在時間
        if (selectedDate.toDateString() === now.toDateString() && selectedTime < now.getHours() + ":" + now.getMinutes()) {
            event.preventDefault(); // 阻止表單提交
            alert("選擇的時間已過，請重新選擇。");
        }
    });
    
</script>

</body>

</html>