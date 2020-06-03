<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Reservation history</title>
	</head>
	<body>	
		<!-- Done by Shubham Rustagi -->
		<%
			// Account for unlogged users		
			String userName = (String) session.getAttribute("userID");;
			if (userName == null) {
			   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			   rd.forward(request, response);
			}
		
		    
			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    ResultSet rs;
		    String query = "SELECT * FROM project.Reservations WHERE customer = '" + (session.getAttribute("userID")) + "';";
		    rs = st.executeQuery(query);
		    
		    int size = 0;
		    if (rs != null) {
		      rs.last();    // moves cursor to the last row
		      size = rs.getRow(); // get row id 
		      rs = st.executeQuery(query); // get back original query results
		    }
		    
		    int i = 0;
		    
		%>   
		
		<!-- if they have no reservations, just display message. Otherwise, display table of reservation -->
		<%if(size == 0) {%>
		You have no reservations with us. To make a reservation, please visit <a href='makeReservation.jsp'>here</a>
		<%} else { %>
		
		<h2>Reservation history</h2>
		
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
				<th>Ticket type</th>
	       	<tr>
			<%while(rs.next()){ %> 
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
					
		            <td style="padding:0 25px 0 25px;"><%=Integer.toString(i)%></td>
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("transit_line")%></td>
		            <td style="padding:0 25px 0 25px;"><%= originStationName %></td>
		            <td style="padding:0 25px 0 25px;"><%= destinationStationName %></td>		            
		            <td style="padding:0 25px 0 25px;"><%=rs.getInt("adults") +rs.getInt("children")+rs.getInt("seniors")+rs.getInt("disabled") %></td>		   
		            <td style="padding:0 25px 0 25px;">$<%=rs.getDouble("total_fare") %></td>		         
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("travelDate")%></td>
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("departOriginTime")%></td>
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("arriveDestinationTime")%></td>
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("seatNumber")%></td>
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("class")%></td>	
		            <td style="padding:0 25px 0 25px;"><%=resMadeAt%></td>	
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("status")%></td>	
		            <td style="padding:0 25px 0 25px;"><%=rs.getString("trip_type")%></td>	
		            
		            <%-- Only have a delete button for same day or future reservations and for uncancelled reservations --%>		            
		            <% if((rs.getDate("travelDate").after(new java.util.Date()) || rs.getDate("travelDate").equals(new java.util.Date()))
		            		&& rs.getString("status").equals("Current")) { %> 
		            	<td><a href="deleteReservation.jsp?id=<%=rs.getString("reservation_no") %>"><button type="button">Delete Reservation</button></a></td>	
		            <%};%>            
		        </tr> 	        	
		    <% } %>
		</table>		
		
		<% } %>
		<br><br><a href= "home.jsp">Go back home</a><br>
	        
		
	</body>
</html>