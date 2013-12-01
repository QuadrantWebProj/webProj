<%-- 
    Document   : register
    Created on : Nov 29, 2013, 1:31:36 PM
    Author     : Ian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <script type="text/JavaScript">
        var failArray = new Array();

        function validateForm()
        {
            var fail = false;
            /* first name */
            var formdata = document.forms["registerform"]["firstName"].value;
            var regex = /[A-Za-z]{1,20}/;
            if (!regex.test(formdata))
            {
                fail = true;
                failArray.push("fname");
            }
            /* last name */
            formdata = document.forms["registerform"]["lastName"].value;
            if (!regex.test(formdata))
            {
                fail = true;
                failArray.push("lname");
            }
            /* city */
            regex = /[A-Za-z]{1,20}/;
            formdata = document.forms["registerform"]["city"].value;
            if(!regex.test(formdata)){
                fail = true;
                failArray.push("city");
            }
            /* password */
            regex = /[A-Za-z0-9]{4,10}/;
            formdata = document.forms["registerform"]["password"].value;
            if (!regex.test(formdata) ||
                formdata != document.forms["registerform"]["passwordcheck"].value)
            {
                fail = true;
                failArray.push("pass");
            }
            /* email */
            formdata = document.forms["registerform"]["email"].value;
            regex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
            if (!regex.test(formdata))
            {
                fail = true;
                failArray.push("email");
            }
            
            /* check if any failed */
            if (fail == true)
            {
                formFailed();
                return false;
            }

            return true;
        }

        function formFailed()
        {
            var alertString = "Invalid fields:";
            var compare;
            var length = failArray.length;
            /* construct the alert string */
            for (var i = 0; i < length; i++)
            {
                compare = failArray.pop();
                if (compare == "fname")
                    alertString = alertString + "\n first name";
                if (compare == "lname")
                    alertString = alertString + "\n last name";
                if (compare == "pass")
                    alertString = alertString + "\n password";
                if (compare == "email")
                    alertString = alertString + "\n email address";
                if (compare == "city")
                    alertString = alertString + "\n city";
            }
            alert(alertString);
            return true;
        }

    </script>

    <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <title>New User Registration</title>
        <link href="http://itweb.cs.nmt.edu/~dfahey/Quadrant/mainpageCSS.css" rel="stylesheet" type="text/css" />
    </head>

    <body>

        <div id="header">
            <div>
                <img alt="" height="58" src="quadrant.png" width="225" />		
            </div>
        </div>
        <br/>
        <div id="createAccountForm">
            <form name="registerform" onsubmit="return validateForm();" action="createuser.jsp">
                <table border="0" cellspacing="1" cellpadding="1">
                    <tr>
                        <td>First Name:</td>
                        <td><input name="firstName" type="text"/></td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td><input name="lastName" type="text"/></td>
                    </tr>
                    <tr>
                        <td>Email Address:</td>
                        <td><input name="email" type="text"/></td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td><input name="city" type="text"/></td>
                    </tr>
                    <tr>
                        <td>State:</td>
                        <td><select name="state">
                                <option value="Alabama">Alabama</option>
                                <option value="Alaska">Alaska</option>
                                <option value="Arizona">Arizona</option>
                                <option value="Arkansas">Arkansas</option>
                                <option value="California">California</option>
                                <option value="Colorado">Colorado</option>
                                <option value="Connecticut">Connecticut</option>
                                <option value="Delaware">Delaware</option>
                                <option value="Florida">Florida</option>
                                <option value="Georgia">Georgia</option>
                                <option value="Hawaii">Hawaii</option>
                                <option value="Idaho">Idaho</option>
                                <option value="Illinois">Illinois</option>
                                <option value="Indiana">Indiana</option>
                                <option value="Iowa">Iowa</option>
                                <option value="Kansas">Kansas</option>
                                <option value="Kentucky">Kentucky</option>
                                <option value="Louisiana">Louisiana</option>
                                <option value="Maine">Maine</option>
                                <option value="Maryland">Maryland</option>
                                <option value="Massachusetts">Massachusetts</option>
                                <option value="Michigan">Michigan</option>
                                <option value="Minnesota">Minnesota</option>
                                <option value="Mississippi">Mississippi</option>
                                <option value="Missouri">Missouri</option>
                                <option value="Montana">Montana</option>
                                <option value="Nebraska">Nebraska</option>
                                <option value="Nevada">Nevada</option>
                                <option value="New Hampshire">New Hampshire</option>
                                <option value="New Jersey">New Jersey</option>
                                <option value="New Mexico">New Mexico</option>
                                <option value="New York">New York</option>
                                <option value="North Carolina">North Carolina</option>
                                <option value="North Dakota">North Dakota</option>
                                <option value="Ohio">Ohio</option>
                                <option value="Oklahoma">Oklahoma</option>
                                <option value="Oregon">Oregon</option>
                                <option value="Pennsylvania">Pennsylvania</option>
                                <option value="Rhode Island">Rhode Island</option>
                                <option value="South Carolina">South Carolina</option>
                                <option value="South Dakota">South Dakota</option>
                                <option value="Tennessee">Tennessee</option>
                                <option value="Texas">Texas</option>
                                <option value="Utah">Utah</option>
                                <option value="Vermont">Vermont</option>
                                <option value="Virginia">Virginia</option>
                                <option value="Washington">Washington</option>
                                <option value="West Virginia">West Virginia</option>
                                <option value="Wisconsin">Wisconsin</option>
                                <option value="Wyoming">Wyoming</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Password must be between 4-10 numbers or letters only.</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input name="password" type="password"/></td>
                    </tr>
                    <tr>
                        <td>Re-enter password:</td>
                        <td><input name="passwordcheck" type="password"/></td>
                    </tr>
                </table>
                <button type="submit">Submit</button>
            </form>
        </div>

    </body>

</html>

