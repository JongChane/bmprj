<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 건의사항</title>
<style>
	
	th {
		width:35%;
		padding : 0px;
		height : 40px;
	}
	
	table {
		margin : 55px auto;
	}
	td {
		border-bottom: 1px solid black;
		height : 70px;
	}
	.container {
		margin : 50px 50px 50px 50px;
		boarder : 1px solid black;
	}
</style>
</head>
<body>
	<div>
		<h2>건의사항 목록</h2>
		<div class="container">
			<table class="w3-center" >
				<tr class="w3-black">
					<th>번호</th>
					<th>제목</th>
					<th>날짜</th>
					<th>작성자</th>
				</tr>
				<c:forEach items="${boardList}" var="boardList">
					<tr>
						<td>${boardList.board_num}</td>
						<td><a href="${path}/board/detail?board_num=${boardList.board_num}">${boardList.board_title}</a></td>
						<td><fmt:formatDate value="${boardList.board_date}" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.user_id}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>



</html>