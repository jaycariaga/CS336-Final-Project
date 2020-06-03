<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Get Passenger Information</title>
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
		<b>If you are not making a change to a certain category, you still need to select the option again.</b><br> 
		<form action="passinfo.jsp" method="POST">
		
			<br/>
			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
			ResultSet rs;
			ResultSet transit;
			transit = st.executeQuery("SELECT DISTINCT transit_line FROM project.Train_new;");
			%>
			
			Transit Line <br>			
			<select name = "transit1" id = "transit1" onchange = "this.form.submit()">
				<option value="0">Select transit line</option>
		        <%while(transit.next()){ %>
		            <option value = "<%=transit.getString(1)%>"
		            <%
		            if(request.getParameter("transit1") != null) {
		            	if (transit.getString(1).equals(request.getParameter("transit1"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            ><%=transit.getString(1)%></option>
		        <% } %>
	        </select>
		        
		     
		 	<%
		 	transit.close();
		 	PreparedStatement psmt = con.prepareStatement("SELECT trainID FROM project.Train_new WHERE transit_line=?");
	        psmt.setString(1, request.getParameter("transit1"));
	        rs = psmt.executeQuery(); 	        
	        %>	        
	        
			
			<br><br> Select Train <br>	
			<select name = "trainid" id = "trainid" onchange = "this.form.submit()">
				<option value="0">Select train</option>
		        <%while(rs.next()){ %>
		            <option value = "<%=rs.getString(1)%>"		            
		            <%
		            if(request.getParameter("trainid") != null) {
		            	if (rs.getString(1).equals(request.getParameter("trainid"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=rs.getString(1)%></option>
		        <% } %>
	        </select>
	        
	        <%
	        rs.close();
	        st.close();	
	        %>
	        
     	</form>
     	
     	
     		<%	
				String transitline1 = request.getParameter("transit1");
     			String trainid1 = request.getParameter("trainid");

     		%>
     		
     		<br> <br> Updating schedule information for: <br><br>
     		Transit Line: <%=transitline1%><br>
     		Train: <%=trainid1%><br>
     		<br><a href = "getpassinfo.jsp?transitline=<%=transitline1%>&trainid=<%=trainid1%>"><button type="button">Confirm Selection</button></a>	
				
   </body>
</html>