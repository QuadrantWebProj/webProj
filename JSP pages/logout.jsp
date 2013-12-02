<%-- 
    Document   : register
    Created on : Nov 29, 2013, 1:31:36 PM
    Author     : Ian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if(session != null)  
    {  
         session.invalidate();  
    } 

    response.sendRedirect("login.jsp");
%>

