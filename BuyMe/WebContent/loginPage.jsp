<!-- Arthkumar Desai, Havan Patel -->
<%@page import="com.cs336.BuyMe.DB_Connection"%>
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
PreparedStatement ps = null;
ResultSet result = null;
	try {
		
		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
		
		String UserName = request.getParameter("UserName");
	  	String Password1 = request.getParameter("Password1");
	  	session.setAttribute("UserName", UserName);
	  	session.setAttribute("Password1", Password1);
	  	if(UserName.equalsIgnoreCase("admin") && Password1.equals("AD")){
			response.sendRedirect("Admin/admin.jsp");
	  	}
	  	
		String query = "SELECT * FROM T_Account WHERE UserName = '"+UserName+"' and Password1 = '"+Password1+"'";
		ps = con.prepareStatement(query);
		result = ps.executeQuery(query);
		if(result.next()){
			if(result.getString("Password1").equals(Password1)){
				boolean isEndUser = result.getBoolean("EndUser");
				boolean isCustomerRep = result.getBoolean("CustomerRep");
	
				/* out.print("Account Name: " + UserName + "<br> Password: " + Password);
				out.print("<br>Logged In!"); */
				if(isEndUser){
					response.sendRedirect("welcome.jsp");
				}
				else if(isCustomerRep){
					response.sendRedirect("CustomerRep/CustomerRep.jsp");
				}
				else {
					out.print("Account Not Found" + " <br>" +  "Creat A New Account");
				}
			}else{
				out.println("Password Does Not Match");
			}
		} else {
			out.print("Account Not Found" + " <br>" +  "Creat A New Account");
		}	
	} catch (Exception ex) {
		out.print("ERROR" + "<br>");
		out.println("Reason: " + ex.getMessage());
		ex.printStackTrace();
	}finally {
        try { ps.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
%>
</body>
</html>