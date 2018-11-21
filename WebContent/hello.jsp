<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>  
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>  
 <head>  
 <title>第一个JSF程序</title>  
 </head>  
 <body>  
 <f:view>  
 <h:form>  
 <h3>请输入您的名称</h3>  
 <h:outputText value="#{user.errmessage}" /><p>
名称: <h:inputText value="#{user.name}"/><p>  
密码：<h:inputText value="#{user.password}" /><p>
<h:inputText binding="#{user.age}" /><p>
 <h:commandButton value="提交" action="#{user.check}"/>  
 </h:form>  
 </f:view>  
 </body>  
 </html> 
