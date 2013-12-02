<%-- 
    Document   : accountLogin
    Created on : Nov 29, 2013, 1:01:55 PM
    Author     : Ian
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String param = request.getParameter("button");
    String email = null;
    String password = null;

    if (param.contentEquals("New Member")) {
        /* Need to register */
        response.sendRedirect("register.jsp");
    } else {
        /* Connect to database to verify user information */
        email = request.getParameter("Email");
        password = request.getParameter("Password");
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
                /* we found a user with that email, now check password */
                if (!result.getString("password").contentEquals(password)) {
                    response.sendError(403, "Incorrect password.");
                } else {
                    /* login verified */
                    session.setAttribute("userID", Integer.parseInt(result.getString("UserID")));
                    session.setAttribute("password", password);
                    request.getRequestDispatcher("profile.jsp?user="+ Integer.parseInt(result.getString("UserID"))).forward(request, response);
                    //response.sendError(500, "id = "+Integer.parseInt(result.getString("UserID"))+"\nsession = "+session.getAttribute("userID"));
                }
            } else {
                response.sendError(403, "No user with given email found.");
            }
        } catch (SQLException ex) {
            response.sendError(500, ex.getLocalizedMessage());
        }

    }
%>

