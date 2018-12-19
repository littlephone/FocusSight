<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
	margin:0;
} 
.projecttitle{
	font-size:30px;
}
</style>
<meta charset="UTF-8">
<title>New Project - Labstry FocusSightEE</title>
</head>
<body>
<%int uid = (int)session.getAttribute("userid");
out.print(uid);
pageContext.setAttribute("uid", uid);
%>
<c:set target = "${projectmbean}" property="manager_id" value="${uid}"/>

<%@include file="../header.jsp"%>

<f:view>
<div class="projecttitle">New Project</div>

<div>Tell us about your idea.</div>


<h:form>
	<div>Project Name: <h:inputText  value="#{projectmbean.pname}"></h:inputText></div>
	<div>Please give us a brief introduction to your project<br/>
	<h:inputTextarea value="#{projectmbean.pintro}"></h:inputTextarea>
	</div>
	<div>Description or Requirements: <br/>
	<h:inputTextarea value="#{projectmbean.requirements}"></h:inputTextarea></div>
	<h:commandButton id="submit" type="submit" value="Submit" action="#{projectmbean.createProject}"/>
</h:form>

</f:view>
</body>


</html>