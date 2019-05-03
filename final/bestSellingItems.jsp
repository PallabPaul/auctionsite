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

<% String what_category = request.getParameter("category"); %>

<%
try {
	
	if(what_category.equals("laptop")){
		//Best Selling Laptops
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Ordering the resultset based on count in descending order
		String str = "SELECT category, brand, year, type, COUNT(*) FROM items NATURAL JOIN auctions WHERE category = 'laptop' AND endPrice > 0 GROUP BY brand, year, type ORDER BY 4 DESC";
		ResultSet result = stmt.executeQuery(str);
		if(result.next()){
			
			out.print("<H1> Here is the list of Best Selling Laptops </H1>");
			Integer i = 1;
			out.print("<table border='1'>");
			//make a row
			out.print("<tr>");
			//
			out.print("<td>"); out.print("Category"); out.print("</td>");
			//
			out.print("<td>"); out.print("Brand"); out.print("</td>");
			//make a column
			out.print("<td>"); out.print("Type"); out.print("</td>");
			//make a column
			out.print("<td>"); out.print("Year");  out.print("</td>");
			//
			out.print("<td>"); out.print("Number of Items Sold"); out.print("</td>");
			//

			do{
				out.print("<tr>");
				//
				out.print("<td>"); out.print("Laptop"); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
				//
				out.print("</tr>");
				
				i++;
				if(i > 10) {
					break;
				}
				
			} while(result.next());
			
		}
		else {
			//resultset has nothing, which means there aren't laptops in auction table
			out.print("There hasn't been any successful Auction for LAPTOPS on this Auction Site :(.");
		}
	
		
	}
	else if(what_category.equals("phone")){
		//Best Selling Phones
		//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Ordering the resultset based on count in descending order
				String str = "SELECT category, brand, year, type, COUNT(*) FROM items NATURAL JOIN auctions WHERE category = 'phone' AND endPrice > 0 GROUP BY brand, year, type ORDER BY 4 DESC";
				ResultSet result = stmt.executeQuery(str);
				if(result.next()){
					
					out.print("<H1> Here is the list of Best Selling Phones </H1>");
					Integer i = 1;
					out.print("<table border='1'>");
					//make a row
					out.print("<tr>");
					//
					out.print("<td>"); out.print("Category"); out.print("</td>");
					//
					out.print("<td>"); out.print("Brand"); out.print("</td>");
					//make a column
					out.print("<td>"); out.print("Type"); out.print("</td>");
					//make a column
					out.print("<td>"); out.print("Year"); out.print("</td>");
					//
					out.print("<td>"); out.print("Number of Items Sold"); out.print("</td>");
					//

					do{
						out.print("<tr>");
						//
						out.print("<td>"); out.print("Phone"); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
						//
						out.print("</tr>");
						
						i++;
						if(i > 10) {
							break;
						}
						
					} while(result.next());
					
				}
				else {
					//resultset has nothing, which means there aren't laptops in auction table
					out.print("There hasn't been any successful Auction for PHONES on this Auction Site :(");
				}

	}
	else if(what_category.equals("tablet")){
		//Best Selling Tablets
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Ordering the resultset based on count in descending order
		String str = "SELECT category, brand, year, type, COUNT(*) FROM items NATURAL JOIN auctions WHERE category = 'tablet' AND endPrice > 0 GROUP BY brand, year, type ORDER BY 4 DESC";
		ResultSet result = stmt.executeQuery(str);
		if(result.next()){
			
			out.print("<H1> Here is the list of Best Selling Tablets </H1>");
			Integer i = 1;
			out.print("<table border='1'>");
			//make a row
			out.print("<tr>");
			//
			out.print("<td>"); out.print("Category"); out.print("</td>");
			//
			out.print("<td>"); out.print("Brand"); out.print("</td>");
			//make a column
			out.print("<td>"); out.print("Type"); out.print("</td>");
			//make a column
			out.print("<td>"); out.print("Year"); out.print("</td>");
			//
			out.print("<td>"); out.print("Number of Items Sold"); out.print("</td>");
			//

			do{
				out.print("<tr>");
				//
				out.print("<td>"); out.print("Tablet"); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
				//
				out.print("</tr>");
				
				i++;
				if(i > 10) {
					break;
				}
				
			} while(result.next());
			
		}
		else {
			//resultset has nothing, which means there aren't laptops in auction table
			out.print("There hasn't been any successful Auction for TABLETS on this Auction Site :(");
		}

	} 
	else {
		//Best Selling Items
		//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Ordering the resultset based on count in descending order
				String str = "SELECT category, brand, year, type, COUNT(*) FROM items NATURAL JOIN auctions WHERE endPrice > 0 GROUP BY brand, year, type ORDER BY 4 DESC";
				ResultSet result = stmt.executeQuery(str);
				if(result.next()){
					
					out.print("<H1> Here is the list of Best Selling Items </H1>");
					Integer i = 1;
					out.print("<table border='1'>");
					//make a row
					out.print("<tr>");
					//
					out.print("<td>"); out.print("Category"); out.print("</td>");
					//
					out.print("<td>"); out.print("Brand"); out.print("</td>");
					//make a column
					out.print("<td>"); out.print("Type"); out.print("</td>");
					//make a column
					out.print("<td>"); out.print("Year"); out.print("</td>");
					//
					out.print("<td>"); out.print("Number of Items Sold"); out.print("</td>");
					//

					do{
						out.print("<tr>");
						//
						out.print("<td>"); out.print(result.getString("category")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("brand")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("type")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("year")); out.print("</td>");
						//
						out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
						//
						out.print("</tr>");
						
						i++;
						if(i > 10) {
							break;
						}
						
					} while(result.next());
					
				}
				else {
					//resultset has nothing, which means there aren't laptops in auction table
					out.print("There hasn't been any successful Auction on this Auction Site :(");
				}
	}
	
	
}
catch (Exception e){
	out.print(e);
}
%>

</body>
</html>
