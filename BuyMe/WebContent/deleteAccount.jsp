<!-- Arthkumar Desai -->
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
Statement st = null;
ResultSet result = null; 
ResultSet BuyerResult = null;
Statement BuyerStmt = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet result2 = null; 

try{

		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
		
		String UserName  = session.getAttribute("UserName").toString();
		String BuyerIdQuery = "SELECT BuyerId FROM T_Buyer WHERE UserName = '"+UserName+"'";
		BuyerStmt = con.createStatement();
		BuyerResult = BuyerStmt.executeQuery(BuyerIdQuery);
		
		int buyerId = BuyerResult.next() ? BuyerResult.getInt("BuyerId") : 0;
			System.out.println(buyerId);

		String CurrentBid = "SELECT * FROM T_Bids WHERE BuyerId = "+buyerId;
  		stmt = con.createStatement();
  		result = stmt.executeQuery(CurrentBid);
  		
  		String CurrentBid2 = "SELECT * FROM T_Bids";
  		stmt2 = con.createStatement();
  		result2 = stmt2.executeQuery(CurrentBid2);
  		
		boolean b = true;
  		if(result.next()){
  			while(result2.next()){
	  			if(result.getInt("BuyerId") == result2.getInt("BuyerId")){
		  			if(result.getBoolean("IsActive") == true || result2.getBoolean("IsActive") == true){
		  				b = false;
		  			}
	  			}
  			}
  		}
		
		if(b == true){
			st =con.createStatement();
			int i = st.executeUpdate("DELETE FROM T_Account WHERE UserName = '"+UserName+"'");
			session.invalidate();
			request.getSession().invalidate();
		    response.sendRedirect("index.jsp");	
		}else{
			out.print("You Cannot Delete Account. You and others are Currently Bidding on same Item. You can delete your account after bid ends");
		}
		}
		catch(Exception e)
		{
		System.out.print(e);
		e.printStackTrace();
		}
	finally {
    try { st.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
    try { stmt.close(); } catch (Exception e) { /* ignored */ }
    try { BuyerStmt.close(); } catch (Exception e) { /* ignored */ }
    try { result.close(); } catch (Exception e) { /* ignored */ }
    try { BuyerResult.close(); } catch (Exception e) { /* ignored */ }
}
%>
</body>
</html>