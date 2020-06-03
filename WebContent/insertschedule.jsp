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
		<%
		    String train = request.getParameter("trainid");   
		    String station = request.getParameter("stations");
		    String time = request.getParameter("time");
		   	String stops = request.getParameter("stops");
		   	int stop = Integer.parseInt(stops);
		   
		   	
		   	
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    PreparedStatement stationId = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    stationId.setString(1, station);
		    ResultSet rs = stationId.executeQuery();
		    rs.next();
		    int stationId1 = rs.getInt(1);
		   
		    
				    
	        String insert = "INSERT into project.stops_at_new values('" + train + "', '" + stationId1 + "', '" + stop + "', '" + time+ "', '0');";
	        st.executeUpdate(insert);
	        st.close();
		%>
		
		Train Schedule was added!<br>
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 