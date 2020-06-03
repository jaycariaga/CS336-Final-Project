<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	</head>
	
	<body>	
		<%
			String userName = (String) session.getAttribute("userID");;
			if (userName == null) {
			   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			   rd.forward(request, response);
			}
		
		    String res = request.getParameter("resnum");
			
	     	int resnum = Integer.parseInt(res);
	     	
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
	        
	        String query = "Delete from project.Reservations where reservation_no = " + res;
	        try
	        {
	        	st.executeUpdate(query);  
	        	st.close();	
			    con.close();
			    out.println("The reservation was deleted!");
	        }
	        catch (SQLException se)
	        {
	        	out.println("The reservation could not be deleted!");
	        	st.close();	
			    con.close();
	        }
	          
		%>
		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 