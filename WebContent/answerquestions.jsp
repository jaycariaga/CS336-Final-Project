<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Answer Question</title>
	</head>
	<body>
		<% // Account for unlogged users		
		String userName = (String) session.getAttribute("userID");;
		if (userName == null) {
		   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		   rd.forward(request, response);
		}
		%>
		<a href = "custrephome.jsp">Home</a><br><br>
		
		
		<form action="answerquestions.jsp" method="POST">
		

			<%
			Class.forName("com.mysql.jdbc.Driver");				    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
			Statement st = con.createStatement();
	        ResultSet questions;
			questions = st.executeQuery("SELECT question FROM project.Forum;");
	        %>	        
	        
			
			<br> Select Question <br>	
			<select name = "ques" id = "ques" onchange = "this.form.submit()">
				<option value="0">Select Question</option>
		        <%while(questions.next()){ %>
		            <option value = "<%=questions.getString(1)%>"		            
		            <%
		            if(request.getParameter("ques") != null) {
		            	if (questions.getString(1).equals(request.getParameter("ques"))) {
		            		out.println("selected");
		            	}
		            }
		            %>
		            
		            ><%=questions.getString(1)%></option>
		        <% } %>
	        </select>
	        
	        <%
	        questions.close();
	        st.close();
	        %>
	        
	        <br> <br> <br>Answer: <input type="text" name="answer"/> <br><br>
      		
      		<input type="submit" value="Submit"/><br> <br> <br>
     	</form>
     	
     	<%
				String question = request.getParameter("ques");
     			String ans = request.getParameter("answer");
     	%>		
     	
     	<br><a href = "insertanswer.jsp?question=<%=question%>&answer=<%=ans%>"><button type="button">Submit Answer</button></a>	
   </body>
</html>