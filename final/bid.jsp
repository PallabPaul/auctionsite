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
		String bidamount = request.getParameter("bidamount");
		String upperlimit = request.getParameter("upperlimit");
		String bidder = request.getParameter("username");
		
		int intauc = Integer.parseInt(auctionid);
		
		double dbid = Double.parseDouble(bidamount);
		
		double dup = 0.00;
		
		if(upperlimit.equals("optional") == false){
	
			dup = Double.parseDouble(upperlimit);
			
		}
			
		double curPrice = 0.00;
		
		double increment = 0.00;
		
		Timestamp endTime;
		
		String prevbidder = "";
		
		String ss = "SELECT * FROM bidhistory WHERE bidder != '" + bidder + "' and auctionid = '" + auctionid + "' ORDER BY upperLimit DESC";
		
		ResultSet resultss = stmt.executeQuery(ss);
		
		if(resultss.next()){
			
			prevbidder = resultss.getString("bidder");
			
		}
		
		String str = "SELECT * FROM auctions WHERE auctionid='" + auctionid + "'";
		ResultSet result = stmt.executeQuery(str);
		
		if(result.next()){
		
		curPrice = result.getDouble("curPrice");
		increment = result.getDouble("increment");
		endTime = result.getTimestamp("endTime");
		//prevbidder = result.getString("currBidder");
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
			if(endTime.before(ts)){
				
				out.print("Sorry, this auction has ended.");
				
				return;
			
			}
		
		}
		
		if(dbid < curPrice+increment){
			
			out.print("Sorry, bid is not high enough.");
			
			return;
		}
		
		//long time = date.getTime();
	 	Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, bidder);
		ps.setInt(2, intauc);
		ps.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
		ps.setDouble(4, curPrice);
		ps.setDouble(5, dbid);
		if(upperlimit.equals("optional") == false){
			ps.setDouble(6, dup);
		}
		else{
			ps.setDouble(6, 0.00);
		}
		
		//Run the query against the DB
		ps.executeUpdate();
		
		String insert2 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
		
		PreparedStatement ps2 = con.prepareStatement(insert2);
		
		ps2.setDouble(1, dbid);
		ps2.setString(2, bidder);
		ps2.setInt(3, intauc);
		
		ps2.executeUpdate();
		
		String str2 = "SELECT * FROM bidhistory WHERE bidder = '" + prevbidder + "' and upperLimit != '0.00' and auctionid = '" + auctionid + "' ORDER BY upperLimit DESC";
		//WHERE category = " + entity;
		//Run the query against the database.
		ResultSet result2 = stmt.executeQuery(str2);
		
		if(result2.next()) {
			
			double compPrice = result2.getDouble("currentprice");
			double complimit = result2.getDouble("upperLimit");
			
			double compcounter = dbid + increment;
			
			if(bidder.equals(prevbidder)){
				out.print("Bid Successfully Placed!");
				return;
			}
			else{
				
				if(upperlimit.equals("optional") == true){
					
					if(compcounter <= complimit){
						
						String insert3 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
								+ "VALUES (?, ?, ?, ?, ?, ?)";
						//Create a Prepared SQL statement allowing you to introduce the parameters of the query
						PreparedStatement ps3 = con.prepareStatement(insert3);

						//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
						ps3.setString(1, prevbidder);
						ps3.setInt(2, intauc);
						ps3.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
						ps3.setDouble(4, dbid);
						ps3.setDouble(5, compcounter);
						ps3.setDouble(6, complimit);
						
						//Run the query against the DB
						ps3.executeUpdate();
						
						String insert4 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
						
						PreparedStatement ps4 = con.prepareStatement(insert4);
						
						ps4.setDouble(1, compcounter);
						ps4.setString(2, prevbidder);
						ps4.setInt(3, intauc);
						
						ps4.executeUpdate();
						
					}
					else{
						out.print("Bid Successfully Placed!");
						return;
					}
				}
				else{
					if(complimit <= dup){
						//dup wins
						if(complimit+increment <= dup){
							
							String insert5 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps5 = con.prepareStatement(insert5);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps5.setString(1, prevbidder);
							ps5.setInt(2, intauc);
							ps5.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps5.setDouble(4, dbid);
							ps5.setDouble(5, complimit);
							ps5.setDouble(6, complimit);
							
							//Run the query against the DB
							ps5.executeUpdate();
							
							String insert3 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps3 = con.prepareStatement(insert3);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps3.setString(1, bidder);
							ps3.setInt(2, intauc);
							ps3.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps3.setDouble(4, complimit);
							ps3.setDouble(5, complimit+increment);
							ps3.setDouble(6, dup);
							
							//Run the query against the DB
							ps3.executeUpdate();
							
							String insert4 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
							
							PreparedStatement ps4 = con.prepareStatement(insert4);
							
							ps4.setDouble(1, complimit+increment);
							ps4.setString(2, bidder);
							ps4.setInt(3, intauc);
							
							ps4.executeUpdate();
							
						}
						
						else{
							
							String insert5 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps5 = con.prepareStatement(insert5);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps5.setString(1, prevbidder);
							ps5.setInt(2, intauc);
							ps5.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps5.setDouble(4, dbid);
							ps5.setDouble(5, complimit);
							ps5.setDouble(6, complimit);
							
							//Run the query against the DB
							ps5.executeUpdate();
							
							String insert4 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
							
							PreparedStatement ps4 = con.prepareStatement(insert4);
							
							ps4.setDouble(1, complimit);
							ps4.setString(2, prevbidder);
							ps4.setInt(3, intauc);
							
							ps4.executeUpdate();
							
						}				
					}else{
						/////////////////////////
						
						if(dup+increment <= complimit){
							
							String insert5 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps5 = con.prepareStatement(insert5);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps5.setString(1, bidder);
							ps5.setInt(2, intauc);
							ps5.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps5.setDouble(4, dbid);
							ps5.setDouble(5, dup);
							ps5.setDouble(6, dup);
							
							//Run the query against the DB
							ps5.executeUpdate();
							
							String insert3 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps3 = con.prepareStatement(insert3);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps3.setString(1, prevbidder);
							ps3.setInt(2, intauc);
							ps3.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps3.setDouble(4, dup);
							ps3.setDouble(5, dup+increment);
							ps3.setDouble(6, complimit);
							
							//Run the query against the DB
							ps3.executeUpdate();
							
							String insert4 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
							
							PreparedStatement ps4 = con.prepareStatement(insert4);
							
							ps4.setDouble(1, dup+increment);
							ps4.setString(2, prevbidder);
							ps4.setInt(3, intauc);
							
							ps4.executeUpdate();
							
						}
						
						else{
							
							String insert5 = "INSERT INTO bidhistory(bidder, auctionid, timeofbid, currentprice, priceofbid, upperlimit)"
									+ "VALUES (?, ?, ?, ?, ?, ?)";
							//Create a Prepared SQL statement allowing you to introduce the parameters of the query
							PreparedStatement ps5 = con.prepareStatement(insert5);

							//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
							ps5.setString(1, bidder);
							ps5.setInt(2, intauc);
							ps5.setTimestamp(3, java.sql.Timestamp.from(java.time.Instant.now()));
							ps5.setDouble(4, dbid);
							ps5.setDouble(5, dup);
							ps5.setDouble(6, dup);
							
							//Run the query against the DB
							ps5.executeUpdate();
							
							String insert4 = "UPDATE auctions SET curPrice =? , currBidder =? WHERE auctionid =?";
							
							PreparedStatement ps4 = con.prepareStatement(insert4);
							
							ps4.setDouble(1, dup);
							ps4.setString(2, bidder);
							ps4.setInt(3, intauc);
							
							ps4.executeUpdate();
							
						}
						
						/////////////////////////
						
					}
				}
			
				double ul = result2.getDouble("upperLimit");
		
				out.print("upper limit to compete with: " + ul);
			}
		}
		else{
			out.print("Bid Successfully Placed!");
			return;
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Bid Successfully Placed!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nItem Listing DB Failed :()");
	}
%>
</body>
</html>