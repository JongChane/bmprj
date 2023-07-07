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
	
	function listpage(page) {
		window.location.href = "${path}/admin/boardListb?type=b&pageNum="+page;
	}
	
	
	$(document).ready(function(){
	    $("#all").click(function(){
	        window.location.href = "${path}/admin/boardList?type=all";
	    });
	    
	    $("#a").click(function(){
	        window.location.href = "${path}/admin/boardLista?type=a";
	    });

	    $("#b").click(function(){
	        window.location.href = "${path}/admin/boardListb?type=b";
	    });
	});
</script>
</head>
<body>
	<div>
		<h2 class="mt-5">건의사항 목록</h2>
		<div class="btn-group mb-3" role="group" aria-label="Basic outlined example">
		  <button type="button" class="btn btn-outline-dark ${type eq 'all' ? 'active' : '' }" id="all">전체</button>
		  <button type="button" class="btn btn-outline-dark ${type eq 'a' ? 'active' : '' }" id="a">답변대기</button>
		  <button type="button" class="btn btn-outline-dark ${type eq 'b' ? 'active' : '' }" id="b">답변완료</button>
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
								<c:if test="${boardList.board_anser == 1}">
								<span class="w3-badge w3-green">답변</span>
								</c:if>
						</td>
						<td><fmt:formatDate value="${boardList.board_date}" pattern="yyyy-MM-dd"/></td>
						<td>${boardList.user_id}</td>
					</tr>
				</c:forEach>
			</table>
			
			<div style="margin : 10px auto; width:150px;">
				<c:if test="${pageNum > 1 }">
					<a href="javascript:listpage('${pageNum - 1 }')">[이전]</a>
				</c:if>
				<c:if test="${pageNum <= 1}">[이전]</c:if>
			
				<c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a == pageNum}">[${a}]</c:if>
					<c:if test="${a != pageNum}">
						<a href="javascript:listpage('${a}')">[${a}]</a>
					</c:if>
				</c:forEach>
			
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:listpage('${pageNum + 1}')">[다음]</a>
				</c:if>   
				<c:if test="${pageNum >= maxpage}">[다음]</c:if>
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
</body>





</html>