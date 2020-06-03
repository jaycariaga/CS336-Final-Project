<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Make Reservation</title>
	</head>
	<body>
		<!-- Done by Shubham Rustagi -->
		<% // Account for unlogged users
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>

		Please fill out the following details to make a reservation or go <a href = "home.jsp">home</a><br><br>
		<u>Pricing:</u>
		<ul>
		<li>There is a flat fee of $2.00 between any two adjacent stations</li>
		</ul>
		
		<u>Discounts available:</u>
		<ul>
		<li>Children (at most 12 years old): 10%</li>
		<li>Seniors (at least 55 years old): 20%</li>
		<li>Disabled: 40%</li>
		</ul>
		
		<u>Types of seats available:</u>
		<ul>
		<li>First class: Additional $2.00 charge</li>
		<li>Business class: Additional $1.00 charge</li>
		<li>Economy class: No additional charge</li>
		</ul>
		
		
		<u>Types of tickets available:</u>
		<ul>
		<li>One way (will cost the fare value)</li>
		<li>Round trip (will cost 2x the fare value)</li>
		<li>Special offer: weekly pass (will cost 7 * 90% the fare value... 10% discount compared to buying a one way ticket 7 times)</li>
		<li>Special offer: monthly pass (will cost 30 * 90% the fare value... 10% discount compared to buying a one way ticket 30 times)</li>
		</ul>

		<form action="makeReservation.jsp" method="POST">
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
	        transitLine.close();

	        PreparedStatement psmt = con.prepareStatement("SELECT stationID, name FROM project.Station_new WHERE transit_line=?");
	        psmt.setString(1, request.getParameter("transit_line"));
	        rs = psmt.executeQuery();
	        %>
	        
	        <%-- Create a drop down menu of all station names --%>
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
	        
	     	// get current date			
   			rs = st.executeQuery("SELECT CURDATE();");
   			rs.next();
   			String currDate = rs.getString(1);
   			rs.close();
   			st.close();

	     	// show all FUTURE dates, relative to today, of trains that go from the origin station to the destination station that have at least 1 available seats
        	psmt = con.prepareStatement("SELECT DISTINCT date FROM project.Train_new t, (SELECT trainId FROM project.stops_at_new WHERE stationID = ?" +
	        		" AND trainID IN (SELECT trainId FROM project.stops_at_new WHERE stationID = ?)) as x WHERE t.trainID = x.trainId" +
	        		 " AND date >= ? AND seats_remaining > 0");
	        psmt.setString(1, request.getParameter("origin"));
	        psmt.setString(2, request.getParameter("destination"));
	        psmt.setString(3, currDate);

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

	        // get arrival time for the train at the origin station
	        psmt_origin = con.prepareStatement("SELECT s.trainID, arrival_time FROM project.stops_at_new s, (SELECT trainID FROM project.stops_at_new WHERE stationID = ?" +
	        		" and trainID IN (SELECT trainID FROM project.stops_at_new WHERE stationID = ?) AND trainID in (SELECT trainID FROM project.Train_new WHERE" +
	        		" date = ?)) as x WHERE s.trainID = x.trainID AND stationID = ?;");
	        psmt_origin.setString(1, request.getParameter("origin"));
	        psmt_origin.setString(2, request.getParameter("destination"));
	        psmt_origin.setString(3, request.getParameter("travelDate"));
	        psmt_origin.setString(4, request.getParameter("origin"));
	        rs = psmt_origin.executeQuery();

	     // get arrival time for the train at the destination station
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
		            <option value ="First class"
		            <%
		            if(request.getParameter("classStyle") != null) {
		            	if ("First class".equals(request.getParameter("classStyle"))) {
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
	        
	        <br><br> Ticket Type <br>
	        <select name = "ticketType" id = "ticketType">
	        	<option value="0">Select your ticket type</option>
		            <option value ="One way"
		            <%
		            if(request.getParameter("ticketType") != null) {
		            	if ("One way".equals(request.getParameter("ticketType"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            >One way</option>
		            
		            <option value ="Round trip"
		            <%
		            if(request.getParameter("ticketType") != null) {
		            	if ("Round trip".equals(request.getParameter("ticketType"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            >Round trip</option>
		            
		            <option value ="Weekly pass"
		            <%
		            if(request.getParameter("ticketType") != null) {
		            	if ("Weekly pass".equals(request.getParameter("ticketType"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            >Weekly pass</option>
		            
		            <option value ="Monthly pass"
		            <%
		            if(request.getParameter("ticketType") != null) {
		            	if ("Monthly pass".equals(request.getParameter("ticketType"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            >Monthly pass</option>
	        </select>


			<br><br><br>Please input how many tickets you want for each category <br><br>

			Adults: <input type="text" name="adults"/><br><br>
      		Children: <input type="text" name="children"/> <br><br>
      		Seniors: <input type="text" name="seniors"/> <br><br>
      		Disabled: <input type="text" name="disabled"/> <br><br>

      		<input type="submit" value="Submit"/>
     	</form>

     	<%-- Show the calculations --%>
     	<%
     	String transit_line = request.getParameter("transit_line");
     	String origin = request.getParameter("origin");
     	String destination = request.getParameter("destination");
     	String travelDate = request.getParameter("travelDate");
     	String travelTime_trainID = request.getParameter("travelTime");
     	String adults = request.getParameter("adults");
     	String children = request.getParameter("children");
     	String seniors = request.getParameter("seniors");
     	String disabled = request.getParameter("disabled");
     	String classStyle = request.getParameter("classStyle");
     	String ticketType = request.getParameter("ticketType");


     	if (origin == null || destination == null || travelDate == null || travelTime_trainID == null || adults == null || 
     			children == null || seniors == null || disabled == null || classStyle == null || ticketType == null) {
     		// do nothing if field parameters are null (when the page is first requested)
     	}
     	else if (adults.length() == 0 && children.length() == 0 && seniors.length() == 0 && disabled.length() == 0) {
     		out.println("At least one person must be reserved for this ticket.");
     	}
     	else {

			int numAdults = 0;
			int numChildren = 0;
			int numSeniors = 0;
			int numDisabled = 0;

			if (adults.length() != 0) {
				numAdults = Integer.parseInt(adults);
				// account for negative inputs
				numAdults = Math.max(0, numAdults);
			}
			if (children.length() != 0) {
				numChildren = Integer.parseInt(children);
				// account for negative inputs
				numChildren = Math.max(0, numChildren);
			}
			if (seniors.length() != 0) {
				numSeniors = Integer.parseInt(seniors);
				// account for negative inputs
				numSeniors = Math.max(0, numSeniors);
			}
			if (disabled.length() != 0) {
				numDisabled = Integer.parseInt(disabled);
				// account for negative inputs
				numDisabled = Math.max(0, numDisabled);
			}

			int totalPeople = numAdults + numChildren + numSeniors + numDisabled;


			psmt = con.prepareStatement("SELECT seats_remaining from project.Train_new WHERE trainID = ?;");
	        psmt.setString(1, travelTime_trainID);
	        rs = psmt.executeQuery();
			rs.next();
	        int seats_remaining = rs.getInt(1);
	        psmt.close();
	        rs.close();

	        // if user books too many tickets
	        if (seats_remaining < totalPeople) {
	        	out.println("There are only " + seats_remaining + " seats remaining on this particular train. Please select a different time or less people");
	        } else {
	        	// calculate ticket price: find out the number of stops remaining as the difference * flat fee of 2
	        	psmt_origin = con.prepareStatement("SELECT stopsLeftTillDestination from project.stops_at_new WHERE trainID = ? AND stationID = ?;");
	        	psmt_origin.setString(1, travelTime_trainID);
	        	psmt_origin.setString(2, origin);
		        rs = psmt_origin.executeQuery();
		        rs.next();
		        int origin_stops = rs.getInt(1);
		        psmt_origin.close();
		        rs.close();

		        psmt_destination = con.prepareStatement("SELECT stopsLeftTillDestination from project.stops_at_new WHERE trainID = ? AND stationID = ?;");
		        psmt_destination.setString(1, travelTime_trainID);
		        psmt_destination.setString(2, destination);
		        rs_other = psmt_destination.executeQuery();
		        rs_other.next();
		        int destination_stops = rs_other.getInt(1);
		        psmt_destination.close();
		        rs_other.close();

		        double ticketPrice = 2 * (origin_stops - destination_stops);

		       	// compute prices for all sorts of people
		        double adultTicketPrice = ticketPrice * numAdults;
				double childTicketPrice = (ticketPrice * 0.9) * numChildren;
				double seniorTicketPrice = (ticketPrice * 0.8) * numSeniors;
				double disabledTicketPrice = (ticketPrice * 0.6) * numDisabled;
				double totalFare = adultTicketPrice + childTicketPrice + seniorTicketPrice + disabledTicketPrice ;
				
				// change the total fare depending on the type of seat they want
				if (classStyle.equalsIgnoreCase("First class")) {
					totalFare += 2;
				} else if (classStyle.equalsIgnoreCase("Business class")) {
					totalFare += 1;
				}
				
				
				
				// change the total fare depending on the type of ticket they have selected
				// A round trip is 2x the fare
				// a weekly pass is 7x the fare * .9
				// a monthly pass is 30x the fare * .9
				
				if (ticketType.equals("One way")) {
					// no changes in the fare					
				} else if (ticketType.equals("Round trip")) {
					totalFare *= 2;					
				} else if (ticketType.equals("Weekly pass")) {
					totalFare = totalFare * 7 * 0.9;
				} else if (ticketType.equals("Monthly pass")) {
					totalFare = totalFare * 30 * 0.9;
				}
				
				// flat booking fee
				totalFare += 3;
				totalFare = Math.round(totalFare * 100.0) / 100.0;
				%>
				<br><br>-----------------------------------------------------------<br>
				Please make sure all values are correct. If not, please readjust above<br><br>
				You will be travelling a total of <%=origin_stops - destination_stops%> stops at a flat fee rate of $2.00 per stop + $3.00 fixed booking fee<br><br>

				<%
				if(adultTicketPrice != 0) {
					%>
					Price for <%=numAdults%> adults is: $<%=(Math.round(adultTicketPrice * 100.0)/100.0)%> <br>
					<%
				}
				if(childTicketPrice != 0) {
					%>
					Price for <%=numChildren%> children is: $<%=Math.round(childTicketPrice * 100.0)/100.0%> <br>
					<%
				}
				if(seniorTicketPrice != 0) {
					%>
					Price for <%=numSeniors%> seniors is: $<%=Math.round(seniorTicketPrice * 100.0)/100.0%> <br>
					<%
				}
				if(disabledTicketPrice != 0) {
					%>
					Price for <%=numDisabled%> disabled is: $<%=Math.round(disabledTicketPrice * 100.0)/100.0%> <br>
					<%
				}
				%>		
						
				<!-- Class type calculations -->
				<%if(classStyle.equalsIgnoreCase("First class")) { %>
				Seating class: First class (+ $2.00)<br>
				<%} else if (classStyle.equalsIgnoreCase("Business class")) {%>
				Seating class: Business class (+ $1.00)<br>
				<%} else {%>
				Seating class: Economy class (+ $0.00)<br>
				<%}%>
				
				<!-- Ticket type calculations -->
				<%if(ticketType.equalsIgnoreCase("One way")) { %>
				Type of ticket: One way (+ $0.00)<br>
				<%} else if (ticketType.equalsIgnoreCase("Round trip")) {%>
				Type of ticket: Round trip (fare * 2)<br>
				<%} else if (ticketType.equalsIgnoreCase("Weekly pass")) {%>
				Type of ticket: Weekly pass (fare * 7 * 90%)<br>
				<%} else if (ticketType.equalsIgnoreCase("Monthly pass")) {%>
				Type of ticket: Monthly pass (fare * 30 * 90%)<br>
				<%}%>
				
				<br>Subtotal: $<%=totalFare - 3.0%>				
				<br>Booking Fee: $3.00<br>
				
				<br><b>Grand total: $<%=totalFare%></b><br><br>


				<%-- Clicking confirm button redirect to a page and send all data to MySQL server --%>

				<a href = "insertReservation.jsp?transit_line=<%=transit_line%>&origin=<%=origin%>&destination=<%=destination%>
				&travelDate=<%=travelDate%>&travelTime_trainID=<%=travelTime_trainID%>&numAdults=<%=numAdults%>&numChildren=<%=numChildren%>
				&numSeniors=<%=numSeniors%>&numDisabled=<%=numDisabled%>&totalFare=<%=totalFare%>&classStyle=<%=classStyle%>&ticketType=<%=ticketType%>">
				<button type="button">Confirm Reservation</button></a>
		<%
		con.close();
	        }
     	}
     	%>

   </body>
</html>
