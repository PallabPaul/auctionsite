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
			
			String str2 = "SELECT * FROM auctions";
			
			ResultSet result2 = stmt.executeQuery(str2);
			
			while (result2.next()) {
				
				int auctionid = result2.getInt("auctionid");
				double curprice = result2.getDouble("curPrice");
				double reserve = result2.getDouble("reserve");
				Timestamp endtime = result2.getTimestamp("endTime");
				String curbidder = result2.getString("currBidder");
				
				Timestamp ts = new Timestamp(System.currentTimeMillis());
				
				if(endtime.before(ts)){
					
					if((reserve != 0.00 && curprice >= reserve) || (reserve == 0.00)){
						
						String insert4 = "UPDATE auctions SET endPrice =? , winner =? WHERE auctionid =?";
						
						PreparedStatement ps4 = con.prepareStatement(insert4);
						
						ps4.setDouble(1, curprice);
						
						if(curbidder.equals("no bid yet") == true){
							ps4.setString(2, "no winner because there were no bids");	
						}
						else{
							ps4.setString(2, curbidder);
						}
						ps4.setInt(3, auctionid);
						
						ps4.executeUpdate();
						
					}
					else{
						
						String insert4 = "UPDATE auctions SET winner =? WHERE auctionid =?";
						
						PreparedStatement ps4 = con.prepareStatement(insert4);
						
						ps4.setString(1, "no winner due to reserve price not being met");
						ps4.setInt(2, auctionid);
						
						ps4.executeUpdate();
						
					}
					
				}
			
			}
			
			
			//Get the combobox from the index.jsp
			String entity = request.getParameter("itemcat");
			
			String str = "";
			
			if(entity.equals("all") == true){
				
				str = "SELECT * FROM items i, auctions a WHERE a.auctionid = i.auctionid";
				
			}
			else{
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				str = "SELECT * FROM items i, auctions a WHERE a.auctionid = i.auctionid and i.category = '" + entity + "'";
			
			}
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
Place Bid:
<br>
	<form method="post" action="bid.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	<tr>
	<td>Amount to Bid</td><td><input type="text" name="bidamount"></td>
	</tr>
	<tr>
	<td>Auto Bid Limit</td><td><input type="text" name="upperlimit" value = "optional"> Leave as "optional" if you don't want to auto bid.</td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Place Bid">
	</form>
<br>
<br>
History of Bids:
<br>
	<form method="post" action="bidHistory.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	</table>
	<input type="submit" value="View History">
	</form>
<br>
<br>
Other User's Auctions:
<br>
	<form method="post" action="userHistory.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="View History">
	</form>
<br>

<br>
	<form method="post" action="similarBids.jsp">
	<table>
	</table>
	<input type="submit" value="Similar Auctions From Last Month">
	</form>
<br>
<br>
<br>
Delete Auction:
<br>
	<form method="post" action="delAuc.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid" value = "in progress"></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Delete Auction">
	</form>
<br>
<br>
<br>
Delete Latest Bid:
<br>
	<form method="post" action="delBid.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid" value = "in progress"></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Delete Latest Bid">
	</form>
<br>


</body>
</html>