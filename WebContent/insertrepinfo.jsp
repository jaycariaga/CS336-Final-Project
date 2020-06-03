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
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String ssn = request.getParameter("ssn");
		    
		    
			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    ResultSet rs;
		    rs = st.executeQuery("SELECT * FROM project.User WHERE username='" + username + "'");
		    System.out.println(rs);
		    
		    // If they're already in the database
		    if (rs.next()) {
		    	out.println("You seem to already have registered with that username. Please try <a href='login.jsp'>logging in</a> instead");
		    } 
		    else 
		    {
		    	String query = "Insert into project.User value('" + username + "', '" + password + "', '" + firstname + "', '" + lastname + "');";
		    	try
		        {
		        	st.executeUpdate(query);
				    out.println("You are signed up successfully" + "<br>");
		        }
		        catch(SQLException e)
		        {
		        	out.println("There was an error" + "<br>");
		        	st.close();	
				    con.close();
		        }
		    	
		    	String query1 = "Insert into project.Employee value('" + username + "', '" + ssn + "', 'rep');";
		    	try
		        {
		        	st.executeUpdate(query1);
		        }
		        catch(SQLException e)
		        {
		        	out.println("There was an error" + "<br>");
		        	st.close();	
				    con.close();
		        }
		    	
		    	String query2 = "Insert into project.Customer_Rep value('" + username + "', '" + ssn + "');";
		    	try
		        {
		        	st.executeUpdate(query2);
		        }
		        catch(SQLException e)
		        {
		        	out.println("There was an error" + "<br>");
		        	st.close();	
				    con.close();
		        }
		    	
		   }%>
		   
		<br><br><a href='login.jsp'>Go to Login Page</a>
	</body>
</html>