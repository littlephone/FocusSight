<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
<%@include file="header.jsp"%>

<% if(uname != null){ %>

<div class="projecttitle">New Project</div>

<div>Tell us about your idea.</div>

<form method="POST" action="CreateProject">

<div>Project Name: <input type="text" class="projectname" name="projectname"/></div>

<div>Description or Requirements:
	<textarea name="requirements"></textarea> 
</div>

<div>Project Screenshots: <input type="file" name="projectScreenshot"/></div>

<input type="submit" name="submit"/>

</form>
<%
}else{
	response.sendRedirect("index.jsp");
}
%>
</body>
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