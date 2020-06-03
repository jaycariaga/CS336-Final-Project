<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Sign Up Form</title>
   </head>
   <body>
   	<%-- Reservation stuff by Shubham Rustagi --%>	
   	 Signup or <a href = "login.jsp">login</a><br><br>
     <form action="checkSignUpDetails.jsp" method="POST">
     	First Name: <input type="text" name="firstname"/> <br><br>
     	Last Name: <input type="text" name="lastname"/> <br><br>
       	Username: <input type="text" name="username"/> <br><br>
       	Password:<input type="password" name="password"/> <br><br>
       	State:<input type="text" name="state"/> <br><br>     
       	City:<input type="text" name="city"/> <br><br> 
       	Telephone:<input type="text" name="telephone"/><br><br>
       	Email:<input type="text" name="email"/> <br><br>  
       	Zip Code:<input type="text" name="zip"/> <br><br>
       	Address:<input type="text" name="address"/> <br><br>   
       <input type="submit" value="Submit"/>
     </form>
     
     
   </body>
</html>