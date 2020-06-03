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
	  Customer Representative Signup or <a href = "login.jsp">login</a><br><br>
     <form action="insertrepinfo.jsp" method="POST">
     	First Name: <input type="text" name="firstname"/> <br><br>
     	Last Name: <input type="text" name="lastname"/> <br><br>
       	Username: <input type="text" name="username"/> <br><br>
       	Password:<input type="password" name="password"/> <br><br>
		SSN: <input type="password" name="ssn"/> <br><br>
		<input type="submit" value="Submit"/>
		</form>
	</body>
</html>