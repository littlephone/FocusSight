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
		if(session.getAttribute("userid") != null){
			userid = (Integer)session.getAttribute("userid");
			username = (String)session.getAttribute("username");
			curruid = userid;
		}
		
		pageContext.setAttribute("userid", userid);
		pageContext.setAttribute("projectid", projectID);
%>
<c:set target="${noticembean}"  property="pid" value="${projectid}"/>
<c:set target="${noticembean}" property="uid" value="${userid}"/>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<f:view>

<h:form>
<h:inputText value="#{noticembean.pid}"/>
<h:inputText value="#{noticembean.uid}"/>
<h:inputText  value="#{noticembean.ntitle}"/><br/>
<h:inputTextarea value="#{noticembean.ncontent}" styleClass="text-area"></h:inputTextarea><br/>
<h:commandButton value="Add" action="#{noticembean.AddNotice}"></h:commandButton>
</h:form>
</f:view>
</body>
</html>