<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Promotion</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1; /* 更換背景色 */
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        label {
            font-weight: bold;
        }

        a {
            text-decoration: none;
            color: blue;
        }

        a:hover {
            color: darkblue;
        }

        .btn {
            padding: 8px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .btn-danger {
            background-color: #f44336;
        }

        .btn-danger:hover {
            background-color: #cc0000;
        }

        #Promotions_picture_img {
            max-width: 100%;
            max-height: 200px; /* 設定最大高度 */
            display: block;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<h2>新增活動</h2>
<form action="/promotions/promotions/insert" method="post" enctype="multipart/form-data">

    <label for="Promotions_id">活動編號:</label> <input type="text"
                                                        id="Promotions_id" name="Promotions_id" required><br> <label
        for="Promotions_name">活動名稱:</label> <input type="text"
                                                       id="Promotions_name" name="Promotions_name" required><br>
    <label for="Promotions_content">活動內容:</label>
    <textarea id="Promotions_content" name="Promotions_content" rows="6"
              required></textarea>
    <br> <br> <label for="Promotions_picture">上傳活動圖片:</label> <input
        type="file" id="Promotions_picture" name="Promotions_picture"
        accept="image/gif, image/jpeg, image/png"><br> <img
        id="Promotions_picture_img" src="#"/><br> <br> <label
        for="Promotions_discount">活動折扣:</label> <input type="number"
                                                           id="Promotions_discount" name="Promotions_discount" min="5"
                                                           step="5"
                                                           required><br> <label
        for="Promotions_discountcode">折扣碼:</label>
    <input type="text" id="Promotions_discountcode"
           name="Promotions_discountcode" required><br> <label
        for="Promotions_startdate">開始日期:</label> <input type="date"
                                                            id="Promotions_startdate" name="Promotions_startdate"
                                                            required><br>

    <label for="Promotions_enddate">結束日期:</label> <input type="date"
                                                             id="Promotions_enddate" name="Promotions_enddate" required><br>

    <button type="submit" value="send">確定</button>
    <button id="clkbtn" class="btn-info">一鍵輸入</button>

</form>
<div align="center">
    <p>
        <a href="/promotions/promotionsMain">查詢所有活動</a>
    </p>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
    $("#Promotions_picture").change(function () {
        readURL(this);
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#Promotions_picture_img").attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>


<script>
    $(document).ready(function () {
        $('#clkbtn').click(function (event) {
            //不要立即提交
            event.preventDefault();

            $('#Promotions_id').val('9999');
            $('#Promotions_name').val('李Array買單');
            $('#Promotions_content').val('瑞又贏，瑞的大勝Z');
            $('#Promotions_discount').val('100');
            $('#Promotions_discountcode').val('Arraywin');
            $('#Promotions_startdate').val('2023-05-01');
            $('#Promotions_enddate').val('2023-05-05');
        });
    });
</script>

</body>
</html>
