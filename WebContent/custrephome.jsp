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
		if ((session.getAttribute("userID") == null)) {
		%>
		You are not logged in<br/>
		<a href="login.jsp">Please Login</a>
		<%
		} 
		    else {
		%>
		<h1> Welcome <%=session.getAttribute("userID")%> </h1>
		<br/>
		
		<%--Messaging stuffs --%>
		<p> Any Questions? <a href='questions.jsp'>Click Here</a> </p>
		<br/>
		
		
		<p> Answer Questions <a href = 'answerquestions.jsp'> Click Here </a> <p>
		<br/>
		<%--Messaging stuffs --%>
		
		<p> Add Reservation? <a href = 'repaddreservation.jsp'> Click Here </a> <p>
		<br/>
	
		
		<p> Edit Reservation? <a href = 'repeditreservation.jsp'> Click Here </a> <p>
		<br/>
		
		
		<p> Delete Reservation? <a href = 'repdeletereservation.jsp'> Click Here </a> <p>
		<br/>
		
		
		<p> Add Train Schedule Information? <a href = 'repaddscheduleinfo.jsp'> Click Here </a> <p>
		<br/>
	
		
		<p> Edit Train Schedule Information? <a href = 'repeditscheduleinfo.jsp'> Click Here </a> <p>
		<br/>
		
		
		<p> Delete Train Schedule Information? <a href = 'repdeletescheduleinfo.jsp'> Click Here </a> <p>
		<br/>
		
		<p> Get train schedule for origin and destination? <a href = 'scheduleoridest.jsp'> Click Here </a> <p>
		<br/>
		
		<p> Get train schedule for a station? <a href = 'stationschedule.jsp'> Click Here </a> <p>
		<br/>
		
		<p> Get passenger names for a certain train and transitline? <a href = 'passinfo.jsp'> Click Here </a> <p>
		<br/>
		
		<a href='logout.jsp'>Log out</a>
		<%
		    }
		%>


</body>
</html>