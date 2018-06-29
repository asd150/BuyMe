<!--Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "customrRep_pass.css">
<title>Customer Rep</title>
</head>
<body>
<ul>
    <li><a class="active" href="CustomerRep.jsp"> Home</a></li>
    <li><a href="#news">News</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<h1>Reset User's Password</h1>
	<form method="post" action= "Actions2/passwordReset.jsp">
	    <div align = "center">
	    	<div class="form-group">
	            <p>UserName<span>*</span></p>
	            <input type="text"  name="C_UserName" id="C_UserName" required/>
	        </div>
	        
	        <div class="form-group">
	            <p>Password<span>*</span></p>
	            <input type="password"  name="C_Password" id="C_Password" required/>
	        </div>
	        
	        <div class="form-group">
	            <p>Repeat Password<span>*</span></p>
	            <input type="password"  name="C_Password2" id="C_Password2" required/>
	        </div>
	    </div>	
	    <button type="submit" class="bouton-contact">Create New</button>
	</form>
</body>
</html>