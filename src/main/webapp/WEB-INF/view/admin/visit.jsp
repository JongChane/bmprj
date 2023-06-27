<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 게임결과</title>
</head>
<body>
	<h2>게임결과</h2>
	<form:form modelAttribute="user" method="post" action="join"> 
		<spring:hasBindErrors name="user">
    	<font color="red">
    		<c:forEach items="${errors.globalErrors}" var="error">
        	<spring:message code="${error.code}" /><br>
      	</c:forEach>
    	</font>
 		</spring:hasBindErrors>
 		<table>
 			<tr>
 				<td>게임참여 회원</td>
 			</tr>
 		</table>
	</form:form>
</body>
</html>