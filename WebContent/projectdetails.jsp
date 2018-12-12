<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*,
								  java.util.*, 
								 com.focussight.stored.*, 
								 javax.faces.context.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	if(Integer.parseInt(request.getParameter("id"))== 0){
		return;
	}
	int projectID = Integer.parseInt(request.getParameter("id"));
	FacesContext facesContext = FacesContext.getCurrentInstance();
	Object o = facesContext.getApplication().evaluateExpressionGet(facesContext,
            "#{phaseListenerBean}", Object.class);
	
	ProjectStored stored = new ProjectStored();
	Map<String, Object> projectMap = stored.getProjectByPid(projectID);
	pageContext.setAttribute("projectMap", projectMap);
%>

<title>Join project ${projectMap.pname} - Labstry FocusSight</title>
</head>
<body>
<%@include file="header.jsp"%>
<div>
<h1>${projectMap.pname}</h1>
Introduction: ${projectMap.pintro}
<a href="addproject.jsf?action=add">Join</a>
</div>
</body>
</html>