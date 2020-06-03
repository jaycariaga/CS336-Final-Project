<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Customer Details</title>
</head>
<body>
<%
	
	String username = (String) session.getAttribute("cusername");
%>
	<%= username %>
	<% 
	String state = request.getParameter("state");
	String city = request.getParameter("city");
	String telephone = request.getParameter("telephone");
	String email = request.getParameter("email");
	String zip = (String) request.getParameter("zip");
	String address = request.getParameter("address");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	Statement ts = con.createStatement();
	ResultSet rs;
	if(username.contains("custrep")){		        
    	response.sendRedirect("ChangeRep.jsp");}
	if(!city.isEmpty()){
		String query1 = "Update project.Customer set city = '" + city + "' where username = '" + username + "';";
		st.executeUpdate(query1);
	}
	if(!telephone.isEmpty()){
		String query2 = "Update project.Customer set telephone = '" + telephone + "' where username = '" + username + "';";
		st.executeUpdate(query2);
	}
	if(!email.isEmpty()){
		String query3 = "Update project.Customer set email = '" + email + "' where username = '" + username + "';";
		st.executeUpdate(query3);
	}
	if(!zip.isEmpty()){
		String query4 = "Update project.Customer set zip = '" + zip + "' where username = '" + username + "';";
		st.executeUpdate(query4);
	}
	if(!state.isEmpty()){
		String query5 = "Update project.Customer set state = '" + state + "' where username = '" + username + "';";
		st.executeUpdate(query5);
	}
	if(!address.isEmpty()){
		String query6 = "Update project.Customer set address = '" + address + "' where username = '" + username + "';";
		st.executeUpdate(query6);
	}
	st.close();
	con.close();
	ts.close();
%>
	<a href = "AdminHome.jsp"> Go back to admin home </a>

</body>
</html>