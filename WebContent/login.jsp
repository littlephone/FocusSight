<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.focussight.dao.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login to EE -  Labstry</title>
</head>
<body>
<div>
Login to FocusSight EE
</div>

<form method="POST" action="Login">
Username: <input type="text" name="username"/><br/>
Password: <input type="password" name="password"/><br/>
<input type="submit" value="Submit"/>
</form>

</body>
</html>