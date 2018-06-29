<!--Ritul Patel, Havan Patel -->
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
<div >
<% 
Connection con = null;
Statement stmt2 = null, Rating = null;
PreparedStatement InsertAward = null, ProductUpdate = null, BidUpdate = null;
ResultSet productToSale = null, bids = null, buyer = null, seller = null, ratings = null; 
int buyerId = 0;
try{
	Statement stmt = null;
	// All properties needed for sale to be finish
	String buyerName, sellerName;
	Float amountSold, bidStarted, reservePrice;
	int PID, BuyerId, BidId, SellerId, RatingValue;
			
	
	
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		//Product that need to be sale 
		String ProductQuery = "SELECT * FROM T_Product P WHERE P.IsActive AND P.StartDate < current_date() AND P.EndDate < (current_date());";
		stmt = con.createStatement();
		productToSale = stmt.executeQuery(ProductQuery);
		
		while(productToSale.next())
		{
			//Null everything
			bids = null; 
			buyer = null;
			PID = productToSale.getInt("PID"); 
			BuyerId = 0; 
			BidId = 0;
			SellerId = 0;
			
			sellerName = productToSale.getString("UserName");
			
			// For each product get the max bid 
			String BidQuery = "SELECT * " +
					"FROM T_Bids a " +
					"LEFT JOIN ( " + 
					    "SELECT PID, MAX(Amount) Amount " + 
					    "FROM T_Bids " + 
					    "GROUP BY PID " + 
					") b ON a.PID = '" + PID +"' AND a.Amount = b.Amount";
			stmt = con.createStatement();
			bids = stmt.executeQuery(BidQuery);
			
			// if there is bid 
			if(bids.next())
			{
				// Get rest bid for deletion
				BidId = bids.getInt("BidId");
						
				BuyerId = bids.getInt("BuyerId");
				
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
					Rating = con.createStatement();
					ratings = Rating.executeQuery(rating);
					
					if(ratings.next()){
						RatingValue = ratings.getInt("Rating");
					} else {
						RatingValue = 0;
					}
					
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
					
					 stmt.close();
				}
			}
		}
  	} catch(Exception ex){
  		StringWriter sw = new StringWriter();
  		PrintWriter pw = new PrintWriter(sw);
  		ex.printStackTrace(pw);
  		String sStackTrace = sw.toString();
  		ex.printStackTrace();
    	out.println("Reason: " + ex.getMessage());
    	out.println("StackTrace: " + sStackTrace);
    } finally {    	
        try { con.close(); } catch (Exception e) { /* ignored */ }
        try { stmt2.close(); } catch (Exception e) { /* ignored */ }
        try { InsertAward.close(); } catch (Exception e) { /* ignored */ }
        try { ProductUpdate.close(); } catch (Exception e) { /* ignored */ }
        try { BidUpdate.close(); } catch (Exception e) { /* ignored */ }
        try { productToSale.close(); } catch (Exception e) { /* ignored */ }
        try { bids.close(); } catch (Exception e) { /* ignored */ }
        try { buyer.close(); } catch (Exception e) { /* ignored */ }
        try { seller.close(); } catch (Exception e) { /* ignored */ }
    }
 %>
 </table>
 </div>
</body>
</html>