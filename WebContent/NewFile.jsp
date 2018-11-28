<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<html>
<head>
<meta charset="ISO-8859-1">
<title>test</title>
<f:view>
<h:form>
<% for(int i=0; i<3;i++){ %>
hello world<% out.println(i); 

}%>
<h:outputText value="#{users.hello}"></h:outputText>

</h:form>
</f:view>
</head>
<body>

</body>
</html>