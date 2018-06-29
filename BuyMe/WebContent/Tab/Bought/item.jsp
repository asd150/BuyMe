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
<title>Bought Product</title>
</head>
<body>
    <ul>
    	<li><a class="active" href="../../welcome.jsp"> Home</a></li>
    	<li><a class="active" href="javascript:history.back()" > Go Back</a></li>
    </ul>
    <br>
<div >
<table width="90%" align="center" border="1">
<% 
Connection con = null;
Statement stmt = null;
Statement stmt2 = null;

ResultSet result = null; 
ResultSet ProductResult = null;

int buyerId = 0;

try{
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		String UserName  = session.getAttribute("UserName").toString();
		
		String Product = "SELECT * FROM T_Buyer WHERE UserName = '" + UserName +"'";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(Product);
  		
  		if(result.next())
  		{
  			buyerId = result.getInt("BuyerId");
  		}
  		
		//Get the product 
		String ProductInfo = "SELECT * " +
							 "FROM T_Awarded A " +
							 "JOIN T_Product P ON A.PID = P.PID " +
							 "JOIN T_Bids B ON A.BidId = B.BidId AND A.BuyerId = B.BuyerId WHERE A.BuyerId = " + buyerId;	
		stmt2 = con.createStatement();
		ProductResult = stmt2.executeQuery(ProductInfo);
  		
  		%>
		<tr>
	    <th >Picture</th>
	    <th>Product</th>
	    <th>Amount Bought at</th>
	    <th>Start Bid</th>
	    <th>Buy Now</th>
	    <th>Reserve Price</th>
	    <th>Start Date</th>
	    <th>End Date</th>
	    <th>Description</th>
	    
	  	</tr>
	  <% 
	  
  		while(ProductResult.next())
  		{
  			%>
            <tr style="text-align:center;">
             <td class="row"><img src="<%out.print(ProductResult.getString("Photo"));%>" alt="Mountain View" width="250" height="200"></td>
             <td class="row"><%out.print(ProductResult.getString("ProductName"));%></td>
             <td class="row"><%out.print(ProductResult.getString("Amount"));%></td>
             <td class="row"><%out.print(ProductResult.getString("StartBid"));%>$</td>
             <td class="row"><%out.print(ProductResult.getString("BuyNow"));%>$</td>
             <td class="row"><%out.print(ProductResult.getString("ReservePrice"));%>$</td>
             <td class="row"><%out.print(ProductResult.getString("StartDate"));%></td>
             <td class="row"><%out.print(ProductResult.getString("EndDate"));%></td>
             <td class="row"><%out.print(ProductResult.getString("Description"));%></td>
            </tr>
            <% 
  		}
  	} catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Error Sending Question");
    	out.println("Reason: " + ex.getMessage());
    } finally {
    	try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { stmt2.close(); } catch (Exception e) { /* ignored */ }
        try { ProductResult.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
 %>
 </table>
 </div>
</body>
</html>