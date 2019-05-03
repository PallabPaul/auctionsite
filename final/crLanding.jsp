<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative</title>
</head>
<%String username = (String)request.getAttribute("username"); %>
<body>
<h1>CUSTOMER REPRESENTATIVE ACCESS</h1>

	<strong><font size="5">Bid On/Sell Items</font></strong>
	
	<form method="post" action="items.jsp">
	<table>
	<tr>
	<td><input type = "hidden" name = "username" value = <%= username%>></td>
	</tr>
	</table>
	<input type="submit" value="Bid/Sell Page">
	</form>

	<form method="post" action="crForumPage.jsp">
	<table>
	<tr>
	<td><input type = "hidden" name = "username" value = <%= username%>></td>
	</tr>
	</table>
	<input type="submit" value="Forum">
	</form>
	<br>
	<br>
	
	<strong><font size="5">Change User's Password</font></strong>
	<form method="post" action="passwordChange.jsp">
	<table>
	<tr>
	<td>Username</td><td><input type = "text" name = "passUser"></td>
	</tr>
	<tr>
	<td>New Password</td><td><input type = "text" name = "newPass"></td>
	</tr>
	</table>
	<input type="submit" value="Change Password">
	</form>
	<br>
	<br>
	<strong><font size="5">Delete Auction or Bid</font></strong>

	
	<form method="post">
<br>
<%--Delete an auction from the table shown in the next page--%>
	<input type="button" value="Delete Auction/Bid"
		onclick="window.location='deleteAuction.jsp'">
</form>
<br>
<br>
<br>
<strong><font size="5">Edit Auction Information</font></strong>
<form method="post" action="editAuction.jsp">
<table>
<tr>
<td><input type = "hidden" name = "username" value = <%= username%>></td>
</tr>
</table>
<input type="submit" value="Edit Auction Info">
</form>
<br>
<br>

<br>
<strong><font size="5">Edit Bid Information</font></strong>
	<form method="post" action="editBid.jsp">
	<br>
	<input type="submit" value="Edit Bid Info">
	</form>
<br>
	
</body>
<input type="button" value="Logout" onclick="window.location='index.jsp'">
</html>