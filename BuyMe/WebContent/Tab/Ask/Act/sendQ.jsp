<!--Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ask</title>
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
    	
    	String Question = request.getParameter("Question");
    	String insert = "INSERT INTO T_QAPage(Question, UserName)"
    			+ "VALUES (?, ?)";
    	ps = con.prepareStatement(insert);
    	ps.setString(1, Question);
    	ps.setString(2, session.getAttribute("UserName").toString());
    	ps.executeUpdate();
  		
		response.sendRedirect("../AskQuestionRep.jsp");
    } catch(Exception ex){
    	ex.printStackTrace();
    	out.print("Error Sending Question");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { ps.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</body>
</html>