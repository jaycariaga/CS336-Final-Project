Project URL: ec2-3-19-222-126.us-east-2.compute.amazonaws.com:8080/cs336Final

Amazon EC2 and Apache Tomcat credentials:
	Tomcat:
		- Username: admin
		- Password: adminadmin

	Private key.pem file is attached in the Sakai submission

Project notes:
	- It takes 20 minutes to go between any 2 adjacent stations
	- There are 3 trains on any given day for each transit line, leaving the starting station in 3 hour intervals
	- The third train is always an express (skips a few stops)
	- All trains of a specific line start at the same station and end at the same station, but their stops on the route differ
	- Sample data has been provided for 3 days (06-10-2020, 06-11-2020, 06-12-2020)
	- A flat fee of $2.00 is charged to go between any 2 stations and a flat fee of $3.00 is charged as booking fee
	- For a train to be delayed, the actual stop time of the train has to be at LEAST 10 MINUTES LATER than the recorded, scheduled stop time.

Contributions:
	Shubham Rustagi
	    - Developed all "I" login/signup/logout functionality pertaining to customer/user login
		- Developed all "III. Reservations" functionality. All drop down menus are filtered with SQL queries so backend has to do almost no logical checks
		- You are able to only make reservations for future trains and only cancel future reservations (relative to today's date)
		- Reservations support multiple people coming on the train with you
		- For any reservation, if multiple people are booked, only the highest seat number will be shown in the history.
			- For example, if you book a ticket for 4 people on a train with 200 people, since seats are given in reverse order, only your seat number (200) will be shown,
			  but there will be 4 less available seats on the train that corresponds to your particular reservation
		- Datetimes recorded for reservations are done using the MYSQL server timezone, which is not the timezone for Eastern United States. So timestamps may look strange at first
		- Various ticket types (round trip, weekly pass, and monthly pass) are supported but these effectively just change ticket price. All types are treated as one way.
		- Similarly, seat types (first class, business class, economy class) only serve to change ticket price and are just counted as normal seats
		- Files responsible for: signup.jsp, login.jsp, logout.jsp, checkLoginDetails.jsp, checkSignUpDetails.jsp, hello.jsp, home.jsp,
								 makeReservation.jsp, insertReservation.jsp, historyReservation.jsp, deleteReservation.jsp

	Jason Cariaga
	    - Developed all of the "IV. Messaging Functions" as per the project checklist
		- Implemented searching/browsing questions with tables to show questions and answers
		- Allows the users to post questions for the rep to answer
		- Table of 30 most recent questions asked listed as a "browsing" functionality
		- table inside SearchForumDetail is a table listed as search result functionalities
	    - Created and gave a templated starting point for customer representative page
	    - Created database, assisted with testing data
	    - Files responsible for: questions.jsp, custrephome.jsp, home.jsp, SearchForumDetail.jsp, checkLoginDetails.jsp

	 Parker Fisher
	 	- Developed all functionality for "II. Browsing and search" functionality as per the project checklist
		- User can search for schedules by different criteria as outlined.
		- Website will assist user, (e.g. if a user gives "New Brunswick" as origin it will not show "Los Angeles" as an available option.
		- User can search for schedule by given date or by current date range
		- User can then find all stops that a train can take (this list can be sorted as well)
		- Files responsible for: schedule.jsp, foundSchedule.jsp

	Harpal Dhillon
		- Added admin account in database
		- Developed all funcionality for "V. Admin Functions" as per the project checklist.
		- Admins can add information for a customer, employee (non primary key fields)
		- Admins can edit information for a customer, employee (all fields)
		- Admins can delete information for a customer, employee (deleting only fields when deleting non primary key fields, deleting accounts when deleting primary key fields)
		- Admins can obtain a sales report for any given month listing revenue alongside customer rep
		- Admins can produce a list of reservations by transitline + train # and by customer name
		- Admins can produce a listing of revenue per transit line, destination city & customer name
		- Admins can see the best customer (by revenue generated)
		- Admins can see the most active transit lines (by seats occupied)
		- Files Responsible for: AdminBestCustomer.jsp, AdminCityRevenue.jsp, AdminCustomerReservations.jsp, AdminCustomerRevenue.jsp, AdminHome.jsp, AdminSalesReports.jsp, 
						   		 AdminTrainReservations.jsp, AdminTrainRevenue.jsp, ChangeCustomer.jsp, ChangeCustomerBackend.jsp, ChangeCustomerBackend2.jsp, 
						   		 ChangeOtherCustomerFields.jsp, ChangeReg.jsp, ChangeRepBackend.jsp, DeleteCustomer.jsp, DeleteRep.jsp, MostActiveTransitLines.jsp

	Karan Singh Arora:
		-Developed all functionality for "VI. Customer Representative" as per the project checklist
			- Developed all functionality for Customer Representaive.
			- Customer rep can add, edit and delete reservations for customers
				-on edit and delete, the number of seats available on the train are updated accordingly.
			- Customer rep can add, edit and delete train schedule information
			- They can answer questions that customers ask
			- Can get schedules for a origin station and destination station
			- Can get schedule for a particular station
			- Can get information on passengers that have seats reserved on a particular train and transit line
		- Added functionality to the customer rep home page to be able to do all of the actions above.
		- Added functionality for a customer rep to sign up and create an account
			- When a customer rep is hired by the company, they will be given an id number. Therefore when signing up, they
			  must sign up with the username "custrep" and then add their ID number. For example if a customer rep's ID is 25,
			  they must use the username "custrep25" when signing up for a customer representative account.
		- Files responsible for: answerquestions.jsp, custrephome.jsp, deleteaction.jsp, deleteschedule.jsp, getpassinfo.jsp,
								  insertanswer.jsp, insertrepinfo.jsp, insertschedule.jsp, makeedit.jsp, passinfo.jsp, printoridest.jsp,
								  printschedule.jsp, repaddreservation.jsp, repaddscheduleinfo.jsp, repdeletereservation.jsp,
								  repdeletescheduleinfo.jsp, repeditreservation.jsp, repeditscheduleinfo.jsp, repinsertreservation.jsp,
								  repsignup.jsp, scheduleoridest.jsp, scheduleupdate.jsp, stationschedule.jsp

Admin credentials:
	username: admin
	password: JWBPANTBPHSBAE
