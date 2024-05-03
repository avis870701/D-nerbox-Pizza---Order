<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員資料</title>
<style>
	body{
		margin: 0;
		padding: 0;
		display: flex;
		justify-content: center;
		align-items: center;
		background-color:  #CCCCFF;
	}
	.div1 {
		margin-left: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 40%;
		height: 100%;
		padding: 30px;
		margin: 30px;
		background-color: #FFFFFF;
		border-radius: 10%;
	}
	.div2 {
		text-align: center;
		align-items: center;
		background-color: 	#99CCFF;
		width: 100%;
		height: 100%;
		padding: 30px;
		font-size: 20px;
		color: #336699;
		font-weight: 700;
		border-radius: 10%;
	}
	.div2 table{
		
		margin: auto;
		border-radius: 25%;
	}
	.div2 thead{
		border: 1px solid #FFFFFF;
		background-color: #CCCCFF;
	}
	.div2 td{
		padding: 10px;
		border-bottom: 1px solid #FFFFFF;
	}
	.div2 button{
		font-size: 20px;
		background-color: #FFFFFF;
		border: 1px solid #336699 ;
		color: #336699 ;
		border-radius: 25%;
		padding: 5px;
	}
	.div2 hr{
		border: 1px solid #FFFFFF;
	}
	.div2 input{
		border: 1px solid #336699;
		color: #336699;
		font-size: 20px;
	}
</style>
</head>
<body>
	<div class="div1">

		<div class="div2">
			<h2>會 員 資 料</h2>
			<hr>
			<jsp:useBean id="bean" scope="request" class="com.team6.model.MemberBean" />
			<form method="post" action="MemberGoToUpdata">
				<table>
					<tr>
						<td>會員帳號
							<td><input type="text" name="account"  maxlength="20"
								value="<%=bean.getAccount()%>" readonly></td>
								<tr>
									<td>會員名稱
										<td><input type="text" name="mName"  maxlength="20"
											value="<%=bean.getmName()%>" readonly>
											<tr>
												<td>會員密碼
													<td><input type="text" name="password"  maxlength="18"
														value="<%=bean.getPassword()%>" readonly>
														<tr>
															<td>電子信箱
																<td><input type="email" name="mEmail"
						value="<%=bean.getmEmail()%>" readonly>
				<tr>
					<td>電話號碼
					<td><input type="text" name="mPhone" pattern="[0]{1}[9]{1}\d{8}" maxlength="10"
						value="<%=bean.getmPhone()%>" readonly>
						<tr>
							<td>會員生日
								<td><input type="date" name="birthday"
						value="<%=bean.getBirthday()%>" readonly>
						<tr>
					<td>帳號權限
						<td><%if(bean.getPermissions()==0){%>
						<label>
							已封鎖
						</label>
                	
						<% }else if(bean.getPermissions()==1){ %> 
							
                		<label>
							已啟用
                		</label>
                		<%} %>
					</table>
					<br>
					<a href="MemberGoToUpdata?account=<%=bean.getAccount()%>"><button
									type="submit">更新</button></a>
					<p>
		</form>
		<a href="Member.SelectAll"><button>回會員資料主頁</button></a>
			
		</div>
	</div>
</body>
</html>