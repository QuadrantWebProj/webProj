<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Nov 12, 2013, 2:38:54 PM
    Author     : Ian
--%>
<sql:query var="subjects" dataSource="jdbc/DBTest">
    SELECT subject_id, name FROM Subject
</sql:query>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Database Tester</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <h1>Welcome! This page is for testing out MySQL implementation with a website!</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>This is a table heading!</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Select something!</td>
                </tr>
                <tr>
                    <td>
                        <form action="response.jsp">
                            <strong> Select: </strong>
                            <select name="subject_id">
                                <c:forEach var="row" items="${subjects.rows}">
                                    <option value="${row.subject_id}">${row.name}</option>
                                </c:forEach>
                            </select>
                            <input type="submit" value="submit" name="submit" />
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </body>
</html>
