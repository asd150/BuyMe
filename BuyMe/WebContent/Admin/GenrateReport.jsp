<!-- Ritul Patel-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel = "stylesheet" href = "report.css">
<title>Report Category</title>
</head>
<body>
    <ul>
    	<li><a class="active" href="admin.jsp"> Home</a></li>
    	<li><a class="active" href="javascript:history.back()" > Go Back</a></li>
    </ul>
    <br>

	<h1	align="center">Report Selection</h1>

	<form method="post" action="Actions/report.jsp">
	    <div align = "center">
	    	<div class="form-group">
		   			 <p >Total Earnings</p>
				<div>
					<input type="checkbox" name="TotalEarnings" value="Earning"/>Earning
				</div>
					<p >Earnings Per:</p>
				<div>
					<input type="checkbox" name="EarningsPer" value="Items" /> Items
			  		<input type="checkbox" name="EarningsPer" value="ItemsType" /> Items Type
			  		<input type="checkbox" name="EarningsPer" value="EndUser" /> End-User
				</div>
					<p >Best Selling Items:</p>
				<div>
					<input type="checkbox" name="BestSellingItems" value="BestBuyer" /> Best Buyer
				</div>
			    <button type="submit" class="bouton-contact">Generate Report</button>
	        </div>
	    </div>	
	</form>
</body>
</html>