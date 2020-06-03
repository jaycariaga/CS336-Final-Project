<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   	<%-- Reservation stuff by Shubham Rustagi --%>	
   	 Welcome to the Train Reservation System. Please login. <br><br>
     <form action="checkLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <br><br>
     <a href = "signup.jsp">Sign up instead</a>
     <br><br>
     <a href = "repsignup.jsp">Customer Representative Sign Up</a>
   </body>
</html>