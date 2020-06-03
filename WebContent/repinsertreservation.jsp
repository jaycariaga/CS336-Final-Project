<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	</head>
	
	<body>	
		<%	
			String userName = (String) session.getAttribute("userID");;
			if (userName == null) {
			   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			   rd.forward(request, response);
			}
		
			String custuser = request.getParameter("custuser");
			String transit_line = request.getParameter("transit_line");
			String origin = request.getParameter("origin");
	     	String destination = request.getParameter("destination");
	     	String traveldate = request.getParameter("traveldate");
	     	String traveltime = request.getParameter("traveltime");
	     	String numadults = request.getParameter("numadults");
	     	String numchildren = request.getParameter("numchildren");
	     	String numseniors = request.getParameter("numseniors");
	     	String numdisabled = request.getParameter("numdisabled");
	     	String totalprice = request.getParameter("totalprice");
	     	String classs = request.getParameter("classs");
	     	String trip = request.getParameter("trip");
	     	
	     	int numpeople = Integer.parseInt(numadults) + Integer.parseInt(numchildren) + Integer.parseInt(numseniors) + Integer.parseInt(numdisabled);
	     	
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    PreparedStatement arrival = con.prepareStatement("SELECT arrival_time from project.stops_at_new WHERE trainID = ? AND stationID = ?");
		    arrival.setString(1, traveltime);
		    arrival.setString(2, origin);
	        ResultSet arrivalrs = arrival.executeQuery(); 	
	        arrivalrs.next();
	        String departure = arrivalrs.getString(1);
	        arrival.close();
	        arrivalrs.close();

		    PreparedStatement destination1 = con.prepareStatement("SELECT arrival_time from project.stops_at_new WHERE trainID = ? AND stationID = ?");
		    destination1.setString(1, traveltime);
		    destination1.setString(2, destination);
	        ResultSet destinationrs = destination1.executeQuery(); 	
	        destinationrs.next();
	        String  arrivaltime = destinationrs.getString(1);
	        destination1.close();
	        destinationrs.close();
	        
	        
	        PreparedStatement nuseats = con.prepareStatement("SELECT seats_remaining FROM project.Train_new WHERE trainID = ?");
	        nuseats.setString(1, traveltime);
	        ResultSet seatsrs = nuseats.executeQuery();
	        seatsrs.next();
	        int numseats = seatsrs.getInt(1);
	        nuseats.close();
	        seatsrs.close();
	        if (numseats < numpeople) 
	        {
	        	out.println("There are only " + (numpeople-numseats) + " seats remaining on this particular train. Please go back and select a different time or less people" + "<br>");
	        }
	        
	        else
	        {
	        	// decrement the seats on the train by number of total people
		        String currseats= Integer.toString(numseats - numpeople);
		        String query = "UPDATE project.Train_new SET seats_remaining ='" + currseats +  "'WHERE (trainID = '"+ traveltime +"')";
		        st.executeUpdate(query);
		      
		       
				ResultSet date = st.executeQuery("SELECT NOW()");
				date.next();
				String currdate = date.getString(1);
				date.close();
				String insertQuery = "INSERT INTO project.Reservations(customer, customerRep, adults, children, seniors, disabled, total_fare, transit_line," + 
						 " trainID, originStationID, destinationStationID, travelDate, departOriginTime, arriveDestinationTime, dateTimeReservationMade, seatNumber," +
		    				" class, status, trip_type) VALUES('"+ custuser +"','" + (session.getAttribute("userID")) + "','" + numadults + "','" + numchildren + "','" + numseniors + "','" + numdisabled + 
		    					"','" + totalprice + "','" + transit_line + "','" + traveltime + "','" + origin + "','" + destination + "','" + traveldate + "',' " +
		    					  departure + "','" + arrivaltime + "','" + currdate + "','" + Integer.toString(numseats) + "','" + classs +"', 'Current', '" + trip + "');";
		        

		        try
		        {
		        	st.executeUpdate(insertQuery);
				    st.close();	
				    con.close();
				    out.println("The reservation was added!" + "<br>");
		        }
		        catch(SQLException e)
		        {
		        	out.println("There was an error" + "<br>");
		        	st.close();	
				    con.close();
		        }
			    
	        }
	        
		%>
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 
