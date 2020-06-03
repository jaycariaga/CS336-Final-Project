<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert Reservation</title>
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
		
		
			String transit_line = request.getParameter("transit_line");
			String origin = request.getParameter("origin");
	     	String destination = request.getParameter("destination");
	     	String travelDate = request.getParameter("travelDate");
	     	String travelTime_trainID = request.getParameter("travelTime_trainID");
	     	String numAdults = request.getParameter("numAdults");
	     	String numChildren = request.getParameter("numChildren");
	     	String numSeniors = request.getParameter("numSeniors");
	     	String numDisabled = request.getParameter("numDisabled");
	     	String totalFare = request.getParameter("totalFare");
	     	String classStyle = request.getParameter("classStyle");
	     	String trip_type = request.getParameter("ticketType"); 
	     	int totalPeople = Integer.parseInt(numAdults) + Integer.parseInt(numChildren) + Integer.parseInt(numSeniors) + Integer.parseInt(numDisabled);
	     	
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    
		    // find out when the train will arrive at the origin station
		    PreparedStatement psmt_arrival = con.prepareStatement("SELECT arrival_time from project.stops_at_new WHERE trainID = ? AND stationID = ?");
		    psmt_arrival.setString(1, travelTime_trainID);
		    psmt_arrival.setString(2, origin);
	        ResultSet rs_arrival = psmt_arrival.executeQuery(); 	
	        rs_arrival.next();
	        String departOriginTime = rs_arrival.getString(1);
	        
	        psmt_arrival.close();
	        rs_arrival.close();
	        
	        
	        // find out when the train will arrive at the destination station
		    PreparedStatement psmt_destination = con.prepareStatement("SELECT arrival_time from project.stops_at_new WHERE trainID = ? AND stationID = ?");
		    psmt_destination.setString(1, travelTime_trainID);
		    psmt_destination.setString(2, destination);
	        ResultSet rs_destination = psmt_destination.executeQuery(); 	
	        rs_destination.next();
	        String arriveDestinationTime = rs_destination.getString(1);
	        
	        psmt_destination.close();
	        rs_destination.close();
	        ResultSet rs;
			
			// Get the seat number for the passenger 
	        PreparedStatement psmt_seatsNumber = con.prepareStatement("SELECT seats_remaining FROM project.Train_new WHERE trainID = ?");
	        psmt_seatsNumber.setString(1, travelTime_trainID);
	        rs = psmt_seatsNumber.executeQuery();
	        rs.next();
	        int seatNumber = rs.getInt(1);
	        
	        psmt_seatsNumber.close();
	        rs.close();
	        
	        // decrement the seats on the train by number of total people
	        String seatsRem = Integer.toString(seatNumber - totalPeople);
	        String query = "UPDATE project.Train_new SET seats_remaining ='" + seatsRem +  "'WHERE (trainID = '" +travelTime_trainID+  "')";
	        st.executeUpdate(query);
	        //rs.close();	        
	        
	        
			// get current date/time reservation is made on			
			rs = st.executeQuery("SELECT NOW()");
			rs.next();
			String now = rs.getString(1);
			rs.close();
			
			String current = "Current";
			
						
	        // Insert reservation into Reservations table
		    String insertQuery = "INSERT INTO project.Reservations(customer, customerRep, adults, children, seniors, disabled, total_fare, transit_line," + 
					 " trainID, originStationID, destinationStationID, travelDate, departOriginTime, arriveDestinationTime, dateTimeReservationMade, seatNumber," +
	    				" class, status, trip_type) VALUES('" + (session.getAttribute("userID") + "','NULL','" + numAdults + "','" + numChildren + "','" + numSeniors + "','" + numDisabled + 
	    					"','" + totalFare + "','" + transit_line + "','" + travelTime_trainID + "','" + origin + "','" + destination + "','" + travelDate + "',' " +
	    					  departOriginTime + "','" + arriveDestinationTime + "','" + now + "','" + Integer.toString(seatNumber) + "','" + classStyle +"', '" + current + 
	    					    "','" + trip_type + "');");
	        
		    st.executeUpdate(insertQuery);
		    st.close();	
		    con.close();
		%>
		<br>Your reservation has been set!. 		
		<br><br><a href='home.jsp'>Go back home</a>
	</body>
</html> 