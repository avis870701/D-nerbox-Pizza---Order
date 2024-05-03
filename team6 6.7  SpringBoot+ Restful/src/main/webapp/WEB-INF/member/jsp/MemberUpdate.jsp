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
				display: flex;
				justify-content: center;
				align-items: center;
				width: 60%;
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
				margin: auto;
				border-radius: 25%;
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

			.div2 input {
				border: 1px solid #336699;
				color: #336699;
				font-size: 20px;
			}

			.can {
				font-size: 16px;
				color: red;
				margin: 5px;
			}

			.cannot {
				font-size: 16px;
				color: #ffffff;
				margin: 5px
			}

			.textRed {
				color: red;
			}
		</style>
	</head>

	<body>
		<div class="div1">
			<div class="div2">
				<h2>修 改 會 員 資 料</h2>
				<hr>
				<div class="textRed">${err}</div>
				<jsp:useBean id="bean" scope="request" class="com.team6.model.MemberBean" />
				<form method="post" action="Member.Update">
					<input type="hidden" name="_method" value="PUT" />
					<table>
						<tr>
							<td>會員帳號</td>
							<td><input type="text" name="account" maxlength="20" required value="<%=bean.getAccount()%>"
									readonly><label class="cannot">不可改。</label></td>
						</tr>
						<tr>
							<td>會員名稱</td>
							<td><input type="text" name="mName" maxlength="20" required
									value="<%=bean.getmName()%>"><label class="can">可更改！</label></td>
						</tr>
						<tr>
							<td>會員密碼</td>
							<td><input type="text" name="password" maxlength="18" required
									value="<%=bean.getPassword()%>"><label class="can">可更改！</label></td>
						</tr>
						<tr>
							<td>電子信箱</td>
							<td><input type="email" name="mEmail" required value="<%=bean.getmEmail()%>"><label
									class="can">可更改！</label></td>
						</tr>
						<tr>
							<td>電話號碼</td>
							<td><input type="text" name="mPhone" pattern="[0]{1}[9]{1}\d{8}" maxlength="10" required
									value="<%=bean.getmPhone()%>"><label class="can">可更改！</label></td>
						</tr>
						<tr>
							<td>會員生日</td>
							<td><input type="date" name="birthday" value="<%=bean.getBirthday()%>"><label class="can">
									可更改！</label></td>
						</tr>
						<tr>
							<td>帳號權限</td>
							<td>
								<% if (bean.getPermissions()==0) { %>
									<label> <input type="radio" name="permissions" value="0" checked>已封鎖
									</label> <label> <input type="radio" name="permissions" value="1" required>已啟用
									</label>
									<% } else if (bean.getPermissions()==1) { %>
										<label> <input type="radio" name="permissions" value="0">已封鎖
										</label> <label> <input type="radio" name="permissions" value="1" required
												checked>已啟用
										</label>
										<% } %>
											<label class="can"> 可更改！</label>
							</td>
						</tr>
					</table>
					<p>
						<button type="submit">確定</button>
				</form>
				<a href="Member.SelectAll"><button>取消</button></a>
			</div>
		</div>
	</body>

	</html>