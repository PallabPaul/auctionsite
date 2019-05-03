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

<%String user = request.getParameter("username"); %>
<%
	try{
		
		//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

		//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
		
		String str = "SELECT * FROM auctions WHERE username = '" + user + "' AND endPrice > 0";
		String str2 = "SELECT COUNT(*) as count FROM auctions WHERE username = '" + user + "' AND endPrice > 0";
		String str3 = "SELECT * FROM auctions WHERE username = '" + user + "' AND endPrice > 0";
		
		ResultSet result1 = stmt.executeQuery(str);
		ResultSet result2 = stmt2.executeQuery(str2);
		ResultSet result3 = stmt3.executeQuery(str3);
		//appears2.getInt(0);
		if(result1.next()){
			
			result2.next();
			
			int total_auctions = result2.getInt("count");
			out.println("USERNAME :-  " + user);
			out.print("<BR>");
			out.print("Total number of SUCCESSFUL AUCTIONS :-  ");
			out.print(total_auctions);
			out.print("<Br>");
			double total_profit = 0;
			while(result3.next()){
				total_profit += (result3.getDouble("endPrice") - result3.getDouble("startPrice"));
			}
			out.print("Total EARNINGS :-  $");
			out.print(total_profit);
			out.print("<Br><BR>");
			
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
			out.print("Initial Price $$");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Selling Price $$");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Profit $$");
			out.print("</td>");
			out.print("</tr>");
			
			//parse out the result
			do {
				out.print("<tr>");
				//
				out.print("<td>");
				out.print(result1.getInt("auctionId"));
				out.print("</td>");
				//
				out.print("<td>");
				out.print(result1.getString("username"));
				out.print("</td>");
				//
				out.print("<td>");
				out.print(result1.getString("winner"));
				out.print("</td>");
				//
				out.print("<td>");
				out.print(result1.getDouble("startPrice"));
				out.print("</td>");
				//
				out.print("<td>");
				out.print(result1.getDouble("endPrice"));
				out.print("</td>");
				//
				out.print("<td>");
				out.print(result1.getDouble("endPrice") - result1.getDouble("startPrice"));
				out.print("</td>");
				out.print("</tr>");
			} while(result1.next());
			out.print("</table>");
		}else {
			out.print("Sorry! '"  + user + "' hasn't put up any AUCTIONS. NO SALES REPORT.");
		}
		con.close();		
	}
catch (Exception ex) {
	out.print(ex);
	out.print("<br>");
	out.print("Error while creating Total Earnings Report for " + user + ".");
}
%>




</body>
</html>