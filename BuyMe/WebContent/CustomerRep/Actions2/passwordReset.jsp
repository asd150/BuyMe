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
ResultSet result = null; 
    try{
		PreparedStatement ps = null;
    	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    	Class.forName("com.mysql.jdbc.Driver").newInstance();
    	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
    	
    	String UserName = request.getParameter("C_UserName");
    	String Password1 = request.getParameter("C_Password");
    	String Password2 = request.getParameter("C_Password2");
    	
    	String Message = "Your Password Has Beeen Reset To: "+Password1;
    	if(Password1.equals(Password2)){
    	String query = "UPDATE T_Account set Password1 ='"+Password1+"', Password2 ='"+Password2+"' where UserName ='"+UserName+"'";
  		ps = con.prepareStatement(query);
  		int valid = ps.executeUpdate();
  		if(valid == 1){  			
  			String insert = "INSERT INTO T_Alert(Message,UserName)"
					+ "VALUES (?, ?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, Message);
			ps.setString(2, UserName);
			ps.executeUpdate();  
			ps.close();
			response.sendRedirect("../CustomerRep.jsp");
  		} else {
  			out.print("failed.");
  			ps.close();
  		  	con.close();
  		}
    	}else{
    		out.print("Password does not match. Try Agian");
  		  	con.close();
    	}
    	} catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Error Sending Question");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</body>
</html>