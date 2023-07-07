<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
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
.delete-btns button{
	cursor: pointer;
}
</style>
</head>
<body>

<%
    String path = request.getContextPath();
    pageContext.setAttribute("path", path);
%>
<div class="container" style="margin-top:100px; width:50%;">
	<div class="w3-container" style="box-shadow: 4px 4px 4px rgb(0,0,0,0.3); padding:10px; border : 0.5px solid rgba(0,0,0,0.1);">
	<h2 class="text-center mb-5">건의사항</h2>
    <table class="table table-bordered align-middle">
    	<tr>
    		<td class="text-center w3-green" style="width:25%;">등록일</td>
    		<td colspan="2">
    			<fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/>
    		</td>
    	</tr>
        <tr>
            <td class="text-center w3-green">작성자</td>
            <td colspan="2">${board.user_id}</td>
        </tr>
        <tr>
            <td class="text-center w3-green">제목</td>
            <td>${board.board_title}</td>
        </tr>
        <tr>
            <td class="text-center w3-green">건의사항</td>
            <td>${board.board_content}</td>
        </tr>
<%-- 		<c:if test="${not empty comm.comm_date}">
		    <tr>
		        <td class="text-center mt-3 mb-5">답변일</td>
		        <td><fmt:formatDate value="${comm.comm_date}" pattern="yyyy-MM-dd" /></td>
		    </tr>
		    <tr>
		        <td class="text-center mt-3 mb-5">답변</td>
		        <td>${comm.comm_content}</td>
		    </tr>
		</c:if> --%>
    </table>
    
    <hr>
    
    <h2 class="text-center mt-3 mb-5">답변</h2>
    <c:if test="${empty comm.comm_date}">
    	<h4 class="text-center">답변 대기중 입니다.</h4>
    </c:if>
    <c:if test="${not empty comm.comm_date}">
    <table class="table table-bordered  align-middle">
    	<tr>
    		<td class="text-center w3-green" style="width:25%;">답변자</td>
    		<td>볼매관리자</td>
    	</tr>
    	<tr>
    		<td class="text-center w3-green">답변일</td>
    		<td><fmt:formatDate value="${comm.comm_date}" pattern="yyyy-MM-dd"/></td>
    	</tr>
    	<tr>
    		<td class="text-center w3-green">답변 내용</td>
    		<td>${comm.comm_content}</td>
    	</tr>
    </table>
    </c:if>
    <div class="text-center mt-3">
    	<a class="w3-button w3-black" href="list">목록</a>
    </div>
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

</body>
</html>