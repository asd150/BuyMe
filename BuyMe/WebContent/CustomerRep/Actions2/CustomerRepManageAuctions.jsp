<!--Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "customrRep_pass.css">
<title>Insert title here</title>
</head>
<body>
<h1>Remove User's All Post</h1>
	<form method="post" action= "Actions/CreateRep.jsp">
	    <div align = "center">
	    	<div class="form-group">
	            <p>UserName<span>*</span></p>
	            <input type="text"  name="CA_UserName" id="CA_UserName" required/>
	        </div>
	    </div>	
	    <button type="submit" class="bouton-contact">Create New</button>
	</form>
</body>
</html>