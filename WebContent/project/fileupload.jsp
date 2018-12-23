<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@page import="java.util.*" %>
<%@page import="com.focussight.stored.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>

<%
		int projectID = Integer.parseInt(request.getParameter("pid"));
        int taskID = Integer.parseInt(request.getParameter("tid"));
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
		pageContext.setAttribute("username", username);
		pageContext.setAttribute("tid", taskID);
		out.println(projectID);
		out.print(taskID);
%>
  <head>
    <title>文件上传</title>
  </head>
  
  <body>
    <form action="${pageContext.request.contextPath}/UploadHandleServlet" enctype="multipart/form-data" method="post">
        上传用户：<input type="text" name="pid" value="${projectid}"><br/>
        上传用户：<input type="text" name="tid" value="${tid}"><br/>
        上传文件1：<input type="file" name="file1"><br/>
        <input type="submit" value="提交">
    </form>
  </body>
</html>