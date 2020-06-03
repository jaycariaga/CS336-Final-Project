<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
         <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Home</title>
	</head>
	<body>	
	
		<%
		    if ((session.getAttribute("userID") == null)) {
		%>
		You are not logged in<br/>
		<a href="login.jsp">Please Login</a>
		<%
		} 
		else {
		%>
		<h1> Welcome <%=session.getAttribute("userID")%> </h1>
		
		<br>
		
		<%-- Reservation stuff by Shubham Rustagi --%>	
		<h2 style = "text-decoration:underline;">Reservations</h2>		 
		<a href='makeReservation.jsp'>Make a reservation</a>
		<br/>		
		<a href='historyReservation.jsp'>View reservation history or cancel existing reservation</a>
		<br><br>
		
		
		
		<%-- Stuff for delayed updates BY JASON CARIAGA--%>	 
		<div border=1px >		
			<% 
				//table creation
				Class.forName("com.mysql.jdbc.Driver");
			    
				Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			    Statement st = con.createStatement();
			    ResultSet browsefor;
			    
			    browsefor = st.executeQuery("select trainID as delayedTrain, stationID as stationID from project.stops_at_new where isdelayed = 1 group by trainID;" );
			%>
			
			<h2 style="color: #ff0000; text-decoration:underline;">Delays:</h2>
			<table border ="1px" align = "left"> 
				<tr> 
					<th>Train:</th> 

		     	</tr>
				<% 
				String alertmsg = ""; //does the alert message part
			 // If query is a success
			 	while (browsefor.next()) {
			 		alertmsg += "Train: " + browsefor.getString("delayedTrain") + " is DELAYED!" + " | ";
			 	%>
			 	<tr>
			 		<td> <%=browsefor.getString("delayedTrain")%> </td>

			 		</td>
			 		</tr>
			 	<% 
			 		    }
				//System.out.println(alertmsg);
			    %>  
					       
		       	</table>
	       	
		</div>
		<br/>
		
		<% 
		st.close();
   	 	con.close();
   	 	
   	 	if(alertmsg != ""){    	%>
    
    		<script type="text/javascript">     
    		var value = "<%=alertmsg%>";
    		alert(value)</script>

		<% } %>		
		
		<%--Messaging stuffs by JASON CARIAGA--%>
		<br><br><br><br><br>
		<p> Any Questions? <a href='questions.jsp'>CLICK HERE</a> </p>
		
		<br>
		<h3>
		<a href='logout.jsp'>Log out</a>
		</h3>
		
		<%} %>
		
	</body>
</html>