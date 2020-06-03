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
	
	String username = (String) session.getAttribute("rusername");
%>
	<% 
	String newusername = request.getParameter("username2");
	String first_name = request.getParameter("first_name");
	String last_name = request.getParameter("last_name");
	String password = request.getParameter("password");
	String ssn = request.getParameter("ssn");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	Statement ts = con.createStatement();
	ResultSet rs;
	String unique = "Select * from project.User where username = '" + newusername + "';";
	rs = ts.executeQuery(unique);
	if(!username.contains("custrep")){		        
    	response.sendRedirect("ChangeCustomer.jsp");
    }
	if(rs.next()){
		newusername = null;
	}
	String query1 = "Update project.User set first_name = '" + first_name + "' where username = '" + username + "';";
	st.executeUpdate(query1);
	String query2 = "Update project.User set last_name = '" + last_name + "' where username = '" + username + "';";
	st.executeUpdate(query2);
	if(!password.isEmpty()){
		String query3 = "Update project.User set password = '" + password + "' where username = '" + username + "';";
		st.executeUpdate(query3);
	}

	if(!ssn.isEmpty()){
		String query5 = "Update project.Employee set SSN = '" + ssn + "' where username = '" + username + "';";
		st.executeUpdate(query5);
	}
	if(!newusername.isEmpty()){
		String query4 = "Update project.User set username = '" + newusername + "' where username = '" + username + "';";
		st.executeUpdate(query4);
	}
	con.close();
	rs.close();
	st.close();
	ts.close();
%>
	<a href = "AdminHome.jsp"> Go back to admin home </a>
	
</body>
</html>