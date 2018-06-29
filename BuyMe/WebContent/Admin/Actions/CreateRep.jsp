<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Rep</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement ps = null;
try{
		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
		
		String FirstName = request.getParameter("A_FirstName");
		String LastName = request.getParameter("A_LastName");
		String UserName = request.getParameter("A_UserName");
		String Email = request.getParameter("A_Email");
		String Password1 = request.getParameter("A_Password1");
		String Password2 = request.getParameter("A_Password2");
		
		String clothes_query = "SELECT UserName FROM T_Account WHERE UserName = '"+UserName+"'";
		Statement stmt2 = con.createStatement();
		ResultSet customers_result = stmt2.executeQuery(clothes_query);
		if(customers_result.next()){
			String checkUser = customers_result.getString("UserName");
			if(checkUser.equalsIgnoreCase(UserName)){
				customers_result.close();
				out.print("USER Account Already Exist");
			}
		}else{
				String insert = "INSERT INTO T_Account(FirstName,LastName,UserName,Email, Password1,Password2,EndUser, Admin, CustomerRep)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
				ps = con.prepareStatement(insert);
				ps.setString(1, FirstName);
				ps.setString(2, LastName);
				ps.setString(3, UserName);
				ps.setString(4, Email);
				ps.setString(5, Password1);
				ps.setString(6, Password2);
				ps.setBoolean(7, false);
				ps.setBoolean(8, false);
				ps.setBoolean(9, true);
				ps.executeUpdate();
				customers_result.close();
				con.close();
				response.sendRedirect("../ManageCustomerRep.jsp");
		}
} catch(Exception ex){
	
	ex.printStackTrace();
	out.print("Customer Rep Already Exist");
	out.println("Reason: " + ex.getMessage());
} finally {
    try { ps.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}
%>
</body>
</html>