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
    	int PID = Integer.parseInt(request.getParameter("C_PID"));   
    	
    	String BuyerIdQuery = "SELECT * FROM T_Seller WHERE UserName = '"+UserName+"'";
		BuyerStmt = con.createStatement();
		BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
	
		if(BuyerResult.next()){
			
			String bidsQ0 = "SELECT * FROM T_Product WHERE PID = '"+PID+"' AND UserName = '"+UserName+"'";
			Statement stmts0 = con.createStatement();
			ResultSet bid_R0 = stmts0.executeQuery(bidsQ0);
			
			if(bid_R0.next()){		
				if(bid_R0.getBoolean("IsActive") == false){
					out.println("User Have Already Sold The Item");
				}else{
			    	String Deletequery = "DELETE FROM T_Product WHERE PID = "+PID;
			    	delete_stmt = con.createStatement();
			    	delete_stmt.executeUpdate(Deletequery);
			    	String Message = "Your Requested Auction Has Been Removed";
			
			    	String insert = "INSERT INTO T_Alert(Message,UserName, PID)"
							+ "VALUES (?, ?, ?)";
					ps = con.prepareStatement(insert);
					ps.setString(1, Message);
					ps.setString(2, UserName);
					ps.setInt(3, PID);
					ps.executeUpdate();  
					ps.close();
					stmts0.close();
					bid_R0.close();
			    	response.sendRedirect("../CustomerRep.jsp");
				}
			}else{
				out.println("PID Don't Exist For That User Go Back Try Again");
				bid_R0.close();
			}
		}else{
			out.println("User Name Is Wrong");
		}
    	} catch(Exception ex){
    	ex.printStackTrace();
    	out.println("Error Deleting Auction");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { BuyerStmt.close(); } catch (Exception e) { /* ignored */ }
        try { BuyerResult.close(); } catch (Exception e) { /* ignored */ }
        try { delete_stmt.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</body>
</html>