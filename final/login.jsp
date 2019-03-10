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
		String newUser = request.getParameter("username");
		String newPass = request.getParameter("password");


		//Make an insert statement for the Sells table:
		String insert = "SELECT username, password, staff FROM users WHERE username =? and password=?";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUser);
		ps.setString(2, newPass);
		//Run the query against the DB
		ResultSet result = ps.executeQuery();
		
		if(result.next()){
           // out.print("Successfully Logged In! Welcome back " + newUser + ".");
            
            if(newUser.equals("admin")){
            	response.sendRedirect(request.getContextPath() + "/adminLanding.jsp");
            }
            else if((result.getString("staff")).equals("yes")){
            	request.setAttribute("username", newUser);
            	request.getRequestDispatcher("crLanding.jsp").forward(request, response);
            }
            else{
            	request.setAttribute("username", newUser);
            	request.getRequestDispatcher("items.jsp").forward(request, response);
            }
            //response.sendRedirect(request.getContextPath() + "/items.jsp");
           	//RequestDispatcher rd = request.getRequestDispatcher("/items.jsp");
            //rd.forward(request, response);
        }else{
            out.print("Sorry Username or Password is incorrect");
        }

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login DB Failed :()");
	}
%>
</body>
</html>