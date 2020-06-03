<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Train Schedule Information</title>
	</head>
	<body>
		<% // Account for unlogged users		
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>
		
		<a href = "custrephome.jsp">Home</a><br><br>
		<form action="insertschedule.jsp" method="POST">
		
			<br/>
			<br><br> Enter train ID: <input type="text" name="trainid"/>
			<br> <b>Train must already be in the database!</b>
			<br><br> Enter station name: <input type="text" name="stations"/>
			<br> <b>Station must already be in the database!</b>
      		<br><br> Enter time train reaches the station: <input type="text" name="time"/>
      		<br> Time Format = 00:00:00<br>
      		<br><br> Enter stops left from last station: <input type="text" name="stops"/>
   
      	
      		<br> <br><input type="submit" value="Enter"/>
      			
     	</form>
     
   </body>
</html>