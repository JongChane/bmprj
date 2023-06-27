<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 마이페이지</title>
</head>
<body>
	<div id="minfo" class="info">
		<table class="w3-table-all">
   		<tr>
   			<td>아이디</td>
   			<td>${user.user_id}</td>
   		</tr>
   		<tr>
   			<td>이름</td>
   				<td>${user.user_name}</td>
   		</tr>   
   		<tr>
   			<td>성별</td>
   			<td>${user.user_gender}</td>
   		</tr>   
			<tr>
				<td>전화번호</td>
				<td>${user.user_tel}</td>
			</tr>   
   		<tr>
   			<td>이메일</td>
   			<td>${user.user_email}</td>
   		</tr>   
   		<tr>
   			<td>에버점수</td>
   			<td>${user.user_avg}</td>
   		</tr>   
 		</table>
 		<br>
		<a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="update?user_id=${user.user_id}">회원정보수정</a>&nbsp;
 		<a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="password">비밀번호수정</a>&nbsp;
		<a class="w3-button w3-white w3-border w3-border-green w3-round-large" href="delete?user_id=${user.user_id}">회원탈퇴</a>&nbsp;
	</div>
 </body>
 </html>