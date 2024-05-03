<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <input type="hidden" name="_method" value="POST" />
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
                    alert("選擇的時間已過，請重新選擇。");
                } else {
                    if (nowMonth > selectMonth) {
                        event.preventDefault();
                        alert("選擇的時間已過，請重新選擇。");
                    } else if (nowMonth == selectMonth) {

                        if (nowDate > selectDay) {
                            event.preventDefault();
                            alert("選擇的時間已過，請重新選擇。");
                        } else if (nowDate == selectDay) {

                            if (nowHour > selectHour) {
                                event.preventDefault();
                                alert("選擇的時間已過，請重新選擇。");
                            } else if (nowHour == selectHour) {
                                event.preventDefault();
                                alert("選擇的時間已過，請重新選擇。");
                            }
                        }
                    } else {
                        if (nowDate > selectDay) {
                            event.preventDefault();
                            alert("選擇的時間已過，請重新選擇。");
                        } else if (nowDate == selectDay) {
                            if (nowHour > selectHour) {
                                event.preventDefault();
                                alert("選擇的時間已過，請重新選擇。");
                            } else if (nowHour == selectHour) {
                                event.preventDefault();
                                alert("選擇的時間已過，請重新選擇。");
                            }
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

                console.log('nowhour' + nowHour);
                console.log('nowminute' + nowMinutes);

                console.log('selecthour' + selectHour);
                console.log('selectminute' + selectMinutes);

                console.log(Boolean(nowHour == selectHour));

            });

            document.getElementById('reservationForm').addEventListener('submit', displayDateTime);

            function fillDefaultValues() {
                document.getElementById("name").value = "王大同";
                document.getElementById("phone").value = "0912345678";
                document.getElementById("date").value = defautDate;
                document.getElementById("time").value = "12:00";
                document.getElementById("people").value = "2";
                document.getElementById("note").value = "吃素";
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