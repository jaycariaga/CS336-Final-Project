<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Update Schedule</title>
	</head>
	<body>	
		<%
		    String oldtrain = request.getParameter("oldtrainid");   
		 	String newtrain = request.getParameter("newtrainid");   
		    String oldstation = request.getParameter("oldstation");
		    String newstation = request.getParameter("newstation");
		    String oldtime = request.getParameter("oldtime");
		    String newtime = request.getParameter("newtime");
		    String newstops= request.getParameter("newstops");
			String oldstops = request.getParameter("oldstops");
			String delated = request.getParameter("delayed");
			int oldstop = Integer.parseInt(oldstops);
			int newstop = Integer.parseInt(newstops);
			int delayed = Integer.parseInt(delated);
			
		    
		    
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    PreparedStatement stationId = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    stationId.setString(1, oldstation);
		    ResultSet rs = stationId.executeQuery();
		    rs.next();
		    int oldstationId = rs.getInt(1);
		    
		    PreparedStatement stationId2 = con.prepareStatement("Select stationID from project.Station_new where name = ?");
		    stationId2.setString(1, newstation);
		    ResultSet rs1 = stationId2.executeQuery();
		    rs1.next();
		    int newstationId = rs1.getInt(1);
		   
		    try
		    {
		    	String update = "UPDATE project.stops_at_new SET trainID = '" + newtrain + "', stationID =  '" + newstationId + "', arrival_time = '" + newtime + "', stopsLeftTillDestination = '" + newstop + "', isDelayed = '" + delayed + "' WHERE trainID = '" + oldtrain + "'&& stationID = '" + oldstationId + "'&& arrival_time = '" + oldtime + "' && stopsLeftTillDestination = '" + oldstops + "';";
		        st.executeUpdate(update);
		        st.close();
		        out.println("Train Schedule was updated!");
		    }
	        catch (SQLException e)
		    {
	        	out.println("There was an error, please try again" + "<br>");
	        	out.println("Error: " + e.getMessage());
		    }
		%>
		
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 