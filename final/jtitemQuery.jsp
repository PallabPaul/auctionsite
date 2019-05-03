<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Current Auctions</title>
</head>
<body>

	<% String newusername = request.getParameter("username");%>
	
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("itemcat");
			String newbrand = request.getParameter("brand");
			String newyear = request.getParameter("year");
			String name = request.getParameter("type");
			String newsortprice = request.getParameter("sortPrice");
			String str = "";
			ResultSet result;
			int newramsize = 0;
			int newscreensize = 0;
			String newphonecolor = "";
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			java.util.Date date = new java.util.Date();
			date.setTime(ts.getTime());
			String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
			
			
			
			
			if(entity.equals("laptop")){
				newramsize = Integer.parseInt(request.getParameter("ramsize"));
				if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year  = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.ramsize = '" + newramsize + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.ramsize = '" + newramsize + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newramsize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newramsize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newramsize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newramsize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.ramsize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.ramsize = '" + newramsize + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				
			}
			else if(entity.equals("phone")){
				newphonecolor = request.getParameter("phonecolor");
				if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year  = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.phonecolor = '" + newphonecolor + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.phonecolor = '" + newphonecolor + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newphonecolor.equals("") && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && !(newphonecolor.equals("")) && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.phonecolor, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.phonecolor = '" + newphonecolor + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}

			}
			else if(entity.equals("tablet")){
				newscreensize = Integer.parseInt(request.getParameter("screensize"));
				if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year  = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && newyear.equals("") && name.equals("") && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && name.equals("") && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && name.equals("") && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(newbrand.equals("") && newyear.equals("") && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.screensize = '" + newscreensize + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && name.equals("") && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.screensize = '" + newscreensize + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newscreensize == 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.brand = '" + newbrand + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(newbrand.equals("") && !(newyear.equals("")) && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.year = '" + newyear + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
				else if(!(newbrand.equals("")) && newyear.equals("") && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("off")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "'";
				}
				else if(!(newbrand.equals("")) && !(newyear.equals("")) && !(name.equals("")) && newscreensize != 0 && newsortprice.equals("on")){
					str = "SELECT i.auctionid, i.username, i.category, i.brand, i.year, i.type, i.screensize, a.curPrice, a.endTime, a.increment, a.winner, a.currBidder FROM items i JOIN auctions a ON i.auctionid = a.auctionid WHERE a.endTime > '" + formattedDate + "' AND i.brand = '" + newbrand + "' AND i.type = '" + name + "' AND i.screensize = '" + newscreensize + "' AND i.year = '" + newyear + "' AND i.category = '" + entity + "' ORDER BY a.curPrice";
				}
			}
			result = stmt.executeQuery(str);
			
			//String str = "SELECT * FROM items WHERE a.endTime > '" + formattedDate + "' AND category = '" + entity + "'";
			//ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table border='1'>");

			//make a row
			out.print("<tr>");
			out.print("<td>");
			out.print("Auction ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Seller");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Category");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Brand");
			out.print("</td>");
			out.print("<td>");
			out.print("Year");
			out.print("</td>");
			out.print("<td>");
			out.print("Type");
			out.print("</td>");
			out.print("<td>");
			if(entity.equals("laptop")){
				out.print("Ram Size");
			}
			else if(entity.equals("tablet")){
				out.print("Screen Size");
			}
			else{
				out.print("Phone Color");
			}
			out.print("</td>");
			out.print("<td>");
			out.print("End Time");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Price");
			out.print("</td>");
			out.print("<td>");
			out.print("Minimum Increment");
			out.print("</td>");
			out.print("<td>");
			out.print("Current Bidder");
			out.print("</td>");
			out.print("<td>");
			out.print("Winner");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getInt("i.auctionid"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("i.username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("i.category"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("i.brand"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("i.year"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("i.type"));
				out.print("</td>");
				out.print("<td>");
				if(entity.equals("laptop")){
					out.print(result.getString("i.ramsize"));
				}
				else if(entity.equals("tablet")){
					out.print(result.getString("i.screensize"));
				}
				else{
					out.print(result.getString("i.phonecolor"));
				}
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("a.endTime"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("a.curPrice"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("a.increment"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("a.currBidder"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("a.winner"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>

<br>
<br>
<br>	
Place Bid:
<br>
	<form method="post" action="bid.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	<tr>
	<td>Amount to Bid</td><td><input type="text" name="bidamount"></td>
	</tr>
	<tr>
	<td>Auto Bid Limit</td><td><input type="text" name="upperlimit" value = "optional"> Leave as "optional" if you don't want to auto bid.</td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Place Bid">
	</form>
<br>
<br>
History of Bids:
<br>
	<form method="post" action="bidHistory.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	</table>
	<input type="submit" value="View History">
	</form>
<br>
<br>
Other User's Auctions:
<br>
	<form method="post" action="userHistory.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="View History">
	</form>
<br>

<br>
Similar Auctions From Last Month:
<br> 
	<form method="post" action="similarBids.jsp">
	<table>
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</table>
	<input type="submit" value="View Similar Auctions">
	</form>
<br>
<br>
<br>
Delete Auction:
<br>
	<form method="post" action="delAuc.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionid"></td>
	</tr>
	<tr>
	<td><input type = "hidden" name = "username" value = <%=newusername%>></td>
	</tr>
	</table>
	<input type="submit" value="Delete Auction">
	</form>
<br>

</body>
</html>