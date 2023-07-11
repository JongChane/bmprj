<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매치 리스트</title>
 <script>
        function listpage(page) {
            document.searchform.pageNum.value = page;
            document.searchform.submit();
        }
    </script>
<style>
	.table-container{
		margin : 0 auto;
		margin-top : 50px;
	}
	.w3-table {
	width: 60%;
	margin : 0 auto;
}

.w3-table td {
  padding: 5px; 
   text-align: center;
}
.w3-table tr {
  margin-bottom: 5px; 
}

</style>
</head>
<body>
<h1 style="text-align: center;">매치 목록</h1>
<div class="container mt-5" >

<form action="gamelist" method="post" name="searchform">
	<div class="text-end" style="margin-left: 30%; margin-right: 15%;">
		<table class="table">
		  	 <tr>
		         <td style="border-bottom: none">
		            <input type="hidden" name="pageNum" value="1">
		            <input type="hidden" name="game_num" value="${param.game_num}">
		            
		            <select name="searchtype" class="form-select" style="height:40px;">
		               <option value="">선택하세요</option>
		               <option value="game_title">제목</option>
		               <option value="user_id">작성자</option>
		               <option value="game_content">내용</option>
		               <option value="game_gender">성별</option>
		               <option value="game_avg">에버리지</option>
		               <option value="game_age">나이제한</option>
		            </select>
		            <script>
		               searchform.searchtype.value="${param.searchtype}";
		            </script>
		         </td>
		         <td colspan="3" style="border-bottom: none">
		            <input type="text" class="form-control" style="height:40px;" name="searchcontent" value="${param.searchcontent}">
		         </td>
		         <td>
		         	<button style="width:100px;" type="submit" class="btn btn-success">검색</button>
		         </td>
		  	 </tr>
		</table>
	</div>
<div class="mx-auto mt-3" style="width: 70%;">	
<c:forEach items="${gamepage}" var="game">
<table class="table">
<tr>
	<td>
		제목 : ${game.game_title}
	</td>
	<td>
		작성자 : ${game.user_id}
	</td>
</tr>
<tr>
	<td>
		경기인원 : ${game.game_max}
	</td>
	<td>
		성별 :
	${game.game_gender }
	</td>
</tr>

<tr>
	<td>
		평균에버리지 : ${game.game_avg}
	</td>
	<td>
		나이제한 : ${game.game_age} 대
	</td>
</tr>
<tr >
	<td>
		경기날짜 : 
		<fmt:formatDate value="${game.game_date}" pattern="yyyy년MM월dd일"/>
	</td>
	<td>
	</td>
</tr>
<tr >
	<td class="table-success" colspan="2" style="text-align: center;">
		
		<a style="font-size : 5px; " href="../game/gameinfo?game_num=${game.game_num}">
			<button type="button" class="btn btn-success">상세보기</button>
		</a>
		
	</td>
</tr>
</table>
</c:forEach>
</div>
   <div style="margin : 0px auto; width:200px;">
   <c:if test="${pageNum > 1 }">
      <a href="javascript:listpage('${pageNum - 1 }')"><button type="button" class="btn btn-success">이전</button></a>
   </c:if>
   <c:if test="${pageNum <= 1}"><button type="button" class="btn btn-outline-success">이전</button></c:if>
   
   <c:forEach var="a" begin="${startpage}" end="${endpage}">
      <c:if test="${a == pageNum}"><button type="button" class="btn btn-success">${a}</button></c:if>
      <c:if test="${a != pageNum}">
         <a href="javascript:listpage('${a}')"><button type="button" class="btn btn-outline-success">${a}</button></a>
      </c:if>
   </c:forEach>

   <c:if test="${pageNum < maxpage}">
      <a href="javascript:listpage('${pageNum + 1}')"><button type="button" class="btn btn-success">다음</button></a>
   </c:if>   
   <c:if test="${pageNum >= maxpage}"><button type="button" class="btn btn-outline-success">다음</button></c:if>
	</div>
   <%-- 등록된 게시물이 없는 경우 --%>
 <c:if test="${listCount <= 0 }">
   <div>
      <span>등록된 게시물이 없습니다.</span>
   </div>
</c:if>

</form>
<div>
<button type="button" class="btn btn-success" onclick="location.href='write'">매치등록하기</button>
</div>
</div>
</body>
</html>