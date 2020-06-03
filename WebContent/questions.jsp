<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import ="java.sql.*" %>
          <%@ page import ="java.time.*" %>
     
<!DOCTYPE html>
<html>
<head>
<style>
div{
  width: auto;
  padding: 10px;
}
</style>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href='home.jsp'> <h3>Go Back to Home</h3></a>

<% 
//ENTIRE PAGE DONE BY JASON CARIAGA


//out.println(java.time.LocalDate.now()); //gets the date in format needed for create queries...!
//page development for browsing and/or for creating a question
			String newquest = request.getParameter("somequestion");

			Class.forName("com.mysql.jdbc.Driver");
		    
			Connection con = DriverManager.getConnection("jdbc:mysql://db-project.cwtgu3tqnwx8.us-east-2.rds.amazonaws.com","admin", "database");
		    Statement st = con.createStatement();
		    
%>

<div>		    

<% //for searching a question...done i think 
//out.println("");
%>
<form action="SearchForumDetail.jsp" method="POST" padding= 6px >
       <h2> Search Question/Answer:</h2> <input type="text" name="searchit" placeholder="Search Here" required /> <br/>
       <input type="submit" value="Submit" />


</form>


	<% 
	ResultSet insertinto;
	//for posting a question - reloads page 
	if(newquest != null ){ //if question is not empty carry procedure of insert
		int forumid = 1;
 		ResultSet checkid = st.executeQuery("select count(*) as counted from project.Forum;");
 		if(checkid.next())
			forumid = Integer.parseInt(checkid.getString("counted"));
		System.out.println(forumid);
 		
		LocalDate currentdate = java.time.LocalDate.now();
		
		forumid += 1; //increments over last forumid and sets it as the new question id...
				//important: use executeUpdate() for db changing statements like modify or insert!!!
		st.executeUpdate("insert into project.Forum(forum_id, question, timestamp) Values(" + String.valueOf(forumid) + ", '" + newquest + "', '" + currentdate + "' );" );
		System.out.println(forumid + " question created...");
        response.sendRedirect("questions.jsp");

	}
	
	%>

<form action="questions.jsp" method="POST"> 
       <h2>Wanna ask a Question?: </h2><input type="text" name="somequestion" placeholder="Ask Here" required /> <br/>
       <input type="submit" value="Submit" />
	<br/>
</form>

	
	</div>
	<h2>Most Recent Questions:</h2>
	
	<%
	
	ResultSet browsefor;
    
    browsefor = st.executeQuery("SELECT Question, if(isnull(answer), 'none', answer) as Answer, Timestamp FROM project.Forum GROUP BY question LIMIT 30 ;" );
	//table creation
		    %>
		    <div>
		    <table border ="1px" align = "left"   border-collapse: collapse > 
			<tr> 
				<th>Questions</th> 
				<th>Answers</th>  
				<th>Date</th>  				
				       
	       	</tr>
		    
		    <% 
		 // If query is a success
		 	while (browsefor.next()) {
		 		
		 	%>
		 	<tr>
		 		<td> <%=browsefor.getString("question")%> </td>
		 		<td> <%=browsefor.getString("answer")%> 
		 		</td>
		 		<td> <%=browsefor.getString("timestamp")%> </td>
		 		</tr>
		 	<% 
		 		
		 		    }
		    
		    %> 
		    
		    </table> 
		    </div>
		    
		    <br />
	<br />
	
	
	
	<% st.close();
   	 con.close();
    %>



</body>
</html>
