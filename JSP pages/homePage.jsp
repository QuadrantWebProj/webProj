

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

    Connection connection2 = null;
    Statement statement2 = null;
    ResultSet result2 = null;

    Integer uid = null;
    uid = (Integer) session.getAttribute("userID");
    String password = null;
    password = (String) session.getAttribute("password");


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









<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Quadrant main page</title>

<script type="text/javascript">
    function animate_tab(menuId){
    var no_of_tabs = 6+1;
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



<link href="http://itweb.cs.nmt.edu/~dfahey/Quadrant/mainpageCSS.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div id="header">
	<div>
		<img alt="" height="58" src="quadrant.png" width="225" />		
	</div>
	<ul>	
		<li  id="menu-01" class="selected"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-01');">Friends</a></li>
      		<li class="unselected" id="menu-02"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-02');">Friend requests</a></li>
		<li class="unselected" id="menu-03"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-03');">Market</a></li>
		<li class="unselected" id="menu-04"><a href="javascript:void(0);" class="fill-div" onclick="animate_tab('menu-04');">Discover Users</a></li>
		<li class="unselected" id="menu-05"><a href="profile.jsp?user=<%=uid%>" class="fill-div">My Profile</a></li>
		<li class="unselected" id="menu-06"><a href="logout.jsp" class="fill-div">Logout</a></li>

	</ul>

</div>



<body>

	<div id="tab-content">
    <div id="tab-01">        
        


    </div>
    <div id="tab-02">
        <%//now retrieve account requested through parameter send with url
        int tempID= 0;
        query = "SELECT * FROM friendTable WHERE friendID='" + uid + "' AND requestOrExisting='req';";
        statement = connection.createStatement();
        result = statement.executeQuery(query);

        while(result.next()){
            tempID = Integer.parseInt(result.getString("userID"));
            query = "SELECT * FROM quad_user_table WHERE UserID='" + tempID + "';";
            statement2 = connection.createStatement();
            result2 = statement2.executeQuery(query);
            result2.next();

            name = result2.getString("Firstname") + " " + result2.getString("Lastname");
            profilePic = result2.getString("profilePic");
        %>
            <div id="status">
        	<div id="statusSpacing">
        	</div>
	       	<div>        	
                    <img id="profilePic" src="<%=profilePic%>" />
                    <h3 id="userName"><%=name%></h3>

                </div>
                <div id="statusText">
                    <div id="friendAcceptButton">
			<a href="acceptFriend.jsp?requestUser=<%=tempID%>" class="fill-div">Accept Friendship</a>
                    </div>
                </div>
            </div>

        <%}%>
    </div>
    <div id="tab-03">
        Content in Tab 03 goes here.
    </div>
    <div id="tab-04">
        <%//list unfriended users
        tempID= 0;
        query = "SELECT * FROM quad_user_table";
        statement = connection.createStatement();
        result = statement.executeQuery(query);

        while(result.next()){
            tempID = Integer.parseInt(result.getString("userID"));
            query = "SELECT * FROM friendTable WHERE UserID='" + tempID + "' AND friendID='" + uid + "';";
            statement2 = connection.createStatement();
            result2 = statement2.executeQuery(query);
            if(!result2.next() & tempID != uid){

                name = result.getString("Firstname") + " " + result.getString("Lastname");
                profilePic = result.getString("profilePic");
        %>
            <div id="status">
        	<div id="statusSpacing">
        	</div>
	       	<div>        	
                    <img id="profilePic" src="<%=profilePic%>" />
                    <h3 id="userName"><%=name%></h3>

                </div>
                <div id="statusText">
                    <div id="friendAcceptButton">
			<a href="requestFriend.jsp?requestUser=<%=tempID%>" class="fill-div">Request Friendship</a>
                    </div>
                </div>
            </div>

        <%}}%>
    </div>
    
    
    
</div>

	


	<p class="status"></p>

	


</body>


</html>
