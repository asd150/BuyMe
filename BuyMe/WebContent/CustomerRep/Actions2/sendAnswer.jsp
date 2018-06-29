<!--Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Answer Sent</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet result = null; 
    try{
    	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    	Class.forName("com.mysql.jdbc.Driver").newInstance();
    	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
    	
    	String QID = request.getParameter("QID");
    	String Answer = request.getParameter("Answer");
    	
    	
    	String query1 = "SELECT * FROM T_QAPage"; 
    	Statement stmt1 = con.createStatement();
		ResultSet result1 = stmt1.executeQuery(query1);
		
		while(result1.next()){
			if(result1.getString("Question").equals(QID)){    	    	
		    	String query = "UPDATE T_QAPage set Answer = '"+Answer+"' WHERE Question = '"+QID+"'";
		  		ps = con.prepareStatement(query);
		  		int valid = ps.executeUpdate();
		  		if(valid == 1){
		  			response.sendRedirect("../CustomerRepManageFQAs.jsp");
		  		} else {
		  			out.print("failed.");
		  		}
  			}
		}
    	
    	} catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Error Sending Question");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { con.close(); } catch (Exception e) { /* ignored */ }
        try { ps.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</body>
</html>