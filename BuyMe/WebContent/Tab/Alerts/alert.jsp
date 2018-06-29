<!--Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "../FAQ/FAQs.css">
<link rel = "stylesheet" href = "../../Admin/admin.css">
<title>Alert</title>
</head>
<body>
    <ul>
    	<li><a class="active" href="../../welcome.jsp"> Home</a></li>
    	<li><a class="active" href="javascript:history.back()" > Go Back</a></li>
    </ul>
    <br>
<div >
<% 
Connection con = null;
PreparedStatement ps = null;
ResultSet result = null, BuyerResult = null, AlertResult = null, bidR = null, bidR1 = null, bidR2 = null;
Statement stmt = null, BuyerStmt = null, AlertStmt = null, bidS = null, bidS1 = null, bidS2 = null;

int buyerId = 0;

try{
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		String UserName  = session.getAttribute("UserName").toString();
		String BuyerIdQuery = "SELECT * FROM T_Buyer WHERE UserName = '"+UserName+"'";
		BuyerStmt = con.createStatement();
		BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
		
		buyerId = BuyerResult.next() ? BuyerResult.getInt("BuyerId") : 0;
		
		String bidQ = "SELECT * FROM T_Bids WHERE BuyerId = '"+buyerId+"'";
		bidS = con.createStatement();
		bidR = bidS.executeQuery(bidQ);
		
		String bidQ1 = "SELECT * FROM T_Bids";
		bidS1 = con.createStatement();
		bidR1 = bidS1.executeQuery(bidQ1);
  		
  		String Current = "SELECT * FROM T_Alert";
  		Statement stmt2 = con.createStatement();
  		ResultSet result2 = stmt2.executeQuery(Current);
		
		String CurrentBid = "SELECT * FROM T_Alert WHERE BuyerId = '"+buyerId+"'";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(CurrentBid);
  		
  		String CurrentBid4 = "SELECT * FROM T_Alert WHERE UserName = '"+UserName+"'";
  		Statement stmt4 = con.createStatement();
  		ResultSet result4 = stmt4.executeQuery(CurrentBid4);
  		%>
  		<table width="90%" align="center" border="1">
		<tr>
	    <th style="text-align: center;" >Alert Message</th>	    
	  	</tr>
	  <% 
  		while(result.next())
  		{
  			if(BuyerResult.getInt("BuyerId") == result.getInt("BuyerId") && result.getString("Message").equals("Your Bid Has Been Removed As Requested")){
  			%>
            <tr style="text-align:center;">
             <td class="row" style="text-align: center;"><%out.print(result.getString("Message"));%></td>
            </tr>
            <% 
  			}
  		}
  		while(result4.next())
  		{
  			if(result4.getString("UserName").equalsIgnoreCase(UserName) && result4.getString("Message").equalsIgnoreCase("Your Password Has Beeen Reset To")){
  			%>
            <tr style="text-align:center;">
             <td class="row" style="text-align: center;"><%out.print(result4.getString("Message"));%></td>
            </tr>
            <% 
  			}else if(result4.getString("UserName").equalsIgnoreCase(UserName) && result4.getString("Message").equalsIgnoreCase("Your Requested Auction Has Been Removed")){
  				%>
  	            <tr style="text-align:center;">
  	             <td class="row" style="text-align: center;"><%out.print(result4.getString("Message"));%></td>
  	            </tr>
  	            <% 
  			}else if(result4.getString("UserName").equalsIgnoreCase(UserName) && result4.getString("Message").contains("Someone Bidded Higher Than Your Bid On This Productname:")){
  				%>
  	            <tr style="text-align:center;">
  	             <td class="row" style="text-align: center;"><%out.print(result4.getString("Message"));%></td>
  	            </tr>
  	            <% 
  			}
  		}
		  
  	} catch(Exception ex){
    	ex.printStackTrace();
    	out.println("Error");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { BuyerStmt.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { BuyerResult.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
 %>
 </table>
 </div>
</body>
</html>