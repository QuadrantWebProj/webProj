<%-- 
    Document   : profile
    Created on : Nov 29, 2013, 6:41:16 PM
    Author     : Ian
--%>

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
    Integer rid = null;
    uid = (Integer) session.getAttribute("userID");
    String password = null;
    password = (String) session.getAttribute("password");

    //get requested user id profile from passes parameter
    if(request.getParameter("user") != null){
        rid = Integer.parseInt(request.getParameter("user"));
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
                    
                    //now retrieve account requested through parameter send with url
                    query = "SELECT * FROM quad_user_table WHERE UserID='" + rid + "';";
                    statement = connection.createStatement();
                    result = statement.executeQuery(query);

                    if(result.next()){
                        name = result.getString("Firstname") + " " + result.getString("Lastname");
                        city = result.getString("City");
                        state = result.getString("State");
                        profilePic = result.getString("profilePic");
                    }
                    else{
                        response.sendError(500, "requested profile doesnt exist");
                    }
                }
            }
            if (valid == false) {
                response.sendError(403, "Log-in details have expired. Please log-in again.");
            }
        } catch (SQLException ex) {
            response.sendError(500, ex.getLocalizedMessage());
        }

    


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <script type="text/javascript">
        function animate_tab(menuId){
        var no_of_tabs = 2+1;
        for(i = 1; i < no_of_tabs; i++){
        menu_id = "menu-0"+i.toString();
        tab_id  = "tab-0"+i.toString();
        if(menu_id == menuId){
        document.getElementById(menu_id).className  = 'selected';
        document.getElementById(tab_id).style.display = 'block';
        }else{
        document.getElementById(menu_id).className  = 'unselected';
        document.getElementById(tab_id).style.display = 'none';
        }
        }
        }</script>


    <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <title>Untitled 1</title>
        <link href="http://itweb.cs.nmt.edu/~dfahey/Quadrant/mainpageCSS.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div id="header">
            <div>
                <a href="homePage.jsp"><img alt="" height="58" src="quadrant.png" width="225" /></a>
                <ul>
                    <li id="menu-01" class="selected"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-01');">Updates</a></li>
                    <li class="unselected" id="menu-02"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-02');">About</a></li>
                    <li class="unselected" id="menu-03"><a href="logout.jsp" class="fill-div">Logout</a></li>

                </ul>

            </div>
        </div>

        <div id="tab-content">
            <div id="tab-02">
                <img id="profilePic" alt="" src="<%=profilePic%>" />
                <%
                Boolean friend=false;
                Boolean requested=false;

                query = "SELECT * FROM friendTable WHERE UserID='" + uid + "';";
                statement = connection.createStatement();
                result = statement.executeQuery(query);
                
                while(result.next()){
                    if(Integer.parseInt(result.getString("friendID")) == rid ){
                        friend = true;
                        if((result.getString("requestOrExisting")).equals("req")){
                            requested=true;
                        }
                    }
                }
                if(uid != rid & !friend ){%>
                    <div id="friendButton">
			<a href="requestFriend.jsp?requestUser=<%=rid%>" class="fill-div">Request Friendship</a>
                    </div>   
                <%}
                else if(requested){%>
                    <div id="friendButton">
			Requested
                    </div>
                <%}
                else if(uid != rid){%>
                    <div id="friendButton">
			Friends
                    </div>
                <%}%>
                <div id="profileInfo" style="width: 100%;">
                    <h2><%=name%></h2>
                    <h3><%=city%></h3>
                    <h3><%=state%></h3>
                </div>
                <br>
                    <div>
                        <br>
                            <br><br><br><br><br><br><br><br><br><br><br><br>

                   </div>
             </div>
                
                <div id="tab-01">
                    <%if(uid == rid){%>
                    <form action="postUpdate.jsp">
                        <div id="status">
                            <div id="statusSpacing">
                        </div>
                        <div>        	
                            <img id="profilePic" src="<%=profilePic%>" />
                            <h3 id="userName"><%=name%></h3>
                        </div>
			<div id="statusText">
                            <textarea type="text" rows="3" cols="50" name="status" ></textarea>
                            <button type="submit">Broadcast Status</button>
			</div>
	 
                    </div>

                        
                    </form>
                    <%}}%>
                    
                </div>
                                                                            
       </div>


</body>

</html>


