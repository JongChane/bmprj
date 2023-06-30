<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td>등록일</td>
			<td>${board.board_date}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${board.board_title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${board.board_content}</td>
		</tr>
		<form:form modelAttribute="board" action="reply" method="post" name="f">
			<form:hidden path="board_num"/>
			<form:hidden path="board_grp"/>
			<form:hidden path="board_grpstep"/>
			<form:hidden path="board_id"/>
			<form:hidden path="user_id"/>
			
			<tr>
				<td>제목</td>
				<td>
					<form:input path="board_title" value="RE:${board.board_title}"/>
					<font color="red"><form:errors path="board_title" /></font>
				</td>
			</tr>
			<tr>
				<td>답변 내용</td>
				<td>
					<textarea name="board_content" rows="5"></textarea>
					<font color="red"><form:errors path="board_content" /></font>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<a href="javascript:document.f.submit()">[답변 등록]</a>
				</td>
			</tr>
		</form:form>
	</table>
	
</body>
</html>