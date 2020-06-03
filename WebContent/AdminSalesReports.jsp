<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Sale Reports</title>
</head>
<body>
<%
	String admin = (String) session.getAttribute("username");
	if(!admin.contains("admin")){
		response.sendRedirect("login.jsp");
	}
	String userName = "admin";
	String month = (String) request.getParameter("month");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	String query = "Select * from project.Reservations where monthname(dateTimeReservationMade) = '" + month + "'Group by customerRep;";
	rs = st.executeQuery(query);
%>
		<h2>Monthly Total by Customer Representative</h2>
		<table>
		<tr>
			<th>Total</th> 
			<th>Customer Rep</th>
		
		
 		
<%
int i = 0;
while(rs.next())
{
	String customerRep = rs.getString("customerRep");
	if(customerRep == "NULL"){
		customerRep = "No Rep";
	}
%>		

		<tr>	
		

				<td> <%= rs.getDouble("total_fare") %>  </td>
				<td> <%= customerRep %>  </td> 
 
	       	
<%
}
	st.close();
	con.close();
	rs.close();
%>
</table>
	<a href = "AdminHome.jsp"> Go back to admin home </a>
	
</body>
</html>