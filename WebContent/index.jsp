<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//Check if the session is exists
if(!session.isNew()){
	String username = (String)session.getAttribute("username");
	int id = (Integer)session.getAttribute("id");
}else{
	String username = null;
	int id = 0;
}
%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
	margin: 0;
}
</style>
<meta charset="UTF-8">
<title>FocusSight EE - Labstry</title>
</head>
<body>
<%@include file="header.jsp"%>
<h1>Your project, your team, starts here...</h1>

<%
if(uname != null){
%>
<a href="myproject.jsp"> 我的项目 My project </a>
<%} %>
</body>
</html>