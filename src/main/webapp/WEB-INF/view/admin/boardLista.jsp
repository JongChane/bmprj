<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<meta charset="UTF-8">
<title>관리자 건의사항</title>
<style>
	a {
	  text-decoration: none;
	}
/* 	th {
		padding : 0px;
		height : 40px;
	}
	
	table {
		margin : 0px auto;
		border-collapse : collapse;
	}
	td {
		border-bottom: 1px solid black;
		height : 70px;
	}
	.container {
		margin : 0px 50px 50px 50px;
		boarder : 1px solid black;
	}  */
	.searchtype {
		width : 10%;
	}
	ul {
		display : inline-flex;
	}
	.button {
		padding: 5px;
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
	
	$(document).ready(function(){
	    $("#all").click(function(){
	        window.location.href = "${path}/admin/boardList";
	    });
	    
	    $("#a").click(function(){
	        window.location.href = "${path}/admin/boardLista";
	    });

	    $("#b").click(function(){
	        window.location.href = "${path}/admin/boardListb";
	    });
	});
</script>
</head>
<body>
	<div>
		<h2 class="mt-5">건의사항 목록</h2>
		<div class="btn-group mb-3" role="group" aria-label="Basic outlined example">
		  <button type="button" class="btn btn-outline-dark active" id="all">전체</button>
		  <button type="button" class="btn btn-outline-dark" id="a">답변대기</button>
		  <button type="button" class="btn btn-outline-dark" id="b">답변완료</button>
		</div>
		<div class="container">
			<table class="w3-center table table-hover" >
				<tr class="w3-black">
					<th style="width:10%">번호</th>
					<th style="width:30%">제목</th>
					<th style="width:20%">날짜</th>
					<th style="width:20%">작성자</th>
				</tr>
				<c:forEach items="${boardList}" var="boardList">
					<tr>
						<td>${boardList.board_num}</td>
						<td>
							<a href="javascript:void(0)" onclick="openModal(${boardList.board_num})">
							${boardList.board_title}
							</a>	
								<c:if test="${boardList.board_anser == 0}">
								<span class="w3-badge w3-red">미답변</span>
								</c:if>
						</td>
						<td><fmt:formatDate value="${boardList.board_date}" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.user_id}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div id="id01" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
			<div class="w3-center"> <br>
				<span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
			</div>
				<div id="comment"></div>
		</div>
	</div>
</body>





</html>