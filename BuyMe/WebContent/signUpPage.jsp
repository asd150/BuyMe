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
PreparedStatement ps = null;
try{
ResultSet result = null;
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
	
	Statement stmt = con.createStatement();
	String str = "SELECT COUNT(*) as cnt FROM T_Account";
	result = stmt.executeQuery(str);
	result.next();
	int countAccount = result.getInt("cnt");
	
	boolean valid = true;
	boolean passValid = true;
	//Get parameters from the HTML form at the SignUp.jsp
	String FirstName = request.getParameter("SignUp_FirstName");
	String LastName = request.getParameter("SignUp_LastName");
	String UserName = request.getParameter("SignUp_UserName");
	String Email = request.getParameter("SignUp_Email");
	String Password1 = request.getParameter("SignUp_Password1");
	String Password2 = request.getParameter("SignUp_Password2");
	
	//check if fileds are empty
	if(FirstName.equals("") || LastName.equals("") || Password1.equals("") || Password2.equals("") || Email.equals("")) {
		valid = false;
	} 
	if(!(Password1.equals(Password2))){
		passValid = false;
	}
	
	if(valid && passValid){
		String insert = "INSERT INTO T_Account(FirstName,LastName,UserName,Email, Password1,Password2,EndUser, Admin, CustomerRep)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);
		//Run the query against the DB
		ps.setString(1, FirstName);
		ps.setString(2, LastName);
		ps.setString(3, UserName);
		ps.setString(4, Email);
		ps.setString(5, Password1);
		ps.setString(6, Password2);
		ps.setBoolean(7, true);
		ps.setBoolean(8, false);
		ps.setBoolean(9, false);
		
		ps.executeUpdate();
		
		//Check counts once again (the same as the above)
		str = "SELECT COUNT(*) as cnt FROM T_Account";
		result = stmt.executeQuery(str);
		result.next();
		int countAccountN = result.getInt("cnt");
		
		String insertInEndUser = "INSERT INTO T_EndUser (FirstName, LastName, UserName, Email)"
				+ "VALUES (?, ?, ?, ?)";
		PreparedStatement psEndUser = con.prepareStatement(insertInEndUser);
		//Run the query against the DB
		psEndUser.setString(1, FirstName);
		psEndUser.setString(2, LastName);
		psEndUser.setString(3, UserName);
		psEndUser.setString(4, Email);
		
		psEndUser.executeUpdate();
		
		int updateAccount = (countAccount != countAccountN) ? 1 : 0;
		if(updateAccount > 0){
			stmt.close();
			result.close(); 
			out.print("Account Created Successfully");
			out.print("<br>Click The Login Button To Go Back To Login Page AND Login <br>"+"<form method=\"post\" action=\"index.jsp\">"
					+ "<input type=\"submit\" name=\"loggedIn\" value=\"Login\"> <br>");
		}else{
			out.print("Account Already Exist");
		}

	}else{
		if(passValid == false){
			out.print("Insert Failed. <br> Password Doesn't Match. <br> Go Back And Signup Again");
		}else{
			out.print("Insert Failed. <br> Fill In All Fields. <br> Go Back And Signup Again");
	
		}
	}
		
}catch(Exception ex) {
	out.print("<br> Username Is Already Taken. <br> Enter Unique Username");
}finally {
    try { ps.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}
%>
</body>
</html>