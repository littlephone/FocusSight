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

<form method="POST" action="Login">
Username: <input type="text" name="username"/><br/>
Password: <input type="password" name="password"/><br/>
<input type="submit" value="Submit"/>
</form>

</div>
</body>
</html>