<!-- HAVAN PATEL-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel = "stylesheet" href = "CSS/buyerCss.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="CSS/looking.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$(".ALL").click(function() {
			$(".product_gallery>li").hide();
			$(".product_gallery>li").fadeIn("slow");
		});
		$(".Shirt").click(function() {
			$(".product_gallery>li").hide();
			$(".Shirt_product").fadeIn("slow");
		});
		$(".T-Shirt").click(function() {
			$(".product_gallery>li").hide();
			$(".T-Shirt_product").fadeIn("slow");
		});
		$(".Pants").click(function() {
			$(".product_gallery>li").hide();
			$(".Pants_product").fadeIn("slow");
		});
		$(".TV").click(function() {
			$(".product_gallery>li").hide();
			$(".TV_product").fadeIn("slow");
		});
		$(".Cellphone").click(function() {
			$(".product_gallery>li").hide();
			$(".Cellphone_product").fadeIn("slow");
		});
		$(".Computer").click(function() {
			$(".product_gallery>li").hide();
			$(".Computer_product").fadeIn("slow");
		});
	});
</script>
</head>
<body>
<%
Connection con = null;

ResultSet result = null;
ResultSet product_result = null;
ResultSet clothes_result = null;
ResultSet electronic_result = null;

try {
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
	
	int product_pid = -1;
	String UserName = session.getAttribute("UserName").toString();
	String user_query = "SELECT UserName FROM T_Buyer WHERE UserName = '"+UserName+"'";
	Statement stmt = con.createStatement();
	result = stmt.executeQuery(user_query );
	
	
	String product_query = "SELECT * FROM T_Product WHERE IsActive AND EndDate >= current_date()";
	Statement stmt1 = con.createStatement();
	product_result = stmt1.executeQuery(product_query);
	if(result.next()){

	} else {
		out.print("username not found");
	}	
	
%>
<div class="topnav">
<!--  CLOSE CONNECTION I CLICK HOME -->
  <a class="active" href="welcome.jsp"> Home</a>
  <a href="#ALL" class="ALL">ALL</a>
  <a href="#Shirt" class="Shirt">Shirts</a>
  <a href="#T-Shirt" class="T-Shirt">T-Shirt</a>
  <a href="#Pants" class="Pants">Pants</a>
  <a href="#TV" class="TV">TV</a>
  <a href="#Cellphone" class="Cellphone">Cellphone</a>
  <a href="#Computer" class="Computer">Computer</a>
  <a href="#about">About</a>
  <div class="search-container">
    <form action="/action_page.php">
      <input type="text" id = "myInput" onkeyup="myFunction()" placeholder="Search Anything: product name or price..." name="search">
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>
</div>
<div style="padding-left:16px">
</div>


<ul id = "product_gallery" class="product_gallery">
<%
while(product_result.next()){
	
	product_pid = product_result.getInt("PID");
	
	String clothes_query = "SELECT * FROM T_Clothes WHERE PID = '"+product_pid+"'";
	Statement stmt2 = con.createStatement();
	clothes_result = stmt2.executeQuery(clothes_query);
	
	String electronic_query = "SELECT * FROM T_Electronics WHERE PID = '"+product_pid+"'";
	Statement stmt3 = con.createStatement();
	electronic_result = stmt3.executeQuery(electronic_query);
	
	
	if(clothes_result.next()){
		if(product_pid == clothes_result.getInt("PID")){
			if(clothes_result.getBoolean("Shirt") == true){
				String photo = product_result.getString("Photo");
%>
				<li class="Shirt_product">
				<img src="<%=photo%>" />
				<div id = "product_information" class="product_information">
					<h4> <%out.print(product_result.getString("ProductName"));%></h4>
					<span><%out.print(product_result.getFloat("BuyNow"));%></span>
				</div>
				<div class="product_description">
					<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
					<a href="buynow.jsp?itemId=<%out.print(clothes_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
				</div>
				</li>
<%
		}
			if(clothes_result.getBoolean("T_Shirt") == true){
				String photo = product_result.getString("Photo");
%>
					<li class="T-Shirt_product">
					<img src="<%=photo%>" />
					<div id = "product_information" class="product_information">
						<h4> <%out.print(product_result.getString("ProductName"));%></h4>
						<span><%out.print(product_result.getFloat("BuyNow"));%></span>
					</div>
					<div class="product_description">
						<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
						<a href="buynow.jsp?itemId=<%out.print(clothes_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
					</div>
					</li>
	<%
		}
			if(clothes_result.getBoolean("Pants") == true){
				String photo = product_result.getString("Photo");
				%>
								<li class="Pants_product">
								<img src="<%=photo%>" />
								<div id = "product_information" class="product_information">
									<h4> <%out.print(product_result.getString("ProductName"));%></h4>
									<span><%out.print(product_result.getFloat("BuyNow"));%></span>
								</div>
								<div class="product_description">
									<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
										<a href="buynow.jsp?itemId=<%out.print(clothes_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
								</div>
								<script type="text/javascript">
									
								</script>
								</li>
				<%
		}
	}
}
	if(electronic_result.next()){
		if(product_pid == electronic_result.getInt("PID")){
			if(electronic_result.getBoolean("TV") == true){
			String photo = product_result.getString("Photo");
%>
			<li class="TV_product">
			<img src="<%=photo%>" />
			<div id = "product_information" class="product_information">
				<h4> <%out.print(product_result.getString("ProductName"));%></h4>
				<span><%out.print(product_result.getFloat("BuyNow"));%></span>
			</div>
			<div class="product_description">
				<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
				<a href="buynow.jsp?itemId=<%out.print(electronic_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
			</div>
		</li>
<%
			}
			if(electronic_result.getBoolean("Cellphone") == true){
			String photo = product_result.getString("Photo");
	%>
				<li class="Cellphone_product">
				<img src="<%=photo%>" />
				<div id = "product_information" class="product_information">
					<h4> <%out.print(product_result.getString("ProductName"));%></h4>
					<span><%out.print(product_result.getFloat("BuyNow"));%></span>
				</div>
				<div class="product_description">
					<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
					<a href="buynow.jsp?itemId=<%out.print(electronic_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
				</div>
			</li>
	<%
				}
			if(electronic_result.getBoolean("Computer") == true){
				String photo = product_result.getString("Photo");
	%>
				<li class="Computer_product">
				<img src="<%=photo%>" />
				<div id = "product_information" class="product_information">
					<h4> <%out.print(product_result.getString("ProductName"));%></h4>
					<span><%out.print(product_result.getFloat("BuyNow"));%></span>
				</div>
				<div class="product_description">
					<p class="overflow-text"><% out.print(product_result.getString("Description"));%></p>
					<a href="buynow.jsp?itemId=<%out.print(electronic_result.getInt("PID"));%>" class="buy_now">Post Bid</a>
				</div>
			</li>
	<%
			}
		}
	}
}
%>
</ul>
<%
	} catch (Exception ex) {
		out.print("ERROR" + "<br>");
		out.println("Reason " + ex.getMessage());
		ex.printStackTrace();
	} finally {
        try { result.close(); } catch (Exception e) { /* ignored */ }
        try { electronic_result.close(); } catch (Exception e) { /* ignored */ }
        try { clothes_result.close(); } catch (Exception e) { /* ignored */ }
        try { product_result.close(); } catch (Exception e) { /* ignored */ }
        try { con.close(); } catch (Exception e) { /* ignored */ }
    }
%>
<script>
function myFunction() {
  var input, filter, table, tr, td, i, j, table1, tr1, td1;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("product_gallery");
  tr = table.getElementsByTagName("li");
  
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("div");
    for(j=0 ; j<td.length ; j++)
    {
      let tdata = td[j] ;
      if (tdata) {
        if (tdata.innerHTML.toUpperCase().indexOf(filter) > -1) {
          tr[i].style.display = "";
          break ; 
        } else {
          tr[i].style.display = "none";
        }
      } 
    }
  }
}
</script>
</body>
</html>