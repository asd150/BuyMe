<!--Arthkumar Desai, Havan Patel -->
<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel = "stylesheet" href = "../FAQ/FAQs.css">
<link rel = "stylesheet" href = "../../CSS/buyerCss.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Ask Questions</title>
</head>
<body>
    
    <div class="topnav">
<!--  CLOSE CONNECTION I CLICK HOME -->
	<a class="active" href="../../welcome.jsp"> Home</a>
	<a href="#about">About</a>
  <div class="search-container">
    <form action="/action_page.php">
      <input type="text" id = "myInput" onkeyup="myFunction()" placeholder="Search.." name="search">
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>
</div>
    <br>
    
  <div class="row" style="background-color:#fffa; width: 50%;">
    <h2>Enter Question</h2>
    <form method="post" action="Act/sendQ.jsp">
    <textarea  maxlength="255" rows="5" cols="83" style="resize: none;" name = "Question" placeholder="HERE YOU CAN ASK CUSTOMER REPRESENTATIVE TO REMOVE BIDS OR PASSWORD OR AUCTION AND YOU WILL SEE THEIR ANSWER BELOW ONCE THEY REPLY BACK ******THIS IS PRIVATE TALK TO CUSTOMER REP****** FAQs TAB IS PUBLIC SO ANYONE CAN SEE YOUR QUESTION AND ANSWERS" ></textarea>
  	<input type = "submit" style="float: right; height: 30px;" name = "Send" value = "Send">
  	</form>
  </div>
	<p style="font-size:50px; color:blue;">QA List From Users</p>
<% 
Connection con = null;
Statement stmt = null;
ResultSet result = null; 
try{
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas");
	
		String UserName  = session.getAttribute("UserName").toString();
		String userQuery = "SELECT * FROM T_QAPage WHERE UserName = '"+UserName+"'";
  		stmt = con.createStatement();
  		result = stmt.executeQuery(userQuery);
  		String Answers = null;
%>  
	<table id="myTable"   width: "100%">
		<tr class="header">
		    <th>Question</th>
		    <th>Answer</th>
		</tr>		
<%
  		while(result.next()){
  			if(result.getString("UserName").equals(UserName)){
	  			if(result.getString("Answer") == null){
	  				Answers = "";
	  			}else{
	  				Answers = result.getString("Answer");
	  			}
	%>				
			  <tr>
			    <td style="width:50%;"><%out.print(result.getString("Question"));%></td>
			    <td style="width:50%;"><%out.print(Answers);%></td>
			  </tr>
	<%
  		}
	}
%>
	</table>
<%
} catch(Exception ex){
	ex.printStackTrace();
	out.print("Error Sending Question");
	out.println("Reason: " + ex.getMessage());
} finally {
    try { stmt.close(); } catch (Exception e) { /* ignored */ }
    try { result.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}
%>
<script>
function myFunction() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>
</body>
</html>