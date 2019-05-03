<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Total Earning Report</title>
</head>
<body>
<h1>Total Earning Report</h1>
<%
	try{
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//selecting all the tuples having an ending price
		String str = "SELECT * FROM auctions WHERE endPrice > startPrice";
		
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
		out.print("Buyer\t");
		out.print("</td>");
		//
		out.print("<td>");
		out.print("Initial Price");
		out.print("</td>");
		//
		out.print("<td>");
		out.print("Selling Price");
		out.print("</td>");
		//
		out.print("<td>");
		out.print("Total Profit");
		out.print("</td>");
		out.print("</tr>");
		
		//parse out the result
		while(result.next()){
			out.print("<tr>");
			//
			out.print("<td>");
			out.print(result.getInt("auctionId"));
			out.print("</td>");
			//
			out.print("<td>");
			out.print(result.getString("username"));
			out.print("</td>");
			//
			out.print("<td>");
			out.print(result.getString("winner"));
			out.print("</td>");
			//
			out.print("<td>");
			out.print(result.getDouble("startPrice"));
			out.print("</td>");
			//
			out.print("<td>");
			out.print(result.getDouble("endPrice"));
			out.print("</td>");
			//
			out.print("<td>");
			out.print(result.getDouble("endPrice") - result.getDouble("startPrice"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		con.close();
	}catch (Exception ex) {
		out.print(ex);
		out.print("Error while creating Total Earnings Report.");
	}
%>



</body>
</html>