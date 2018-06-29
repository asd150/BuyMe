<!--Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Connection con = null;
Statement delete_stmt = null, BuyerStmt = null; 
ResultSet BuyerResult = null;
    try{
		PreparedStatement ps = null;

    	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    	Class.forName("com.mysql.jdbc.Driver").newInstance();
    	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
    	
    	String UserName = request.getParameter("C_UserName");
		int BidId = Integer.parseInt(request.getParameter("C_BidId"));    	
    	
    	String BuyerIdQuery = "SELECT * FROM T_Buyer WHERE UserName = '"+UserName+"'";
		BuyerStmt = con.createStatement();
		BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
		if(BuyerResult.next()){
			String bidsQ0 = "SELECT * FROM T_Bids WHERE BidId = '"+BidId+"' AND BuyerId = '"+BuyerResult.getInt("BuyerId")+"'";
			Statement stmts0 = con.createStatement();
			ResultSet bid_R0 = stmts0.executeQuery(bidsQ0);
			if(bid_R0.next()){
		
		    	String Deletequery = "DELETE FROM T_Bids WHERE BidId = "+BidId;
		    	delete_stmt = con.createStatement();
		    	delete_stmt.executeUpdate(Deletequery);
	    		response.sendRedirect("../CustomerRepManageBids.jsp");
			}else{
				out.print("Bid Id Don't Exist Try Agian");
				con.close();
			}
		}else{
			out.print("User Name Is Wrong");
			con.close();
		}
    	} catch(Exception ex){
    	ex.printStackTrace();
    	out.println("Error Deleting Bid");
    	out.println("Reason: " + ex.getMessage());
    }finally {
        try { delete_stmt.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</body>
</html>