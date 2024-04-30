<%@page import="java.util.ArrayList" %>
	<%@page import="com.team6.member.model.MemberBean" %>
		<%@page import="java.util.List" %>
			<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<!DOCTYPE html>
					<html>

					<head>
						<meta charset="UTF-8">
						<title>會員資料</title>
						<link rel="stylesheet" href="/css/MemberGetAll.css">
						<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
						<script>
							// $('')
							var indexPage = 1;
							$(function () {
								loadPage(indexPage);
							});
							function loadPage(indexPage) {
								$.ajax({
									type: 'get',
									url: '/member/Member/' + indexPage,
									contentType: 'application/json',
									success: function (response) {
										$('#showmember').empty("");
										if (response == null) {
											$('table').prepend('<tr><td>no result</td></tr>');
										} else {
											var table = $('#showmember');
											table.append("<thead><tr>" + "<th>會員帳號</th><th>會員名稱</th><th>會員密碼</th><th>電子信箱</th><th>電話號碼</th><th>會員生日</th><th>帳號權限</th><th>修改</th><th>刪除</th></tr></thead><tbody>");
											$.each(response, function (i, n) {
												var tr = `<tr><td>` + n.account + "</td><td><a href='Member.SelectByOne?account=" + n.account + "'>" + n.mName + "</a></td><td>" + n.password + "</td><td>" + n.mEmail + "</td><td>" + n.mPhone + "</td><td>" + n.birthday + "</td>";
												if (n.permissions == 0) {
													tr += `<td><label> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.account + `', this.value)" checked>已封鎖</label>`
														+ `<label> <input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.account + `', this.value)">已啟用</label></td>`;
												} else if (n.permissions == 1) {
													tr += `<td><label> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.account + `', this.value)">已封鎖</label>`
														+ `<label> <input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.account + `', this.value)" checked>已啟用</label></td>`;
												}
												// tr += `</form>`;
												tr += "<td><a href='MemberGoToUpdate?account=" + n.account + "'><button type='submit'>更新</button></a></td>";
												tr += `<td><button type="submit" onclick="deleteAccount('` + n.account + `')">刪除</button></td>`;
												tr += "</tr>";
												table.append(tr);
											})
											table.append("</tbody>");
										}
									}
								});
							}

							function page(page) {
								indexPage = page;
								loadPage(indexPage);
							}

							function deleteAccount(account) {
								  let confirmDelete = confirm("確定要 刪除 嗎？");
							        if (confirmDelete) {
								$.ajax({
									type: 'delete',
									url: '/member/Member.Delete',
									data: { "account": account },
									success: function () {
										window.location.href = "/member/Member.SelectAll";
									},
									error: function(){
										alert("已取消刪除!");
									}
								});
								}
							}

						</script>
					</head>

					<body>
						<div class="div1">

							<div class="div2">
								<h2>會 員 管 理 資 料</h2>
								<hr>
								<form method="get" action="Member.SelectByName">
									姓名：<input type="text" name="mName">
									<button type="submit">查詢</button>
								</form>
								<hr>
								<a href="MemberGoToInsert"><button>新增</button></a>

								<p>
								<table id="showmember"></table>
								<table id="showpage">
									<tr>
										<td>總共 ${totalPages} 頁 有 ${totalElements} 筆資料</td>
										<td colspan="3" align="right">Previous
											<c:forEach var="i" begin="1" end="${totalPages}" step="1">
												<button id="myPage" type="button" onclick="page(${i})">${i}</button>
											</c:forEach>Next
										</td>
									</tr>
								</table>
								<br>
								<hr>
								<a href="MemberGoBackToIndex"><button>回主頁</button></a> <a
									href="login"><button>登出</button></a> <a href="Member.Save"><button>印出檔案</button></a>
							</div>
						</div>
						<script>
							function change(account, permissions) {
								$.ajax({
									type: 'PUT',
									url: '/member/Member.UpdatePermissions',
									data: {
										"account": account,
										"permissions": permissions
									},
									success: function () {
										window.location.href = "/Member.SelectAll";
									}

								});
							}
						</script>
					</body>

					</html>