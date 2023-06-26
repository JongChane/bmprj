<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 아이디 찾기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
var code;
var isCodeValid = true; // 인증번호 유효성 검사를 위한 변수, 초기값을 true로 설정

$(document).on('click', '#mail-Check-Btn', function() {
    const email = $('#user_email').val(); // 입력칸의 이메일 값만 가져오기
    const emailDomain = $('#user_email_domain').val(); // 셀렉트 옵션 태그의 선택값 가져오기
    const checkInput = $('.mail-check-input');
    
    // 이메일 입력칸이 비어있는지 확인
    if (email.trim() === '') {
        alert('이메일을 입력해주세요.');
        return;
    }
    
    const fullEmail = email + emailDomain; // 이메일과 도메인을 합쳐 전체 이메일 주소 생성

    $.ajax({
        type: 'get',
        url: '<c:url value="/user/idMailCheck?email="/>' + fullEmail,
        success: function (data) {
            checkInput.attr('disabled', false);
            code = data;
            isCodeValid = true; // 인증번호 유효함을 표시
            alert('인증번호가 전송되었습니다.');
        }            
    });
});

$(document).on('click', 'input[type="submit"]', function(event) {
    if (!isCodeValid) { // 인증번호 유효하지 않으면 회원가입 버튼 동작 막기
        event.preventDefault();
        alert('인증번호를 정확히 입력하세요.');
    } else {
        // 이메일 주소값을 생성하여 필드에 설정
        const emailValue = $('#user_email').val() + $('#user_email_domain').val();
        $('#user_email').val(emailValue);
    }
});
</script>
</head>
<body>
	<h3>아이디찾기</h3>
	<form:form  modelAttribute="user" action="idsearch" method="post">
  	<spring:hasBindErrors name="user">
    	<font color="red">
    		<c:forEach items="${errors.globalErrors}" var="error">
    			<spring:message code="${error.code}" />
      	</c:forEach>
    	</font>
    </spring:hasBindErrors>
		<table class="w3-table">
			<tr>
    		<td>이메일</td>
   				<td>
     		   <div class="form-group email-form">
            <div class="input-group">
                <input type="text" class="form-control" name="user_email" id="user_email" placeholder="이메일">
                <select class="form-control" name="user_email_domain" id="user_email_domain">
                    <option value="@naver.com">@naver.com</option>
                    <option value="@daum.net">@daum.net</option>
                    <option value="@gmail.com">@gmail.com</option>
                    <option value="@hanmail.com">@hanmail.com</option>
                </select>
            </div>
            <div class="input-group-addon">
                <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
            </div>
            <div class="mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
            </div>
            <span id="mail-check-warn"></span>
        		</div>
  			  </td>
			</tr>
  		<tr>
		  	<td colspan="2" class="w3-center">
 				<input type="submit" value="아이디찾기" class="w3-btn w3-blue">
 				</td>
 			</tr>
 			</table>
	</form:form>
</body>
</html>