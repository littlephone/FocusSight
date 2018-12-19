<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.focussight.stored.* , java.util.*" %>
    
<%
		int pid = Integer.parseInt(request.getParameter("pid"));

		ProjectStored projectstored = new ProjectStored(pid);
		
		String project_name = projectstored.project.getPname();
		
		
		//Set Attrib
		pageContext.setAttribute("pname", project_name);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Status of ${pname} - Labstry FocusSight</title>
</head>
<body>

</body>
</html>