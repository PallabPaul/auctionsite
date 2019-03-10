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
Create Customer Representative Account:
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
	<input type="submit" value="Create Account">
	</form>
<br>

<input type="button" value="Logout" onclick="window.location='index.jsp'">

</body>
</html>