<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 점수등록</title>
<style>
   .noline { text-decoration: none;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>점수등록</h2>
<form method="post" action="visit">
	<input type="hidden" name="rv_num" value="${param.rv_num}">
	<table class="w3-table-all">
  	<tr>
  		<th>예약번호</th>
  		<th>아이디</th>
  		<th>총점</th>
  		<th>게임수</th>
  		<th>에버점수</th>
  	</tr>
  	<c:forEach items="${visitList}" var="visit">
  	<tr>
  		<td>${visit.rv_num}</td>
  		<td><input type="hidden" name=vi_id value="${visit.vi_id}">${visit.vi_id}</td>
  		<td><input type="text" name="vi_total"></td>
  		<td><input type="text" value="${visit.vi_game}" readonly></td>
  		<td><input type="text" name="vi_avg"></td>				
  	</tr>
  	</c:forEach>
   </table>
   <button type="submit">점수등록</button>
</form>
</body>
</html>
