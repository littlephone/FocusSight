<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<%@include file="../header.jsp"%>
<% if(uname != null){ %>
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
	<div>Project Screenshots: <!--<input type="file" name="projectScreenshot"/> ---></div>
	
	<h:outputLink id="submit" value="#{projectmbean.createProject}+#{projectmbean.pid}">Create</h:outputLink>

</h:form>

</f:view>
</body>
<%
}else{
	response.sendRedirect("index.jsp");
}
%>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<script>
$('.projectname').on("keyup", function(e){
	var projectname = $('.projectname').val();
	if(projectname != ""){
		$(document).prop('title', projectname + " - Labstry FocusSightEE");
		$('.projecttitle').text(projectname);
	}
	else{
		$(document).prop('title', "New Project - Labstry FocusSightEE");
		$('.projecttitle').text("New Project");
	}
});
</script>
</html>