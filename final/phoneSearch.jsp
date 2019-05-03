<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Laptop Search</title>
</head>

<%String newusername = request.getParameter("username"); %>

<body>
<h1>Enter Phone Attributes</h1>
<br>
<br>
	<form method="post" action="jtitemQuery.jsp">
	<table>
	<tr>
	<td>Phone Brand</td><td><input type="text" name="brand"></td>
	</tr>
	<tr>    
	<td>Phone Year</td><td><input type="text" name="year"></td>
	</tr>
	<tr>
	<td>Phone Type</td><td><input type="text" name="type"></td>
	</tr>
	<tr>
	<td>Phone Color</td><td><input type="text" name="phonecolor"></td>
	</tr>
	<tr>
	<td>Sort by price</td><td><input type="radio" id="choice1"
     name="sortPrice" value="on">
    <label for="choice1">On</label>

    <input type="radio" id="choice2"
     name="sortPrice" value="off" checked>
    <label for="choice2">Off</label></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%= newusername%>></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "itemcat" value = "phone"></td>
	</tr>
	</table>
	<input type="submit" value="Search">
	</form>
<br>
<br>

	
<input type="button" value="Logout" onclick="window.location='index.jsp'">


</body>
</html>