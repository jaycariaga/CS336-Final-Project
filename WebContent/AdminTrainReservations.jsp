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
	String admin = (String) session.getAttribute("username");
	if(!admin.contains("admin")){
		response.sendRedirect("login.jsp");
	}
	int trainID = Integer.parseInt(request.getParameter("trainID"));
	String Transitline = (String) request.getParameter("transitLine");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	String query = "Select * from project.Reservations where trainID = '" + trainID + "'AND transit_line ='" + Transitline + "';";
	rs = st.executeQuery(query);
%>
		<h2>Totals</h2>
<table>
<tr>
				<th>Id</th> 
				<th>Transit Line</th>    
				<th>Origin Station</th>    
				<th>Destination Station</th>    
				<th>Total People</th>
				<th>Total Cost</th>				
				<th>Travel Date</th>   
				<th>Departure Time</th>   
				<th>Arrival Time</th> 
				<th>Seat Number</th>   
				<th>Class</th>   
				<th>Reservation Made</th> 
				<th>Reservation Status</th> 

		
<%

int i = 1;
while(rs.next()){ %> 
<tr>
	<%
	i++;
	ResultSet originStation;
	ResultSet destStation;
	ResultSet dateTimeResMadeOn;
	
	// Get the station name corresponding to the origin station ID
	PreparedStatement psmt_orig = con.prepareStatement("SELECT name FROM project.Station_new WHERE stationID = ?");
	psmt_orig.setString(1,rs.getString("originStationID"));
    originStation = psmt_orig.executeQuery();
    originStation.next();
    String originStationName = originStation.getString(1);
    psmt_orig.close();
    originStation.close();

    // Get the station name corresponding to the destination station ID
    PreparedStatement psmt_dest = con.prepareStatement("SELECT name FROM project.Station_new WHERE stationID = ?");
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
    <td> <%=rs.getString("transit_line")%></td>
    <td> <%= originStationName %></td>
    <td> <%= destinationStationName %></td>		            
    <td> <%=rs.getInt("adults") +rs.getInt("children")+rs.getInt("seniors")+rs.getInt("disabled") %></td>		   
    <td> <%=rs.getDouble("total_fare") %></td>		         
    <td> <%=rs.getString("travelDate")%></td>
    <td> <%=rs.getString("departOriginTime")%></td>
    <td> <%=rs.getString("arriveDestinationTime")%></td>
    <td> <%=rs.getString("seatNumber")%></td>
    <td> <%=rs.getString("class")%></td>	
    <td> <%=resMadeAt%></td>	
    <td> <%=rs.getString("status")%></td>	
    
          
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