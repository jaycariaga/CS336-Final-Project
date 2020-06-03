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
	String username = (String) session.getAttribute("cusername");
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
	con.close();
	rs.close();
    
%>
	<p> Enter new values in fields. If nothing is entered, the field will remain the same. </p>
	<form action="ChangeCustomerBackend2.jsp" method="POST">
	State:<input type="text" name="state"/> <br/>     
    City:<input type="text" name="city"/> <br/>     
    Telephone:<input type="text" name="telephone"/> <br/>     
    Email:<input type="text" name="email"/> <br/>  
    Zip Code:<input type="text" name="zip"/> <br/>     
    Address:<input type="text" name="address"/> <br/>      
	<input type="submit" value="Submit"/>
	</form>	
</body>
</html>