<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소셜매치 내역</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("#minfo").show()
		$("#oinfo").hide()
		$(".gLine").each(function(){
			$(this).hide()
		})
	})
	
	function list_disp(id){
		$("#"+id).toggle()
	}
</script>
</head>
<body>
<div class="container" style="magin-top:55px;">
	<div id="minfo" class="minfo" style="display : flex; justify-content : space-between;">
	  	<div style="flex-basis : 20%;">
			<h2>소셜매치 내역</h2>
 			<%@ include file="mypageSideBar2.jsp" %>
		</div>
		<div style="flex-basis : 80%; margin-top:100px;">
	<table class="w3-table-all" style="text-align:center;">
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>내용</th>
			<th>매칭날짜</th>
			<th>신청인원</th>
			<th></th>
		</tr>
			<c:forEach var="g" items="${gmuser}" varStatus="stat">
		<tr>
			<td>${g.key.game_title}</td>
			<td>${g.key.user_id}</td>
			<td>${g.key.game_content}</td>
			<td>
				<fmt:formatDate value="${g.key.game_date}" pattern="yyyy년MM월dd일"/>
			</td>
				<td>
				<a href="javascript:list_disp('gLine${stat.index}')">
					${g.key.game_max}/${g.key.game_people}
				</a>
				</td>
			<td>
					<c:if test="${param.user_id == g.key.user_id}">				
						<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
	  						삭제
						</button>					
					
					<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">볼링매니아</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        정말 나가시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
	        <a href="mpdelete?gmnum=${g.key.game_num}" ><button type="button" class="btn btn-succe	ss">나가기</button></a>
	      </div>
	    </div>
	  </div>
	</div>
				</c:if>
			</td>
		</tr>
		<tr  id="gLine${stat.index}" class="gLine">
		<td colspan="6">
		<table class="w3-table-all">
			<tr >
				<th>참가자 아이디</th>
				<th>참가자 성별</th>
				<th>참가자 나이</th>
				<th>참가자 에버리지</th>
				<th></th>
			</tr>
			<c:forEach var="gm" items="${g.value}">
				<tr>
					<td>${gm.user_id}</td>
					<td>${gm.user_gender}</td>
					<td>${gm.user_age}</td>
					<td>${gm.user_avg}</td>
					<td>
						<c:if test="${param.user_id == gm.user_id}">
						<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal2">
  						매치 나가기
					</button>
							<!-- Modal 2 -->
    <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">볼링매니아</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    정말 나가시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
                    <a href="mpudelete?gmnum=${g.key.game_num}&user_id=${sessionScope.loginUser.user_id}"><button type="button" class="btn btn-success">매치 나가기</button></a>
                </div>
            </div>
        </div>
    </div>
						</c:if>
						
					</td>
				</tr>
			</c:forEach>
		</table>
		</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</div>
	</div>
</body>
</html>