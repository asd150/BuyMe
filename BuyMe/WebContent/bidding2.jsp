<!-- RITUL PATEL; -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<%
Connection con = null;
Statement stmt1 = null, stmt2 = null, stmt3 = null; 
ResultSet user_result = null, bid_result = null, productresult = null;

PreparedStatement InsertAward = null, ProductUpdate = null, BidUpdate = null;
ResultSet productToSale = null, bids = null, buyer = null, seller = null, ratings = null; 

PreparedStatement ps2 = null;
try {
	Statement stmt = null;
	PreparedStatement ps = null, ps3 = null;
	PreparedStatement ps5 = null;

	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
	Random rand = new Random();
	int randomNum = rand.nextInt((5 - 3) + 1) + 3;

	int PID = Integer.parseInt(request.getParameter("PIDS"));
	int Rating =  request.getParameter("rating") != null ? Integer.parseInt(request.getParameter("rating")) : randomNum;
	String UserName = session.getAttribute("UserName").toString();
		
		String userQuery = "SELECT * FROM T_Buyer WHERE UserName = '"+UserName+"'";
		stmt = con.createStatement();
		user_result = stmt.executeQuery(userQuery);
		user_result.next();
		
		String productQuery = "SELECT * FROM T_Product WHERE PID = '"+PID+"'";
		stmt1 = con.createStatement();
		productresult = stmt1.executeQuery(productQuery);
		productresult.next();
		
	int BuyerId = user_result.getInt("BuyerId");
	//out.print(request.getParameter("AutoMaxBid"));
	float Amount = productresult.getFloat("BuyNow");
	float SeceretAutoBidingAmout =  request.getParameter("AutoMaxBid") != null ? Float.parseFloat(request.getParameter("AutoMaxBid")) : 0;	
	boolean IsAutoBid = false;
	
	String bidsQuery = "SELECT * FROM T_Bids WHERE PID = '" +PID + "' AND BuyerId = '" + BuyerId + "'";
	stmt2 = con.createStatement();
	bid_result = stmt2.executeQuery(bidsQuery);	
	
	if(bid_result.next())
	{
		//Bid exists, update value 
		String query = "UPDATE T_Bids set Amount ='"+Amount+"' WHERE BuyerId = '"+BuyerId+"' AND PID ='"+PID+"'";
  		ps2 = con.prepareStatement(query);
  		ps2.executeUpdate();
	} else {
		//add to table
		String insert = "INSERT INTO T_Bids(BuyerId, PID, Amount, AutomaticBiding, SeceretAutoBidingAmout)"
				+ "VALUES (?, ?, ?, ?, ?)";
		ps = con.prepareStatement(insert);
		ps.setInt(1, BuyerId);
		ps.setInt(2, PID);
		ps.setFloat(3, Amount);
		ps.setBoolean(4, IsAutoBid);	
		ps.setFloat(5, SeceretAutoBidingAmout);
		ps.executeUpdate();
	}
	
	
	// All properties needed for sale to be finish
		String buyerName, sellerName;
		Float amountSold, bidStarted, reservePrice;
		int  BidId, SellerId, RatingValue;
		
		//Product that need to be sold 
				String ProductQuery = "SELECT * FROM T_Product WHERE IsActive AND PID = '" +PID+ "'";
				stmt3 = con.createStatement();
				productToSale = stmt3.executeQuery(ProductQuery);
	
				while(productToSale.next())
				{
					//Null everything
					bids = null; 
					buyer = null;
					PID = productToSale.getInt("PID"); 
					System.out.println(PID);		
					BuyerId = 0; 
					BidId = 0;
					SellerId = 0;
					
					sellerName = productToSale.getString("UserName");
					
					// For each product get the max bid 
// 					String BidQuery = 
// 							"SELECT * " +
// 							"FROM T_Bids a " +
// 							"LEFT JOIN ( " + 
// 							    "SELECT PID, MAX(Amount) Amount, BuyerId " + 
// 							    "FROM T_Bids " + 
// 							    "GROUP BY PID " + 
// 							") b ON a.PID = '" + PID +"' AND a.Amount = b.Amount";
					
					
					String BidQuery =
							" SELECT * " +
							" FROM T_Bids a " +
							" INNER JOIN ( " +
							"    SELECT PID, MAX(Amount) Amount " +
							"    FROM T_Bids " +
							"    GROUP BY PID " +
							" ) b ON a.PID = '"+PID+"' AND a.Amount = b.Amount ; " ;
					
					stmt = con.createStatement();
					bids = stmt.executeQuery(BidQuery);
					
					// if there is bid 
					if(bids.next())
					{
						// Get rest bid for deletion
						BidId = bids.getInt("BidId");
						BuyerId = bids.getInt("BuyerId");
						System.out.println(BidId +"  " + BuyerId);

						// Get the seller and buyer
						String BuyerQuery = "SELECT B.UserName " +
								"FROM T_Buyer B " +
								"WHERE B.BuyerId = '"+ BuyerId +"';";
								
						String SellerQuery = "SELECT S.SellerID " +
								"FROM T_Seller S " +
								"WHERE S.UserName  = '"+ sellerName +"';";
						stmt = con.createStatement();
						buyer = stmt.executeQuery(BuyerQuery);
						
						stmt2 = con.createStatement();
						seller = stmt2.executeQuery(SellerQuery);
						
						if(seller.next()){
							SellerId = seller.getInt("SellerID");
						}
						
						if(buyer.next())
						{
							// Set all properties need 
							// String
							buyerName = buyer.getString("UserName");
							sellerName = productToSale.getString("UserName");
							
							
							//Floats
							amountSold = bids.getFloat("Amount");
							reservePrice = productToSale.getFloat("ReservePrice");
									
							// Get Rating for current bid
							String rating = "SELECT * FROM T_Ratings WHERE BidId =" + BidId;
							RatingValue = Rating;
							
							// Insert Into Awarded only if amount is >= reserve price
							if(amountSold >= reservePrice)	{
								String insertAward = "INSERT INTO T_Awarded(PID, BuyerId, SellerId, BidId, Rating, BuyerName, SellerName)"
										 + "VALUES (?, ?, ?, ?, ?, ?, ?)";
					
								InsertAward = con.prepareStatement(insertAward);
								InsertAward.setInt(1, PID);
								InsertAward.setInt(2, BuyerId);
								InsertAward.setInt(3, SellerId);
								InsertAward.setInt(4, BidId);
								InsertAward.setInt(5, RatingValue);
								InsertAward.setString(6, buyerName);
								InsertAward.setString(7, sellerName);
								InsertAward.executeUpdate();
							}
							
							// Update Table (Product and Bid) set IsActive to false
							String ProductUpdateQuery = "UPDATE T_Product SET IsActive = False WHERE PID = " + PID;
							ProductUpdate = con.prepareStatement(ProductUpdateQuery);
							ProductUpdate.execute();
							
							String BidUpdateQuery = "UPDATE T_Bids SET IsActive = False WHERE PID = " + PID;
							BidUpdate = con.prepareStatement(BidUpdateQuery);
							BidUpdate.execute();
						}
					}
				}
				stmt.close();
	response.sendRedirect("welcome.jsp");
	
	
}catch (Exception ex) {
		out.print("ERROR" + "<br>");
		out.println("Reason " + ex.getMessage());
		ex.printStackTrace();
	} finally {
        try { ps2.close(); } catch (Exception e) { /* ignored */ }
        try { stmt1.close(); } catch (Exception e) { /* ignored */ }
        try { user_result.close(); } catch (Exception e) { /* ignored */ }
        try { bid_result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
%> 
</body>
</html>