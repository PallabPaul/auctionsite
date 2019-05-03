<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Forum</title>
</head>

<%String newusername = request.getParameter("username"); %>

<body>
<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM requests";
			//WHERE category = " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table border = 1>");

			//make a row
			out.print("<tr>");
			out.print("<td>");
			out.print("Question ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Subject");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Message");
			out.print("</td>");
			out.print("<td>");
			out.print("Customer Rep Response");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getInt("questionID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("reqSubject"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("message"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("response"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
<br>
<br>
<br>
<strong><font size="5">Make a customer request:</font></strong>
<br>
	<form method="post" action="makeRequest.jsp">
	<table>
	<tr>
		<td><input type = "hidden" name = "username" value = <%= newusername%>></td>
	</tr>
	<tr>
		<td>Request Subject:</td><td><input type="text" name="reqSubject"></td>
	</tr>
	<tr>
		<td>Request Message:</td><td><textarea name="message" rows="10" cols="30"></textarea></td>
	</tr>

	</table>
	<input type="submit" value="Post Question">
	</form>
<br>
<br>
<input type="button" onclick="location.reload();"value="Reload Page">
<br>
<input type="button" value="Back to Your Page" onclick="window.location='items.jsp'">


	

<input type="button" value="Logout" onclick="window.location='index.jsp'">

</body>
</html>