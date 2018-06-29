<!-- Ritul Patel-->
<%@page import="com.cs336.BuyMe.DB_Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "../CSS/welcomeCSS.css">
<link rel = "stylesheet" href = "admin.css">
<title>Admin Page</title>


</head>
<body>

<div class="container">

<header>
   <h1>Welcome Admin</h1>   
</header>
 
 <div class = "center">
	<section>
	        <div class="dropdown">
	            <button class="dropbtn">Admin Functions</button>
	            <div class="dropdown-content">
	                <p> Choose </p>
	                <a href="ManageCustomerRep.jsp">Manage Customer Rep</a>
	                <a href="GenrateReport.jsp"> Generate Report </a>
	                <br>
	                <br>
	                <br>
	                <a href="../Logout.jsp">LogOut</a>
	            </div>
	        </div>
	</section>
</div>
</div>
</body>
</html>