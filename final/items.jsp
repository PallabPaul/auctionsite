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

<body>
<h1>Hi <%= username%>. Buy or Sell </h1>
Search for an item:
<br>
<br>
	<form method="post" action="itemQuery.jsp">
		<select name="itemcat" size=1>
			<option value="laptop">Laptop</option>
			<option value="phone">Phone</option>
			<option value="tablet">Tablet</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
<br>

<br>
Sell an item:
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
	<td>Item Brand</td><td><input type="text" name="brand"></td>
	</tr>
	<tr>    
	<td>Item Year</td><td><input type="text" name="year"></td>
	</tr>
	<tr>
	<td>Item Type</td><td><input type="text" name="type"></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%= username%>></td>
	</tr>
	</table>
	<input type="submit" value="List Item for Sale">
	</form>
<br>

</body>
</html>