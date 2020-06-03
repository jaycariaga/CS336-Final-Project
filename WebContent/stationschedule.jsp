<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Station Schedule</title>
	</head>
	<body>
		<% // Account for unlogged users		
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>
		<a href = "custrephome.jsp">Home</a><br><br>
		<b>If you are not making a change to a certain category, you still need to select the option again.</b><br> 
		<form action="stationschedule.jsp" method="POST">
		
			<br/>
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
	        ResultSet origin;
			origin = st.executeQuery("SELECT Distinct name FROM project.Station_new");
	        %>	        
	        
			
			<br><br> Select Station <br>	
			<select name = "origin" id = "origin" onchange = "this.form.submit()">
				<option value="0">Select origin station</option>
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
	        st.close();
	        %>
     	</form>
     	
     		<%
				String origin1 = request.getParameter("origin");
     		%>
     		
     		<br> <br><b>Schedule information for: </b> <br><br>
     		Station Selected: <%=origin1%><br><br>
     		<br><a href = "printschedule.jsp?origin=<%=origin1%>"><button type="button">Confirm Selections</button></a>	
				
   </body>
</html>