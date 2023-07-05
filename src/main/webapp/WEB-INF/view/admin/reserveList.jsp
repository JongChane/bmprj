<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약관리</title>
<style>
   .noline { text-decoration: none;}
</style>
</head>
<body>
<h2>예약목록</h2>
  <table class="w3-table-all">
  	<tr>
  		<th>예약번호<a href="reserveList?sort=10" class="noline">▲</a>
                <a href="reserveList?sort=11" class="noline">▼</a></th>
      <th>아이디<a href="reserveList?sort=20" class="noline">▲</a>
              <a href="reserveList?sort=21" class="noline">▼</a></th>
      <th>예약시간<a href="reserveList?sort=30" class="noline">▲</a>
                <a href="reserveList?sort=31" class="noline">▼</a></th>
      <th>방문날짜<a href="reserveList?sort=40" class="noline">▲</a>
                <a href="reserveList?sort=41" class="noline">▼</a></th>
      <th>시작시간<a href="reserveList?sort=50" class="noline">▲</a>
                <a href="reserveList?sort=51" class="noline">▼</a></th>
      <th>종료시간<a href="reserveList?sort=60" class="noline">▲</a>
                <a href="reserveList?sort=61" class="noline">▼</a></th>
      <th>레인번호<a href="reserveList?sort=70" class="noline">▲</a>
                <a href="reserveList?sort=71" class="noline">▼</a></th>
      <th>게임수<a href="reserveList?sort=80" class="noline">▲</a>
               <a href="reserveList?sort=81" class="noline">▼</a></th>
      <th>방문인원<a href="reserveList?sort=90" class="noline">▲</a>
                <a href="reserveList?sort=91" class="noline">▼</a></th>
  </tr>
  <c:forEach items="${reserveList}" var="reserve">
  <tr>
  	<td>${reserve.rv_num}</td>
  	<td>${reserve.user_id}</td>
  	<td><fmt:formatDate value="${reserve.rv_now}" pattern="yyyy년 MM월 dd일 hh시 mm분"/></td>
  	<td><fmt:formatDate value="${reserve.rv_date}" pattern="yyyy년 MM월 dd일"/></td>
  	<td><tf:formatDateTime value="${reserve.rv_start}" pattern="HH:mm"/></td>
  	<td><tf:formatDateTime value="${reserve.rv_end}" pattern="HH:mm"/></td>
  	<td>${reserve.lane_num}</td>
  	<td>${reserve.rv_game}</td>
  	<td>${reserve.rv_people}</td>
  	<td>
 			<a href="../admin/visit?rv_num=${reserve.rv_num}">점수등록</a>
  	</td>
  </tr>
  </c:forEach>
  </table>
 </body>
 </html>