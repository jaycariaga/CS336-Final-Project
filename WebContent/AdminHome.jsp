<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>See list of reservations by</title>
</head>
<body>
	<p> What would you like to do? </p>
	<div>
	<p> Change user details? </p>
	 <form action="ChangeCustomer.jsp" method="POST">
		Customer username: <input type="text" name = "cusername" />
		<input type="submit" value="Submit"/>
     </form>
     <form action="ChangeRep.jsp" method="POST">
		CustomerRep username: <input type = "text" name = "rusername" />
		 <input type="submit" value="Submit"/>
     </form>
	</div>

	<p> See list of Reservations by </p>
	<div>
	<p> Customer? </p>
	 <form action="AdminCustomerReservations.jsp" method="POST">
       First name: <input type="text" name="first_name"/> <br/>
       Last name: <input type="text" name="last_name"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
	</div>
	<div>
	<p> Transit line and Train Number </p>
	 <form action="AdminTrainReservations.jsp" method="POST">
       trainID: <input type="text" name="trainID"/> <br/>
       Transit Line: <input type="text" name="transitLine"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
	</div>
	<div>
	<p> Which month would you like Sales Reports for?</p>
	 <form action="AdminSalesReports.jsp" method="POST">
       <input type="text" name="month"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
	</div>
		<p> Produce Revenue listings by </p>
	<div>
	<p> Customer Name </p>
	 <form action="AdminCustomerRevenue.jsp" method="POST">
       <input type="submit" value="Submit"/>
     </form>
	</div>
	<div>
	<p> Transit Line </p>
	 <form action="AdminTrainRevenue.jsp" method="POST">
       <input type="submit" value="Submit"/>
     </form>
	</div>
	<p> Destination City </p>
	 <form action="AdminCityRevenue.jsp" method="POST">
       <input type="submit" value="Submit"/>
     </form>
     <hr>
     <div>
	 <form action="AdminBestCustomer.jsp" method="POST">
       Best Customer: <input type="submit" value="Submit"/>
     </form>
	</div>
	 <hr>
     <div>
	 <form action="MostActiveTransitLines.jsp" method="POST">
       Most Active Transit Lines: <input type="submit" value="Submit"/>
     </form>
	</div>
</body>
</html>