<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		
		String auctionid = request.getParameter("auctionid");
		String newusername = request.getParameter("username");
		
		String queryUsername = "";
		String queryBidder = "";
		
		//Make an insert statement for the Sells table:
		String str = "SELECT username, currBidder FROM auctions WHERE auctionid = '" + auctionid + "'";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		//PreparedStatement ps = con.prepareStatement(str);
		

		ResultSet resultstr = stmt.executeQuery(str);
		
		if(resultstr.next()){
			
			queryUsername = resultstr.getString("username");
			queryBidder = resultstr.getString("currBidder");
			
		}
		
		if(queryUsername.equals(newusername) == false){
			out.print("Sorry this is not your auction. You cannot delete another person's auction.");
			return;
		}
		else if(queryBidder.equals("no bid yet") == false){
			out.print("Sorry this auction already has a bid, you cannot delete it. Please talk to a customer representative.");
			return;
		}
		else{
			String del = "DELETE FROM auctions WHERE auctionid =?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(del);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, auctionid);
			//Run the query against the DB
			ps.executeUpdate();
		}

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		//ps.setString(1, specType);
		
		//Run the query against the DB		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Auction Deleted");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nItem Listing DB Failed :()");
	}
%>
</body>
</html>