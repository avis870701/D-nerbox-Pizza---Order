<%@page import="java.util.ArrayList" %>
	<%@page import="com.team6.member.model.MemberBean" %>
		<%@page import="java.util.List" %>
			<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<title>會員資料</title>
					<style>
						body {
							margin: 0;
							padding: 0;
							display: flex;
							justify-content: center;
							align-items: center;
							background-color: #CCCCFF;
						}

						.div1 {
							margin-left: 50%;
							display: flex;
							justify-content: center;
							align-items: center;
							width: 80%;
							height: 100%;
							padding: 30px;
							margin: 30px;
							background-color: #FFFFFF;
							border-radius: 10%;
						}

						.div2 {
							text-align: center;
							align-items: center;
							background-color: #99CCFF;
							width: 100%;
							height: 100%;
							padding: 30px;
							font-size: 20px;
							color: #336699;
							font-weight: 700;
							border-radius: 10%;
						}

						.div2 table {
							/*border:1px solid #FFFFFF;*/
							border: none;
							margin: auto;
						}

						.div2 thead {
							border: 1px solid #FFFFFF;
							background-color: #CCCCFF;
						}

						.div2 td {
							padding: 10px;
							border-bottom: 1px solid #FFFFFF;
						}

						.div2 button {
							font-size: 20px;
							background-color: #FFFFFF;
							border: 1px solid #336699;
							color: #336699;
							border-radius: 25%;
							padding: 5px;
						}

						.div2 hr {
							border: 1px solid #FFFFFF;
						}

						.div2 fieldset {
							border: 2px solid #FFFFFF;
						}

						.div2 input {
							border: 1px solid #336699;
							color: #336699;
						}

						.page {
							color: #336699;
							font-size: 24px;
							margin: 10px;
						}
					</style>
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
							<table>
								<thead>

									<tr>
										<th>會員帳號</th>
										<th>會員名稱</th>
										<th>會員密碼</th>
										<th>電子信箱</th>
										<th>電話號碼</th>
										<th>會員生日</th>
										<th>帳號權限</th>
										<th>修改</th>
										<th>刪除</th>
									</tr>
								</thead>
								<tbody>

									<% List<MemberBean> beans = (ArrayList<MemberBean>) request.getAttribute("beans");
											for (MemberBean bean : beans) {
											%>
											<form method="get" action="#">
												<tr>
													<td>
														<%=bean.getAccount()%>
													</td>
													<td><a href="Member.SelectByOne?account=<%=bean.getAccount()%>">
															<%=bean.getmName()%>
														</a>
													</td>
													<td>
														<%=bean.getPassword()%>
													</td>
													<td>
														<%=bean.getmEmail()%>
													</td>
													<td>
														<%=bean.getmPhone()%>
													</td>
													<td>
														<%=bean.getBirthday()%>
													</td>
													<td>
														<%if(bean.getPermissions()==0){%> <label> <input type="radio"
																	name="permissions" value="0" checked
																	onchange="change('<%=bean.getAccount()%>', this.value)">已封鎖
															</label> <label> <input type="radio" name="permissions"
																	value="1" required
																	onchange="change('<%=bean.getAccount()%>', this.value)">已啟用
															</label>
															<% }else if(bean.getPermissions()==1){ %> <label> <input
																		type="radio" name="permissions" value="0"
																		onchange="change('<%=bean.getAccount()%>', this.value)">已封鎖
																</label> <label> <input type="radio" name="permissions"
																		value="1" required checked
																		onchange="change('<%=bean.getAccount()%>', this.value)">已啟用
																</label>
																<%} %>
													</td>
											</form>
											<td>
												<a href="MemberGoToUpdata?account=<%=bean.getAccount()%>"><button
														type="submit">更新</button></a>
											</td>
											<td>
												<a href="Member.Delete?account=<%=bean.getAccount()%>"><button
														type="submit">刪除</button></a>
											</td>
											</tr>
											<% } %>
								</tbody>
							</table>
							<br>
							<hr>
							<label> 共<%=beans.size()%>筆員工資料
							</label> <br>
							<br>
							<button>第一頁</button>
							<label class="page"> 1 </label>
							<button>最後一頁</button>
							<br>
							<hr>
							<a href="MemberGoBackToIndex"><button>回主頁</button></a> <a
								href="login"><button>登出</button></a> <a href="Member.Save"><button>印出檔案</button></a>
						</div>
					</div>
					<script>
						function change(account, permissions) {
							let path = "Member.UpdataPermissions?account=" + account
								+ "&permissions=" + permissions;
							window.location.href = path;
						}
					</script>
				</body>

				</html>