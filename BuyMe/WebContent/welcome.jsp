<!--Arthkumar Desai-->
<%@page import="com.cs336.BuyMe.DB_Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "CSS/welcomeCSS.css">
<title>Welcome</title>
</head>
<body>
<% 
	Connection con = null;
	Statement stmt = null;
	ResultSet  result = null;
try {
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
	
	String UserName = session.getAttribute("UserName").toString();
	String query = "SELECT UserName FROM T_Account WHERE UserName = '"+UserName+"'";

	stmt = con.createStatement();
	result = stmt.executeQuery(query);

	if(result.next()){

	} else {
		out.print("Account Not Found" + " <br>" +  "Creat A New Account");
	}	
%>

<div class="container">

<header>
   <h1>Welcome "<% out.print(result.getString("UserName")); %>"</h1>   
</header>
  
<div class="tab">
	<button name="CurrentBids" type="submit" onclick="location.href='Tab/Current/Bidding.jsp?user=<% out.print(result.getString("UserName")); %>'" value="CurrentBids">Current Bids</button>
	<button name="CurrentSelling" type="submit" onclick="location.href='Tab/Current/Selling.jsp?user=<% out.print(result.getString("UserName")); %>'" value="CurrentSelling">Current Selling</button>
	<button name="PastHistory" type="submit" onclick="location.href='Tab/History/AllHistory.jsp?user=<% out.print(result.getString("UserName")); %>'" value="PastHistory">Past History</button>
	<button name="Bought" type="submit" onclick="location.href='Tab/Bought/item.jsp?user=<% out.print(result.getString("UserName")); %>'" value="Bought">Bought</button>
	<button name="FAQs" type="submit" onclick="location.href='Tab/FAQ/AskQuestions.jsp'" value="FAQs">FAQs</button>
	<button name="FAQs1" type="submit" onclick="location.href='Tab/Ask/AskQuestionRep.jsp'" value="FAQs1">Ask Customer Rep</button>
	<button name="FAQs2" type="submit" onclick="location.href='Tab/Alerts/alert.jsp'" value="FAQs2">Alert</button>
	<button name="Logout" type="submit"  onclick="location.href='Logout.jsp'" value="Logout">Logout</button>
	<button name="DeleteAccount" type="submit" onclick="location.href='deletePage.jsp'" value="DeleteAccount">Delete Account</button>
</div>

<div class="tab1" align="center" >
	<button name="Buy" type="submit" onclick="location.href='buyerSection.jsp'" value="Buy">Buy</button>
	<br>
	<button name="Sell" type="submit" onclick="location.href='sellerSection.jsp'" value="Sell">Sell</button>
</div>
</div>
<%
	} catch (Exception ex) {
		out.print("ERROR" + "<br>");
		out.println("Reason " + ex.getMessage());
		ex.printStackTrace();
	}finally {
        try { con.close(); } catch (Exception e) { /* ignored */ }
        try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }

    }
%>
</body>
</html>