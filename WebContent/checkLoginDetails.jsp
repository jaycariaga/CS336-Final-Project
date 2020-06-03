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
		    String userid = request.getParameter("username");   
		    String pwd = request.getParameter("password");
		    
			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    ResultSet rs;
		    rs = st.executeQuery("SELECT * FROM project.User WHERE username='" + userid + "' and password='" + pwd + "'");
		    
		    if (rs.next()) {
		        session.setAttribute("userID", userid); // the username will be stored in the session
		        if(userid.contains("custrep")){		        
		        	response.sendRedirect("custrephome.jsp");
		        }
		        if(userid.contains("admin")){
		        	session.setAttribute("username", userid);
		        	response.sendRedirect("AdminHome.jsp");
		        }
		        if(!userid.contains("admin") && !userid.contains("custrep")){
		        	response.sendRedirect("home.jsp");
		        }
		    } 
		    else {
		        out.println("Invalid username or password <a href='login.jsp'>try again</a>");
		    }
		    st.close();
		    con.close();
		%>
	</body>
</html> 
