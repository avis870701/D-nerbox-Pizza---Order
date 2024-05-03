<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>活動資料</title>
<style>
a, a:visited {
    text-decoration: none;
    color: blue;
    margin-right: 20px;
}
img {
    width: 16vw;
    height: 16vw;
}
</style>
</head>

<body style="background-color: #fdf5e6">
    <div align="center">
        <h2>活動資料</h2>
        <c:set var="promotions" scope="request" value="${promotions}" />
        <table>
            <tr>
                <td>活動編號:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_id}"></td>
            </tr>
            <tr>
                <td>活動名稱:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_name}"></td>
            </tr>
            <tr>
                <td>活動內容:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_content}"></td>
            </tr>
            <tr>
                <td>活動圖片:</td>
                <td><img src="${promotions.promotions_picture}" alt="暫無圖片"></td>
            </tr>
            <tr>
                <td>活動折扣:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_discount}"></td>
            </tr>
            <tr>
                <td>折扣碼:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_discountcode}"></td>
            </tr>
            <tr>
                <td>開始日期:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_startdate}"></td>
            </tr>
            <tr>
                <td>結束日期:</td>
                <td><input type="text" disabled
                    value="${promotions.promotions_enddate}"></td>
            </tr>
        </table>
        <p>
            <a href="/promotions/promotionsMain">查詢所有活動</a>
             
    </div>
</body>

</html>
