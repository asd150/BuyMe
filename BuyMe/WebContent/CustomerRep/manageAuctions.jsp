<!--Havan Patel -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "customerRep_auction.css">
<title>Manage Auction</title>
</head>
<body>
    <ul>
    	<li><a class="active" href="CustomerRep.jsp"> Home</a></li>
    	<li><a class="active" href="javascript:history.back()" > Go Back</a></li>
    </ul>
    <br>
<% 
Connection con = null;
Statement stmt = null;

ResultSet result = null; 
ResultSet BuyerResult = null;
Statement BuyerStmt = null;

int buyerId = 0;

try{
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		
		
		
		String CurrentBid = "SELECT * FROM T_Product";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(CurrentBid);
  		%>
  		<h1>Remove User's Auction</h1>
	<form method="post" action= "Actions2/DeleteAuction.jsp">
	    <div align = "center">
			<p class="head">***See The Active Auctions List Below To Remove the Product***</p>
			<p class="head">***Fill In Same Fields For PID THAT You Want to Remove***</p>
	    	<div class="form-group">
	            <p>UserName<span>*</span></p>
	            <input type="text" required  name="C_UserName" id="C_UserName" required/>
	        </div>
	        <div class="form-group">
	            <p>PID<span>*</span></p>
	            <input type="text" required name="C_PID" id="C_PID" required/>
	        </div>
	    </div>	
	    <button type="submit" class="bouton-contact">Remove Auction</button>
	</form>
	
  		<h1> Active Customer's Auction</h1>
  		<table width="100%" align="center" border="1">
		<tr>
	    <th>Picture</th>
	    <th>Product Name</th>
	    <th>Start Bid</th>
	    <th>Reserve Price</th>
	    <th>Start Date</th>
	    <th>End Date</th>
	    <th>Description</th>
	    <th>Buy Now</th>
	    <th>UserName</th>
	    <th>PID</th>
	  	</tr>
	  <% 
	  
  		while(result.next())
  		{
  			if(result.getBoolean("IsActive") == true){
	  			%>
	            <tr style="text-align:center;">
	             <td class="row"><img src="<%out.print(result.getString("Photo"));%>" width="200" height="170"></td>
	             <td class="row"><%out.print(result.getString("ProductName"));%></td>
	             <td class="row"><%out.print(result.getString("StartBid"));%>$</td>
	             <td class="row"><%out.print(result.getString("ReservePrice"));%>$</td>
	             <td class="row"><%out.print(result.getString("StartDate"));%></td>
	             <td class="row"><%out.print(result.getString("EndDate"));%></td>
	             <td class="row"><%out.print(result.getString("Description"));%></td>
	             <td class="row"><%out.print(result.getString("BuyNow"));%></td>
	             <td class="row"><%out.print(result.getString("UserName"));%></td>
				 <td class="row"><%out.print(result.getString("PID"));%></td>
	            </tr>
	            <% 
  			}
  		}
  	} catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Error Sending Question");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { BuyerStmt.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { BuyerResult.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
 %>
</body>
</html>