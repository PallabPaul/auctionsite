<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("auctionid");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM bidhistory WHERE auctionid = '" + entity + "'";
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
			out.print("Bidder");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Time of Bid");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Previous Price");
			out.print("</td>");
			out.print("<td>");
			out.print("Price of Bid");
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
				out.print(result.getString("bidder"));
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
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	
</body>
</html>
