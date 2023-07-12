<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<style>
   .noline { text-decoration: none;}
</style>
</head>
<body>
<h2>회원목록</h2>
  <table class="w3-table-all">
  <%-- list?sort=10 : 아이디의 오름차순 정렬
       list?sort=11 : 아이디의 내림차순 정렬 
  --%>
  <tr><th>아이디<a href="list?sort=10" class="noline">▲</a><%--ㅁ한자 --%>
              <a href="list?sort=11" class="noline">▼</a></th>
      <th>이름<a href="list?sort=20" class="noline">▲</a><%--ㅁ한자 --%>
              <a href="list?sort=21" class="noline">▼</a></th>
      <th>전화<a href="list?sort=30" class="noline">▲</a><%--ㅁ한자 --%>
              <a href="list?sort=31" class="noline">▼</a></th>
      <th>나이<a href="list?sort=40" class="noline">▲</a><%--ㅁ한자 --%>
              <a href="list?sort=41" class="noline">▼</a></th>
      <th>이메일<a href="list?sort=50" class="noline">▲</a><%--ㅁ한자 --%>
              <a href="list?sort=51" class="noline">▼</a></th><th></th>
  </tr>
  <c:forEach items="${list}" var="user">
  <tr>
  	<td>${user.user_id}</td>
  	<td>${user.user_name}</td>
  	<td>${user.user_tel}</td>
  	<td>${user.user_age}</td>
  	<td>${user.user_email}</td>
  	<td>
 			<a href="../user/delete?user_id=${user.user_id}">강제탈퇴</a>
  	</td>
  </tr>
  </c:forEach>
  </table>
 </body>
 </html>