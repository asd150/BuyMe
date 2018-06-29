<!-- HAVAN PATEL-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Clothes Item</title>
</head>
<body>
<%
try{
		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 

		float StartBid = Float.parseFloat(request.getParameter("clothesStartBid"));
		float ReservePrice = Float.parseFloat(request.getParameter("clothesReservePrice"));

		String Photo64 = request.getParameter("clothesPicture64");
		String StartDate = request.getParameter("clothesStartDate");		
		String EndDate = request.getParameter("clothesEndDate");
		String ProductName = request.getParameter("clothesProductName");
		String Description = request.getParameter("clothesDescription");
		float BuyNow = Float.parseFloat(request.getParameter("clothesBuyNow"));
		
		String Brand = request.getParameter("clothesBrand");
		String Color = request.getParameter("clothesColor");
		String Size = request.getParameter("clothesSize");
			
		Boolean isPants = false;
		Boolean isShirt = false;
		Boolean isTShirt = false;
		
		String path = request.getHeader("referer");
		if(path.contains("Pants")){
			isPants = true;
		}
		if(path.contains("sharts")){
			isShirt = true;
		}
		if(path.contains("T_Shirt")){
			isTShirt = true;
		}
		
		if(ReservePrice >= BuyNow ){
			out.println("Reserve Price Must Be Less Than Buy Now Price");
		}else if(StartBid >= ReservePrice && ReservePrice > 0){
			out.println("Start Bid Price Must Be Less Than Reserve Price");
		}else if(StartBid >= BuyNow){
			out.println("Start Bid Price Must Be Less Than Buy Now Price");
		}
		else{
		
		
		String insert = "INSERT INTO T_Product(StartBid, ReservePrice, Photo, StartDate, EndDate, ProductName, Description, BuyNow, UserName)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setFloat(1, StartBid);
		ps.setFloat(2, ReservePrice);
		ps.setString(3, Photo64);	
		ps.setString(4, StartDate);
		ps.setString(5, EndDate);
		ps.setString(6, ProductName);
		ps.setString(7, Description);
		ps.setFloat(8, BuyNow);
		ps.setString(9, session.getAttribute("UserName").toString());
		ps.executeUpdate();
		
		String query = "SELECT PID FROM T_Product WHERE BuyNow = '"+BuyNow+"' AND StartBid = '"+StartBid+"' AND ReservePrice = '"+ReservePrice+"' AND Photo = '"+Photo64+"' AND StartDate = '"+StartDate+"' AND EndDate = '"+EndDate+"'  AND ProductName = '"+ProductName+"'AND Description = '"+Description+"'";
		Statement stmt1 = con.createStatement();
		ResultSet result1 = stmt1.executeQuery(query);
		int PIDfromProduct = -1;
		if(result1.next()){
			PIDfromProduct = result1.getInt("PID");
		}
		String insertInClothings = "INSERT INTO T_Clothes (PID, Brand, Size, Color, Pants, Shirt, T_Shirt)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement Clothings = con.prepareStatement(insertInClothings);
		Clothings.setInt(1, PIDfromProduct);
		Clothings.setString(2, Brand);
		Clothings.setString(3, Size);
		Clothings.setString(4, Color);
		Clothings.setBoolean(5, isPants);
		Clothings.setBoolean(6, isShirt);
		Clothings.setBoolean(7, isTShirt);
		Clothings.executeUpdate();			
		
		Clothings.close();
		ps.close();
		con.close();
		result1.close();
		stmt1.close();
		response.sendRedirect("welcome.jsp");
	}
} catch(Exception ex){
	out.println("Reason: " + ex.getMessage());
	ex.printStackTrace();
}
%>
</body>
</html>