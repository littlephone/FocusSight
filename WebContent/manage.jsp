<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="java.util.*" %>
<%@page import="com.focussight.stored.*" %>
<%@page import="com.focussight.manbean.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int uid = (int)session.getAttribute("userid");
request.setAttribute("uid", uid);
UserMBean bean = new UserMBean();
bean.ShowUserByUid(uid);
Map<String, Object> map = bean.getUsermap();
pageContext.setAttribute("map", map);
%>
<c:set target = "${usermbean}" property="userid" value="${map.userid}"/>
<c:set target = "${usermbean}" property="username" value="${map.username}"/>
<c:set target = "${usermbean}" property="profession" value="${map.profession}"/>
<c:set target = "${usermbean}" property="gender" value="${map.gender}"/>
<c:set target = "${usermbean}" property="age" value="${map.age}"/>
<c:set target = "${usermbean}" property="email" value="${map.email}"/>
<c:set target = "${usermbean}" property="phone" value="${map.phone}"/>


<f:view>
<h:form >
<a href="index.jsf"> &le;&le;back <br/>
Userid: <h:inputText   id="userid" value="#{usermbean.userid}"/><br/>
Username: <h:inputText  id="username" value="#{usermbean.username}"/><br/>
GENDER:<h:inputText id="gender" value="#{usermbean.gender}"/><br/>
Profession:<h:inputText id="profession" value="#{usermbean.profession}"/><br/>
AGE:<h:inputText id="age" value="#{usermbean.age}"/><br/>
EMAIL:<h:inputText id="email" value="#{usermbean.email}"/><br/>
PHONE:<h:inputText id="phone" value="#{usermbean.phone}"/><br/>
<h:commandButton id="submit" type="submit" value="Submit" action="#{usermbean.UpdateUserInfoByUid}"/>
</h:form>
</f:view>
</body>
</html>