<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%-- List of Buyer or Seller? --%>
<% String list_of_what = request.getParameter("usertype"); %>

<%
try{
	if(list_of_what.equals("seller")){
		//Top 10 Buyers
		out.print("<H1> Here is the list of top Sellers </H1>");
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String str = "SELECT username, COUNT(*) FROM auctions WHERE endPrice > 0 GROUP BY username ORDER BY 2 DESC";
		ResultSet result = stmt.executeQuery(str);
		if(result.next()){
			Integer x = 1;
			out.print("<table border='1'>");
			//make a row
			out.print("<tr>");
			//
			out.print("<td>"); out.print("Seller"); out.print("</td>");
			//
			out.print("<td>"); out.print("Number of Items Sold"); out.print("</td>");
			//
			out.print("</tr>");
			do{
				out.print("<tr>");
				//
				out.print("<td>"); out.print(result.getString("username")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
				//
				out.print("</tr>");
				//
				x++;
				if(x>10){
					break;
				}
				
			} while(result.next());
		}
		else {
			out.print("None of the sellers have had a successful auctions yet :(");
		}
		
	}
	else{
		//Top 10 Sellers
		out.print("<H1> Here is the list of top Buyers </H1>");
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String str = "SELECT winner, COUNT(*) FROM auctions WHERE endPrice > 0 GROUP BY winner ORDER BY 2 DESC";
		ResultSet result = stmt.executeQuery(str);
		if(result.next()){
			Integer x = 1;
			out.print("<table border='1'>");
			//make a row
			out.print("<tr>");
			//
			out.print("<td>"); out.print("Buyer"); out.print("</td>");
			//
			out.print("<td>"); out.print("Number of Items Bought"); out.print("</td>");
			//
			out.print("</tr>");
			do{
				out.print("<tr>");
				//
				out.print("<td>"); out.print(result.getString("winner")); out.print("</td>");
				//
				out.print("<td>"); out.print(result.getString("COUNT(*)")); out.print("</td>");
				//
				out.print("</tr>");
				//
				x++;
				if(x>10){
					break;
				}
				
			} while(result.next());
		}
		else {
			out.print("None of the buyers have bought anything yet :(");
		}
	}
}
catch (Exception e){
	out.print(e);
}

%>

</body>
</html>
