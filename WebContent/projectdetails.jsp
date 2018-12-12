<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*,
								  java.util.*, 
								 com.focussight.stored.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	if(Integer.parseInt(request.getParameter("id"))== 0){
		return;
	}
	int projectID = Integer.parseInt(request.getParameter("id"));
	ProjectStored stored = new ProjectStored();
	Map<String, Object> projectMap = stored.getProjectByPid(projectID);
	pageContext.setAttribute("projectMap", projectMap);
%>

<title>Insert title here</title>
</head>
<body>
${projectMap.pid} <br/>
${projectMap.pname}<br/>
${projectMap.pintro}
<a href="addproject.jsf?action=add">Add</a>
</body>
</html>