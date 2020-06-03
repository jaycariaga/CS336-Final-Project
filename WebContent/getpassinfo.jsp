<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Passenger Information</title>
	</head>
	<body>	
	<table border=1>
	<tr><th>First Name</th><th>Last Name</th></tr>
		<%
		    String transitline = request.getParameter("transitline");    
		   	int trainid = Integer.parseInt(request.getParameter("trainid"));
		    
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    String query = "select first_name, last_name from project.User where username in (select customer from project.Reservations where trainID = '" + trainid + "' && transit_line = '" + transitline + "');";
		    ResultSet ori = st.executeQuery(query);
		    out.println("<b>" + "Passenget Information" + "</b>" + "<br><br>");
		    while(ori.next())
		    {
		    	%>
		    	    <tr><td><%=ori.getString(1)%></td><td><%=ori.getString(2)%></td></tr>
		    	<%
		    } 
		%>
		</table>
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 