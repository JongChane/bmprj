<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript">
<%
String path = request.getContextPath();
pageContext.setAttribute("path", path);
%>
function formatDate(dateString) {
	  const date = new Date(dateString);
	  const year = date.getFullYear();
	  const month = String(date.getMonth() + 1).padStart(2, '0');
	  const day = String(date.getDate()).padStart(2, '0');
	  
	  return year+"-"+month+"-"+day;
}
	
	
	function openModal(num){
		  document.getElementById('id01').style.display='block';
		  // ajax
		  $.ajax({
		    url: "${path}/board/detailJson?board_num=" + num,
		    success: function(data) {
		      console.log(data);
		      let html = "";
		      html += "<div> <table>";
		      html += "<tr> <td>등록일</td>";
		      html += "<td>" + formatDate(data.board_date) + "</td>";
		      html += "</tr> <tr> <td>제목</td>";
		      html += "<td>" + data.board_title + "</td>";
		      html += "</tr> <tr> <td>내용</td>";
		      html += "<td>" + data.board_content + "</td>";
		      html += "</tr> </table> </div>";
		      html += "<form class='w3-container' action='comment' method='post'>";
		      html += "<input type='hidden' id='num' name='"+ num +"' value='" + num + "'>";
		      html += "<div class='w3-section'>";
		      html += "<table>";
		      html += "<tr>";
		      html += "<td>답변내용</td>";
		      html += "<td><textarea rows='5' name='comm_content'></textarea></td>";
		      html += "</tr>";
		      html += "</table>";
		      html += "<button class='w3-button w3-green' type='submit'>답변하기</button>";
		      html += "<button onclick='document.getElementById(\"id01\").style.display=\"none\"' type='button' class='w3-button w3-red'>뒤로가기</button>";
		      html += "</div>";
		      html += "</form>";		      
		      
		      $("#detail").html(html);
		    }
		  });
		  
		  $("#num").val(num);
		}
</script>
</head>
<body>
<div id="boardlist">
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>작성자</th>
			<th>상태</th>
		</tr>
	<c:forEach items="${boardList}" var="list" varStatus="stat">
			<tr>
				<td>${list.board_num}</td>
				<td>${list.board_title}</td>
				<td>
					<fmt:formatDate value="${list.board_date}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${list.user_id}</td>
				<td>
		            <div>
		            	<button onclick="openModal('${list.board_num}')" class="w3-button w3-green w3-small">답변하기</button>
		            </div>
		        </td>    
			</tr>
	</c:forEach>
	</table>		
</div>


<div class="w3-container">

  <div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">

      <div class="w3-center"><br>
        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
      </div>
	
		
	<%--   <div>
	  	<c:forEach items="${boardList}" var="list">
	  	<table>
	  		<tr>
	  			<td>등록일</td>
	  			<td><fmt:formatDate value="${list.board_date}" pattern="yyyy-MM-dd"/></td>
	  		</tr>
	  		<tr>
	  			<td>제목</td>
	  			<td>${list.board_title}</td>
	  		</tr>
	  		<tr>
	  			<td>내용</td>
	  			<td>${list.board_content}</td>
	  		</tr>
	  	</table>
	  	</c:forEach>
	  </div> --%>
	  <div id="detail"></div>
	  
 <!--      <form class="w3-container" action="comment" method="post">
      	<input type="hidden" id="num" name="" value="">
        <div class="w3-section">
        	<table>
        		<tr>
        			<td>답변내용</td>
        			<td><textarea rows="5" name="comm_content"></textarea></td>
        		</tr>
        	</table>
        	<button class="w3-button w3-green" type="submit">답변하기</button>
	        <button onclick="document.getElementById('id01').style.display='none'" type="button" class="w3-button w3-red">뒤로가기</button>
        </div>
      </form> -->
    </div>
  </div>
</div>
            
</body>
</html>
