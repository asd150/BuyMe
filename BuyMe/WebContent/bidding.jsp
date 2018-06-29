<!-- HAVAN PATEL, RITUL PATEL; -->
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
Statement stmt = null, stmt1 = null, stmt2 = null; 
ResultSet user_result = null, bid_result = null, p_result = null;
PreparedStatement ps2 = null;
try {
	PreparedStatement ps = null, ps3 = null;
	PreparedStatement ps5 = null;

	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 

	int PID = Integer.parseInt(request.getParameter("PIDS"));
	int Rating = request.getParameter("rating") != null ? Integer.parseInt(request.getParameter("rating")) : 0;

	String UserName = session.getAttribute("UserName").toString();
		
		String userQuery = "SELECT * FROM T_Buyer WHERE UserName = '"+UserName+"'";
		stmt = con.createStatement();
		user_result = stmt.executeQuery(userQuery);
		user_result.next();
	
		String pQuery = "SELECT * FROM T_Product WHERE PID = '"+PID+"' AND UserName = '"+UserName+"'";
		stmt2 = con.createStatement();
		p_result = stmt2.executeQuery(pQuery);
		p_result.next();
		
	int BuyerId = user_result.getInt("BuyerId");
	
	float Amount = Float.parseFloat(request.getParameter("EnterBidAmount"));
	float SeceretAutoBidingAmout =  request.getParameter("AutoMaxBid") != "" ? Float.parseFloat(request.getParameter("AutoMaxBid")) : 0;	
	boolean IsAutoBid = SeceretAutoBidingAmout != 0 ? true : false;	
	int autoBid = -1;
	if(IsAutoBid){
		autoBid = 1;
	}else{
		autoBid = 0;
	}
	
	String bidsQuery = "SELECT * FROM T_Bids WHERE PID = '"+PID+"' AND BuyerId = '"+BuyerId+"'";
	stmt1 = con.createStatement();
	bid_result = stmt1.executeQuery(bidsQuery);
	int  i = 0;
	boolean t = true;
	while(bid_result.next()){
		if(bid_result.getInt("PID") == PID && bid_result.getInt("BuyerId") == BuyerId){
				String query = "UPDATE T_Bids set Amount ='"+Amount+"', AutomaticBiding = '"+autoBid+"', SeceretAutoBidingAmout = '"+SeceretAutoBidingAmout+"'  WHERE BuyerId = '"+bid_result.getInt("BuyerId")+"' AND PID ='"+bid_result.getInt("PID")+"'";
		  		ps2 = con.prepareStatement(query);
		  		int valid = ps2.executeUpdate();
		  		
		  		String Ratingquery = "UPDATE T_Ratings set Rating = '"+Rating+"' WHERE BuyerId ='"+bid_result.getInt("BuyerId")+"' and PID ='"+bid_result.getInt("PID")+"'";
		  		ps3 = con.prepareStatement(Ratingquery);
		  		int valid1 = ps3.executeUpdate();
		  		
		  		String bidsQ0 = "SELECT * FROM T_Bids WHERE BuyerId = '"+BuyerId+"'";
				Statement stmts0 = con.createStatement();
				ResultSet bid_R0 = stmts0.executeQuery(bidsQ0);
				
				String bidsQ1 = "SELECT * FROM T_Bids";
				Statement stmts1 = con.createStatement();
				ResultSet bid_R1 = stmts1.executeQuery(bidsQ1);
				
				if(bid_R0.next()){
					while(bid_R1.next()){
			  			if(bid_R0.getInt("PID") == bid_R1.getInt("PID")){
			  				if(bid_R0.getInt("Amount") > bid_R1.getInt("Amount")){
			  					String userQuery6 = "SELECT * FROM T_Buyer WHERE BuyerId = '"+bid_R1.getInt("BuyerId")+"'";
			  					Statement stmt6 = con.createStatement();
			  					ResultSet user_result6 = stmt6.executeQuery(userQuery6);
			  					user_result6.next();
			  					
			  					String userQuery7 = "SELECT * FROM T_Product WHERE PID = '"+PID+"'";
			  					Statement stmt7 = con.createStatement();
			  					ResultSet user_result7 = stmt7.executeQuery(userQuery7);
			  					user_result7.next();
			  					
						  		String Message = "Someone Bidded Higher Than Your Bid On This Productname: " + user_result7.getString("ProductName");
						  		String insertAlert = "INSERT INTO T_Alert(Message,UserName,BuyerId, PID)"
										+ "VALUES (?, ?, ?, ?)";
								ps5 = con.prepareStatement(insertAlert);
								ps5.setString(1, Message);
								ps5.setString(2, user_result6.getString("UserName"));
								ps5.setInt(3, user_result6.getInt("BuyerId"));
								ps5.setInt(4, PID);
								ps5.executeUpdate();  
								ps5.close();
								user_result7.close();
								stmt7.close();
								user_result6.close();
								stmt6.close();
			  				}
			  			}
					}
				}
				bid_R0.close();
				bid_R1.close();
		  		if(valid == 1 && valid1 == 1){
			  		t = false;
					i = 1;
		  			break;
		  		} else {
		  			out.print("failed. here");
		  			break;
		  		}
		}
	}
	if(t == true && i == 0){
		String insert = "INSERT INTO T_Bids(BuyerId, PID, Amount, AutomaticBiding, SeceretAutoBidingAmout)"
				+ "VALUES (?, ?, ?, ?, ?)";
		ps = con.prepareStatement(insert);
		ps.setInt(1, BuyerId);
		ps.setInt(2, PID);
		ps.setFloat(3, Amount);
		ps.setBoolean(4, IsAutoBid);	
		ps.setFloat(5, SeceretAutoBidingAmout);
		ps.executeUpdate();
		ps.close();
		
		String Ratingquery = "UPDATE T_Ratings set Rating = '"+Rating+"' WHERE BuyerId ='"+BuyerId+"' and + PID ='"+PID+"'";
  		ps3 = con.prepareStatement(Ratingquery);
  		ps3.executeUpdate(); 
  		
  		String bidsQ2 = "SELECT * FROM T_Bids WHERE BuyerId = '"+BuyerId+"'";
		Statement stmts8 = con.createStatement();
		ResultSet bid_R8 = stmts8.executeQuery(bidsQ2);
		
		String bidsQ3 = "SELECT * FROM T_Bids";
		Statement stmts9 = con.createStatement();
		ResultSet bid_R9 = stmts9.executeQuery(bidsQ3);
		
		if(bid_R8.next()){
			while(bid_R9.next()){
	  			if(bid_R8.getInt("PID") == bid_R9.getInt("PID")){
	  				if(bid_R8.getInt("Amount") > bid_R9.getInt("Amount")){
	  					
	  					String userQuery6 = "SELECT * FROM T_Buyer WHERE BuyerId = '"+bid_R9.getInt("BuyerId")+"'";
	  					Statement stmt6 = con.createStatement();
	  					ResultSet user_result6 = stmt6.executeQuery(userQuery6);
	  					user_result6.next();
	  					
	  					
	  					String userQuery12 = "SELECT * FROM T_Product WHERE PID = '"+PID+"'";
	  					Statement stmt12 = con.createStatement();
	  					ResultSet user_result12 = stmt12.executeQuery(userQuery12);
	  					user_result12.next();
	  					
				  		String Message = "Someone Bidded Higher Than Your Bid On This Productname: " + user_result12.getString("ProductName");
				  		String insertAlert = "INSERT INTO T_Alert(Message,UserName,BuyerId, PID)"
								+ "VALUES (?, ?, ?, ?)";
				  		ps5 = con.prepareStatement(insertAlert);
						ps5.setString(1, Message);
						ps5.setString(2, user_result6.getString("UserName"));
						ps5.setInt(3, user_result6.getInt("BuyerId"));
						ps5.setInt(4, PID);
						ps5.executeUpdate();
						user_result12.close();
						user_result6.close();
						stmt12.close();
	  				}
	  			}
			}
		}
						bid_R8.close();
						stmts8.close();
						stmts9.close();
						bid_R9.close();
	}
	ps3.close();
	p_result.close();
	response.sendRedirect("welcome.jsp");
	
	
}catch (Exception ex) {
		out.print("ERROR" + "<br>");
		out.println("Reason " + ex.getMessage());
		ex.printStackTrace();
	} finally {
		try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { ps2.close(); } catch (Exception e) { /* ignored */ }
        try { stmt1.close(); } catch (Exception e) { /* ignored */ }
        try { user_result.close(); } catch (Exception e) { /* ignored */ }
        try { bid_result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
%> 
</body>
</html>