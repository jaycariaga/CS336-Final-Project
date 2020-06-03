<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import ="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Customer Details</title>
</head>
<body>
<%
	String admin = (String) session.getAttribute("username");
	if(!admin.contains("admin")){
		response.sendRedirect("login.jsp");
	}
	String username = request.getParameter("cusername");
	session.setAttribute("cusername", username);
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("SELECT * FROM project.User WHERE username='" + username + "';");
	if (rs.next()) {
        if(username.contains("custrep")){		        
        	response.sendRedirect("ChangeRep.jsp");
        }
	}
    else{
     	response.sendRedirect("AdminHome.jsp");}
	st.close();
	rs.close();
	con.close();
    
%>
	<p> Enter new values in fields. If nothing is entered the current entry will be replaced
		by an empty string. Mandatory fields password and username cannot be deleted as they'd 
		cause the customer to be deleted. </p>

	<form action="ChangeCustomerBackend.jsp" method="POST">
	Username: <input type="text" name = "username2" />
	<hr>
	Password: <input type = "text" name = "password" />
	<hr>
	First Name: <input type = "text" name = "first_name" />
	<hr>
	Last Name: <input type = "text" name = "last_name" />
	<input type="submit" value="Submit"/>
	</form>
	<p> If you want to change other fields, click here <p>
	<form action="ChangeOtherCustomerFields.jsp" method = "Post">
	<input type = "submit" value = "click me" />
	</form>
	<hr>
	<p> If you'd like to delete this customer, click here </p>
	<form action ="DeleteCustomer.jsp" method = "Post" >
	<input type = "submit" value = "Delete" />
	</form>



</body>
</html>