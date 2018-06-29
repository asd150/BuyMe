<!--Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel = "stylesheet" href = "CSS/css.css">
</head>
<body>
	<h2>Create Account</h2>
	<h3>**All Fields Are Required**</h3>
		<form method="post" action="signUpPage.jsp">
					<input type = "text" required name = "SignUp_FirstName" maxlength="20" placeholder = "First Name" />
				<br>
					<input type = "text" required name = "SignUp_LastName" maxlength="20" placeholder = "Last Name" />
				<br>
					<input type = "text" required name = "SignUp_UserName" maxlength="20" placeholder = "Username" />
				<br>	
					<input type = "email" required name = "SignUp_Email" maxlength="30" placeholder = "Email" />
				<br>
					<input type = "password" required name = "SignUp_Password1" maxlength="15" placeholder = "Password" />
				<br>
					<input type = "password" required name = "SignUp_Password2" maxlength="15" placeholder = "Re-enter Password" />
				<br>	
					<input type = "submit" name = "SignUp" value = "SignUp">
		</form>	

</body>
</html>