<!-- Arthkumar Desai-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		
		session.invalidate();
		request.getSession().invalidate();
	    response.sendRedirect("index.jsp");
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
</body>
</html>