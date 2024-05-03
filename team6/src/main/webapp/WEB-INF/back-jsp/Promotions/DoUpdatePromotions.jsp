<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>修改活動資料</title>
    <style>
        a, a:visited {
            text-decoration: none;
            color: blue;
        }

        button {
            margin: 0 20px 0 35px;
        }

        img {
            width: 16vw;
            height: 16vw;
        }
    </style>
</head>

<body style="background-color: #fdf5e6">
<div align="center">

    <h2>修改活動資料</h2>
    <form method="post" action="/promotions/promotions/update">
        <input type="hidden" name="_method" value="Put"/>
        <table>
            <tr>
                <td>活動編號</td>
                <td><input type="text" name="promotions_id" readonly
                           value="${promotions.promotions_id}"></td>
            </tr>
            <tr>
                <td>活動名稱</td>
                <td><input type="text" name="promotions_name"
                           value="${promotions.promotions_name}"></td>
            </tr>
            <tr>
                <td>活動內容</td>
                <td><input type="text" name="promotions_content"
                           value="${promotions.promotions_content}"></td>
            </tr>
            <tr>
                <td>活動圖片</td>
                <td><input type="text" name="promotions_picture"
                           value="${promotions.promotions_picture}"></td>
                <%--                    <td><img src="${promotions.promotions_picture}"></td>--%>

            </tr>
            <tr>
                <td>活動折扣</td>
                <td><input type="text" name="promotions_discount"
                           value="${promotions.promotions_discount}"></td>
            </tr>
            <tr>
                <td>折扣碼</td>
                <td><input type="text" name="promotions_discountcode"
                           value="${promotions.promotions_discountcode}"></td>
            </tr>
            <tr>
                <td>開始日期</td>
                <td><input type="text" name="promotions_startdate"
                           value="${promotions.promotions_startdate}"></td>
            </tr>
            <tr>
                <td>結束日期</td>
                <td><input type="text" name="promotions_enddate"
                           value="${promotions.promotions_enddate}"></td>
            </tr>
        </table>
        <button type="submit" value="send">更新</button>
        <button href="/promotionsMain">查詢所有活動</button>
    </form>
</div>
</body>

</html>
