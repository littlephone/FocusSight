<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page import="java.sql.*,
								  java.util.*, 
								 com.focussight.stored.*, 
								 javax.faces.context.*" %>

<!DOCTYPE html>
<html>
<style>
body{
	margin:0;
}
.introwrapper{
	border-radius: 18px;
	border: 1px solid grey;
	width: 98%;
	min-height: 400px;
	margin: 0 auto;
	margin-top: 50px;
	overflow-x:hidden;
}
.introinnerwrapper{
	width:100%;
	height:100%;
}
.coloredwrapper{
	background-color: #00c5ff;
	padding:100px;
}
.projecttitle{
	font-size:28px;
}
</style>
<head>
<meta charset="UTF-8">
<%
	if(request.getParameter("id") == null || session.getAttribute("userid") == null){
		HttpSession session22 = request.getSession();
		response.sendRedirect("index.jsf");
		return;
	}
	int userid = (int)session.getAttribute("userid");
	int projectID = Integer.parseInt(request.getParameter("id"));
	
	pageContext.setAttribute("userid", userid);
	pageContext.setAttribute("projectid", projectID);
%>
<c:set target="${projectmbean}" property="pid" value="${projectid}"/>
<c:set value="${projectmbean.projectdetails}" var="map"/>

<title>Join project ${map.pname} - Labstry FocusSight</title>
</head>
<body>
<f:view>
<%@include file="header.jsp"%>
<div class="introwrapper">
	<div class="introinnerwrapper">
		<div class="coloredwrapper">
			<div class="projecttitle">${map.pname}</div>
			Introduction: ${map.pintro}
		</div>
		<a href="joinproject.jsf?action=request&id=${userid}&project=${map.pid}">Join</a>
	</div>
</div>
</f:view>
</body>
</html>