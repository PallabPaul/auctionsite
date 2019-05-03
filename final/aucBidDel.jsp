<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String auctionID = request.getParameter("auctionid"); 
	String delete_what = request.getParameter("deleteWhat");
%>


<%
try{
	//out.print(delete_what);
	if(delete_what.equals("auction") == true){
		//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str8 = "SELECT auctionid FROM auctions";
			ResultSet result8 = stmt.executeQuery(str8);
			Integer x = 0;
			
			//checking if the auctionID provided by user is even in the table or not.
			while(result8.next()){
				if(auctionID.equals(result8.getString("auctionid"))){
					x = 1;
					break;
				}
			}
			
			if(x == 0) {
				//Auction ID is not in the auction table.
				out.print("No Auction with Auction ID - " + auctionID);
			} else {
				
				//Create a SQL statement
				String str1 = "SELECT endPrice FROM auctions WHERE auctionid = " + auctionID;
			
				ResultSet result1 = stmt.executeQuery(str1);
			
				result1.next();
				Double endPrice = result1.getDouble("endPrice");
			
				if(endPrice > 0.0){
					out.print("Sorry! You can't delete this auction, this auction is not part of current auction list.");
					out.print("<Br>");
					out.print("Current Auction list only contains auctions that are still active.");
				} else {
				
					String str7 = "DELETE FROM bidhistory WHERE auctionid = " + auctionID;
					stmt.executeUpdate(str7);
			
					String str2 = "DELETE FROM auctions WHERE auctionid = " + auctionID;
					stmt.executeUpdate(str2);
					out.print("Auction deleted Successfully");
				}
				
				

			}
			stmt.close();
	} else {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str8 = "SELECT auctionid FROM auctions";
		ResultSet result8 = stmt.executeQuery(str8);
		Integer x = 0;
		
		//checking if the auctionID provided by user is even in the table or not.
		while(result8.next()){
			if(auctionID.equals(result8.getString("auctionid"))){
				x = 1;
				break;
			}
		}
		if(x == 0) {
			//Auction ID is not in the auction table.
			out.print("Can't Remove this Bid. No Auction with Auction ID - " + auctionID);
		
		} else {	
	
			String str3 = "SELECT * FROM bidhistory WHERE auctionid = " + auctionID;
			ResultSet result3 = stmt.executeQuery(str3);
			//looping until the last row, last row is the latest bid on that auction
			
			while(result3.next()){
			}
			result3.previous();
			Double lastbidprice = result3.getDouble("priceofbid");
			

			
			if(result3.previous()){
				//since the current bidder is deleted, we are going to update the auction
				//table with previous bidder and his/her price
				
				Double priceofbid = result3.getDouble("priceofbid");
				String oldbidder = result3.getString("bidder");
				
				String str6 = "UPDATE auctions SET currBidder = '" + oldbidder + 
						"', curPrice =" + priceofbid + " WHERE auctionid = " +
						auctionID;
				stmt.executeUpdate(str6);
				
				String str4 = "DELETE FROM bidhistory WHERE priceofbid = " + lastbidprice + " AND auctionid = " + auctionID;
				stmt.executeUpdate(str4);
				
				out.print("Bidder removed from the auction");
				
			} else {
				
				//this means there was only one bidder and it's been deleted
				String str9 = "SELECT startPrice FROM auctions WHERE auctionid = " + auctionID;
				ResultSet result9 = stmt.executeQuery(str9);
				result9.next();
				Double startprice = result9.getDouble("startPrice");
			
				
				String str5 = "DELETE FROM bidhistory WHERE priceofbid = " + lastbidprice + " AND auctionid = " + auctionID;
				stmt.executeUpdate(str5);
				
				
				String str7 = "UPDATE auctions SET currBidder = 'no bid yet', curPrice = " + startprice + " WHERE auctionid = " + auctionID;
				stmt.executeUpdate(str7);
				out.print("Bidder removed from the auction. Current Price setted to Start Price.");
			}
			
		
		}
		stmt.close();
	}
} 
catch (Exception ex){
	out.print(ex);
}
%>

</body>
</html>