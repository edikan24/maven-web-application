<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RondusTechnologies- Home Page</title>
<link href="images/RondusTech Logo.jpeg" rel="icon">
<style>
    body {
        font-family: Arial, sans-serif;
        color: #333;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    h1, h3 {
        color: #0066cc;
    }
    hr {
        border: 1px solid #ccc;
    }
    #header {
        text-align: center;
        margin-top: 20px;
    }
    #footer {
        text-align: center;
        margin-top: 20px;
    }
    .logo {
        display: inline-block;
        vertical-align: middle;
    }
    .contact-info {
        display: inline-block;
        vertical-align: middle;
        margin-left: 20px;
    }
</style>
</head>
<body>
<div id="header">
    <h1>Welcome to Rondus Technologies, Auburn, WA #, USA</h1>
    <h1>Rondus Technologies - Wonderful Training center for DevOps with AWS located in Auburn WA, USA and also for Job Assistance, Job Support, and shadowing. Teaching Real-Time scenarios and practical hands-on experience</h1>
    <hr>
    <h1><h3>Server Side IP Address</h3></h1>
    <%
    String ip = "";
    InetAddress inetAddress = InetAddress.getLocalHost();
    ip = inetAddress.getHostAddress();
    out.println("<h1>Server Host Name :: " + inetAddress.getHostName() + "</h1>");
    out.println("<h1>Server IP Address :: " + ip + "</h1>");
    %>
    <hr>
    <h1><h3>Client Side IP Address</h3></h1>
    <% out.println("<h1>Client IP Address :: " + request.getRemoteAddr() + "</h1>"); %>
    <% out.println("<h1>Client Name Host :: " + request.getRemoteHost() + "</h1>"); %>
    <hr>
    <div class="logo">
        <img src="images/RondusTech Logo.jpeg" alt="RondusTech Logo" width="100">
    </div>
    <div class="contact-info">
        <span style="font-weight: bold;">Rondus Technologies,<br>
        rondusllc@gmail.com<br>
        <a href="mailto:rondusllc@gmail.com">Mail to Rondus Technologies</a></span>
    </div>
</div>
<hr>
<p>Service : <a href="services/employee/getEmployeeDetails">Get Employee Details</a></p>
<hr>
<div id="footer">
    <p>Rondus Technologies - Consultant, Training, Development Center.</p>
    <p><small>Copyrights 2022 by <a href="http://rondustech.com/">Rondus Technologies, Auburn</a></small></p>
</div>
</body>
</html>


