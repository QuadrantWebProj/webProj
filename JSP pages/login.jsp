<%-- 
    Document   : login
    Created on : Nov 29, 2013, 12:40:13 PM
    Author     : Ian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html>

    <script type="text/javascript">
        /* check to make sure the given strings are valid */
        function validate() {
            var emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
            var passwordRegex = /[A-Za-z0-9]{4,10}/;
            var email = document.forms["loginForm"]["Email"].value;
            var password = document.forms["loginForm"]["Password"].value;
            var button = document.forms["loginForm"]["button"].value;
            /* if "New Member" was clicked, skip string checking */
            if (button.valueOf("New Member")){
                return true;
            }else if (!emailRegex.test(email)) {
                alert("Invalid email.");
                return false;
            } else if (!passwordRegex.test(password)) {
                alert("Invalid password.");
                return false;
            }
            return true;
        }
    </script>

    <head>
        <meta content="en-us" http-equiv="Content-Language" />
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <title>Quadrant Login</title>
        <style>
            .auto-style2 {
                font-family: "Arial Black";
                font-size: larger;
                color: #FFFFFF;
            }
            .input {
                border-radius: 10px;
                background:#7FFFD4;
            }
        </style>
    </head>
    <body style="background-color: #808080;">
        <p>&nbsp;</p>
        <h1 align="center" class="auto-style2">
            <img alt="" height="58" src="quadrant.png" width="225" />
            <br/>Welcome!
        </h1>
        <div align="center">
            <form name="loginForm" onsubmit="return validate();" action="accountLogin.jsp" method="POST">
                Enter email:<input type="text" class="input" name="Email" title="User Name"/>
                <br/>
                Enter password:<input type="password" class="input" name="Password" title="Password"/>
                <br/>
                <input type="submit" value="Login" name="button" />
                <input type="submit" value="New Member" name="button" /><br/> 
            </form>
        </div>
    </body>
</html>
