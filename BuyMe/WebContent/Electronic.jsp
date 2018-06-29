<!--Ritul Patel, Arthkumar Desai, Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "CSS/electronicCss.css">
<title>Electronic</title>

<script>
function SetMaxMinDate() {
	var today = new Date();
	var tomorrow = new Date();
	tomorrow.setDate(today.getDate() + 1);
	
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	 if(dd<10){
	        dd='0'+dd
	    } 
	    if(mm<10){
	        mm='0'+mm
	    } 
	    
	var _dd = tomorrow.getDate();
	var _mm = tomorrow.getMonth()+1; //January is 0!
	var _yyyy = tomorrow.getFullYear();
	if(_dd<10){
		_dd='0'+_dd
    }
	if(_mm<10){
		_mm='0'+_mm
    } 
	var _today = yyyy+'-'+mm+'-'+dd;
	var _tomorrow = _yyyy+'-'+_mm+'-'+_dd;
	document.getElementById("StartDate").setAttribute("min", _today);
	document.getElementById("EndDate").setAttribute("min", _tomorrow);
}
function encodeImageFileAsURL(element) {
	  var file = element.files[0];
	  console.info(file.size);
	  if(file.size > 1358263 ){
			alert("Image size is too big. Choose Image with size less than or equal to 1.29MB");
			document.getElementById("Picture").value =  "";
		}
	  var reader = new FileReader();
	  reader.onloadend = function() {
	    document.getElementById("Picture64").value = reader.result;
	  }
	  reader.readAsDataURL(file);
	}
</script>

</head>
<body onload="SetMaxMinDate()">
    <ul>
    	<li><a class="active" href="welcome.jsp"> Home</a></li>
    	<li><a class="active" href="javascript:history.back()" > Go Back</a></li>
        <li><a href="#about">About</a></li>
    </ul>    
<h1>Seller Details.</h1>
	<form method="post" action= "electronicsItem.jsp">
	    <div class="leftcontact">
	       <div class="form-group">
	            <p>Product Name <span>*</span></p>
	            <input type="text"  name="ProductName" id="ProductName" required />
	        </div>
	        
	        <div class="form-group">
	            <p>Brand<span>*</span></p>
	            <input type="text"  name="Brand" id="Brand" required  />
	        </div>
	
	        <div class="form-group">
	            <p>Color <span>*</span></p>
	            <input type="text"  name="Color" id="Color" required  />
	        </div>
	
	        <div class="form-group">
	            <p>Model <span>*</span></p>
	            <input type="text" name="Model" id="Model"  required  />
	        </div>
			
			<div class="form-group">
	            <p>Description <span>*</span></p>
	            <input  maxlength="255" type="text"  name="Description" id="Description" required  />
	        </div>
	        
	        <div class="form-group">
	            <p>Picture <span>*</span></p>
	            <input type="hidden"  name="Picture64" id="Picture64" required  />
	            <input type="file" onchange="encodeImageFileAsURL(this)" required name="Picture" id="Picture"  />
	        </div> 
	    
	    </div>
	    
	    <div class="rightcontact">
	    	<div class="form-group">
            	<p>Starting Bid Price<span>*</span></p>
            	<input type="number"  min = "1" name="StartBid" id="StartBid" required  />
	        </div>
	
	        <div class="form-group">
	            <p>Start Date <span>*</span></p>
	            <input type="date" name="StartDate" id="StartDate" min="2018-04-04" required data-rule="maxlen:10" />
	        </div>
	        <div class="form-group">
	            <p>End Date <span>*</span></p>
	            <input type="date"  name="EndDate" id="EndDate" min="2018-04-04" required data-rule="maxlen:10"/>
	        </div>
	
	        <div class="form-group">
	            <p>Reserve Price  <span>*</span></p>
	            <input type="number"  min = "0" name="ReservePrice" id="ReservePrice" required="0 TO NOT SET OR PLACE MORE THAN 0 TO SET RESERVE PRICE"  />
	        </div>
	
	        <div class="form-group">
	            <p>Buy Now Price<span>*</span></p>
	            <input type="number"  min = "1" name="BuyNow" id="BuyNow" required  />
	        </div>
	    </div>
	    <button  type="submit" class="bouton-contact">Post Auction</button>
	</form>
</body>
</html>