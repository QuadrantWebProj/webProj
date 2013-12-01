<%-- 
    Document   : createuser
    Created on : Nov 29, 2013, 2:22:13 PM
    Author     : Ian
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String firstname = request.getParameter("firstName");
    String lastname = request.getParameter("lastName");
    String email = request.getParameter("email");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String password = request.getParameter("password");
    String profilePic = request.getParameter("profilePic");

    String dburl = "jdbc:mysql://itweb.cs.nmt.edu:3306/ismi01";
    String dbusername = "ismi01";
    String dbpassword = "K8dKjuSx";
    Connection connection = null;
    Statement statement = null;
    ResultSet result = null;
    String query = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dburl, dbusername, dbpassword);
        /* Check if the email exists */
        query = "SELECT * FROM quad_user_table WHERE Email='" + email + "';";
        statement = connection.createStatement();
        result = statement.executeQuery(query);
        if (result.next()) {
            /* we found a user with that email already */
            response.sendError(409, "The email " + email + " is already registered.");
        } else {
            /* find unused ID */
            int id = 0;
            do {
                id++;
                query = "SELECT * FROM quad_user_table WHERE UserID='" + id + "';";
                result = statement.executeQuery(query);
            } while (result.next());
            /* email appears to be unique, create new user in DB */
            query = "INSERT INTO quad_user_table (Email, Firstname, Lastname, UserID, Password, City, State, profilePic) "
                    + "VALUES ('" + email + "', '" + firstname + "', '" + lastname + "', '" + id + "', '" + password + "', '" + city + "', '" + state + "', '" + profilePic + "');";
            statement.executeUpdate(query);
            /* Done! Now, setup the session and redirect to profile page! */
            session.setAttribute("userID", id);
            session.setAttribute("password", password);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    } catch (SQLException ex) {
        response.sendError(500, ex.getLocalizedMessage());
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creating user...</title>
    </head>
    <body>
        <h1>Creating user...</h1>
    </body>
</html>
