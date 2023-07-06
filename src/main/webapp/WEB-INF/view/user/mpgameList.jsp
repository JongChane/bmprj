<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소셜매치 내역</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("#minfo").show()
		$("#oinfo").hide()
		$(".gLine").each(function(){
			$(this).hide()
		})
	})
	
	function list_disp(id){
		$("#"+id).toggle()
	}
</script>
</head>
<body>
<div class="container" style="magin-top:55px;">
	<div id="minfo" class="minfo" style="display : flex; justify-content : space-between;">
	  	<div style="flex-basis : 20%;">
			<h2>소셜매치 내역</h2>
 			<%@ include file="mypageSideBar2.jsp" %>
		</div>
	<table class="w3-table-all">
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>내용</th>
			<th>매칭날짜</th>
			<th>신청인원</th>
			<th></th>
		</tr>
			<c:forEach var="g" items="${glist}" varStatus="stat">
		<tr>
			<td>${g.game_title}</td>
			<td>${g.user_id}</td>
			<td>${g.game_content}</td>
			<td>
				<fmt:formatDate value="${g.game_date}" pattern="yyyy년MM월dd일"/>
			</td>
				<td>
				<a href="javascript:list_disp('gLine${stat.index}')">
					${g.game_max}/${g.game_people}
				</a>
				</td>
			<td>
				<input type="checkbox" name="idchks" value="${g.game_num}"/>
			</td>
		</tr>
		<tr id="gLine${stat.index}" class="gLine">
		<td>
		<table>
			<tr >
				<th>참가자 아이디</th>
				<th>참가자 성별</th>
				<th>참가자 나이</th>
				<th>참가자 에버리지</th>
				<th></th>
				<th></th>
			</tr>
			<c:forEach var="gm" items="${gmuser}">
				<tr>
					<td>${gm.user_id}</td>
					<td>${gm.user_gender}</td>
					<td>${gm.user_age}</td>
					<td>${gm.user_avg}</td>
				</tr>
			</c:forEach>
		</table>
		</td>
		</tr>
		</c:forEach>
	</table>
</div>
	</div>
</body>
</html>