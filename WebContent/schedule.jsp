<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule</title>
</head>
<body>
	<a href = "hello.jsp">Back to Home Page</a>
	<br><br>
		<b>Please enter the desired date, origin, and destination</b>
		
		<%String destinationstr = "test"; 
		  String datestr = "*";
		 %>
		<!-- need to give options for  -->
		<form action="schedule.jsp" method="POST">
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
			ResultSet rs;
			ResultSet origin;
			
			
			//This query lists the citys of stations that are on a route and are not the final stop
			origin = st.executeQuery("SELECT DISTINCT s.city, s.stationID FROM project.Station_new s "
						+"LEFT JOIN project.stops_at_new st "+
						"ON (s.stationID = st.stationID) "+
						"WHERE st.stopsLeftTillDestination > 0");
			
			%>
			
			<p>origin <br>			
			<select name = "origin" id = "origin" onchange = "this.form.submit()">
				<option value="0">Select origin</option>
		        <%while(origin.next()){ %>
		            <option value = "<%=origin.getString(1)%>"
		            <%
		            if(request.getParameter("origin") != null) {
		            	if (origin.getString(1).equals(request.getParameter("origin"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            ><%=origin.getString(1)%></option>
		        <% } %>
		        
		    
	        </select>
	        <%
	        
	     
	       
	        
	     
	        origin.close();
	        
	      
	     	
	     	
	     	//The below query is used to find the valid destination stops for the previously input origin
	        String query = "SELECT t.stationID, t.city FROM project.Station_new t, (SELECT DISTINCT stationID FROM" +
	        		" project.stops_at_new s, (SELECT DISTINCT trainID, stopsLeftTillDestination FROM project.stops_at_new WHERE stationID = (SELECT DISTINCT stationId FROM project.Station_new Where city = ?)) AS x" + 
	        		" WHERE x.trainId = s.trainID AND x.stopsLeftTillDestination > s.stopsLeftTillDestination) AS y WHERE y.stationID = t.stationId";
	    	
    		PreparedStatement psmt =con.prepareStatement(query);	 
    
    		psmt.setString(1,request.getParameter("origin"));
    		rs = psmt.executeQuery();
    	
    	
	        %>
	            
	        <p><p> Destination <p>
	        <select name = "destination" id = "destination" onchange = "this.form.submit()">
		        <option value="0">Select destination station</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"
		            <%
		            if(request.getParameter("destination") != null) {
		            	if (rs.getString(1).equals(request.getParameter("destination"))) {
		            		out.println("selected");
		            		destinationstr = rs.getString(2); 
		            	}
		            }
		            %>
		            
		            >
		            
		            <%=rs.getString(2)%></option>
		        <% } %>
	        </select>
	        <%
	    
	        psmt.close();
	        rs.close();
	        
	     	// show all FUTURE dates of train that go from the origin station to the destination station that have at least 1 available seats	                	
        	psmt = con.prepareStatement("SELECT DISTINCT date FROM project.Train_new t, (SELECT trainId FROM project.stops_at_new WHERE stationID = (SELECT DISTINCT stationId FROM project.Station_new Where city = ?)" +
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
		            		datestr = rs.getString(1);
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(1)%></option>
		        <% } %>
	        </select>
	        
	        <%
	        rs.close();
	        psmt.close();
	        %>
	        
	            <br><br>Sort By <br>	    
	        <select name = "sortBy" id = "sortBy" onchange = "this.form.submit()">
	       		
		        <option value="0" selected="selected">Arrival Time</option>
		        <option value="1">Departure Time</option>
		        <option value="2">Origin</option>
		        <option value="3">Destination</option>
		        <option value="4">Fare</option>
	        </select>
	        
	       	</form>	 
	      
	        <br><br>
	        <%if(!destinationstr.equals("test")){ %>
		      <a class="button" href = 'foundSchedule.jsp?origin=<%=request.getParameter("origin")%>&destination=<%=destinationstr%>&travelDate=<%=datestr%>&sortBy=<%=request.getParameter("sortBy")%>'> Search for Schedule</a>
			<%}else{ %>
				<p style="color:red"> Please fill in all entries </p>
			<%} %>	
				
				
	

</body>
</html>