<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Auction</title>
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
			
			
			
			
			//Get the combobox from the index.jsp
			String entity = request.getParameter("itemcat");
			
			String str = "";
			
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			java.util.Date date = new java.util.Date();
			date.setTime(ts.getTime());
			String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
			
				
			str = "SELECT * FROM items i, auctions a WHERE a.auctionid = i.auctionid and a.endTime > '" + formattedDate + "'";
				
			
			//WHERE category = " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table border='1'>");

			//make a row
			out.print("<tr>");
			out.print("<td>");
			out.print("Auction ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Seller");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Category");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Brand");
			out.print("</td>");
			out.print("<td>");
			out.print("Year");
			out.print("</td>");
			out.print("<td>");
			out.print("Type");
			out.print("</td>");
			out.print("<td>");
			out.print("End Time");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Price");
			out.print("</td>");
			out.print("<td>");
			out.print("Minimum Increment");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Bidder");
			out.print("</td>");
			out.print("<td>");
			out.print("Winner");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getInt("auctionid"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("category"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("brand"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("year"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("type"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getTimestamp("endTime"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("curPrice"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("increment"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("currBidder"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("winner"));
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
Edit Auction Information
<br>
	<form method="post" action="editAucBack.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	<tr>
	<td>Increment Amount</td><td><input type="text" name="incAmt" value="0">Leave as 0 if you do not wish to change</td>
	</tr>
	<tr>
	<td>End Time</td><td><input type="text" name="endTime">Leave blank if you do not wish to change</td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Edit Auction">
	</form>
<br>
<br>


</body>
</html>