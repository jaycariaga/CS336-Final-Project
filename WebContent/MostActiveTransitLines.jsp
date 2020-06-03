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
		Most Active Transit Lines
	</p>
<% 
	String first_name = (String) request.getParameter("first_name");
	String last_name = (String) request.getParameter("last_name");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	String query = "SELECT (adults+children+seniors+disabled) as coun, transit_line FROM project.Reservations Group by transit_line ORDER BY coun DESC LIMIT 5;";
	rs = st.executeQuery(query);
%>
<table>
<tr>
				<th>Index</th> 
				<th>Transit Line</th>    
				<th> Seats Taken </th>


		
<%

int i = 1;
while(rs.next()){ %> 
<tr>

	
    <td> <%=Integer.toString(i)%></td>
    <td> <%=rs.getString("transit_line")%></td>		   
    <td> <%=rs.getString("coun") %></td>		   
    		         	
	
            
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