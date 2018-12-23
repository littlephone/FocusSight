<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@page import="com.focussight.stored.*, 
				java.util.*"  %>
<!DOCTYPE html>
<%
	int pid = Integer.parseInt(request.getParameter("pid"));
	int userid = (int)session.getAttribute("userid");
	
	List<Integer> availyears = new ArrayList<Integer>();
	List<Integer> months = new ArrayList<Integer>();
	
	for(int i = 1970; i<= 2099; i++) availyears.add(i);
	for(int i = 1; i<= 12; i++) months.add(i);
	
	//Set page context
	pageContext.setAttribute("pid", pid);
	pageContext.setAttribute("year", availyears);
	
%>
<c:set target="${taskmbean}" property="pid" value="${pid}"/>

<html>
<link rel="stylesheet" type="text/css" href="projectsettings.css"/>
<head>
<meta charset="UTF-8">
<title>Add task to ${map.pname} - Labstry FocusSight</title>
</head>
<body>
<f:view>
<c:import url="header.jsp"/>
<div class="project_details_wrapper">
	<div class="details_inner_wrapper">
		<div class="project_name"><b>Add task to ${map.pname}</b></div>
	</div>
</div>
<h:form>
	<h:inputText id="pid" value="#{taskmbean.pid}" styleClass="hidden"></h:inputText>
	<h:inputText id="ttitle" value="#{taskmbean.ttitle}"></h:inputText><br/>
	<select name="year" class="year">
		<c:forEach items="${year}" var="yearline">
			<option value="${yearline}">${yearline}</option>
		</c:forEach>
	</select>/
	<select name="month" class="month">
		<c:forEach items="${month}" var="monthline">
			<option value="${monthline}">${monthline}</option>
		</c:forEach>
	</select>/

</h:form>
</f:view>
</body>
</html>