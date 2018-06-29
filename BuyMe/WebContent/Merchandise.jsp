<!--Ritul Patel, Arthkumar Desai, Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<link rel = "stylesheet" href = "CSS/merchandiseCss.css">
<title>Merchandise</title>

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
	document.getElementById("clothesStartDate").setAttribute("min", _today);
	document.getElementById("clothesEndDate").setAttribute("min", _tomorrow);
}
function encodeImageFileAsURL(element) {
	  var file = element.files[0];
	  if(file.size > 1358263 ){
			alert("Image size is too big. Choose Image with size less than or equal to 1.29MB");
			document.getElementById("clothesPicture").value =  "";
		}
	  var reader = new FileReader();
	  reader.onloadend = function() {
	    document.getElementById("clothesPicture64").value = reader.result;
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
<h1>Seller Details</h1>
<form method="post" action= "clothesItem.jsp">
    <div class="leftcontact">
        <div class="form-group">
	    	<p>Product Name <span>*</span></p>
	        <input type="text"  required name="clothesProductName" id="clothesProductName" />
	    </div>
        
        <div class="form-group">
            <p>Brand<span>*</span></p>
            <input type="text" required name="clothesBrand" id="clothesBrand"  />
        </div>

        <div class="form-group">
            <p>Color <span>*</span></p>
            <input type="text" required name="clothesColor" id="clothesColor" />
        </div>
        
        <div class="form-group">
            <p>Size <span>*</span></p>
            <input type="text" required name="clothesSize" id="clothesSize"  />
        </div>
        
        <div class="form-group">
	            <p>Description <span>*</span></p>
	            <input  maxlength="255" type="text" required name="clothesDescription" id="clothesDescription"  />
	    </div>
	        
        <div class="form-group">
	            <p>Picture <span>*</span></p>
	            <input type="hidden" required name="clothesPicture64" id="clothesPicture64"  />
	            <input type="file" required onchange="encodeImageFileAsURL(this)"  name="clothesPicture" id="clothesPicture"  />
	    </div>
    </div>
    
    <div class="rightcontact">
        <div class="form-group">
            <p>Starting Bid Price <span>*</span></p>
            <input type="number"  min = "1" required name="clothesStartBid" id = "clothesStartBid" required />
        </div>

        <div class="form-group">
            <p>Start Date <span>*</span></p>
            <input type="date" required name="clothesStartDate" id="clothesStartDate" min="2018-04-04" required />
        </div>
        <div class="form-group">
            <p>End Date <span>*</span></p>
            <input type="date" required name="clothesEndDate" id="clothesEndDate" min="2018-04-04" data-rule="maxlen:10"/>
        </div>

        <div class="form-group">
            <p>Reserve Price  <span>*</span></p>
            <input type="number" required="0 TO NOT SET OR PLACE MORE THAN 0 TO SET RESERVE PRICE"  min = "0" name="clothesReservePrice" id="clothesReservePrice"  />
        </div>

        <div class="form-group">
            <p>Buy Now Price<span>*</span></p>
            <input type="number" min = "1" required name="clothesBuyNow" id="clothesBuyNow"  />
        </div>
	    </div>
    <button  type="submit" class="bouton-contact">Post Auction</button>
</form>
</body>
</html>