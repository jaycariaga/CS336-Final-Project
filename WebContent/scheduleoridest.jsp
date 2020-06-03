<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Get Information</title>
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
		<form action="scheduleoridest.jsp" method="POST">
		
			<br/>
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
	        ResultSet origin;
			origin = st.executeQuery("SELECT Distinct name FROM project.Station_new");
	        %>	        
	        
			
			<br><br> Select <b>ORIGIN</b> Station <br>	
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
	        ResultSet dest;
			dest = st.executeQuery("SELECT Distinct name FROM project.Station_new");
	        %>	        
	        
			
			<br><br> Select <b>DESTINATION</b> Station <br>	
			<select name = "dest" id = "dest" onchange = "this.form.submit()">
				<option value="0">Select destination station</option>
		        <%while(dest.next()){ %>
		            <option value = "<%=dest.getString(1)%>"		            
		            <%
		            if(request.getParameter("dest") != null) {
		            	if (dest.getString(1).equals(request.getParameter("dest"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=dest.getString(1)%></option>
		        <% } %>
	        </select>
	        
	        
	        <%
	        dest.close();
	        st.close();	
	        %>
     	</form>
     	
     	
     		<%
				String origin1 = request.getParameter("origin");
 				String dest1 = request.getParameter("dest");
     		%>
     		
     		<br> <br><b>Updating schedule information for: </b> <br><br>
     		Origin Station Selected: <%=origin1%><br><br>
     		Destination Station Selected: <%=dest1%><br>
     		<br><a href = "printoridest.jsp?origin=<%=origin1%>&dest=<%=dest1%>"><button type="button">Confirm Selections</button></a>	
				
   </body>
</html>