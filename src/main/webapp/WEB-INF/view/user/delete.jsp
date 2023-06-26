<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 회원탈퇴</title>
</head>
<body>
	<table class="w3-table">
  	<tr>
  		<td>아이디</td>
  		<td>${user.user_id}</td>
  	</tr>
  	<tr>
  		<td>이름</td>
  		<td>${user.user_name}</td>
  	</tr>
	</table>
	<form method="post" action="delete" name="deleteForm">
  	<input type="hidden" name="user_id" value="${param.user_id}">
  	비밀번호 : <input type="password" name="user_pass" class="w3-input">
  	<a href="javascript:document.deleteForm.submit()">[회원탈퇴]</a>
	</form>
</body>
</html>