<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 회원가입</title>
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
var code;
var isCodeValid = false; // 인증번호 유효성 검사를 위한 변수 추가
var isIdValid = false;
$(document).on('click', '#id-Check-Btn', function() {
    const userId = $('#user_id').val(); // 아이디 입력값 가져오기

    // 아이디 입력칸이 비어있는지 확인
    if (userId.trim() === '') {
        alert('아이디를 입력해주세요.');
        return;
    }

    $.ajax({
        type: 'get',
        url: '<c:url value="/user/idCheck?userId="/>' + userId,
        success: function (data) {
            if (data === "duplicated") {
                alert('이미 사용 중인 아이디입니다.')
                isIdValid = false; // 아이디 유효성 검사 실패
            } else {
                alert('사용 가능한 아이디입니다.');
                isIdValid = true; // 아이디 유효성 검사 통과
                $('#user_id').prop('disabled', true);
                $('#hidden_user_id').val(userId);
            }
        }            
    });
});

$(document).on('click', '#mail-Check-Btn', function() {
    if (!isIdValid) {
        alert('아이디 중복검사를 먼저 진행해주세요.');
        return;
    }
    const email = $('#user_email').val(); // 입력칸의 이메일 값만 가져오기
    const emailDomain = $('#user_email_domain').val(); // 셀렉트 옵션 태그의 선택값 가져오기
    const checkInput = $('.mail-check-input');
    
    // 이메일 입력칸이 비어있는지 확인
    if (email.trim() === '') {
        alert('이메일을 입력해주세요.');
        return;
    }
    
    const fullEmail = email + emailDomain; // 이메일과 도메인을 합쳐 전체 이메일 주소 생성
    // 이메일 값을 hidden 필드에 저장
    $('#hidden_user_email').val(fullEmail);
    $.ajax({
        type: 'get',
        url: '<c:url value="/user/mailCheck?email="/>' + fullEmail,
        success: function (data) {
        	if (data === "duplicated") {
        		alert('이미 가입된 이메일입니다.')
        	} else {
            checkInput.attr('disabled', false);
            code = data;
            isCodeValid = true; // 인증번호 유효함을 표시
            alert('인증번호가 전송되었습니다.');
            
            $('#user_email').prop('disabled', true);
            $('#user_email_domain').prop('disabled', true);
        	}
        }            
    });
});

$('form').on('submit', function(event) {
    if (!isCodeValid) { // 인증번호 유효하지 않으면 회원가입 버튼 동작 막기
        event.preventDefault();
        alert('인증번호를 정확히 입력하세요.');
    } else {
        // 이메일 주소값을 생성하여 필드에 설정
        const emailValue = $('#user_email').val() + $('#user_email_domain').val();
        $('#user_email').prop('disabled', false).val(emailValue);
    }
});

$(document).on('keyup', '.mail-check-input', function() {
    const inputCode = $(this).val();
    const warnSpan = $('#mail-check-warn');

    if (inputCode.length === 6) {
        if (inputCode === code) {
            warnSpan.text('인증번호가 일치합니다.').css('color', 'green');
            isCodeValid = true; // 인증번호 유효함을 표시
        } else {
            warnSpan.text('인증번호가 다릅니다.').css('color', 'red');
            isCodeValid = false; // 인증번호 유효하지 않음을 표시
        }
    } else {
        warnSpan.text('');
        isCodeValid = false; // 인증번호 유효하지 않음을 표시
    }
});
</script>
<style>
.container {
   width: 35%;
   margin: 200px auto;
   text-align: center;
}
</style>
</head>
<body>
	<h2>볼링매니아 회원가입</h2>
		<form:form modelAttribute="user" method="post" action="join">
 			<spring:hasBindErrors name="user">
    	<font color="red">
<%-- ${errors.globalErrors} : controller에서 bresult.reject(코드값)메서드로
                              추가한 error 코드 값들
 --%>      
    		<c:forEach items="${errors.globalErrors}" var="error">
<%--
    <spring:message code="${error.code}" /> : 코드값에 해당하는 메세지를 출력
				                                    현재 messages.properties 파일에 설정
    ${error.code} : reject(코드값)으로 등록한 코드값
 --%>      
        	<spring:message code="${error.code}" /><br>
      	</c:forEach>
    	</font>
 			</spring:hasBindErrors>
 			<h1>회원가입</h1>
 			<table>
   			<tr>
   				<td>아이디</td>
   				<td>
   					<form:input path="user_id"/>
   					<input type="hidden" id="hidden_user_id" name="user_id"/>
   					<button class="w3-button w3-white w3-border" type="button" id="id-Check-Btn">중복검사</button>
        		<font color="red">
        			<form:errors path="user_id"/>
        		</font>
        	</td>
        </tr>
   			<tr>
   				<td>비밀번호</td>
   				<td>
   					<form:password path="user_pass" />
       			<font color="red">
       				<form:errors path="user_pass" />
       			</font>
       		</td>
       	</tr>
   			<tr>
   				<td>이름</td>
   				<td>
   					<form:input path="user_name" />
        		<font color="red">
        			<form:errors path="user_name" />
        		</font>
        	</td>
        </tr>
   			<tr>
   				<td>나이</td>
   				<td>
   					<form:input path="user_age" />
        		<font color="red">
        			<form:errors path="user_age" />
        		</font>
        	</td>
        </tr>        
  			<tr>
  				<td>성별</td>
  				<td>
  					<form:select path="user_gender">
  						<form:option value="">성별 선택</form:option>
  						<form:option value="남성">남성</form:option>
  						<form:option value="여성">여성</form:option>
  					</form:select>
  					<font color="red">
        			<form:errors path="user_gender" />
        		</font>
  				</td>
  			</tr>
   			<tr>
   				<td>전화번호</td>
   				<td>
   					<form:input path="user_tel" />
   					<font color="red">
        			<form:errors path="user_tel" />
        		</font>
   				</td>
   			</tr>
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
            <button class="w3-button w3-white w3-border" type="button" id="mail-Check-Btn">메일인증</button>
            </div>
            <div class="mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
            </div>
            <span id="mail-check-warn"></span>
                <input type="hidden" class="form-control" name="user_email" id="hidden_user_email">
        		</div>
  			  </td>
				</tr>
   			<tr>
   				<td>에버점수</td>
   				<td>
   					<form:input path="user_avg" />
        		<font color="red">
        			<form:errors path="user_avg" />
        		</font>
        	</td>
        </tr>
   			<tr>
   				<td>
   					<input type="submit" value="회원가입">
            <input type="reset" value="초기화">
  				</td>
  			</tr>
  		</table>
  	</form:form>
  </body>
</html>