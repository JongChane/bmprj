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
		background-color : green;
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
	a {
	  text-decoration: none;
	}
</style>
<script>
function openModal(board_num){
	document.getElementById('id01').style.display='block';
	$.ajax({
		url : "${path}/admin/detail?board_num="+board_num,
		method: "GET",
		success: function(data) {
			  console.log(data);
			  $("#comment").html(data);
		}
	})
}

function listpage(page, board_anser){
	window.location.href = "${path}/user/boardList?pageNum="+page+"&board_anser="+board_anser;
}

</script>
</head>
<body>
<div class="container" style="margin-top:100px;">
	<div style="display : flex; justify-content : space-between;">
		<div style="flex-basis : 20%;">
		   <%@ include file="mypageSideBar2.jsp" %>
		</div>
		<div style="flex-basis : 80%;">
			<h2>건의 내역</h2>
			<div style="margin-bottom : 10px;">
				<a href="boardList" class="btn  ${board_anser eq null? 'btn-success' : '' }">전체</a>
				<a href="boardList?board_anser=0" class="btn  ${board_anser eq 0? 'btn-success' : '' }">답변대기</a>
				<a href="boardList?board_anser=1" class="btn  ${board_anser eq 1? 'btn-success' : '' }">답변완료</a>
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
					<td><a href="javascript:void(0)" onclick="openModal(${board.board_num})">
							${board.board_title}
							</a>
						<c:if test="${board.board_anser == 1}">
							<span class="w3-badge w3-green">답변</span>
						</c:if>
						<c:if test="${board.board_anser == 0}">
							<span class="w3-badge w3-red">미답변</span>
						</c:if>
					</td>
					<td><fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd" /></td>
					<td><button type="button" class="btn btn-success " onclick="detailDelete('${board.board_num}')">삭제</button></td>
				</tr>
				</c:forEach>
			</table>
			
			<div style="margin : 10px auto; width:200px;">
			<c:if test="${pageNum > 1 }">
			  <a href="javascript:listpage('${pageNum - 1 }', '${board_anser}')">[이전]</a>
			</c:if>
			<c:if test="${pageNum <= 1}">[이전]</c:if>
			
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
			  <c:if test="${a == pageNum}">[${a}]</c:if>
			  <c:if test="${a != pageNum}">
			     <a href="javascript:listpage('${a}', '${board_anser}')">[${a}]</a>
			  </c:if>
			</c:forEach>
			
			<c:if test="${pageNum < maxpage}">
			  <a href="javascript:listpage('${pageNum + 1}', '${board_anser}')">[다음]</a>
			</c:if>   
			<c:if test="${pageNum >= maxpage}">[다음]</c:if>
			</div>
			
			
		</div>
	</div>
</div>


	<div id="id01" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom  w3-black">
			<div class="w3-center"> <br>
				<h3>건의사항 상세</h3><span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
			</div>
				<div class="w3-white" id="comment"></div>
			<br>
			<h4 class="text-center"><img src="${path }/image/bm.png" width="50px"/> &nbsp;&nbsp;&nbsp;볼매 관리자</h4>
			<br>
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