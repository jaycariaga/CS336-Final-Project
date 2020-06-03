<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>	
	<table border=1>
	<tr><th>Train ID</th><th>Arrival Time</th></tr>
		<%
		    String origin = request.getParameter("origin");    
		   	
		    
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    PreparedStatement originstationId = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    originstationId.setString(1, origin);
		    ResultSet rs = originstationId.executeQuery();
		    rs.next();
		    int originstationId1 = rs.getInt(1);
		    rs.close();
		    
		    String query = "Select trainID, arrival_time from project.stops_at_new where stationID = '" + originstationId1 + "';";
		    ResultSet ori = st.executeQuery(query);
		    out.println("<b>" + "Schedule for: " + origin + "</b>" + "<br><br>");
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