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
		
		pageContext.setAttribute("mode", (String) request.getParameter("mode"));
		pageContext.setAttribute("userid", userid);
		pageContext.setAttribute("projectid", projectID);
		
%>

<c:set target="${noticembean}"  property="pid" value="${projectid}"></c:set>
<c:set target="${noticembean}" property="uid" value="${userid}"></c:set>


<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<f:view>
<c:set value="${noticembean.noticemap}" var="map"/>
<c:forEach items="${map}"  var="mapline">
	<c:if test="${mode == 'delete'}" var="isdelete">
		<a href="deletenotice.jsf?pid=${projectid}&nid=${mapline.nid}">${mapline.ntitle}</a>
	</c:if>
	<c:if test="${not isdelete}">
		<a href="editnotice.jsf?pid=${projectid}&nid=${mapline.nid}">${mapline.ntitle}</a>
	</c:if>
</c:forEach>

</f:view>
</body>
</html>