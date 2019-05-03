<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alerts</title>
</head>


<body>

<h1>Alerts</h1>
<%String username = request.getParameter("username"); %>
<%
		List<String> list = new ArrayList<String>();
		
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			
			out.print("<h4> You've been outbid </h4>");
			String str6 = "SELECT * FROM outbid WHERE outbidusername = '"+username+"'";
			ResultSet result6 = stmt4.executeQuery(str6);
			
			out.print("<table border = 1>");
			
			out.print("<tr>");
			
			out.print("<td>"); out.print("Auction ID"); out.print("</td>");
			
			out.print("<td>"); out.print("</td>");
			
			out.print("</tr>");
			
			
			while (result6.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>"); out.print(result6.getInt("auctionid")); out.print("</td>");

				out.print("<td>"); out.print("Unfortunately you have been out bid."); out.print("</td>");
				
				out.print("</tr>");
				
			}
			out.print("</table>");
			
			out.print("<br>");
			out.print("<br>");
			
			//Running a query check if there is an auction put up with similar item name
			String str1 = "SELECT * FROM alerts WHERE alertuser = '" + username + "' AND alerttype = 'no'";
			ResultSet result1 = stmt.executeQuery(str1);
			String checker;
			String str2, str3;
			ResultSet result2;
			Integer newauctionid;
			String seller;
			while(result1.next()) {
				checker = result1.getString("itemname");
				str2 = "SELECT * FROM items i, auctions a WHERE i.auctionid = a.auctionid AND type LIKE '%" + checker + "%' AND a.endPrice = 0";
				result2 = stmt1.executeQuery(str2);
				if(result2.next()){
					//checker= result2.getString("type");
					newauctionid = result2.getInt("auctionid");
					seller = result2.getString("username");
					str3 = "UPDATE alerts SET alerttype = 'yes', auctionid = '" + newauctionid + "', username = '" + seller + "' WHERE alertuser = '" +
					username + "' AND itemname = '" + checker + "'";
					stmt2.executeUpdate(str3);
					
				}
				
			}
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM alerts WHERE alertuser = '" + username + "' AND alerttype = 'yes'";
			//WHERE category = " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//String str5 = "SELECT * FROM items WHERE type LIKE '%" + checker + "%'";
			//ResultSet result5 = stmt3.executeQuery(str5);
			
			out.print("<h4> Fulfilled Alerts </h4>");
			//Make an HTML table to show the results in:
			out.print("<table border = 1>");
			//make a row
			out.print("<tr>");
			
			out.print("<td>"); out.print("Alert Number"); out.print("</td>");
			
			out.print("<td>");out.print("Seller Username"); out.print("</td>");
			//make a column
			out.print("<td>"); out.print("Entered Item Name"); out.print("</td>");
			
			out.print("<td>"); out.print("Action ID"); out.print("</td>");
			
			//out.print("<td>"); out.print("Alert Name"); out.print("</td>");
			
			out.print("</tr>");

			//parse out the results
			//result5.next();
			while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>"); out.print(result.getInt("alertid")); out.print("</td>");
				//make a column
				out.print("<td>"); out.print(result.getString("username")); out.print("</td>");
				
				out.print("<td>"); out.print(result.getString("itemname")); out.print("</td>");
				
				out.print("<td>"); out.print(result.getInt("auctionid")); out.print("</td>");
				
				//out.print("<td>"); out.print(result.getString("itemname")); out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	
	<form method= "post" action= "itemQuery.jsp"> 
	<input type = "hidden" name = "username" value = <%= username%>>
	<input type = "hidden" name = "itemcat" value = "all">
	<input type="submit" value="Go Place a bid">
	</form>
	
<br>	
<br>
<br>
	<form method= "post" action= "alertsLanding.jsp"> 
	<table>
	<tr>
	<td>Type of Item (iphone, macbook, etc.)</td>
	<td><input type="text" name="itemname"> (when this item gets put on sale you will get an alert)
	</td>
	</tr>
	</table>
	<input type = "hidden" name = "username" value = <%= username%>>
	<input type="submit" value="Set Item Alert">
	</form>
	
<br>
<br>
<%
try{	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String str = "SELECT * FROM alerts WHERE alertuser = '" + username + "' AND alerttype = 'no'"; 
	
	ResultSet result = stmt.executeQuery(str);
	out.print("<h4> Pending Alerts </h4>");
	out.print("<table border = 1>");
	//make a row
	out.print("<tr>");
	
	out.print("<td>"); out.print("Alert Number"); out.print("</td>");
	
	out.print("<td>");out.print("Seller Username"); out.print("</td>");
	//make a column
	out.print("<td>"); out.print("Item Name"); out.print("</td>");
	
	out.print("<td>"); out.print("Action ID"); out.print("</td>");
	
	out.print("</tr>");

	//parse out the results
	
	while (result.next()) {
		//make a row
		out.print("<tr>");
		
		out.print("<td>"); out.print(result.getInt("alertid")); out.print("</td>");
		//make a column
		out.print("<td>"); out.print(result.getString("username")); out.print("</td>");
		
		out.print("<td>"); out.print(result.getString("itemname")); out.print("</td>");
		
		out.print("<td>"); out.print(result.getInt("auctionid")); out.print("</td>");
		
		out.print("</tr>");

	}
	out.print("</table>");

	//close the connection.
	con.close();


	
	
}catch (Exception e){
	out.print(e);
}
%>
	
</body>
</html>