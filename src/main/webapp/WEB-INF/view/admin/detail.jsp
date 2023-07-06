<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<style>
.detail {
  border-collapse: collapse;
}

.detail td {
  border-bottom: 1px solid black;
  padding : 15px;
}	
.delete-btns {
	margin : 100px 0 0 500px;
}
</style>


<div class="container" style="margin-top:55px;">
	<div class="w3-container" align="center">
    <table class="detail">
    	<tr>
    		<td>등록일</td>
    		<td colspan="2">
    			<fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/>
    		</td>
    	</tr>
        <tr>
            <td>작성자</td>
            <td colspan="2">${board.user_id}</td>
        </tr>
        <tr>
            <td>제목</td>
            <td>${board.board_title}</td>
        </tr>
        <tr>
            <td>내용</td>
            <td>${board.board_content}</td>
        </tr>
		<c:if test="${not empty comm.comm_date}">
		    <tr>
		        <td>답변일</td>
		        <td><fmt:formatDate value="${comm.comm_date}" pattern="yyyy-MM-dd" /></td>
		    </tr>
		    <tr>
		        <td>답변</td>
		        <td>${comm.comm_content}</td>
		    </tr>
		</c:if>
    </table>
    </div>
<%--     <c:if test="${sessionScope.login eq board.user_id}">
        <div class="delete-btns">
            <button type="button" onclick="location.href='update?board_num=${board.board_num}'">수정</button>
            <button type="button" onclick="detailDelete(${board.board_num})">삭제</button>
        </div>
    </c:if> --%>
    
</div>

<c:if test="${sessionScope.adminId == 'admin'}">
    <div class="reply-container">
        <form:form modelAttribute="comment" action="comment" method="post" class="reply-form">
            <table>
                <tr>
                <c:if test="${empty comm.comm_content}">
                    <td>답변 내용 :</td>
                    <td><textarea rows="4" cols="50" name="comm_content"></textarea></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="답변하기"></td>
                </tr>
                </c:if>
                
            </table>
        </form:form>
    </div>
</c:if>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function detailDelete(board_num) {
        if (confirm('정말 삭제하시겠습니까?')) {
            deleteComment(board_num);
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
