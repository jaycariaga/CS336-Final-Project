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

<h1 font= "25">Search Results </h1>

<%
//ENTIRE PAGE DONE BY JASON CARIAGA

			String questans = request.getParameter("searchit");

			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    ResultSet rs;
		    
		    rs = st.executeQuery("SELECT question, if(isnull(answer), 'none', answer) as answer FROM project.Forum WHERE (question LIKE '%" + questans + "%') OR (answer LIKE '%" + questans + "%') GROUP BY forum_id ;" );
		    System.out.println(rs);
		    
		    //table creation
		    %>
		    
		    <table border ="1" align = "center"> 
			<tr> 
				<th>Questions</th> 
				<th>Answers</th>         
	       	</tr>
		    
		    <% 
		 // If query is a success
		 	while (rs.next()) {
		 		
		 			//String questlist = rs.getString("answer");
		 			//String anslist = rs.getString("question");
		 	%>
		 	<tr>
		 		<td> <%=rs.getString("question")%> </td>
		 		<td> <%=rs.getString("answer")%> </td>
		 		
		 		</tr>
		 	<% 
		 		
		 		    }
		    
		    %> 
		    
		    </table> 
		    
		    <%
		     
		    out.println("Go back to <a href='questions.jsp'>search page</a>" );
		    
		%>
		
	<% st.close();
   	 con.close();
    %>

</body>
</html>