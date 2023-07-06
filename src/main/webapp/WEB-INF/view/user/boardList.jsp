<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<meta charset="UTF-8">
<title>건의사항 내역</title>
<style>
	table {
	  margin: 0px auto;
	  border-collapse: collapse; /* 여백 제거 */
	  width : 100%;
	}

	th{
		background-color : black;
		color : white;
		height :45px;
		text-align : center;
	}	
	td{
		text-align : center;
		padding : 20px;
		border-bottom : 1px solid black;
	}
	.button {
		padding: 5px;
	}
</style>
<script>
$(document).ready(function() {
	  $("#statusFilter").change(function() {
	    var selectedValue = $(this).val(); // 선택된 옵션의 값 가져오기

	    if (selectedValue === "") {
	      // 전체상태일 경우 모든 테이블 데이터 표시
	      $("tr").show();
	    } else {
	      // 선택된 상태와 일치하는 데이터만 표시
	      $("tr").hide(); // 모든 행 숨기기
	      $("tr[data-status='" + selectedValue + "']").show(); // 선택된 상태와 일치하는 행 표시
	      $("tr:first-child").show(); // 첫 번째 행 표시
	    }
	  });
	});
</script>
</head>
<body>
<div class="container" style="margin-top:55px;">
	<div style="display : flex; justify-content : space-between;">
		<div style="flex-basis : 20%;">
		   <%@ include file="mypageSideBar2.jsp" %>
		</div>
		<div style="flex-basis : 80%;">
			<h2>건의 내역</h2>
			<div>
				<select class="w3-right" style="margin : 10px;" id="statusFilter">
					<option value="">전체상태</option>
					<option value="1">답변</option>
					<option value="0">미답변</option>
				</select>
			</div>
			<table>
				<tr>
					<th style="width:10%">번호</th>
					<th style="width:40%">제목</th>
					<th style="width:20%">날짜</th>
					<th style="width:20%">비고</th>
				</tr>
				<c:forEach items="${board}" var="board">
				<tr data-status="${board.board_anser}">
					<td>${board.board_num}</td>
					<td>${board.board_title}
						<c:if test="${board.board_anser == 1}">
							<span class="w3-badge w3-green">답변</span>
						</c:if>
						<c:if test="${board.board_anser == 0}">
							<span class="w3-badge w3-red">미답변</span>
						</c:if>
					</td>
					<td><fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd" /></td>
					<td><button type="button" class="w3-button w3-black" onclick="detailDelete('${board.board_num}')">삭제</button></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
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
            data: { board_num: board_num},
            success: function(response) {
                if (response.success) {
                    alert("게시글이 삭제되었습니다.");
                    // 삭제 후 필요한 동작 수행 (예: 페이지 리로드)
                    location.reload();
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