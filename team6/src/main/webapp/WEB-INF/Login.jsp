<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
		<title>Login here</title>
		<style>
			body {
				font-family: Arial, Helvetica, sans-serif;
				margin: 0;
				padding: 0;
			}

			form {
				border: 3px solid #f1f1f1;
			}

			input[type=text],
			input[type=password] {
				width: 100%;
				padding: 12px 20px;
				margin: 8px 0;
				display: inline-block;
				border: 1px solid #ccc;
				box-sizing: border-box;
			}

			button {
				background-color: #04AA6D;
				color: white;
				padding: 14px 20px;
				margin: 8px 0;
				border: none;
				cursor: pointer;
				width: 100%;
			}

			button:hover {
				opacity: 0.8;
			}

			.cancelbtn {
				width: auto;
				padding: 10px 18px;
				background-color: #f44336;
			}

			.imgcontainer {
				text-align: center;
				margin: 24px 0 12px 0;
			}

			img.avatar {
				width: 40%;
				border-radius: 50%;
			}

			.container {
				padding: 16px;
			}

			span.psw {
				float: right;
				padding-top: 16px;
			}

			/* Change styles for span and cancel button on extra small screens */
			@media screen and (max-width: 300px) {
				span.psw {
					display: block;
					float: none;
				}

				.cancelbtn {
					width: 100%;
				}
			}

			.model {
				left: 0;
				justify-content: center;
				align-items: center;
				padding: 30px;
				margin: 30px;
				background-color: #FFFFFF;
				border-radius: 3%;
			}

			.center {
				left: 0;
				display: flex;
				justify-content: center;
				align-items: center;
				width: 35%;
				height: 100%;
				padding: auto;
				margin: auto;
				background-color: #FFFFFF;
				border-radius: 3%;
			}

			.textRed {
				color: red;
			}
		</style>
	</head>

	<body>
		<div class="center">

			<div class="model">
				<h2>Login Form</h2>
				<form action="login.controller" method="post">
					<div class="imgcontainer">
						<img src="/member/images/loginmember01.jpg" alt="Avatar" class="avatar">
					</div>

					<div class="container">
						<label for="account"><b>UserAccount</b></label> <input type="text" placeholder="Enter Username"
							name="account" required> <label for="pwd"><b>Password</b></label> <input type="password"
							placeholder="Enter Password" name="pwd" required id="myInput"><input type="checkbox"
							onclick="myFunction()">Show Password
						<div class="textRed">${err}</div>
						<button type="submit" name="type" value="Login">Login</button>
						<label> <input type="checkbox" checked="checked" name="remember"> Remember me
						</label>
					</div>

					<div class="container" style="background-color: #f1f1f1">
						<button type="button" class="cancelbtn">Cancel</button>
						<span class="psw">Forgot <a href="#">password?</a></span>
					</div>
				</form>
			</div>
		</div>
		<script>
			function myFunction() {
				var x = document.getElementById("myInput");
				if (x.type === "password") {
					x.type = "text";
				} else {
					x.type = "password";
				}
			}
		</script>
	</body>

	</html>