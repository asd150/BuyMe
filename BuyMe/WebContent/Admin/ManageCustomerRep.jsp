<!-- Ritul Patel-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "../CSS/electronicCss.css">
<link rel = "stylesheet" href = "admin.css">
<title>Manage Customer Rep</title>

</head>
<body> 
<ul>
    <li><a class="active" href="admin.jsp"> Home</a></li>
    <li><a href="#news">News</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<h1> Active Customer representatives </h1>
<div >

<table width="60%" align="center" border="1">
    <%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet result = null; 
    try{
    		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
    		Class.forName("com.mysql.jdbc.Driver").newInstance();
    		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
    		String query = "SELECT FirstName, LastName, UserName, Email FROM T_CustomerRep";
    		ps = con.prepareStatement(query);
    		result = ps.executeQuery(query);
    		%>
    		<tr>
    	    <th>First Name</th>
    	    <th>Last Name</th>
    	    <th>User Name</th>
    	    <th>Email</th>
    	  	</tr>
    	  <% 
    		while(result.next())
    		{
    			%>
                <tr>
                 <td><%out.print(result.getString("FirstName"));%></td>
                 <td><%out.print(result.getString("LastName"));%></td>
                 <td><%out.print(result.getString("UserName"));%></td>
                 <td><%out.print(result.getString("Email"));%></td>
                </tr>
            <% 
    		}
    } catch(Exception ex){
    	
    	ex.printStackTrace();
    	out.print("Customer Rep Already Exist");
    	out.println("Reason: " + ex.getMessage());
    } finally {
        try { ps.close(); } catch (Exception e) { /* ignored */ }
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
    %>
</table>
</div>
   
<h1>Add new customer representatives.</h1>
	<form method="post" action= "Actions/CreateRep.jsp">
	    <div class="leftcontact">
	    	<div class="form-group">
	            <p>First Name<span>*</span></p>
	            <input type="text"  name="A_FirstName" id="A_FirstName" required/>
	        </div>
	        
	        <div class="form-group">
	            <p>Last Name<span>*</span></p>
	            <input type="text"  name="A_LastName" id="A_LastName" required/>
	        </div>
	        
	        <div class="form-group">
	            <p>User Name<span>*</span></p>
	            <input type="text"  name="A_UserName" id="A_UserName" required/>
	        </div>
	    </div>	
	    
	    <div class="rightcontact">
	    <div class="form-group">
	            <p>Email<span>*</span></p>
	            <input type="email"  name="A_Email" id="A_Email" required/>
	        </div>
	
			<div class="form-group">
	            <p>Password<span>*</span></p>
	            <input type="password"  name="A_Password1" id="A_Password1" required/>
	        </div>
	        
	        <div class="form-group">
	            <p>Re-Type Password"<span>*</span></p>
	            <input type="password"  name="A_Password2" id="A_Password2" required/>
	        </div>
	    </div>
	    
	    <button type="submit" class="bouton-contact">Create New</button>
	</form>
</body>
</html>