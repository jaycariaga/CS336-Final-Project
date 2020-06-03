<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Schedule</title>
<style>
   table, th, td {  
       border: 1px solid black;  
     }  
     td, th {  
       padding: 5px;  
     }  
   </style> 
</head>
 
<body>
		
		Found schedules leaving from <%out.println(request.getParameter("origin"));%> going to  <%out.println(request.getParameter("destination"));%>
		<%if(!request.getParameter("travelDate").equals("*")){ %> on  <%out.println(request.getParameter("travelDate"));}%>
		
		
		<br><br>
		<a href = 'schedule.jsp'>Search for  another train</a>
		
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			
			ResultSet rs;
			
			
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String travelDate = request.getParameter("travelDate");
			String sortBy = request.getParameter("sortBy");
			String sortQuery = "default";
			
			//This query lists the citys of stations that are on a route and are not the final stop
			String scheduleQueryStub = "Select t1.trainID as ID, t1.transit_line, t1.date, t1.city as origin, t1.arrival_time as departure_time, t2.city as destination, t2.arrival_time, TIME(t2.arrival_time - t1.arrival_time) Travel_Time, concat('$',Format(2*(t1.stopsLeftTillDestination-t2.stopsLeftTillDestination),2)) fareNoBookingFee " 
			+ "From (SELECT t.trainID, t.transit_line, s.stationID, st.city, t.date,  s.arrival_time , s.stopsLeftTillDestination FROM project.Train_new t "
			+ "Left outer join project.stops_at_new s on t.trainID = s.trainID "
			+ "right outer join project.Station_new st on st.stationID = s.stationID "
			+ "where t.date = ? and st.city = ? " 
			+ "group by t.trainID) t1 "
			+ "inner join (SELECT t.trainID, t.transit_line, s.stationID, st.city, t.date,  s.arrival_time, s.stopsLeftTillDestination FROM project.Train_new t "
			+ "Left outer join project.stops_at_new s on t.trainID = s.trainID "
			+ "right outer join project.Station_new st on st.stationID = s.stationID "
			+ "where t.date = ? and st.city = ? " 
			+ "group by t.trainID) t2 "
			+ "on t1.trainID = t2.trainID ";
			
			
			//if a specified date is not entered, the schedule shows all trains on the origin/destination route
			if(travelDate.equals("*")){ 
				scheduleQueryStub =  "Select t1.trainID as ID, t1.transit_line, t1.date, t1.city as origin, t1.arrival_time as departure_time, t2.city as destination, t2.arrival_time, TIME(t2.arrival_time - t1.arrival_time) Travel_Time, concat('$',Format(2*(t1.stopsLeftTillDestination-t2.stopsLeftTillDestination),2)) fareNoBookingFee " 
						+ "From (SELECT t.trainID, t.transit_line, s.stationID, st.city, t.date,  s.arrival_time , s.stopsLeftTillDestination FROM project.Train_new t "
						+ "Left outer join project.stops_at_new s on t.trainID = s.trainID "
						+ "right outer join project.Station_new st on st.stationID = s.stationID "
						+ "where st.city = ? " 
						+ "group by t.trainID) t1 "
						+ "inner join (SELECT t.trainID, t.transit_line, s.stationID, st.city, t.date,  s.arrival_time, s.stopsLeftTillDestination FROM project.Train_new t "
						+ "Left outer join project.stops_at_new s on t.trainID = s.trainID "
						+ "right outer join project.Station_new st on st.stationID = s.stationID "
						+ "where st.city = ? " 
						+ "group by t.trainID) t2 "
						+ "on t1.trainID = t2.trainID ";
			}

			%>
			
			<br><br>
		<b>Sort By:</b>
		<br><t><a href = 'foundSchedule.jsp?origin=<%=request.getParameter("origin")%>&destination=<%=request.getParameter("destination")%>&travelDate=<%=request.getParameter("travelDate")%>&sortBy=0'>Arrival Time </a></t>
		<br><t><a href = 'foundSchedule.jsp?origin=<%=request.getParameter("origin")%>&destination=<%=request.getParameter("destination")%>&travelDate=<%=request.getParameter("travelDate")%>&sortBy=1'>Departure Time </a></t>
		<br><t><a href = 'foundSchedule.jsp?origin=<%=request.getParameter("origin")%>&destination=<%=request.getParameter("destination")%>&travelDate=<%=request.getParameter("travelDate")%>&sortBy=2'>Travel Time </a></t>

		<br><t><a href = 'foundSchedule.jsp?origin=<%=request.getParameter("origin")%>&destination=<%=request.getParameter("destination")%>&travelDate=<%=request.getParameter("travelDate")%>&sortBy=4'>Fare </a></t><a></a>
<%
switch(Integer.parseInt(sortBy)){

	case (0):
		sortQuery = "order by t2.arrival_time";
		break;
	case (1):
		sortQuery = "order by departure_time";
		break;
	case (2):
		sortQuery = "order by Travel_Time";
		break;
	case (3):
		sortQuery = "order by t2.city";
		break;
	case (4):
		sortQuery = "order by fareNoBookingFee desc";
		break;
	default:
		sortQuery = "order by t1.arrival_time";
		break;

}


if(travelDate.equals("*")){
	sortQuery = "order by t1.date, t1.arrival_time";
}

PreparedStatement pmst = con.prepareStatement(scheduleQueryStub+sortQuery);

if(travelDate.equals("*")){
	pmst.setString(1,origin);
	pmst.setString(2,destination);
}else{
pmst.setString(1,travelDate);
pmst.setString(2,origin);
pmst.setString(3,travelDate);
pmst.setString(4,destination);
}

rs = pmst.executeQuery();
%>

<table>
	<tr><th>Train Id</th><th>Transit Line	</th>
		<th>Date</th>
		<th>Origin</th>
		<th>Departure Time</th>
		<th>Destination</th>
		<th>Arrival Time</th>
		<th>Travel Time</th>
		<th>Fare - No Booking Fee</th>
		</tr>
<%
while(rs.next()){
%>

    <tr>
    <td><%=rs.getString("ID")%></td><td><%=rs.getString("transit_line")%></td>
    <td><%=rs.getString("date")%></td>
    <td><%=rs.getString("origin")%></td>
    <td><%=rs.getString("departure_time")%></td>
    <td><%=rs.getString("destination")%></td>
    <td><%=rs.getString("arrival_time")%></td>
    <td><%=rs.getString("Travel_Time")%></td>
    <td><%=rs.getString("fareNoBookingFee")%></td>
    </tr>

<%} %>
    </table>
	 
	 <%
	 rs = pmst.executeQuery();
	 	
	 	%>
	 <br>Select a train ID # to see all of the train's stops <br>		
	 <form action="" method="POST">>
			<select name = "trainID" id = "trainID" onchange = "this.form.submit()">
				<option value="0">Select Train ID</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"
		            <%
		            if(request.getParameter("trainID") != null) {
		            	if (rs.getString(1).equals(request.getParameter("trainID"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            ><%=rs.getString("ID")%></option>
		        <% } %>
		        
		    
	        </select>
	        
	        <select name = "sort" id = "sort" onchange = "this.form.submit()">
	        	<option value = "0" selected = "selected">Please select a new sorting method</option>
	        	
	        	<option value = "1">Destination</option>
	        	<option value = "2">Arrival Time</option>
	        </select>
	      </form>  
		<%
		String trainSort = "3";
		if(request.getParameter("sort") != null){
			trainSort = request.getParameter("sort");
		}
		
		
		switch(Integer.parseInt(trainSort)){

		case (1):
			trainSort = "order by destination";
			break;
		case (2):
			trainSort = "order by arrival_time";
			break;
		default:
			trainSort = "order by arrival_time";
			break;

	}
		
		 pmst = con.prepareStatement("SELECT s2.name as destination, s1.arrival_time as arrival_time FROM project.stops_at_new s1 left join project.Station_new s2 on s1.stationID = s2.stationID where s1.trainID = ? " + trainSort);

		pmst.setString(1,request.getParameter("trainID"));
		rs = pmst.executeQuery();
		%>
	        
	        <table>
				<tr><th>Destination</th><th>Arrival Time</th></tr>
		
					<%while(rs.next()){%>

   						 <tr> <td><%=rs.getString("destination")%></td>
   						 <td><%=rs.getString("arrival_time")%></td></tr>

					<%} 
					pmst.close();
					rs.close();
					%>
  		  </table>
	        
	        
	

</body>
</html>