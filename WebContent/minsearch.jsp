<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@page import="java.util.*, 
 								com.focussight.manbean.*" %>
 								
 			
<%

//Check if the session is exists
if(!session.isNew()){
	String username = (String)session.getAttribute("username");
	int id = (Integer)session.getAttribute("id");
}else{
	String username = null;
	int id = 0;
}
String searchname=request.getParameter("searchname");
pageContext.setAttribute("searchname", searchname);

	ProjectMBean mbean = new ProjectMBean();
	 mbean.selectProjectbyName(searchname);
	 List<Map<String, Object>> list = mbean.getProjectmap();
	 pageContext.setAttribute("list", list);
%>
<c:forEach items="${list}" var="map">
	<a class="card" href="projectdetails.jsf?id=${map.pid}">
	${map.pname} (pid: ${map.pid})
	</a>
</c:forEach>
