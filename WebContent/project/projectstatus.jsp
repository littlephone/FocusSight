<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ page import="com.focussight.stored.* , java.util.*" %>
    
<%
		int pid = Integer.parseInt(request.getParameter("pid"));

		ProjectStored projectstored = new ProjectStored(pid);
		
		String project_name = projectstored.project.getPname();
		
		
		//Set Attrib
		pageContext.setAttribute("pname", project_name);
		pageContext.setAttribute("pid", pid);
%>
<c:set target="${membermbean}" property="projectid" value="${pid}"></c:set>
<c:set value="${membermbean.unconfirmeduser}" var="requestmap"></c:set>

<!DOCTYPE html>
<html>
<style>
body{
	margin:0;
}
</style>
<head>
<meta charset="UTF-8">
<title>Project Status of ${pname} - Labstry FocusSight</title>
</head>
<body>
<c:forEach items="${requestmap}" var="requestsent">
	<div>${requestsent.username} would like to participate in the project.</div>
	<a>View Profile</a>
	<a href="managemember.jsf?action=add&pid=${pid}&uid=${requestsent.mid}">Allow</a>
	<a href="managemember.jsf?action=reject&pid=${pid}&uid=${requestsent.mid}">Reject</a>
	<a href="managemember.jsf?action=block&pid=${pid}&uid=${requestsent.mid}">Block</a>
</c:forEach>

</body>
</html>