<!-- Havan Patel -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Electrics Item</title>
</head>
<body>
<%
try{
		String connectionUrl = "jdbc:mysql://cs336-spr18.ccfyyi3lze0j.us-east-2.rds.amazonaws.com:3306/BuyMe";
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(connectionUrl, "hp397", "Excited2eatpizzas"); 
		
		PreparedStatement ps = null, Electronics = null;
		System.out.println("");
		
		float StartBid = Float.parseFloat(request.getParameter("StartBid"));
		float ReservePrice = Float.parseFloat(request.getParameter("ReservePrice"));
		String Photo64 = request.getParameter("Picture64");
		String StartDate = request.getParameter("StartDate");		
		String EndDate = request.getParameter("EndDate");
		
		String ProductName = request.getParameter("ProductName");
		String Description = request.getParameter("Description");
		float BuyNow = Float.parseFloat(request.getParameter("BuyNow"));
		
		String Brand = request.getParameter("Brand");
		String Color = request.getParameter("Color");
		String Model = request.getParameter("Model");
		
		
		Boolean isTv = false;
		Boolean isComputer = false;
		Boolean isCellphone = false;
		
		String path = request.getHeader("referer");
		if(path.contains("TV")){
			isTv = true;
		}
		if(path.contains("Cellphone")){
			isCellphone = true;
		}
		if(path.contains("Computer")){
			isComputer = true;
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
			ps = con.prepareStatement(insert);
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
			ps.close();
			
			String query = "SELECT PID FROM T_Product WHERE BuyNow = '"+BuyNow+"' AND StartBid = '"+StartBid+"' AND ReservePrice = '"+ReservePrice+"' AND StartDate = '"+StartDate+"' AND EndDate = '"+EndDate+"'  AND ProductName = '"+ProductName+"'AND Description = '"+Description+"'";
			Statement stmt1 = con.createStatement();
			ResultSet result1 = stmt1.executeQuery(query);
			int PIDfromProduct = -1;
			if(result1.next()){
				PIDfromProduct = result1.getInt("PID");
			}
					String insertInElectronics = "INSERT INTO T_Electronics(PID, Brand, Model, Color, TV, Cellphone, Computer)"
							+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
					Electronics = con.prepareStatement(insertInElectronics);
					Electronics.setInt(1, PIDfromProduct);
					Electronics.setString(2, Brand);
					Electronics.setString(3, Model);
					Electronics.setString(4, Color);
					Electronics.setBoolean(5, isTv);
					Electronics.setBoolean(6, isCellphone);
					Electronics.setBoolean(7, isComputer);
					Electronics.executeUpdate();	
					
					
					Electronics.close();
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