<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Landing Page</title>
</head>

<%String username = (String)request.getAttribute("username"); %>

<%username = (String)request.getParameter("username"); %>
<body>
<h1>Hi <%= username%>. Buy or Sell </h1>

<strong><font size ="5">Basic Search</font></strong>
<br>
<br>
	<form method="post" action="itemQuery.jsp">
		<select name="itemcat" size=1>
			<option value="all">All</option>
			<option value="laptop">Laptop</option>
			<option value="phone">Phone</option>
			<option value="tablet">Tablet</option>
	
		</select>&nbsp;<br> 
		
	
		<input type = "hidden" name = "username" value = <%= username%>>
	
		
		<input type="submit" value="Basic Search">
	</form>
<br>

<strong><font size ="5">Advanced Search</font></strong>
<br>
<br>
	<form method="post" action="laptopSearch.jsp">

		<input type = "hidden" name = "username" value = <%= username%>>

		<input type="submit" value="Laptop">

		<input type="submit" value="Phone" formaction="phoneSearch.jsp">

		<input type="submit" value="Tablet" formaction="tabletSearch.jsp">		

	</form>

<br>

<br>
<strong><font size ="5">Sell an Item</font></strong>
<br>
	<form method="post" action="itemSell.jsp">
	<table>
	<tr>    
	<td>Item Category</td><td><select name="category" size=1>
			<option value="laptop">Laptop</option>
			<option value="phone">Phone</option>
			<option value="tablet">Tablet</option></select></td>
	</tr>
	<tr>
	<td>Start Price</td><td><input type="text" name="startprice"></td>
	</tr>
	<tr>
	<td>Secret Reserve Price</td><td><input type="text" name="reserve" value = "optional"> Leave as "optional" if you don't want to set a reserve price.</td>
	</tr>
	<tr>
	<td>Bid Increment</td><td><input type="text" name="increment"></td>
	</tr>
	<tr>
	<td>End date (yyyy-mm-dd hh:mm:ss)</td><td><input type="text" name="enddate"> Time will be automatically converted to UTC time which is 4 hours ahead of EST.</td>
	</tr>
	<tr>
	<td>Item Brand</td><td><input type="text" name="brand"></td>
	</tr>
	<tr>    
	<td>Item Year</td><td><input type="text" name="year"></td>
	</tr>
	<tr>
	<td>Item Type</td><td><input type="text" name="type"></td>
	</tr>
	<tr>

	<td>Laptops, input ram size</td><td><input type="text" value="0" name="ramsize"> If you are not selling a Laptop leave as is.</td>

	</tr>
	
	<tr>

	<td>Phones, input color</td><td><input type="text" value="N/A" name="phonecolor"> If you are not selling a Phone leave as is.</td>

	</tr>

	<tr>

	<td>Tablets, input screen size (inches)</td><td><input type="text" value="0" name="screensize"> If you are not selling a Table leave as is.</td>

	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%= username%>></td>
	</tr>
	</table>
	<input type="submit" value="List Item for Sale">
	</form>
<br>

<form method="post" action="alerts.jsp">
<table>
<td>
<input type = "hidden" name = "username" value = <%= username%>>
</td>
</table>
<input type="submit" value="Alerts" onclick="window.location='alerts.jsp'">
</form>

<form method="post" action="forumPage.jsp">
<table>
<tr>
<td><input type = "hidden" name = "username" value = <%= username%>></td>
</tr>
</table>
<input type="submit" value="Forum">
</form>

<input type="button" value="Logout" onclick="window.location='index.jsp'">
<br>
<br>
<br>
	<form method="post" action="delAcc.jsp">
	<input type = "hidden" name = "username" value = <%= username%>>
	<input type="submit" value="Delete Account">
	</form>

</body>
</html>