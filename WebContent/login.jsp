<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@page import="java.util.*" %>
<%@page import="com.focussight.stored.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<%
	String from = null;
	if(request.getParameter("from") != null){
		from = (String)request.getParameter("from");
	}
	pageContext.setAttribute("fromsite", from);
%>
<c:set target="${loginmbean}" property="fromsite" value="${fromsite}"></c:set>
<html>
<head>
<style>
.cardwrapper{
	width: 500px;
	min-height: 400px;
	border: 2px solid grey;
	border-radius: 20px;
	margin: auto;
	overflow:hidden;
}
.cardtitle{
	font-size: 30px;
	font-family: Arial, Tahoma;
	padding-top: 120px;
	background-color: orange;
	padding-left: 10px;
}
.hidden{
	display:none;
}
</style>

<meta charset="UTF-8">
<title>Login to EE -  Labstry</title>
</head>
<body>

<f:view>

<div class="cardwrapper">
<div class="cardtitle">Login to FocusSight EE</div>

<h:form>
<div class="formrow hidden"><h:inputText id="from" value="#{loginmbean.fromsite}"></h:inputText></div>
<div class="formrow"> Username: <h:inputText id="username" value="#{loginmbean.username}"></h:inputText></div>
<div class="formrow"> Password: <h:inputSecret id="password" value="#{loginmbean.password}"></h:inputSecret></div>
<!--<div class="formrow"> Username: <input type="text" name="username"/></div>
<div class="formrow"> Password: <input type="password" name="password"/></div> -->
<div class="formrow"><h:commandButton id="submit" type="submit"  action="#{loginmbean.proccessLogin}" value="Submit"/></div>
<div class="formrow"> Not registered? <a href="register.jsp">Register</a></div>

</h:form>

</div>
</f:view>
</body>
</html>