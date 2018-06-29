<!-- Ritul Patel-->
<%@page import="com.cs336.BuyMe.DB_Connection"%>
<%@page import="com.cs336.BuyMe.Awards, com.cs336.BuyMe.AllAwards"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.sql.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "../../CSS/electronicCss.css">
<link rel = "stylesheet" href = "../admin.css">
<title>Report</title>
</head>
<body>
<ul>
    <li><a class="active" href="../admin.jsp"> Home</a></li>
    <li><a href="#news">News</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<%
Connection con = null;
Statement stmt = null;
ResultSet productToSale = null;
ArrayList<Awards> awards = new ArrayList<Awards>();
AllAwards _AllAwards = null;
ArrayList<Awards> bestSellings = new ArrayList<Awards>();

float totalEarnigs, earningElect, earningCloth;
    try{
    	 	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    		Class.forName("com.mysql.jdbc.Driver").newInstance();
    		con  = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
    		
    		String ProductQuery = "SELECT * " +
    	    		"FROM T_Awarded A " + 
    	    		"JOIN T_Product P ON A.PID = P.PID "  + 
    	    		"JOIN T_Bids B ON A.BidId = B.BidId AND A.BuyerId = B.BuyerId " +
    	    		"LEFT JOIN T_Clothes C ON C.PID = A.PID " + 
					"LEFT JOIN T_Electronics E ON E.PID = A.PID" ;	
    		
    		stmt = con.createStatement();
    		productToSale = stmt.executeQuery(ProductQuery);
    		
    	 	while(productToSale.next())
    	 	{
    	 		int PID, BuyerId, SellerId, BidId, Rating; 
    	 		Float Amount, StartBid, ReservePrice;

    	 		Date StartDate, EndDate, SoldAt;
    	 		String Photo, BuyerName, SellerName, ProductName;
    	 		
    	 		Boolean IsElect;
    	 		
    	 		PID = productToSale.getInt("PID");
    	 		BuyerId = productToSale.getInt("BuyerId");
    	 		SellerId = productToSale.getInt("SellerId");
    	 		BidId = productToSale.getInt("BidId");
    	 		Rating = productToSale.getInt("Rating");
    	 		
    	 		Amount = productToSale.getFloat("Amount");
    	 		StartBid = productToSale.getFloat("StartBid");
    	 		ReservePrice = productToSale.getFloat("ReservePrice");
    	 		
    	 		StartDate = productToSale.getDate("StartDate");
    	 		EndDate = productToSale.getDate("EndDate");
    	 		SoldAt = productToSale.getDate("SoldAt");
    	 		
    	 		Photo = productToSale.getString("Photo");
    	 		BuyerName = productToSale.getString("BuyerName");
    	 		SellerName = productToSale.getString("SellerName");
    	 		ProductName = productToSale.getString("ProductName");
    	 		
    	 		IsElect = productToSale.getString("Size") != null ? false : true;
    	 		
    	 		awards.add(new Awards (PID,  BuyerId,  SellerId,  BidId,  Rating,  BuyerName,  SellerName,  StartBid,  ReservePrice, 
    	 				 Amount,  StartDate,  EndDate,  SoldAt,  Photo, ProductName, IsElect));
    	 	}
    	 	
    	 	if(!awards.isEmpty())
    	 	{
    	 		_AllAwards = new AllAwards(awards);
    	 		totalEarnigs = _AllAwards.GetTotalEarnings();
    	 		bestSellings = _AllAwards.BestSellings();
    	 		earningElect = _AllAwards.GetTotalByTypeEarnings(true); 
    	 		earningCloth = _AllAwards.GetTotalByTypeEarnings(false);  
    	 	} else {
    	 		return;
    	 	}
    	 	
			String entity1 = request.getParameter("TotalEarnings");
			String entity2 = request.getParameter("BestSellingItems");
			String entity3 = request.getParameter("EarningsPer");

			if(entity1 == null){
			}else if(entity1.equals("Earning")){
    		%>

<h1> Total Earnings </h1>
<div >
<table style="margin: 0px auto; width: 20%" border="1">
    		<tr>
    	    <th style="text-align: center;">Earning</th>
    	  	</tr>
    	  	
            <tr>
            	<td><%out.print(totalEarnigs); %>$</td>
			</tr>
</table>
</div>
<%}
			if(entity2 == null){
			}else if(entity2.equals("BestBuyer")){ %>
<h1>Best Selling Items</h1>
<div>
<table style="margin: 0px auto; width: 20%" border="1">
    		<tr>
    		<th style="text-align: center;"></th>
    	    <th style="text-align: center;">Ratings</th>
    		<th style="text-align: center;">Amount</th>
    	    <th style="text-align: center;">StartBid</th>
    		<th style="text-align: center;">Buyer</th>
    	    <th style="text-align: center;">Item Name</th>
    	  	</tr>
    	  	
            
            <%
            	for(Awards award : bestSellings)
            	{
            		%>
            		<tr>
            		<td><%out.print(bestSellings.indexOf(award)); %></td> 
            		<td><%out.print(award.getRating()); %></td> 
            		<td><%out.print(award.getAmount()); %>$</td> 
            		<td><%out.print(award.getStartBid()); %>$</td> 
            		<td><%out.print(award.getBuyerName()); %></td> 
            		<td><%out.print(award.getProductName()); %></td> 
            		</tr>
            		<%
            	}
            %>
			
</table>
</div>
<%} 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			if(entity3 == null){
			}else if(entity3.equals("Items") ||entity3.equals("ItemsType") ||entity3.equals("EndUser")){%>
<h1>Earnings Per</h1>
<div>
<table style="margin: 0px auto; width: 100%" border="1">
    		<tr>
    		<th style="text-align: center;"></th>
    	    <th style="text-align: center;">Item Name</th>
    		<th style="text-align: center;">Item Type</th>
    	    <th style="text-align: center;">End-User</th>
    	    <th style="text-align: center;">$ Made On Item</th>
    	  	</tr>
    	  	
            <%
            	for(Awards award : bestSellings)
            	{
            		%>
            		<tr>
            		<td><%out.print(bestSellings.indexOf(award)); %></td> 
            		<td><%out.print(award.getProductName()); %></td> 
            		<td>
            			<% if(award.getIsElect()){
            					out.print("Electronics");
            				} else {
            					out.print("Clothes");
            				}
            			%>
            		</td> 
            		<td><%out.print(award.getSellerName()); %></td> 
            		<td><%out.print(award.getAmount()); %></td> 
            		</tr>
            		
            		<%
            	}
            %>
            
</table>

<h1>Total Earnings per type</h1>
<table style="margin: 0px auto; width: 100%" border="1">
			<tr>
    	    <th style="text-align: center;" width="33.33px"></th>
    		<th style="text-align: center;" width="33.33px">Electronic</th>
    	    <th style="text-align: center;" width="33.33px">Clothes</th>
    	  	</tr>
    	  	
    	  	<tr>
    	  	<td>Total</td>
    	  	<td><%out.print(earningElect); %>$</td>
    	  	<td><%out.print(earningCloth); %>$</td>
    	  	</tr>
			
</table>
</div>
<% }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	} catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Customer Rep Already Exist");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { productToSale.close(); } catch (Exception e) { /* ignored */ }
        try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
%>
</body>
</html>