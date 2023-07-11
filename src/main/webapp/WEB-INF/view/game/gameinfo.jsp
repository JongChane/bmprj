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
<div class="mx-auto mt-5" style="width: 70%;">
  <table class="table table" style="text-align:center;"  >
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
		성별 : ${game.game_gender }
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
	<td colspan="2">
		경기날짜 : 
		<fmt:formatDate value="${game.game_date}" pattern="yyyy년MM월dd일"/>
	</td>
	<td>
	</td>
</tr>
<tr>
	<td colspan="2">
		제한사항
	</td>
</tr>
</table>
<table class="table table" style="text-align:center; height:500px;">
<tr>
	<td>
		${game.game_content}
	</td>

</tr>
<tr>
	<td colspan="2" style="text-align: center;">
		<c:if test="${game.game_max > game.game_people && game.user_id != sessionScope.loginUser.user_id}">
			<button type="button" class="btn btn-success" onclick="location.href='apply?game_num=${game.game_num}'">신청하기</button>
		</c:if>
		<c:if test="${game.game_max == game.game_people }">
			<button type="button" class="btn btn-success" onclick="javascript:alert('마감되었습니다.')">마감</button>
		</c:if>
		<c:if test="${sessionScope.loginUser.user_id == game.user_id }">
			<a href="update?game_num=${game.game_num}&userid=${sessionScope.loginUser.user_id}">
				<button type="button" class="btn btn-success">매치 수정하기</button>
			</a>
		</c:if>
	</td>
</tr>
</table>
</div>
</body>
</html>