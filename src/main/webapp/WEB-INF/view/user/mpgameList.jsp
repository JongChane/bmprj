<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소셜매치 내역</title>
</head>
<body>
<div class="container" style="magin-top:55px;">
	<div style="display : flex; justify-content : space-between;">
	  	<div style="flex-basis : 20%;">
			<h2>소셜매치 내역</h2>
 			<%@ include file="mypageSideBar2.jsp" %>
		</div>
	<table class="w3-table">
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>내용</th>
			<th>매칭날짜</th>
			<th>신청인원</th>
			<th></th>
		</tr>
		<c:forEach var="g" items="${glist}">
		<tr>
			<td>${g.game_title}</td>
			<td>${g.user_id}</td>
			<td>${g.game_content}</td>
			<td>
				<fmt:formatDate value="${g.game_date}" pattern="yyyy년MM월dd일"/>
			</td>
			<td>${g.game_max}/${g.game_people}</td>
			<td>
				<input type="checkbox" name="idchks" value="${g.game_num}"/>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</div>
</body>
</html>