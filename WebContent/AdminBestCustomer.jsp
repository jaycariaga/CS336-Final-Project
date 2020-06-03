<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Best Customer</title>
</head>
<body>
	<p>
		Best Customer
	</p>
<% 
	String admin = (String) session.getAttribute("username");
	if(!admin.contains("admin")){
		response.sendRedirect("login.jsp");
	}
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	String query = "Select username, first_name, last_name from project.User where username = (SELECT customer FROM project.Reservations Group by customer ORDER BY total_fare DESC LIMIT 1);";
	rs = st.executeQuery(query);
%>
<table>
<tr>
				<th>Index</th> 
				<th>Username</th>    
				<th>First Name</th>
				<th> Last Name </th>    


		
<%

int i = 1;
while(rs.next()){ %> 
<tr>

	
    <td> <%=Integer.toString(i)%></td>
    <td> <%=rs.getString("username")%></td>		   
    <td> <%=rs.getString("first_name") %></td>
   	<td> <%=rs.getString("last_name")%></td>		   
    		         	
	
    
    <%-- Only have a delete button for future reservations and for uncancelled reservations --%>
         
</tr>
	        	
<% } 
	st.close();
	con.close();
	rs.close();
%>
</tr>
</table>

		 <a href = "AdminHome.jsp"> Go back to admin home </a>
 
</body>
</html>