<!--Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "customrRep_bid.css">
<title>ManageBid</title>
</head>
<body>
    <ul>
    	<li><a class="active" href="CustomerRep.jsp"> Home</a></li>
    </ul>
    <br>
<% 
Connection con = null;
Statement stmt = null, stmt1 = null;

ResultSet result = null, result1 = null; 
ResultSet BuyerResult = null;
Statement BuyerStmt = null;

int buyerId = 0;

try{
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		
		
		
		String CurrentBid = "SELECT * FROM T_Bids";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(CurrentBid); 		
  		%>
  		<h1>Remove User's Bid</h1>
	<form method="post" action= "Actions2/DeleteBid.jsp">
	    <div align = "center">
			<p class="head">***See The Active Bid List Below To Remove the Bid***</p>
			<p class="head">***And Fill In Same Fields For Bids You Want to Remove***</p>
	    	<div class="form-group">
	            <p>UserName<span>*</span></p>
	            <input type="text" required name="C_UserName" id="C_UserName" required/>
	        </div>
	        <div class="form-group">
	            <p>Bid Id<span>*</span></p>
	            <input type="text" required name="C_BidId" id="C_BidId" required/>
	        </div>
	    </div>	
	    <button type="submit" class="bouton-contact">Remove Bid</button>
	</form>
	
  		<h1> Active Customer's Bid</h1>
  		<table width="100%" align="center" border="1">
		<tr>
	    <th>Picture</th>
	    <th>Product Name</th>
	    <th>Start Bid</th>
	    <th>Your Bid</th>
	    <th>Start Date</th>
	    <th>End Date</th>
	    <th>Description</th>
	    <th>Time Stamp</th>
	    <th>UserName</th>
	    <th>BidId</th>
	  	</tr>
	  <% 
	  
  		while(result.next())
  		{
  			String BuyerIdQuery = "SELECT * FROM T_Buyer WHERE BuyerId = '"+result.getInt("BuyerId")+"'";
  			BuyerStmt = con.createStatement();
  			BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
  			BuyerResult.next();
  			String user = null;
  			if(BuyerResult.getInt("BuyerId") == result.getInt("BuyerId")){
  				user = BuyerResult.getString("UserName");
  			}
  			
  			String CurrentBid1 = "SELECT * FROM T_Product WHERE PID = '"+result.getInt("PID")+"'";
  	  		stmt1 = con.createStatement();
  	  		result1 = stmt1.executeQuery(CurrentBid1); 
  	  		result1.next();
  	  		if(result.getBoolean("IsActive") == false){
  	  			
  	  		}else{
  			%>
            <tr style="text-align:center;">
             <td class="row"><img src="<%out.print(result1.getString("Photo"));%>" width="200" height="170"></td>
             <td class="row"><%out.print(result1.getString("ProductName"));%></td>
             <td class="row"><%out.print(result1.getString("StartBid"));%>$</td>
             <td class="row"><%out.print(result.getString("Amount"));%>$</td>
             <td class="row"><%out.print(result1.getString("StartDate"));%></td>
             <td class="row"><%out.print(result1.getString("EndDate"));%></td>
             <td class="row"><%out.print(result1.getString("Description"));%></td>
             <td class="row"><%out.print(result.getString("TimeStamp"));%></td>
             <td class="row"><%out.print(user);%></td>
			 <td class="row"><%out.print(result.getString("BidId"));%></td>
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