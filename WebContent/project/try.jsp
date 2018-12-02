<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.focussight.stored.SQLToolkit" %>
<%@ page import="java.sql.*, 
				com.focussight.manbean.*, 
				com.focussight.stored.*,
				java.util.*, 
				javax.servlet.jsp.*
				"
				 %>

<%
	//Before we start, we need to get the current session
	if(session.getAttribute("username") == null){
		System.out.println("HERE");
		response.sendRedirect("../login.jsf?getBackTo=myproject.jsf");
		return;
	}
	MyProjectMBean pb = new MyProjectMBean();
	String username = (String)session.getAttribute("username");
	int userid = (Integer)session.getAttribute("userid");
	pageContext.setAttribute("userid", userid);
	
	ProjectStored ps = new ProjectStored();
	List<Map> maplist = ps.getProjectProp(userid);
	pageContext.setAttribute("projectmap", maplist);
	
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
a{
	display:block;
	text-decoration:none;
	color:black;
}

.item{
	width: 98%;
	height: 100px;
	border:1px solid grey;
	border-radius: 18px;
	margin:auto;
	
}
.projectwrapper{
	padding: 10px;
}
</style>
<meta charset="UTF-8">
<title>My project</title>
</head>
<body>
<%@include file="../header.jsp"%>
<f:view>
<div class="title">My FocusSight Projects</div>
<a href="newproject.jsp" class="add">Create a new project</a>

<c:forEach items="${projectmap}" var="map">
	<a class="item" href="viewproject.jsp?id=${map.pid}">
		<c:out value="${map.pname}"></c:out>
		<c:out value="${map.pintro}"></c:out>
	</a>
</c:forEach>
<!-- 
	for(Map mapitem : maplist){
		int pid = (int) mapitem.get("pid");
		String pname = (String) mapitem.get("pname");
		String pintro = (String) mapitem.get("pintro");
		pageContext.setAttribute()
		pageContext.setAttribute("pname", pname);
		pageContext.setAttribute("pintro", pintro);
		%>
		<a class="item" href="viewproject.jsp?id=${pid}">
			<div class="cardwrapper">
				<c:out value="${pname}"></c:out>
				<c:out value="${pintro}"></c:out>
			</div>
		
		</a>
			
	}
	 -->
</f:view>
</body>

</html>