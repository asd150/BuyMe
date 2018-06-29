<!-- HAVAN PATEL, RITUL PATEL; -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "CSS/buynow.css">
<link rel = "stylesheet" href = "Ratings/rating.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BUY</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    // Check Radio-box
    $(".rating input:radio").attr("checked", false);

    $('.rating input').click(function () {
        $(".rating span").removeClass('checked');
        $(this).parent().addClass('checked');
    });

    $('input:radio').change(
      function(){
        var userRating = this.value;
        document.getElementsByName("rating").value = userRating;
    }); 
});
</script>
</head>
<body>
<%
Connection con = null;

ResultSet clothes_result = null;
ResultSet electronics_result = null;
ResultSet currentBidResult = null;
ResultSet product_result = null;
Statement clothes_stmt = null, electronics_stmt  = null, stmt4 = null;
double currentBid = 0;

try {
	String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
	
	String PIDs = request.getParameter("itemId");
	int PID = Integer.parseInt(PIDs);
	
	
	String product_query = "SELECT * FROM T_Product WHERE PID = "+PID;
	Statement product_stmt = con.createStatement();
	product_result = product_stmt.executeQuery(product_query);
	
	
	String photo = null;
	String clothes_query = "SELECT * FROM T_Clothes WHERE PID = "+PID;
	clothes_stmt = con.createStatement();
	clothes_result = clothes_stmt.executeQuery(clothes_query);
	
	String electronics_query = "SELECT * FROM T_Electronics WHERE PID ="+PID;
	electronics_stmt = con.createStatement();
	electronics_result = electronics_stmt.executeQuery(electronics_query);
	
	String currentBidQuery = "SELECT Max(Amount) as CurrentBid FROM T_Bids WHERE PID = '"+PID+"'";
	stmt4 = con.createStatement();
	currentBidResult = stmt4.executeQuery(currentBidQuery);
	
	if(currentBidResult.next()){
		currentBid = currentBidResult.getFloat("CurrentBid");
	} 
	
	if(product_result.next()){
		photo = product_result.getString("Photo");
		session.setAttribute("ReservePrice", product_result.getFloat("ReservePrice"));
		if(currentBid == 0){
			currentBid = product_result.getFloat("StartBid");
		}
	}
%>

    <ul class="uls">
    	<li class="active1"><a class="active" href="welcome.jsp"> Home</a></li>
    	<li class="active1"><a class="active" href="javascript:history.back()" > Go Back</a></li>
        <li class="active1"><a class="active" href="#about">About</a></li>
    </ul>
<h1>Buyer Details.</h1>


<%	if(clothes_result.next()){ 
	if(clothes_result.getInt("PID") == product_result.getInt("PID")){ %>
<form method="post" action= "bidding.jsp?PIDS=<%out.print(PID);%>">
<ul class="product_gallery">
	<li class="Pants_product">
		<img src="<%=photo%>" />
	</li>
</ul>
    <div class="leftcontact">
        <div class="form-group">
        	<div class="form-group">
	            <p>Description</p>
	            <textarea rows="100" cols="50" readonly>
ProductName:- <%out.print(product_result.getString("ProductName"));%>
Brand:- <%out.print(clothes_result.getString("Brand"));%>
Size:- <%out.print(clothes_result.getString("Size"));%>
Color:- <%out.print(clothes_result.getString("Color"));%>
Description:- <%out.print(product_result.getString("Description"));%>
				</textarea>
	        </div>
	        <p>Buy Now<span>*</span></p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(Float.parseFloat(product_result.getString("BuyNow")));%>$" data-rule="maxlen:10" readonly/>
            
            <p>Starting Bid Price<span>*</span></p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(Float.parseFloat(product_result.getString("StartBid")));%>$" data-rule="maxlen:10" readonly/>
        </div>

        <div class="form-group">
            <p>Current Bid Amount<span>*</span></p>
            <input type="text" required name="CurrentBid" id="CurrentBid" value="<%out.print(currentBid); %>$" data-rule="required" readonly/>
        </div>
        <p>Rate Product<span>*</span></p>
        <div class="rating">
		    <span><input type="radio" name="rating" id="str5" value="5"><label for="str5"></label></span>
		    <span><input type="radio" name="rating" id="str4" value="4"><label for="str4"></label></span>
		    <span><input type="radio" name="rating" id="str3" value="3"><label for="str3"></label></span>
		    <span><input type="radio" name="rating" id="str2" value="2"><label for="str2"></label></span>
		    <span><input type="radio" name="rating" id="str1" value="1"><label for="str1"></label></span>
		</div>
    </div>
    
    <div class="rightcontact">

        <div class="form-group">
            <p>Start Date</p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(product_result.getString("StartDate"));%>" data-rule="maxlen:10" readonly/>
        </div>
        <div class="form-group">
            <p>End Date</p>
            <input type="text" name="EndDate" id="EndDate" value="<%out.print(product_result.getString("EndDate"));%>" data-rule="maxlen:10" readonly/>
        </div>
        <div class="form-group">
            <p>Enter Bid Amount <span>*</span></p>
            <input type="number" required name="EnterBidAmount" id="EnterBidAmount" min="<%out.print(currentBid + 1); %>"/>
        </div>
        
        <div class="form-group">
	            <p>Auto Bid Max Amount</p>
	            <input type="number" name="AutoMaxBid" id="AutoMaxBid" min = "0"/>
	    </div>
	    </div>
    <button  type="submit" class="bouton-contact">Post Bid</button>
</form>
<div>
<form method="post" action= "bidding2.jsp?PIDS=<%out.print(PID);%>">
<button  type="submit" class="bouton-contact2" >BuyNow</button>
</form>
</div>
<%
	} 
}
if(electronics_result.next()){
	if(electronics_result.getInt("PID") == product_result.getInt("PID")){ %>
<form method="post" action= "bidding.jsp?PIDS=<%out.print(PID);%>">
<ul class="product_gallery">
	<li class="Pants_product">
		<img src="<%=photo%>" />
	</li>
</ul>
    <div class="leftcontact">
        <div class="form-group">
        	<div class="form-group">
	            <p>Description</p>
	            <textarea rows="4" cols="50" readonly>
ProductName&emsp;&emsp;:- <%out.print(product_result.getString("ProductName"));%>
Brand&emsp;&emsp;:- <%out.print(electronics_result.getString("Brand"));%>
Model&emsp;&emsp;- <%out.print(electronics_result.getString("Model"));%>
Color&emsp;&emsp;:- <%out.print(electronics_result.getString("Color"));%>
Description&emsp;&emsp;:- <%out.print(product_result.getString("Description"));%>
				</textarea>
	        </div>
            <p>Buy Now<span>*</span></p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(Float.parseFloat(product_result.getString("BuyNow")));%>$" data-rule="maxlen:10" readonly/>
            
            <p>Starting Bid Price<span>*</span></p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(Float.parseFloat(product_result.getString("StartBid")));%>$" data-rule="maxlen:10" readonly/>
        </div>

        <div class="form-group">
            <p>Current Bid Amount<span>*</span></p>
            <input type="text" required name="CurrentBid" id="CurrentBid" value="<%out.print(currentBid); %>$" data-rule="required" readonly/>
        </div>
        	<p>Rate Product<span>*</span></p>
        <div class="rating">
		    <span><input type="radio" name="rating" id="str5" value="5"><label for="str5"></label></span>
		    <span><input type="radio" name="rating" id="str4" value="4"><label for="str4"></label></span>
		    <span><input type="radio" name="rating" id="str3" value="3"><label for="str3"></label></span>
		    <span><input type="radio" name="rating" id="str2" value="2"><label for="str2"></label></span>
		    <span><input type="radio" name="rating" id="str1" value="1"><label for="str1"></label></span>
		</div>
    </div>
    
    <div class="rightcontact">

        <div class="form-group">
            <p>Start Date</p>
            <input type="text" name="StartDate" id="StartDate" value="<%out.print(product_result.getString("StartDate"));%>" data-rule="maxlen:10" readonly/>
        </div>
        <div class="form-group">
            <p>End Date</p>
            <input type="text" name="EndDate" id="EndDate" value="<%out.print(product_result.getString("EndDate"));%>" data-rule="maxlen:10" readonly/>
        </div>
        <div class="form-group">
            <p>Enter Bid Amount <span>*</span></p>
            <input type="number" required name="EnterBidAmount" id="EnterBidAmount" min="<%out.print(currentBid + 1); %>" />
        </div>
        
        <div class="form-group">
	            <p>Auto Bid Max Amount</p>
	            <input type="number" name="AutoMaxBid" id="AutoMaxBid" min="0"/>
	    </div>
	    </div>
    <button id = "postBid"  type="submit" class="bouton-contact" >Post Bid</button>
</form>
<form method="post" action= "bidding2.jsp?PIDS=<%out.print(PID);%>">
<button  type="submit" class="bouton-contact2" >BuyNow</button>
</form>
<%
	}
}
%>
<%
} catch (Exception ex) {
	out.print("ERROR" + "<br>");
	out.println("Reason " + ex.getMessage());
	ex.printStackTrace();
} finally {
	try { clothes_stmt.close(); } catch (Exception e) { /* ignored */ }
    try { electronics_stmt.close(); } catch (Exception e) { /* ignored */ }
    try { stmt4.close(); } catch (Exception e) { /* ignored */ }
    try { product_result.close(); } catch (Exception e) { /* ignored */ }
    try { clothes_result.close(); } catch (Exception e) { /* ignored */ }
    try { electronics_result.close(); } catch (Exception e) { /* ignored */ }
    try { currentBidResult.close(); } catch (Exception e) { /* ignored */ }
    try { con.close(); } catch (Exception e) { /* ignored */ }
}
%>
</body>
</html>