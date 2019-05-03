<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
<h1>List of all the current Auctions.</h1>
<%
try{
	
	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

	//Create a SQL statement
		Statement stmt = con.createStatement();
	
	String str = "SELECT DISTINCT * from auctions NATURAL JOIN items WHERE endPrice = 0";
	
	ResultSet result = stmt.executeQuery(str);
	
	//Make an HTML table to show the results in:
		out.print("<table border='1'>");

		//make a row
		out.print("<tr>");
		//
		out.print("<td>"); out.print("Auction ID"); out.print("</td>");
		//
		out.print("<td>"); out.print("Category"); out.print("</td>");
		//
		out.print("<td>"); out.print("Brand"); out.print("</td>");
		//
		out.print("<td>"); out.print("Year"); out.print("</td>");
		//
		out.print("<td>"); out.print("Type"); out.print("</td>");
		//
		out.print("<td>"); out.print("Seller"); out.print("</td>");
		//
		out.print("<td>"); out.print("Current Bidder\t"); out.print("</td>");
		//
		out.print("<td>"); out.print("Initial Price"); out.print("</td>");
		//
		out.print("<td>"); out.print("Current Price"); out.print("</td>");
		//
		out.print("<td>"); out.print("Start Time"); out.print("</td>");
		//
		out.print("<td>"); out.print("End Time"); out.print("</td>");
		//
		out.print("</tr>");
	
		while(result.next()){
			out.print("<tr>");
			//
			out.print("<td>"); out.print(result.getInt("auctionId")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("category")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("username")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getString("currBidder")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getDouble("startPrice")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getDouble("curPrice")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getTimestamp("startTime")); out.print("</td>");
			//
			out.print("<td>"); out.print(result.getTimestamp("endTime")); out.print("</td>");
			//
			out.print("</tr>");
		}
		out.print("</table>");
		con.close();
		
} catch (Exception ex){
	out.print(ex);
	out.print("Error while loading Delete Auction page.");
}
%>
<br>
<br>
Delete Auction:
<br>
	<form method="post" action="aucBidDel.jsp">
	<input type="hidden" name="deleteWhat" value="auction">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	</table>
	<input type="submit" value="Delete Auction">
	</form>
<br>



<%-- Table of auctions where admin can delete bids from. --%> 
<h1>List of all the current Auctions with Bids.</h1>
<%
try{
	//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

		//Create a SQL statement
			Statement stmt = con.createStatement();
		
		String str = "SELECT DISTINCT * from auctions NATURAL JOIN items WHERE endPrice = 0 AND winner != 'no winner due to reserve price not being met' AND currbidder != 'no bid yet'";
		
		ResultSet result = stmt.executeQuery(str);
		
		//Make an HTML table to show the results in:
			out.print("<table border='1'>");

			//make a row
			out.print("<tr>");
			//
			out.print("<td>"); out.print("Auction ID"); out.print("</td>");
			//
			out.print("<td>"); out.print("Category"); out.print("</td>");
			//
			out.print("<td>"); out.print("Brand"); out.print("</td>");
			//
			out.print("<td>"); out.print("Year"); out.print("</td>");
			//
			out.print("<td>"); out.print("Type"); out.print("</td>");
			//
			out.print("<td>"); out.print("Seller"); out.print("</td>");
			//
			out.print("<td>"); out.print("Current Bidder\t"); out.print("</td>");
			//
			out.print("<td>"); out.print("Initial Price"); out.print("</td>");
			//
			out.print("<td>"); out.print("Current Price"); out.print("</td>");
			//
			out.print("<td>"); out.print("Start Time"); out.print("</td>");
			//
			out.print("<td>"); out.print("End Time"); out.print("</td>");
			//
			out.print("</tr>");
		
			while(result.next()){
				out.print("<tr>");
				//
				out.print("<td>"); out.print(result.getInt("auctionId")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("category")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("username")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("currBidder")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getDouble("startPrice")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getDouble("curPrice")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getTimestamp("startTime")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getTimestamp("endTime")); out.print("</td>");
				//
				out.print("</tr>");
			}
			out.print("</table>");
			con.close();
}
catch(Exception e){
	out.print(e);
}
%>
<br>
<br>

Delete Current Bid:
<br>
	<form method="post" action="aucBidDel.jsp">
	<input type="hidden" name="deleteWhat" value="bid">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	</table>
	<input type="submit" value="Delete Current Bid">
	</form>
<br>
<br>
</body>
</html>