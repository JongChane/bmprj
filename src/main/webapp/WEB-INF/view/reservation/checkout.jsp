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
<title>예약 확정 페이지</title>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript">
		let IMP = window.IMP
	  let user_id = '<%= session.getAttribute("login") %>';
		IMP.init("imp85850271") //가맹점 식별코드
	  
	  function kakaopay() {
		   $.ajax("kakao",{
			   success : function(json) {
				   iamPay(json)
			   }
		   })
	   }
	   function iamPay(json) {
		   IMP.request_pay({
			   pg : "kakaopay",     //상점구분. 카카오페이
			   pay_method : "card", //카드 결제
			   merchant_uid : json.merchant_uid,  //주문번호:주문별로 유일한값이 필요. userid-session id 값
			   name : json.name,    //주문상품명. 사과외3건     
			   amount : json.amount,//전체주문금액
			   buyer_email : "",   //주문자이메일. 테스트. 
			   buyer_name : json.buyer_name,    //주문자성명
			   buyer_tel : "",      //주문자전화번호
			   buyer_addr : "",    //주문자 주소
			   buyer_postcode : ""  //주문자 우편번호
		   },function(rsp){
			   if (rsp.success) {
				   let msg = "결제가 완료 되었습니다."
				   msg += "\n:고유ID : " + rsp.imp_uid
				   msg += "\n:상점ID : " + rsp.merchant_uid
				   msg += "\n:결제금액 : " + rsp.paid_amount
				   alert(msg)
				   
				   $.ajax({
				        url: "reservation",
				        type: "POST",
				        contentType: "application/json",
				        data: JSON.stringify({
				            success: true
				        }),
				        success: function(data) {
				           window.location.href = "../user/reserveList?user_id=" + user_id;
				           
				        },
				        error: function(jqXHR, textStatus, errorThrown) {
				            console.error('Error:', textStatus, errorThrown);
				        }
				    });
			   } else {
				   alert("결제에 실패 했습니다.:" + rsp.error_msg)
			   }
		   })
	   }
	</script>
</head>
<body>
	<div style="margin-top: 70px">
	<h1>예약확정</h1>
	</div>
	<div>
	<table class="w3-table-all">
		<tr>
			<th>예약자 아이디</th>
			<th>방문날짜</th>
			<th>방문시간</th>
			<th>게임수</th>
			<th>인원수</th>
			<th>레인번호</th>
			<th>결제가격</th>
		</tr>
		<c:forEach items="${reserveList}" var="reserve">
		<tr>
			<td>${reserve.user_id}</td>
			<td><fmt:formatDate value="${reserve.rv_date}" pattern="yyyy년 MM월 dd일"/></td>
			<td>
				<tf:formatDateTime value="${reserve.rv_start}" pattern="HH:mm"/> ~ <tf:formatDateTime value="${reserve.rv_end}" pattern="HH:mm"/>
			</td>
  		<td>${reserve.rv_game}</td>
  		<td>${reserve.rv_people}</td>
			<td>${reserve.lane_num}</td>
			<td><fmt:formatNumber value="${reserve.rv_price}" pattern="#,###" />원</td>		
		</tr>
		</c:forEach>
	</table>
	</div>
	<div>
	<a href="javascript:kakaopay()"><button>결제하기</button></a>
	<button onclick="history.back()">예약수정</button>
	</div>
</body>
</html>