<!--Ritul Patel-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "../../FAQ/FAQs.css">
<link rel = "stylesheet" href = "../../Admin/admin.css">
<link rel = "stylesheet" href = "current.css">
<title>Current Bidding</title>
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
Statement stmt = null;

ResultSet result = null; 
ResultSet BuyerResult = null;
Statement BuyerStmt = null;

int buyerId = 0;

try{
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		String UserName  = session.getAttribute("UserName").toString();
		String BuyerIdQuery = "SELECT BuyerId FROM T_Buyer WHERE UserName = '"+UserName+"'";
		BuyerStmt = con.createStatement();
		BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
		
		buyerId = BuyerResult.next() ? BuyerResult.getInt("BuyerId") : 0;
		
		String CurrentBid = "SELECT * FROM T_Bids JOIN T_Product ON T_Bids.PID = T_Product.PID AND T_Bids.IsActive AND T_Bids.BuyerId = '"+buyerId+"'";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(CurrentBid);
  		%>
  		<table width="90%" align="center" border="1">
		<tr>
	    <th>Picture</th>
	    <th>Product</th>
	    <th>Start Bid</th>
	    <th>Your Bid</th>
	    <th>Start Date</th>
	    <th>End Date</th>
	    <th>Description</th>
	    <th>Time</th>
	    
	  	</tr>
	  <% 
	  
  		while(result.next())
  		{
  			%>
            <tr style="text-align:center;">
             <td class="row"><img src="<%out.print(result.getString("Photo"));%>" width="250" height="200"></td>
             <td class="row"><%out.print(result.getString("ProductName"));%></td>
             <td class="row"><%out.print(result.getString("StartBid"));%>$</td>
             <td class="row"><%out.print(result.getString("Amount"));%>$</td>
             <td class="row"><%out.print(result.getString("StartDate"));%></td>
             <td class="row"><%out.print(result.getString("EndDate"));%></td>
             <td class="row"><%out.print(result.getString("Description"));%></td>
             <td class="row"><%out.print(result.getString("TimeStamp"));%></td>
            </tr>
            <% 
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
 </table>
 </div>
</body>
</html>