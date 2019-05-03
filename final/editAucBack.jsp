<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Auction</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String newauctionid = request.getParameter("auctionid");
		double newIncrement = Double.parseDouble(request.getParameter("incAmt"));
		String newEndTime = request.getParameter("endTime");
		String insert = "";
		if(newIncrement == 0 && !(newEndTime.equals(""))){
			insert = "UPDATE auctions SET endTime ='" + newEndTime +  "'WHERE auctionid =" + newauctionid;
		}
		else if(newIncrement != 0 && newEndTime.equals("")){
			insert = "UPDATE auctions SET increment ='" + newIncrement +  "'WHERE auctionid =" + newauctionid;
			
		}
		else if(newIncrement != 0 && !(newEndTime.equals(""))){
			insert = "UPDATE auctions SET increment ='" + newIncrement +  "', endTime ='" + newEndTime +  "'WHERE auctionid =" + newauctionid;
			
		}
		else{
			out.print("Invalid edit attempt");
		}
		
			
			PreparedStatement ps = con.prepareStatement(insert);

			ps.executeUpdate();

			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();

			out.print("Auction Successfully Edited");


		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nItem Listing DB Failed :()");
	}
%>


</body>
</html>