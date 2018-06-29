<!--Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "CSS/sellerCss.css">
<title>Sell</title>
</head>
<body>
<ul>
    <li><a class="active" href="welcome.jsp"> Home</a></li>
    <li><a class="active" href="javascript:history.back()" > Go Back</a></li>
    <li><a href="#news"> Buy Item</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<div class = "center">
	<section>
	        <h2> Sell Items </h2>
	        <div class="dropdown">
	            <button class="dropbtn">Department</button>
	            <div class="dropdown-content">
	                <p> Choose Section </p>
	                <a href="elecSelection.jsp">Electronics</a>
	                <a href="clothSelection.jsp"> Merchandise </a>
	
	            </div>
	        </div>
	
	</section>
</div>
</body>
</html>
