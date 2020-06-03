<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Delete Reservation</title>
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
		    String id = request.getParameter("id");	    
		    
		    // update the reservation status
		    String cancelled = "Cancelled";		    
		    String query = "UPDATE project.Reservations SET status ='" + cancelled +  "'WHERE reservation_no = '" + id + "';";	
	        st.executeUpdate(query);
		    
		    
		    // increment the number of seats on the train by the number of people on the cancelled reservation		    
		    PreparedStatement psmt = con.prepareStatement("SELECT trainID, adults, children, seniors, disabled FROM project.Reservations WHERE reservation_no = ?");	        
        	psmt.setString(1, id);
        	ResultSet rs = psmt.executeQuery();
        	rs.next();
        	String trainID = rs.getString(1);
        	String numAdults = rs.getString(2);
        	String numChildren = rs.getString(3);
        	String numSeniors = rs.getString(4);
        	String numDisabled = rs.getString(5);        	
        	int totalPeople = Integer.parseInt(numAdults) + Integer.parseInt(numChildren) + Integer.parseInt(numSeniors) + Integer.parseInt(numDisabled);
        	
        	
        	psmt.close();
        	rs.close();
        	
        	String update = "UPDATE project.Train_new SET seats_remaining = seats_remaining + '" + totalPeople +  "'WHERE trainID = '" + trainID + "';";	
	        st.executeUpdate(update);
        			    
        	st.close();	
        	con.close();
		%>  
		Your reservation has been successfully deleted <br><br>
		<a href = "historyReservation.jsp">Go back to your reservation history</a> or go <a href = "home.jsp">home</a>
		<br>
		
	</body>
</html>