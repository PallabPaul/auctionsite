<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<h1>Welcome to our site! </h1>
Please Login:
<br>
	<form method="post" action="login.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login">
	</form>
<br>

New user? Please create an account:
<br>
	<form method="post" action="createAccount.jsp">
	<table>
	<tr>    
	<td>New Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>New Password</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Create Account">
	</form>
<br>

</body>
</html>