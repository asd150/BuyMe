<!-- Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "CSS/css.css">
<title>Index</title>
</head>
<body>
		<h1>BuyMe</h1>
		<h2>Login</h2>
			<form method="get" action="loginPage.jsp">
				<input type = "text" name = "UserName" maxlength="20"  placeholder = "UserName" />
				<br>
				<input type = "password" name = "Password1" maxlength="20" placeholder = "Password" />
				<br>
			
				<input type = "submit" name = "login" value = "Login">
			</form>	
			<form method="post" action="SignUp.jsp">
				<input type = "submit" name = "singup" value = "SignUp">
			</form>
			<p><a href = "forgotpass.jsp"> Forgot Password? </a></p>
			<br>
			<h3>Created By: Havan Patel, Ritul Patel, Arthkumar Desai</h3>
</body>
</html>