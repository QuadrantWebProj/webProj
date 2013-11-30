<%-- 
    Document   : profile
    Created on : Nov 29, 2013, 6:41:16 PM
    Author     : Ian
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    boolean valid = false;

    Integer id = null;
    id = (Integer) session.getAttribute("userID");
    String password = null;
    password = (String) session.getAttribute("password");

    /* if session doesn't match required format, go back to login */
    if (id == null || id < 1 || password == null || password.contentEquals("")) {
        //response.sendRedirect("login.jsp");
        response.sendError(500, "session is fucked, yo");
    } else {
        /* double check that this is a valid id/pass pair */
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
            query = "SELECT * FROM quad_user_table WHERE UserID='" + id + "';";
            statement = connection.createStatement();
            result = statement.executeQuery(query);
            if (result.next()) {
                if (result.getString("Password").contentEquals(password)) {
                    valid = true;
                }
            }
            if (valid == false) {
                //response.sendRedirect("login.jsp");
                response.sendError(500, "session is fucked, yo");
            }
        } catch (SQLException ex) {
            response.sendError(500, ex.getLocalizedMessage());
        }

    }


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quadrant</title>
    </head>
    <body>
        <h1>Imagine a cool profile page that shows friend statuses and local news stories</h1>
    </body>
</html>
