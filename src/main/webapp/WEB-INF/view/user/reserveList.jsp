<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	a {
	  text-decoration: none;
	}
</style>
<script type="text/javascript">
function listpage(page){
	window.location.href = "${path}/user/reserveList?pageNum="+page;
}

</script>
</head>
<body>
<div class="container" style="margin-top : 100px;">
   <div style="display : flex; justify-content : space-between;">   
      <div style="flex-basis : 20%;">
         <%@ include file="mypageSideBar2.jsp" %>
      </div>
      <div style="flex-basis : 80%;">
      	<h2>예약내역</h2>
      	<div style="margin-bottom : 10px;">
      	</div>
      	<table>
      		<tr>
      			<th style="width:20%">예약시간</th>
      			<th style="width:20%">방문날짜</th>
      			<th style="width:20%">방문시간</th>
      			<th style="width:6%">게임수</th>
	      		<th style="width:6%">인원수</th>
      			<th style="width:6%">레인</th>
      			<th style="width:6%">에버</th>
      			<th style="width:20%">결제가격</th>
      		</tr>
      		<c:forEach items="${reserve}" var="reserve">
      		<tr>
						<td><fmt:formatDate value="${reserve.rv_now}" pattern="yyyy-MM-dd HH:mm"/></td>
      			<td><fmt:formatDate value="${reserve.rv_date}" pattern="yyyy-MM-dd"/></td>
      			<td>
							<tf:formatDateTime value="${reserve.rv_start}" pattern="HH:mm"/> ~ <tf:formatDateTime value="${reserve.rv_end}" pattern="HH:mm"/>
						</td>
						<td>${reserve.rv_game}</td>
  					<td>${reserve.rv_people}</td>
						<td>${reserve.lane_num}</td>
						<td>${reserve.vi_avg}</td>
						<td><fmt:formatNumber value="${reserve.rv_price}" pattern="#,###" />원</td>						
      		</c:forEach>
      	</table>
      	
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
      </div>
   </div>   
</div>   
</body>
</html>