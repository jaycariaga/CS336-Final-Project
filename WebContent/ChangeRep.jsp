<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Customer Rep Details</title>
</head>
<body>
<%
	String username = request.getParameter("rusername");
	session.setAttribute("rusername", username);
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("SELECT * FROM project.User WHERE username='" + username + "';");
	if (rs.next()) {
        if(!username.contains("custrep")){		        
        	response.sendRedirect("ChangeCustomer.jsp");
        }
	}
    else{
     	response.sendRedirect("AdminHome.jsp");}
    
%>
	<p> Enter new values in fields. If nothing is entered the current entry will be replaced
		by an empty string. Mandatory fields password, ssn and username cannot be deleted as they'd 
		cause the customer rep to be deleted. </p>
	<form action="ChangeRepBackend.jsp" method="POST">
	Username: <input type="text" name = "username2" />
	<hr>
	Password: <input type = "text" name = "password" />
	<hr>
	First Name: <input type = "text" name = "first_name" />
	<hr>
	Last Name: <input type = "text" name = "last_name" />
	<hr>
	Social Security Number: <input type = "text" name = "ssn" />
	<input type="submit" value="Submit"/>
	
	</form>
	<p> If you'd like to delete this rep, click here </p>
	<form action ="DeleteRep.jsp" method = "Post" >
	<input type = "submit" value = "Delete" />
	</form>
	




%>
</body>
</html>