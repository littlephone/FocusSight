<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>

<%
		int projectID = Integer.parseInt(request.getParameter("pid"));

		//Set current userid and username if exists
		Integer userid = 0;
		String username = null;
		int curruid = 0;
		if(session.getAttribute("id") != null){
			userid = (Integer)session.getAttribute("userid");
			username = (String)session.getAttribute("username");
			curruid = userid;
		}
		
		pageContext.setAttribute("mode", (String) session.getAttribute("mode"));
		pageContext.setAttribute("userid", userid);
		pageContext.setAttribute("projectid", projectID);
%>


<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set target="${noticembean}"  property="pid" value="${projectid}"></c:set>
<c:set target="${noticembean}" property="uid" value="${userid}"></c:set>

<f:view>
<h:inputText  value="#{noticembean.ntitle}"/><br/>
<h:inputTextarea value="#{noticembean.ncontent}" styleClass="text-area"></h:inputTextarea><br/>
<c:if test="${mode == 'add'}" var="addmode">
	<h:commandButton value="Add" action="#{noticembean.AddNotice}"></h:commandButton>
</c:if>
<c:if test="${not addmode}">
	<h:commandButton value="Edit" action="#{noticembean.EditNotice}"></h:commandButton>
</c:if> 
</f:view>
</body>
</html>