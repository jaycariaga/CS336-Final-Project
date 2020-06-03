<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert Question</title>
	</head>
	
	<body>	
		<%
			String userName = (String) session.getAttribute("userID");;
			if (userName == null) {
			   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			   rd.forward(request, response);
			}
			
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
		    
			String question = request.getParameter("question");
 			String ans = request.getParameter("answer");
 
 			String query = "Update project.Forum Set answer = '" + ans+ "' where question = '" + question + "';";
 			
    		try
			{
		      st.executeUpdate(query);
			  st.close();	
			  con.close();
			  out.println("The question was answered" + "<br>");
			}
		    catch(SQLException e)
		    {
		      out.println("There was an error" + "<br>");
			  st.close();	
		      con.close();
			}
%>		
			

		<br><br><a href='custrephome.jsp'>Go back home</a>
	</body>
</html> 



































