<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치 상세보기</title>
</head>
<body>
<h2>매치 상세보기</h2>
<hr>
  <table class="w3-table"  >
<tr>
	<td>
		제목 : ${game.game_title}
	</td>
	<td>
		작성자 : ${game.user_id}
	</td>
</tr>
<tr>
	<td>
		경기인원 : ${game.game_max}
	</td>
	<td>
		성별 :
	<c:if test="${game.game_gender == 1 }">
		남
	</c:if>
	<c:if test="${game.game_gender == 2 }">
		여
	</c:if>
	<c:if test="${game.game_gender == 3 }">
		성별무관
	</c:if>
	</td>
</tr>

<tr>
	<td>
		평균에버리지 : ${game.game_avg}
	</td>
	<td>
		나이제한 : ${game.game_age}
	</td>
</tr>
<tr >
	<td>
		경기날짜 : 
		<fmt:formatDate value="${game.game_date}" pattern="yyyy년MM월dd일"/>
	</td>
	
</tr>
</table>
<hr>
<table>
<tr>
	<td>
		제한사항
	</td>
</tr>
<tr>
	<td>
		${game.game_content}
	</td>
</tr>
<tr>
	<td colspan="2" style="text-align: center;">
		<input type="submit" value="신청하기"  onclick="">	
	</td>
</tr>
</table>
</body>
</html>