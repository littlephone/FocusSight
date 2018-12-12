<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@page import="java.util.*, 
 								com.focussight.manbean.*" %>
<%

//Check if the session is exists
if(!session.isNew()){
	String username = (String)session.getAttribute("username");
	int id = (Integer)session.getAttribute("id");
}else{
	String username = null;
	int id = 0;
}

	ProjectMBean mbean = new ProjectMBean();
	 mbean.showProjects();
	 List<Map<String, Object>> list = mbean.getProjectmap();
	 pageContext.setAttribute("list", list);
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
<f:view>
<h1>Your project, your team, starts here...</h1>

<%
if(uname != null){
%>
<a href="project/myproject.jsf"> 我的项目 My project </a>
<a href="manage.jsf">My information</a>
<%} %>

<div>
Projects:
<c:forEach items="${list}" var="map">
	<a href="projectdetails.jsf?id=${map.pid}">${map.pname} <br/>
		
	</a>
</c:forEach>
</div>
</f:view>
</body>
</html>