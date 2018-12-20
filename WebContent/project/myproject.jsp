<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	//MyProjectMBean pb = new MyProjectMBean();
	String path = (String) request.getAttribute("javax.servlet.forward.request_uri");
	if(session.getAttribute("username") == null){
		System.out.println("HERE");
		response.sendRedirect("../login.jsf?from="+path);
		return;
	}
	
	
	
	
	
	String username = (String)session.getAttribute("username");
	int userid = (Integer)session.getAttribute("userid");
	ProjectStored ps = new ProjectStored();
	List<Map<String, Object>> maplist = ps.getProjectProp(userid);
	
	//Set page context
	pageContext.setAttribute("maplist", maplist);
	pageContext.setAttribute("userid", userid);
	
%>
<c:set target="${usermbean}" property="userid" value="${userid}"/>
<c:set value="${usermbean.joinedproject}" var="joinedprojectlist"/>

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
.contentswrapper{
	padding: 10px;
}
.seperator{
	height: 20px;
}
</style>
<meta charset="UTF-8">
<title>My project - Labstry FocusSight</title>
</head>
<body>
<%@include file="header.jsp"%>
<f:view>
<div class="title">My FocusSight Projects</div>
<a href="newproject.jsf" class="add">Create a new project</a>
<div class="card">
<div class="title">Leading Projects...</div>
<c:forEach items="${maplist}" var="mapitem">
	<a class="item" href="viewproject.jsf?id=${mapitem.pid}">
		<div class="contentswrapper">
			<div>${mapitem.pname}</div>
			<div>${mapitem.pintro}</div>
		</div>
	</a>
	<div class="seperator"></div>
</c:forEach>
</div>
<div class="card">
<div class="title">Joined Projects..</div>
<c:forEach items="${joinedprojectlist}" var="joinedlist">
	<c:if test="${joinedlist.pid == 0}" var="notfound">
		<a class="item" href="viewprojectbycata.jsf">
			<div class="contentswrapper">
				<div>${joinedlist.pname}</div>
				<div>We need your contribution. ${joinedlist.pintro}</div>
			</div>
		</a>
		<div class="seperator"></div>
	</c:if>
	<c:if test="${not notfound}">
		<a class="item" href="viewproject.jsf?id=${joinedlist.pid}">
			<div class="contentswrapper">
				<div>${joinedlist.pname}</div>
				<div>${joinedlist.pintro}</div>
			</div>
		</a>
		<div class="seperator"></div>
	</c:if>
</c:forEach>
</div>
<!--
%
	
=======
<a href="newproject.jsp" class="add">Create a new project</a>

<c:forEach items="${projectmap}" var="map">
	<a class="item" href="viewproject.jsp?id=${map.pid}">
		<c:out value="${map.pname}"></c:out>
		<c:out value="${map.pintro}"></c:out>
	</a>
</c:forEach>
<!-- 
<<<<<<< HEAD
>>>>>>> CAUSAL UPLOAD
=======
>>>>>>> c71fa41b7ae82bb79776ca509a4bff9933b14e32
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
<<<<<<< HEAD
<<<<<<< HEAD
	
%> 
--->
</f:view>
</body>

</html>