<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>
<%

	int pid = Integer.parseInt(request.getParameter("pid"));
	System.out.println(pid);
	int uid = 0;
	
	if(request.getParameter("uid") != null)
		uid = Integer.parseInt(request.getParameter("uid"));
	
	String action = (String) request.getParameter("action");
	
	
	pageContext.setAttribute("pid", pid);
	pageContext.setAttribute("userid", uid);
	pageContext.setAttribute("action", action);

%>

<c:set target="${membermbean}" property="projectid" value="${pid}"/>

<c:if test="${action != null}">
	<c:if test="${action == 'add'}">
		<c:set target="${membermbean}" property="projectid" value="${pid}"/>
		<c:set target="${membermbean}" property="userid" value="${userid}"></c:set>
		<%--Callback function and never returns--%>
		<c:set value="${membermbean.confirmUser}" var="cuser"></c:set>
	</c:if>
	<c:if test="${action == 'reject'}">
		<c:set target="${membermbean}" property="projectid" value="${pid}"/>
		<c:set target="${membermbean}" property="userid" value="${userid}"></c:set>
		
		<%--Callback function and never returns--%>
		<c:set value="${membermbean.rejectUser}" var="ruser"></c:set>
	</c:if>
	<c:if test="${action == 'block'}">
		<c:set target="${membermbean}" property="projectid" value="${pid}"/>
		<c:set target="${membermbean}" property="userid" value="${userid}"></c:set>
		
		<%--Callback function and never returns--%>
		<c:set value="${membermbean.blockUser}" var="buser"></c:set>
	</c:if>
	
</c:if>

<html>
<head>


<meta charset="UTF-8">
<title>Manage member of </title>
</head>
<body>

</body>
</html>