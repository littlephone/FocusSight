<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="com.focussight.dao.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<style>
.cardwrapper{
	width: 500px;
	min-height: 400px;
	border: 2px solid grey;
	border-radius: 20px;
	margin: auto;
	overflow:hidden;
}
.cardtitle{
	font-size: 30px;
	font-family: Arial, Tahoma;
	padding-top: 120px;
	background-color: orange;
	padding-left: 10px;
}
</style>

<meta charset="UTF-8">
<title>Login to EE -  Labstry</title>
</head>
<body>
<div class="cardwrapper">
<div class="cardtitle">Login to FocusSight EE</div>

<form method="POST" action="LoginServlet">
<div class="formrow"> Username: <input type="text" name="username"/></div>
<div class="formrow"> Password: <input type="password" name="password"/></div>
<div class="formrow"><input type="submit" name="submit" value="Submit"/></div>
<div class="formrow">New to here? <a href="register.jsp">Register</a></div>
</form>

</div>
</body>
</html>