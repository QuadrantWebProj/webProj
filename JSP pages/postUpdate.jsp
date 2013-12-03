<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    boolean valid = false;
    String name= null;
    String city = null;
    String state = null;
    String profilePic = null;

    String query = null;
    Connection connection = null;
    Statement statement = null;
    ResultSet result = null;

    Integer uid = null;
    String status=null;

    uid = (Integer) session.getAttribute("userID");
    String password = null;
    password = (String) session.getAttribute("password");

    //get requested user id profile from passes parameter
    if(request.getParameter("status") != null){
        status = request.getParameter("status");
    }
    else{
        response.sendError(500, "you are skipping steps! You broke something");
    }
    /* if session doesn't match required format, go back to login */
    if (uid == null || uid < 1 || password == null || password.contentEquals("")) {
        response.sendError(500, "The session is messed up!");
    } else {
        /* double check that this is a valid id/pass pair */
        String dburl = "jdbc:mysql://itweb.cs.nmt.edu:3306/ismi01";
        String dbusername = "ismi01";
        String dbpassword = "K8dKjuSx";



        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dburl, dbusername, dbpassword);
            /* Check if the email exists */
            query = "SELECT * FROM quad_user_table WHERE UserID='" + uid + "';";
            statement = connection.createStatement();
            result = statement.executeQuery(query);
            if (result.next()) {
                //check for a valid session
                if (result.getString("Password").contentEquals(password)) {
                    valid = true;

                    int storyID = 0;
                    do {
                        storyID++;
                        query = "SELECT * FROM storyTable WHERE storyID='" + storyID + "';";
                        result = statement.executeQuery(query);
                    } while (result.next());
                    
                    //update story table with new story
                    query = "INSERT INTO storyTable (storyID, authorID, content) VALUES ('" + storyID + "', '" + uid + "','" + status + "')";
                    statement = connection.createStatement();
                    statement.executeUpdate(query);

                    //select all friends of current user
                    query="SELECT * FROM friendTable WHERE userID='" + uid + "' AND requestOrExisting='exist'";
                    statement = connection.createStatement();
                    result = statement.executeQuery(query);

                    //insert your story into your own update table
                    query = "INSERT INTO UT" + uid + " (storyID) VALUES ('" + storyID + "');";
                    statement = connection.createStatement();
                    statement.executeUpdate(query);

                    while(result.next()){

                        query = "INSERT INTO UT" + result.getString("friendID") + " (storyID) VALUES ('" + storyID + "');";
                        statement = connection.createStatement();
                        statement.executeUpdate(query);

                    }
                    response.sendRedirect("homePage.jsp");
                }
            }
            if (valid == false) {
                response.sendError(403, "Log-in details have expired. Please log-in again.");
            }
        } catch (SQLException ex) {
            response.sendError(500, ex.getLocalizedMessage());
        }

    }


%>