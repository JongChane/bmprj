<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<script type="text/javascript">
function openDetail(idx) {
	  var detail = $("#notice" + idx);
	  var isHidden = detail.is(":hidden");
	  $(".detail").hide();
	  if (isHidden) {
	    detail.show();
	  }
	}
</script>
</head>
<body>
	<div>
		<h2 class="mt-5">공지사항 목록</h2>
	</div>
	<div class="container">
		<c:if test="${listCount > 0 }">
			<h5>글 개수 : ${listCount}</h5>
	    </c:if>
		<table class="w3-center table table-hover align-middle">
			<tr class="w3-green">
				<th style="width:10%">번호</th>
				<th style="width:30%">제목</th>
				<th style="width:20%">작성자</th>
				<th style="width:20%">날짜</th>
			</tr>
			<c:forEach items="${noticeList}" var="noticeList" varStatus="st">
				<tr>
					<td>${noticeList.notice_num}</td>
					<td><a href="javascript:openDetail('${st.index}')">${noticeList.notice_title}</a></td>
					<td><span>볼매관리자</span></td>
					<td><fmt:formatDate value="${noticeList.notice_regdate}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr class="detail" id="notice${st.index }" style="display: none;">
					<td>내용</td>
					<td colspan="3">
						<div class="container w3-white text-start mb-3" style="border:1px solid rgba(0,0,0,0.1); min-height: 100px;">${noticeList.notice_content}</div>
					</td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
	
			<div style="margin : 10px auto; width:200px;">
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
	<script>
		function listpage(page){
			window.location.href = "${path}/admin/noticeList?pageNum="+page;
		}
	</script>
</body>
</html>