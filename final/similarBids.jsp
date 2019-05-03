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

	<% String newusername = request.getParameter("username");%>
	
	<%
		List<String> list = new ArrayList<String>();

		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			int newauctionid = Integer.parseInt(request.getParameter("auctionid"));
			String newbrand = "";
			/*
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			java.util.Date date = new java.util.Date();
			date.setTime(ts.getTime() - 2629746000);
		//	java.util.Date monthAgo = new java.util.Date(date - 2629746);
			String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
			*/
			Calendar cal = Calendar.getInstance();
			cal.setTime(new java.util.Date());
			int num =30; // here is a number of days to add/subtract
			// add number of days
			cal.add(Calendar.DATE ,(-num));
			java.util.Date ed = cal.getTime();
			//and now formatting the date to meet ur requirements,I prefer
			// dd.MM.yy
			String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ed);
			//out.println(formattedDate);
			

			
			
			
			
			String str2 = "SELECT brand FROM items WHERE auctionid ='" + newauctionid + "'";
			
			ResultSet result2 = stmt.executeQuery(str2);
			
			if(result2.next()){
				newbrand = result2.getString("brand");
			}
			
			
			String str = "";
			
			
				
			str = "SELECT * FROM items i, auctions a WHERE a.auctionid = i.auctionid AND i.brand='" + newbrand + "' AND a.startTime > '" + formattedDate + "'";
				
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

</body>
</html>