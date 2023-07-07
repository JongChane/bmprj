<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>

<div class="container w3-light-grey">
	<div class="w3-container">
    <table class="table table-bordered align-middle mt-5">
    	<tr>
    		<td class="text-center w3-black" style="width:25%;">등록일</td>
    		<td colspan="2">
    			<fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/>
    		</td>
    	</tr>
        <tr>
            <td class="text-center w3-black">작성자</td>
            <td colspan="2">${board.user_id}</td>
        </tr>
        <tr>
            <td class="text-center w3-black">제목</td>
            <td>${board.board_title}</td>
        </tr>
        <tr>
            <td class="text-center w3-black">건의사항</td>
            <td>${board.board_content}</td>
        </tr>
    </table>
    
    
    <h2 class="text-center mt-3 mb-5">답변</h2>
    <c:if test="${empty comm.comm_date}">
    	<h4 class="text-center">답변 대기중 입니다.</h4>
    </c:if>
    <c:if test="${not empty comm.comm_date}">
    <table class="table table-bordered  align-middle">
    	<tr>
    		<td class="text-center w3-black" style="width:25%;">답변자</td>
    		<td>볼매관리자</td>
    	</tr>
    	<tr>
    		<td class="text-center w3-black">답변일</td>
    		<td><fmt:formatDate value="${comm.comm_date}" pattern="yyyy-MM-dd"/></td>
    	</tr>
    	<tr>
    		<td class="text-center w3-black">답변 내용</td>
    		<td>${comm.comm_content}</td>
    	</tr>
    </table>
    </c:if>
    </div>
</div>

<%-- <c:if test="${sessionScope.adminId == 'admin'}">
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
</c:if> --%>

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
