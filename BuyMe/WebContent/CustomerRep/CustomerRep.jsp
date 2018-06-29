<!--Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "../CSS/welcomeCSS.css">
<link rel = "stylesheet" href = "customerRep.css">
<title>Customer Rep</title>
</head>
<body>

<div class="container">
<header>
   <h1>Customer Representative "<%out.print(session.getAttribute("UserName").toString());%>"</h1>   
</header>
 
 <div class = "center">
	<section>
	        <div class="dropdown">
	            <button class="dropbtn">Customer Representative Functions</button>
	            <div class="dropdown-content">
	                <p> Choose </p>
	                <a href="CustomerRepResetPass.jsp">Manage User Password</a>
	                <a href="CustomerRepManageBids.jsp">Manage Bids</a>
	                <a href="manageAuctions.jsp">Manage Auction</a>
	                <a href="CustomerRepManageFQAs.jsp">User FAQs</a>
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