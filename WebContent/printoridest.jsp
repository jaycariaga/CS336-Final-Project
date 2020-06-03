<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Get Info</title>
	</head>
	<body>	
	<table border=1>
	<tr><th>Train ID</th><th>Arrival Time</th></tr>
		<%
		    String origin = request.getParameter("origin");   
		 	String dest = request.getParameter("dest");   
		   	
		    
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    PreparedStatement originstationId = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    originstationId.setString(1, origin);
		    ResultSet rs = originstationId.executeQuery();
		    rs.next();
		    int originstationId1 = rs.getInt(1);
		    rs.close();
		    String oriid = Integer.toString(originstationId1);
		    
		    
		    PreparedStatement deststationId = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    deststationId.setString(1, dest);
		    ResultSet rs1 = deststationId.executeQuery();
		    rs1.next();
		    int deststationId1 = rs1.getInt(1);
		    rs1.close();
		    
		    String query = "Select trainID, arrival_time from project.stops_at_new where stationID = '" + originstationId1 + "';";
		    ResultSet ori = st.executeQuery(query);
		    out.println("<b>" + "Schedule for: " + origin + "</b>" + "<br><br>");
		    while(ori.next()){
		    	%>
		    	    <tr><td><%=ori.getString(1)%></td><td><%=ori.getString(2)%></td></tr>
		    	<%
		    	}%>
		    </table>
		    <br> <br> <br> <br>
		    <table border=1>
			<tr><th>Train ID</th><th>Arrival Time</th></tr>
			<% 
			ori.close();
			String query1 = "Select trainID, arrival_time from project.stops_at_new where stationID = '" + deststationId1 + "';";
		    ResultSet dest1 = st.executeQuery(query1);
		    out.println("<b>" + "Schedule for: " + dest + "</b>" + "<br><br>");
		    while(dest1.next()){
		    	%>
		    	    <tr><td><%=dest1.getString(1)%></td><td><%=dest1.getString(2)%></td></tr>
		    	<%
		    	}
		  
		%>
		</table>
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 