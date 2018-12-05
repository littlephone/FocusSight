<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.focussight.stored.SQLToolkit" %>
<%@ page import="java.sql.*, com.focussight.manbean.*, 
				com.focussight.stored.*,
				java.util.*" %>

<%
	//Before we start, we need to get the current session
	MyProjectMBean pb = new MyProjectMBean();

	String username = (String)session.getAttribute("username");
	int userid = (Integer)session.getAttribute("userid");
	ProjectStored ps = new ProjectStored();
	List<Map<String, Object>> maplist = ps.getProjectProp(userid);
	pageContext.setAttribute("maplist", maplist);
	
%>

<!DOCTYPE html>
<html>
<head>
<style>
body{
	margin:0;
}
.title{
	font-size: 20px;
	padding:50px;
}
.contents{
	
}
</style>
<meta charset="UTF-8">
<title>My project</title>
</head>
<body>
<%@include file="../header.jsp"%>
<f:view>
<div class="title">My FocusSight Projects</div>
<a href="newproject.jsf" class="add">Create a new project</a>
<c:forEach items="${maplist}" var="mapitem">
	<a href="viewproject.jsf?id=${mapitem.pid}">${mapitem.pname}</a>
</c:forEach>
<!--
%
	
	for(Map mapitem : maplist){
		int pid = (int) mapitem.get("pid");
		String pname = (String) mapitem.get("pname");
		out.println("<a href=\"viewproject.jsp?id="+pid+"\">"+pname+"</a>");
		
	}
	
%> 
--->
</f:view>
</body>

</html>