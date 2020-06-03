<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Edit Reservation</title>
	</head>
	<body>
		<% 	
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>
		
		<a href = "custrephome.jsp">Home</a><br><br>
		
		
		<b>If you are not making a change to a certain category, you still need to select the option again.</b><br> <br>
		<form action="repeditreservation.jsp" method="POST">
		
			<br/>
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
			ResultSet rs;
			ResultSet transitLine;
			transitLine = st.executeQuery("SELECT DISTINCT transit_line FROM project.Train_new;");
			
			%>
			
			Transit Line <br>			
			<select name = "transit_line" id = "transit_line" onchange = "this.form.submit()">
				<option value="0">Select transit line</option>
		        <%while(transitLine.next()){ %>
		            <option value = "<%=transitLine.getString(1)%>"
		            <%
		            if(request.getParameter("transit_line") != null) {
		            	if (transitLine.getString(1).equals(request.getParameter("transit_line"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            ><%=transitLine.getString(1)%></option>
		        <% } %>
	        </select>
		        
	        
	        
	        <%
	        st.close();	
	        transitLine.close();
	        
	        PreparedStatement psmt = con.prepareStatement("SELECT stationID, name FROM project.Station_new WHERE transit_line=?");
	        psmt.setString(1, request.getParameter("transit_line"));
	        rs = psmt.executeQuery(); 	        
	        %>	        
	        
			
			<br><br> Origin <br>	
			<select name = "origin" id = "origin" onchange = "this.form.submit()">
				<option value="0">Select origin station</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"		            
		            <%
		            if(request.getParameter("origin") != null) {
		            	if (rs.getString(1).equals(request.getParameter("origin"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(2)%></option>
		        <% } %>
	        </select>
	        
	        
	        <%
	        psmt.close();
	        rs.close();
	        
	        // Get the trains that stop at the origin station and then get the (destination) stations those trains stop at AFTER the origin station
	        String query = "SELECT t.stationID, name FROM project.Station_new t, (SELECT DISTINCT stationID FROM" +
		        		" project.stops_at_new s, (SELECT DISTINCT trainID, stopsLeftTillDestination FROM project.stops_at_new WHERE stationID = ?) AS x" + 
		        		" WHERE x.trainId = s.trainID AND x.stopsLeftTillDestination > s.stopsLeftTillDestination) AS y WHERE y.stationID = t.stationId;";
		        		
        	psmt = con.prepareStatement(query);	        
        	psmt.setString(1, request.getParameter("origin"));
        	rs = psmt.executeQuery();
	               
	        %>	 
	           
	        <br><br> Destination <br>
	        <select name = "destination" id = "destination" onchange = "this.form.submit()">
		        <option value="0">Select destination station</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"
		            <%
		            if(request.getParameter("destination") != null) {
		            	if (rs.getString(1).equals(request.getParameter("destination"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(2)%></option>
		        <% } %>
	        </select>
	        
	        <%
	        psmt.close();
	        rs.close();
	        
	     	// show all FUTURE dates of train that go from the origin station to the destination station that have at least 1 available seats	                	
        	psmt = con.prepareStatement("SELECT DISTINCT date FROM project.Train_new t, (SELECT trainId FROM project.stops_at_new WHERE stationID = ?" +
	        		" AND trainID IN (SELECT trainId FROM project.stops_at_new WHERE stationID = ?)) as x WHERE t.trainID = x.trainId" +
	        		 " AND date >= '2020-04-08' AND seats_remaining > 0");
	        psmt.setString(1, request.getParameter("origin"));
	        psmt.setString(2, request.getParameter("destination"));
	        
	        rs = psmt.executeQuery(); 	
	        	 
	        %>        
	        
	       			
	        <br><br> Date of travel <br>	    
	        <select name = "travelDate" id = "travelDate" onchange = "this.form.submit()">
	       		<option value="0">Select date of travel</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"		            
		            <%
		            if(request.getParameter("travelDate") != null) {
		            	if (rs.getString(1).equals(request.getParameter("travelDate"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(1)%></option>
		        <% } %>
	        </select>
	        
	        
	        <%
	        psmt.close();
	        rs.close();
	        PreparedStatement psmt_origin;
	        PreparedStatement psmt_destination;
	        ResultSet rs_other;
	        
	        psmt_origin = con.prepareStatement("SELECT s.trainID, arrival_time FROM project.stops_at_new s, (SELECT trainID FROM project.stops_at_new WHERE stationID = ?" +
	        		" and trainID IN (SELECT trainID FROM project.stops_at_new WHERE stationID = ?) AND trainID in (SELECT trainID FROM project.Train_new WHERE" + 
	        		" date = ?)) as x WHERE s.trainID = x.trainID AND stationID = ?;");
	        psmt_origin.setString(1, request.getParameter("origin"));
	        psmt_origin.setString(2, request.getParameter("destination"));
	        psmt_origin.setString(3, request.getParameter("travelDate"));
	        psmt_origin.setString(4, request.getParameter("origin"));
	        rs = psmt_origin.executeQuery(); 
	        
	        
	        psmt_destination = con.prepareStatement("SELECT s.trainID, arrival_time FROM project.stops_at_new s, (SELECT trainID FROM project.stops_at_new WHERE stationID = ?" +
	        		" and trainID IN (SELECT trainID FROM project.stops_at_new WHERE stationID = ?) AND trainID in (SELECT trainID FROM project.Train_new WHERE" +
	        		" date = ?)) as x WHERE s.trainID = x.trainID AND stationID = ?;");
	        psmt_destination.setString(1, request.getParameter("origin"));
	        psmt_destination.setString(2, request.getParameter("destination"));
	        psmt_destination.setString(3, request.getParameter("travelDate"));
	        psmt_destination.setString(4, request.getParameter("destination"));
	        rs_other = psmt_destination.executeQuery(); 
	        %>
	        
	        
	        <br><br> Time of travel <br>	    
	        <select name = "travelTime" id = "travelTime">
	        	<option value="0">Select time of travel</option>
		        <%while(rs.next() && rs_other.next()){ %>
		            <option value ="<%=rs.getString(1)%>"
		            <%
		            if(request.getParameter("travelTime") != null) {
		            	if (rs.getString(1).equals(request.getParameter("travelTime"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(2)%> - <%=rs_other.getString(2)%></option>
		        <% } %>
	        </select>
	        
	        <%
	        psmt_origin.close();
	        psmt_destination.close();
	        rs.close();
	        rs_other.close();
	        %>
	        
	        <br><br> Class Type <br>	    
	        <select name = "classStyle" id = "classStyle">
	        	<option value="0">Select your class seating</option>
		            <option value ="First Class"
		            <%
		            if(request.getParameter("classStyle") != null) {
		            	if ("First Class".equals(request.getParameter("classStyle"))) {
		            		out.println("selected");
		            	}
		            }
		            %>		            
		            >First class</option>
		            <option value ="Business class"
		            <%
		            if(request.getParameter("classStyle") != null) {
		            	if ("Business class".equals(request.getParameter("classStyle"))) {
		            		out.println("selected");
		            	}
		            }
		            %>		            
		            >Business class</option>
		            <option value ="Economy class"
		            <%
		            if(request.getParameter("classStyle") != null) {
		            	if ("Economy class".equals(request.getParameter("classStyle"))) {
		            		out.println("selected");
		            	}
		            }
		            %>		            
		            >Economy class</option>
	        </select>
			
			
			<br> <br> <br> Customer Username: <input type="text" name="custuser"/><br/>
      		Reservation Number: <input type="text" name="resnumber"/><br/><br>
      		
      		<br>Trip Type: <input type="text" name="trip"/><br>
			Type in <b>exactly one</b> of the options: One way, Round trip, Weekly pass, Monthly pass<br><br>
			
			
			<br><br><b>Number of tickets?</b> <br><br>
			
			Adults: <input type="text" name="adults"/><br><br>
      		Children: <input type="text" name="children"/> <br><br>
      		Seniors: <input type="text" name="seniors"/> <br><br>
      		Disabled: <input type="text" name="disabled"/> <br><br>
      		
      		<input type="submit" value="Submit"/>
     	</form>
     	
     	<%-- Show the calculations --%>
     	<%
     	String resnumber = request.getParameter("resnumber");
     	String custuser = request.getParameter("custuser");
     	String transit_line = request.getParameter("transit_line");
     	String origin = request.getParameter("origin");
     	String destination = request.getParameter("destination");
     	String traveldate = request.getParameter("travelDate");
     	String traveltime = request.getParameter("travelTime");
     	String adults = request.getParameter("adults");
     	String children = request.getParameter("children");
     	String seniors = request.getParameter("seniors");
     	String disabled = request.getParameter("disabled");
     	String classs = request.getParameter("classStyle");
     	String trip = request.getParameter("trip");
     	
     	
     	if (origin == null || destination == null || traveldate == null || traveltime == null || adults == null || children == null || seniors == null || disabled == null)
     	{
     		
     	}
     	else if (adults.length() == 0 && children.length() == 0 && seniors.length() == 0 && disabled.length() == 0) 
     	{
     		out.println("At least one person must be reserved for this ticket.");
     	}
     	else 
     	{
     		
			int numadults = 0;
			int numchildren = 0;
			int numseniors = 0;
			int numdisabled = 0;
			
			if (adults.length() != 0) 
			{
				numadults = Integer.parseInt(adults);
			}
			if (children.length() != 0) 
			{
				numchildren = Integer.parseInt(children);
			}
			if (seniors.length() != 0) 
			{
				numseniors = Integer.parseInt(seniors);
			}			
			if (disabled.length() != 0) 
			{
				numdisabled = Integer.parseInt(disabled);
			}
			
	        	// calculate ticket price: find out the number of stops remaining as the difference * flat fee of 10
	        	psmt_origin = con.prepareStatement("SELECT stopsLeftTillDestination from project.stops_at_new WHERE trainID = ? AND stationID = ?;");
	        	psmt_origin.setString(1, traveltime);	  
	        	psmt_origin.setString(2, origin);	  
		        rs = psmt_origin.executeQuery(); 
		        rs.next();
		        int origin_stops = rs.getInt(1);
		        psmt_origin.close();
		        rs.close();
		        
		        psmt_destination = con.prepareStatement("SELECT stopsLeftTillDestination from project.stops_at_new WHERE trainID = ? AND stationID = ?;");
		        psmt_destination.setString(1, traveltime);	  
		        psmt_destination.setString(2, destination);	  
		        rs_other = psmt_destination.executeQuery(); 
		        rs_other.next();
		        int destination_stops = rs_other.getInt(1);
		        psmt_destination.close();
		        rs_other.close();
		     
		        int totalstops = origin_stops - destination_stops ;
		        
		        double ticketprice = 2 * (totalstops);
		        double adultprice = ticketprice * numadults;
				double childrenprice = (ticketprice * 0.9) * numchildren;
				double seniorprice = (ticketprice * 0.8) * numseniors;
				double disabledprice = (ticketprice * 0.6) * numdisabled;
				double totalprice = adultprice + childrenprice + seniorprice + disabledprice + 3;
				totalprice = Math.round(totalprice * 100.0) / 100.0;
				
				if(trip.equals("Round trip"))
				{
					totalprice = totalprice*2;
				}
				else if(trip.equals("Weekly pass"))
				{
					totalprice = totalprice*7*0.9;
				}
				else if(trip.equals("Monthly pass"))
				{
					totalprice = totalprice*30*0.9;
				}
				%>
				<% 
				if(adultprice != 0) {
					%>
					Price for <%=numadults%> adults is: $<%=adultprice%> <br>
					<%
				}
				if(childrenprice != 0) {
					%>
					Price for <%=numchildren%> children is: $<%=childrenprice%> <br>
					<%
				}
				if(seniorprice != 0) {
					%>
					Price for <%=numseniors%> seniors is: $<%=seniorprice%> <br>
					<%
				}
				if(disabledprice != 0) {
					%>
					Price for <%=numdisabled%> disabled is: $<%=disabledprice%> <br>
					<%
				}
				%>
				
	
				<br>Customer Username: <%=custuser%><br>
				Grand total: $<%=totalprice%><br><br>
			
		
				<a href = "makeedit.jsp?trip=<%=trip%>&resnum=<%=resnumber%>&custuser=<%=custuser%>&transit_line=<%=transit_line%>&origin=<%=origin%>&destination=<%=destination%>
				&traveldate=<%=traveldate%>&traveltime=<%=traveltime%>&numadults=<%=numadults%>&numchildren=<%=numchildren%>
				&numseniors=<%=numseniors%>&numdisabled=<%=numdisabled%>&totalprice=<%=totalprice%>&classs=<%=classs%>"><button type="button">Confirm Edit</button></a>	
				
							
		<%con.close();
     	}%>
   </body>
</html>