<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
</head>
<body>
    <%
        String path = request.getContextPath();
        pageContext.setAttribute("path", path);
    %>

	<table>
		<tr>
			<td>작성자</td>
			<td>${board.user_id}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${board.board_title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<table>
					<tr>
						<td>${board.board_content}</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<c:if test="${sessionScope.login eq board.user_id}">
	<button type="button" onclick="location.href='update?board_num=${board.board_num}'">[수정]</button>
	<button type="button" onclick="detailDelete(${board.board_num})">[삭제]</button>
	</c:if>
	
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
	<script>
		function detailDelete(board_num) {
		    if (confirm('정말 삭제하시겠습니까?')) {
		        deleteBoard(board_num);
		    }
		}
		
		function deleteBoard(board_num) {
		    $.ajax({
		        url: "${path}/board/delete",
		        method: "POST",
		        data: { board_num: board_num },
		        success: function(response) {
		            if (response.success) {
		                alert("게시글이 삭제되었습니다.");
		                // 삭제 후 필요한 동작 수행 (예: 페이지 리로드)
		                window.location.href = "${path}/board/list";
		            } else {
		                alert("게시글 삭제에 실패했습니다.");
		            }
		        },
		        error: function() {
		            alert("서버 요청 실패");
		        }
		    });
		}
	</script>
	
</body>
</html>