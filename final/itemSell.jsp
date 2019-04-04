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
		String newcategory = request.getParameter("category");
		String newbrand = request.getParameter("brand");
		String newyear = request.getParameter("year");
		String newtype = request.getParameter("type");
		String newusername = request.getParameter("username");
		
		int idnum = -1;
		
		String str = "SELECT MAX(itemid) maxid FROM items";
		ResultSet result = stmt.executeQuery(str);
		
		if(result.next()){
		
		idnum = result.getInt("maxid");
		
		}
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO items(itemid, username, category, brand, year, type)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, idnum+1);
		ps.setString(2, newusername);
		ps.setString(3, newcategory);
		ps.setString(4, newbrand);
		ps.setString(5, newyear);
		ps.setString(6, newtype);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Item Successfully Listed!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(".\nItem Listing DB Failed :()");
	}
%>
</body>
</html>