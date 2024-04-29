<%@page import="com.team6.model.Promotions" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>所有活動資料</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd; /* 更換欄位邊框顏色 */
            padding: 10px;
            text-align: center;
            background-color: #fff; /* 更換欄位背景色 */
        }

        th {
            background-color: #4CAF50; /* 更換標題背景色 */
            color: white; /* 更換標題文字顏色 */
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

        img {
            width: 12vw;
            height: 12vw;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>

<body>
<div align="center">
    <h2>所有活動資料</h2>
    <table>
        <tr>
            <th>活動編號</th>
            <th>活動名稱</th>
            <th>活動內容</th>
            <th>活動圖片</th>
            <th>活動折扣</th>
            <th>折扣碼</th>
            <th>開始日期</th>
            <th>結束日期</th>
            <th>修改</th>
            <th>刪除</th>
        </tr>
        <%
            List<Promotions> promotionsBeans = (ArrayList<Promotions>) request.getAttribute("promotions");
            for (Promotions promotions : promotionsBeans) {
        %>

        <tr>
            <td><%=promotions.getPromotions_id()%>
            </td>
            <td><a
                    href="promotions/<%=promotions.getPromotions_id()%>"><%=promotions.getPromotions_name()%>
            </a>
            </td>
            <td><%=promotions.getPromotions_content()%>
            </td>
            <td><img alt="無圖片" src=" <%=promotions.getPromotions_picture()%>"></td>
            <!--<td><img src="<%=promotions.getPromotions_picture()%>?timestamp=<%=System.currentTimeMillis()%>"></td>-->
            <td><%=promotions.getPromotions_discount()%>
            </td>
            <td><%=promotions.getPromotions_discountcode()%>
            </td>
            <td><%=promotions.getPromotions_startdate()%>
            </td>
            <td><%=promotions.getPromotions_enddate()%>
            </td>
            <td>
                <a class="btn"
                   href="promotions/update/<%=promotions.getPromotions_id()%>">修改</a>
            </td>
            <td>
                <a class="btn btn-danger" href="javascript:void(0);"
                   onclick="deletePromotions('<%=promotions.getPromotions_name()%>', '<%=promotions.getPromotions_id()%>')">刪除</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <h3>
        共<%=promotionsBeans.size()%>筆活動資料
    </h3>
    <p>
        <a class="btn" href="promotions/insert">新增活動</a>
        <a class="btn" href="/member/MemberGoBackToIndex">回首頁</a>
    </p>
</div>


<script>
    function deletePromotions(promotionsName, promotionsId) {
        let confirmDelete = confirm("確定要刪除活動 '" + promotionsName + "' 嗎？");
        if (confirmDelete) {
            $.ajax({
                url: "/promotions/promotions/delete/" + promotionsId,
                type: "DELETE",
                success: function (response) {
                    window.location.href = "/promotions/promotionsMain";
                    alert("活動已成功刪除！");
                },
                error: function (xhr, status, error) {
                    alert("刪除活動失敗：");
                }
            });
        }
    }
</script>


</body>

</html>
