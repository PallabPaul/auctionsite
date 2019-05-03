<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative</title>
</head>
<%
	String item = request.getParameter("itemname");
	String alertusername = request.getParameter("username");%>
<body>

<% 

	try{
		out.print(item);
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str1 = "SELECT * FROM alerts WHERE alertuser = '" + alertusername + "' ORDER BY alertid DESC"; 
		ResultSet result1 = stmt.executeQuery(str1);
		Integer alertID = 1;
		if(result1.next()){
			alertID = result1.getInt("alertid") + 1;
		}
		out.print(alertID);
		String str2 = "INSERT INTO alerts (username, itemname, alerttype, alertid, auctionid, alertuser)" + 
				"VALUES ('null','" +  item + "', 'no'," +  alertID + "," + 0 + ", '" + alertusername + "')";
		
		stmt.executeUpdate(str2);
		out.print("Alert created successfully.");
		
	}catch(Exception e){
		out.print(e);
	}

%>


</body>
</html>