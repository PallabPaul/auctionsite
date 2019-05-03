<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Bid</title>
</head>
<body>

	<% String newusername = request.getParameter("username");%>
	
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();	
				
			String str = "SELECT * FROM bidhistory";
				
			
			//WHERE category = " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table border='1'>");

			//make a row
			out.print("<tr>");
			out.print("<td>");
			out.print("Bidder");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Auction ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Time of Bid");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Current Price");
			out.print("</td>");
			out.print("<td>");
			out.print("Price of Bid");
			out.print("</td>");
			out.print("<td>");
			out.print("Upper Limit");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("bidder"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getInt("auctionid"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getTimestamp("timeofbid"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getDouble("currentprice"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getDouble("priceofbid"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getDouble("upperLimit"));
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
Edit Bid Information
<br>
	<form method="post" action="editBidBack.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	<tr>
	<td>Price of Bid</td><td><input type="text" name="bidAmt"></td>
	</tr>
	</table>
	<input type="submit" value="Edit Bid">
	</form>
<br>
<br>


</body>
</html>