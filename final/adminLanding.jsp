<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin</title>
</head>

<body>
<h1>ADMIN ACCESS</h1>
Create an Account:
<br>
	<form method="post" action="adminCR.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="crusername"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="crpassword"></td>
	</tr>
	</table>
	<%--This is drop down menu when admin selects if the user is CR or not --%>
	Is it a Staff account? <br> 
	<select name="isStaff">
			<option value="yes">YES</option>
			<option value="no">NO</option>
	</select>
	<br>
	<input type="submit" value="Create Account">
	</form>
<br>


Sales Report of all the items Sold
<br>
<%--Create a Sales Report of all the items sold--%>
	<input type="button" value="Sales Report"
		onclick="window.location='TEReport.jsp'">
<br>


<%-- Create Report for items by Category --%>
<form method="post" action="categorySalesReport.jsp">
Sales Report for particular Category Items:-
<br>
<select name="SalesCategory">
	<option value="laptop">Laptops</option>
	<option value="phone">Phones</option>
	<option value="tablet">Tablets</option>
</select>
<br>
<input type="submit" value="Create Report">
</form>
<br>


<%-- Create Report for particular user --%>
<form method="post" action="userSalesReport.jsp">
Sales Report for particular User:-
<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
</table>
<input type="submit" value="Create Report">
</form>
<br>

<br>
<br>

Buy/Sell an item:-
<form method="post" action="items.jsp">
<table>

<td><input type = "hidden" name = "username" value = "ADMIN"></td>

</table>
<input type="submit" value="Sell an Item" onclick="window.location='items.jsp'">

</form>
<br>
<br>

<%--Admin can perform activites like buy and sell --%>
Search for items based on Category (PAGE includes Bidding and Auction):-
	<form method="post" action="itemQuery.jsp">
		<select name="itemcat" size=1>
			<option value="all">All</option>
			<option value="laptop">Laptop</option>
			<option value="phone">Phone</option>
			<option value="tablet">Tablet</option>
	
		</select>&nbsp;<br> 
	
		<input type="submit" value="Search">
	</form>
<br>

<form method="post" action="adminDeleteAuction.jsp">
Delete Current Auction:- IN PROGRESS
<br>
<%--Delete an auction from the table shown in the next page--%>
	<input type="button" value="Delete Auction/Bid"
		onclick="window.location='deleteAuction.jsp'">
<br>

</form>

<%-- Create a table for best selling items based on Category --%>
Get the best Selling Items in particular Category :-
<br>
<form method="post" action="bestSellingItems.jsp">
<select name="category">
	<option value="all">All</option>
	<option value="laptop">Laptop</option>
	<option value="phone">Phone</option>
	<option value="tablet">Tablet</option>
</select>
<br>
<input type="submit" value="List top Selling items">
</form>
<br>
<br>


<%-- List of top 10 best Sellers/Buyers --%>
Top 10 Best Sellers/Buyers :-
<br>
<form method="post" action="bestSellerBuyer.jsp">
<select name="usertype">
	<option value="buyer">Buyer</option>
	<option value="seller">Seller</option>
</select>
<br>
<input type="submit" value="List Top 10">
</form>
<br>
<br>

<%--Logout Button--%>
<input type="button" value="Logout" onclick="window.location='index.jsp'">

</body>
</html>