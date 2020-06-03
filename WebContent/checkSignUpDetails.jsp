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
		<!-- Done by Shubham Rustagi -->
		<%
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
		    String userid = request.getParameter("username");   
		    String pwd = request.getParameter("password");
		    String state = request.getParameter("state");
		    String city = request.getParameter("city");
		    String telephone = request.getParameter("telephone");
		    String email = request.getParameter("email");		    
		    String zip = request.getParameter("zip");
		    String address = request.getParameter("address");
		    
		    
			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    ResultSet rs;
		    rs = st.executeQuery("SELECT * FROM project.User WHERE username='" + userid + "'");
		    System.out.println(rs);
		    
		    // If they're already in the database
		    if (rs.next()) {
		    	out.println("You seem to already have registered with that username. Please try <a href='login.jsp'>logging in</a> instead");
		    } else {
		    	// log them in as a user
		        st.executeUpdate("INSERT INTO project.User(username, password, first_name, last_name) VALUES('" + userid + "','" + pwd + "','" + firstname +"','"+ lastname + "')");		        
		       
		    	// log them in as a customer as well
		       	st.executeUpdate("INSERT INTO project.Customer(username, state, city, telephone, email, zip, address) VALUES('" + userid + "','" + state + "','" + city +"','"+ telephone + 
		       					"','" + email + "','" + zip + "','" + address + "')");
		       	out.println("Thank you for creating an account. Please <a href='login.jsp'>log in</a>");
		       	
		       	
		       	st.close();
		       	con.close();
		    }
		    
		%>
	</body>
</html>