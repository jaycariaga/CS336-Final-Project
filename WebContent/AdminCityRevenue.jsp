<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin City Revenue</title>
</head>
<body>
<% 
	String admin = (String) session.getAttribute("username");
	if(!admin.contains("admin")){
		response.sendRedirect("login.jsp");
	}
	String first_name = (String) request.getParameter("first_name");
	String last_name = (String) request.getParameter("last_name");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	String current = "Current";
	String query = "Select * from project.Reservations where status ='" + current + "' group by destinationStationID;";
	rs = st.executeQuery(query);
%>
		<h2>Revenue by Destination City</h2>
<table>
<tr>
				<th>Index</th> 
				<th>Destination City</th>    
				<th>Revenue</th>    


		
<%

int i = 0;
while(rs.next()){ %> 
<tr>
<%
	i++;
	ResultSet originStation;
	ResultSet destStation;
	ResultSet dateTimeResMadeOn;
	
	// Get the station name corresponding to the origin station ID
	PreparedStatement psmt_orig = con.prepareStatement("SELECT city FROM project.Station_new WHERE stationID = ?");
	psmt_orig.setString(1,rs.getString("originStationID"));
    originStation = psmt_orig.executeQuery();
    originStation.next();
    String originStationName = originStation.getString(1);
    psmt_orig.close();
    originStation.close();

    // Get the station name corresponding to the destination station ID
    PreparedStatement psmt_dest = con.prepareStatement("SELECT city FROM project.Station_new WHERE stationID = ?");
    psmt_dest.setString(1,rs.getString("destinationStationID"));
    destStation = psmt_dest.executeQuery();				
    destStation.next();
    String destinationStationName = destStation.getString(1);
    
    psmt_dest.close();
    destStation.close();
    
    // Display the datetime reservation was made on in readable manner
    PreparedStatement psmt_time = con.prepareStatement("SELECT date_format(x.dateTimeReservationMade,'%d %b %Y at %H:%i')" + 
    						" FROM (SELECT dateTimeReservationMade from project.Reservations WHERE reservation_no = ?) as x;");
    psmt_time.setString(1, rs.getString("reservation_no"));
    dateTimeResMadeOn = psmt_time.executeQuery();				
    dateTimeResMadeOn.next();
    String resMadeAt = dateTimeResMadeOn.getString(1);

	%>
	
    <td> <%=Integer.toString(i)%></td>
    <td> <%=destinationStationName%></td>		   
    <td> <%=rs.getDouble("total_fare") %></td>		         	
	
    
    <%-- Only have a delete button for future reservations and for uncancelled reservations --%>
         
</tr>
	        	
<% } 
	st.close();
	con.close();
	rs.close();

%>
</tr>
</table>
	<a href = "AdminHome.jsp"> Go back to admin home </a>
	
 
</body>
</html>