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
			
			String resnumber = request.getParameter("resnum");
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
	   
			
	        PreparedStatement prevtotalseats = con.prepareStatement("SELECT adults, children, seniors, disabled FROM project.Reservations WHERE reservation_no = ?");
	        prevtotalseats.setString(1, resnumber);
	        ResultSet rs = prevtotalseats.executeQuery();
	        rs.next();
	        int adults = rs.getInt(1);
	        int children = rs.getInt(2);
	        int seniors = rs.getInt(3);
	        int disabled = rs.getInt(4);
	        int totalprev = adults + children + seniors + disabled;
	        
			
	        PreparedStatement nuseats = con.prepareStatement("SELECT seats_remaining FROM project.Train_new WHERE trainID = ?");
	        nuseats.setString(1, traveltime);
	        rs = nuseats.executeQuery();
	        rs.next();
	        int numseats = rs.getInt(1);
	        nuseats.close();
	        rs.close();
	        
	        
	        int newseats = 0;
	        if(numpeople >= totalprev)
	        {
	        	int diff = numpeople - totalprev;
	        	newseats = numseats - diff;
	        	String newseat = Integer.toString(newseats);
		        String query = "UPDATE project.Train_new SET seats_remaining ='" + newseat +  "'WHERE (trainID = '"+ traveltime +"')";
		        st.executeUpdate(query);
	        }
	        else
	        {
	        	int newdiff = totalprev - numpeople;
	        	newseats = numseats + numpeople;
	        	String newseat = Integer.toString(newseats);
		        String query = "UPDATE project.Train_new SET seats_remaining ='" + newseat +  "'WHERE (trainID = '"+ traveltime +"')";
		        st.executeUpdate(query);
	        }
	   	
	        ResultSet date = st.executeQuery("SELECT NOW()");
			date.next();
			String currdate = date.getString(1);
			date.close();
			
		      String update = "UPDATE project.Reservations SET customer = '" + custuser + "', adults = '" + numadults + "', children = '" + numchildren + "', seniors = '" + numseniors + "'," + 
		      "disabled = '" + numdisabled + "', total_fare = '" + totalprice + "', transit_line = '" + transit_line + "', trainId = '" + traveltime + "', originStationID = '" + origin + "'," +
		      "destinationStationId = '" + destination + "', travelDate = '" + traveldate + "', departOriginTime = '" + departure + "', arriveDestinationTime = '" + arrivaltime + "'," +
		      "dateTimeReservationMade = '" + currdate + "', seatNumber = '" + Integer.toString(newseats) + "', class = '" + classs + "', status = 'Current', trip_type = '" + trip + "' WHERE reservation_no = " + resnumber + ";";
	    	try
	    	{
	    		
	    		st.executeUpdate(update);
			    st.close();	
			    con.close();
			    out.println("The reservation was updated");
	    	}
	    	catch(SQLException e)
	        {
	        	out.println("There was an error" + "<br>");
	        	st.close();	
			    con.close();
	        }
			
		%>

		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 
