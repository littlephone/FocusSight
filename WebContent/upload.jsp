<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@page import="java.util.*" %>
<%@page import="com.focussight.stored.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>文件上传</title>
  </head>
  
  <body>
    <form action="${pageContext.request.contextPath}/UploadHandleServlet" enctype="multipart/form-data" method="post">
        上传用户：<input type="text" name="username"><br/>
        上传文件1：<input type="file" name="file1"><br/>
        上传文件2：<input type="file" name="file2"><br/>
        <input type="submit" value="提交">
    </form>
  </body>
</html>