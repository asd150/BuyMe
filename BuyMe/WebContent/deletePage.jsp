<!-- Arthkumar Desai -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "CSS/welcomeCSS.css">
<title>Are You Sure?</title>
</head>
<body>
<div class="tab2" align="center">
	<h1>Are You Sure You Want To Delete Your Account?</h1>
	<button name="Yes" type="submit"  onclick="location.href='deleteAccount.jsp'" value="Yes">Yes</button>
	<button name="No" type="submit"  onclick="history.back()" value="No">No</button>
</div>

</body>
</html>