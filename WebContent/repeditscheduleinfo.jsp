<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Edit Train Schedule Information</title>
	</head>
	<body>
		<% 	
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>
		
		<a href = "custrephome.jsp">Home</a><br><br>
		
		<b>If you are not making a change to a certain category, you still need to select the option again.</b><br>
		
		<form action="scheduleupdate.jsp" method="POST">
		
			<br/>
			<br><br> Enter <b>OLD</b> train ID: <input type="text" name="oldtrainid"/>
			<br> <b>Train must already be in the database!</b>
			<br> Enter <b>NEW</b> train ID: <input type="text" name="newtrainid"/>
			<br> <b>Train must already be in the database!</b>
			<br><br> Enter <b>OLD</b> station name: <input type="text" name="oldstation"/>
			<br> <b>Station must already be in the database!</b>
			<br> Enter <b>NEW</b> station name: <input type="text" name="newstation"/>
			<br> <b>Station must already be in the database!</b>
      		<br><br> Enter <b>OLD</b> time train reaches the station: <input type="text" name="oldtime"/>
      		<br> Time Format = 00:00:00<br>
      		<br><br> Enter <b>NEW</b> time train reaches the station: <input type="text" name="newtime"/>
      		<br> Time Format = 00:00:00<br>
      		<br><br> Enter <b>OLD</b> stops left from last station: <input type="text" name="oldstops"/>
      		<br><br> Enter <b>NEW</b> stops left from last station: <input type="text" name="newstops"/>
      		<br><br> Is delayed?: <input type="text" name="delayed"/>
  			<br> 0 = No, 1 = Yes<br><br>
      	
      		<br> <br><input type="submit" value="Enter"/>
      			
     	</form>
				
   </body>
</html>