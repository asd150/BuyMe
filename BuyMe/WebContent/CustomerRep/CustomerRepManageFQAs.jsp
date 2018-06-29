<!--Arthkumar Desai, Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "customerRep.css">
<title>FAQs</title>
</head>
<body>
<ul>
    <li><a class="active" href="CustomerRep.jsp"> Home</a></li>
    <li><a href="#news">News</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<h1>Active Questions</h1>
<table width="60%" align="center" border="1">
    <%
    Connection con = null;
    Statement stmt = null;
    ResultSet result = null; 
    try{
    		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    		Class.forName("com.mysql.jdbc.Driver").newInstance();
    		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
    		String query = "SELECT * FROM T_QAPage";
    		stmt = con.createStatement();
    		result = stmt.executeQuery(query);
    		%>
    		<tr>
    	    <th style="width: 50%">Question</th>
    	    <th>Answer</th>
    	  	</tr>
    	  <% 
    		while(result.next())
    		{
    			if(result.getString("Question") == null || (result.getString("Answer") != null && !result.getString("Answer").contains("null"))){
    				
    			}else{
    			%>
                <tr>
                 <td><%out.print(result.getString("Question"));%></td>
                 <td><%if(result.getString("Answer") == null || result.getString("Answer").isEmpty() || result.getString("Answer").equals("null")) {%>
				 <form method="post" action="Actions2/sendAnswer.jsp?QID=<%out.print(result.getString("Question"));%>">
				 <textarea  maxlength="255" rows="5" cols="55" name="Answer" placeholder="Type Your Answer.."></textarea>
  				 <input type = "submit" name = "Send" value = "Send">
                 </form>
                 </td>
                </tr>
            <% 
    				}
    			}
    		}
    } catch(Exception ex){
    	
    	ex.printStackTrace();
    	out.print("Customer Rep Already Exist");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { stmt.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</table>
</body>
</html>