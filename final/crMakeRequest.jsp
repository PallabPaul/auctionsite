<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		
		int newquestionID = Integer.parseInt(request.getParameter("questionID"));
		String newresponse = request.getParameter("response");
		//String newDateTime = request.getParameter("dateTime");
		
		//java.util.Date dateStr = newDateTime
		//java.sql.Date dateDB = new java.sql.Date(dateStr.getTime());
		
		//Make an insert statement for the Sells table:
		String insert = "UPDATE requests SET response ='" + newresponse + "' WHERE questionID =" + newquestionID;
		//out.println(insert);
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		//ps.setString(1, newresponse);
		//ps.setInt(2, newquestionID);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Response Submitted Successfully");
		//<input type="button" value="Return to Forums Page" onclick="window.location='forumPage.jsp'">
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nRequest not added to DB:	 Failed :()");
	}
%>
</body>
</html>