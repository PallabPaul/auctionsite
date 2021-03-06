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
		String reqUsername = request.getParameter("username");
		String newReqSubject = request.getParameter("reqSubject");
		String newMessage = request.getParameter("message");
		//String newDateTime = request.getParameter("dateTime");

		
		//java.util.Date dateStr = newDateTime
		//java.sql.Date dateDB = new java.sql.Date(dateStr.getTime());
		
		int idnum = -1;
		
		String str = "SELECT MAX(questionID) maxid FROM requests";
		ResultSet result = stmt.executeQuery(str);
		
		if(result.next()){
		
		idnum = result.getInt("maxid");
		
		}
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO requests(questionID, username, reqSubject, message)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, idnum+1);
		ps.setString(2, reqUsername);
		ps.setString(3, newReqSubject);
		ps.setString(4, newMessage);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Item Successfully Listed!");
		//<input type="button" value="Return to Forums Page" onclick="window.location='forumPage.jsp'">
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nRequest not added to DB:	 Failed :()");
	}
%>
</body>
</html>