<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치 리스트</title>
<style>
	.table-container{
		margin : 0 auto;
		margin-top : 50px;
	}
	.w3-table {
	width: 60%;
	margin : 0 auto;
}

.w3-table td {
  padding: 5px; 
   text-align: center;
}
.w3-table tr {
  margin-bottom: 5px; 
 
}

</style>
</head>
<body>
<h1 style="text-align: center;">매치 목록</h1>
<div class="table-container" >
<c:forEach items="${gamelist}" var="game">
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
<tr>
	<td colspan="2" style="text-align: center;">
		<a style="font-size : 5px; " class="underbar" href="../game/gameinfo?game_num=${game.game_num}">[상세보기]</a>
	</td>
</tr>
</table>
</c:forEach>
</div>
<input type="button" value="매치등록하기" onclick="location.href='write'">
</body>
</html>