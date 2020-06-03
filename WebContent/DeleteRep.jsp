<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String rusername = (String) session.getAttribute("rusername");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	st.executeUpdate("Delete from project.User WHERE username='" + rusername + "';");
	con.close();
	st.close();
%>
<p> User: <%= rusername %> has been deleted <p>
	<a href = "AdminHome.jsp"> Go back to admin home </a>


</body>
</html>