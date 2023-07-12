<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
.container {
   width: 35%;
   margin: 100px auto;
   text-align: center;
}
input.valid {
  border: 2px solid green;
}

input.invalid {
  border: 2px solid red;
}

.table-with-shadow {
   box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);
    border-radius: 10px;
    width: 500px;
    height: 600px;
}
.search-input {
   border: none;
   width: 300px;
   height : 30px;'
   padding: 10px 20px;
   border-radius: 10px;
   box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.2);
   outline: none;
   transition: box-shadow 0.3s ease;
}

.search-input:focus {
   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
}
.w3-table td {
  padding: 5px; 
   text-align: left;
}
.w3-table tr {
  margin-bottom: 5px; 
   height: 10px;
}
.user-id-label {
  font-size: 30px;
}
</style>
<meta charset="UTF-8">
<title>볼링매니아 회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	  // 아이디 유효성 검사: 3자 이상 10자 이하
	  $('#user_id').on('input', function() {
	    var input=$(this);
	    var user_id=input.val();
	    if(user_id.length >= 3 && user_id.length <= 10){
	      input.removeClass("invalid").addClass("valid");
	      $('#user_id_error').text("").css('color', 'green');
	    }
	    else{
	      input.removeClass("valid").addClass("invalid");
	      $('#user_id_error').text("3자 이상 10자 이하로 입력하세요.").css('color', 'red');
	    }
	  });
	  
	  $('#user_pass').on('input', function() {
		    var input=$(this);
		    var user_pass=input.val();
		    if(user_pass.length >= 3 && user_pass.length <= 10){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_pass_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_pass_error').text("3자 이상 10자 이하로 입력하세요.").css('color', 'red');
		    }
		  });
	 
	  $('#user_name').on('input', function() {
		    var input=$(this);
		    var user_name=input.val();
		    if(user_name.trim() != ''){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_name_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_name_error').text("이름을 입력해주세요.").css('color', 'red');
		    }
		  });
	  
	  $('#user_age').on('input', function() {
		    var input=$(this);
		    var user_age=input.val();
		    if(user_age >= 10 && user_age <= 100){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_age_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_age_error').text("10 이상 100 이하의 숫자를 입력해주세요.").css('color', 'red');
		    }
		  });
	  
	  $('#user_gender').change(function() {
		    var input=$(this);
		    var user_gender=input.val();
		    if(user_gender.trim() != ''){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_gender_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_gender_error').text("성별을 선택해주세요.").css('color', 'red');
		    }
		  });
	  
	  $('#user_tel').on('input', function() {
		    var input=$(this);
		    var user_tel=input.val();
		    var regex = /^[0-9]+$/;
		    if(user_tel.match(regex)){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_tel_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_tel_error').text("숫자만 입력 가능합니다.").css('color', 'red');
		    }
		  });
	  
	  $('#user_avg').on('input', function() {
		    var input=$(this);
		    var user_avg=input.val();
		    if(user_avg >= 0 && user_avg <= 300){
		      input.removeClass("invalid").addClass("valid");
		      $('#user_avg_error').text("").css('color', 'green');
		    }
		    else{
		      input.removeClass("valid").addClass("invalid");
		      $('#user_avg_error').text("0 이상 300 이하의 숫자를 입력해주세요.").css('color', 'red');
		    }
		  });
});  
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
    if (userId.length < 3 || userId.length > 10) {
        alert('아이디는 3~10자리여야 합니다.');
        return; // 이벤트 핸들러를 더 이상 실행하지 않음
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


$(document).on('keyup', '.mail-check-input', function() {
    const inputCode = $(this).val();
    const warnSpan = $('#mail-check-warn');

    if (inputCode.length === 6) {
        if (inputCode === code) {
            warnSpan.text('인증번호가 일치합니다.').css('color', 'green');
            isCodeValid = true;
            $('#mail-Check-Btn').prop('disabled', true);// 인증번호 유효함을 표시
        } else {
            warnSpan.text('인증번호가 다릅니다.').css('color', 'red');
            isCodeValid = false; // 인증번호 유효하지 않음을 표시
        }
    } else {
        warnSpan.text('');
        isCodeValid = false; // 인증번호 유효하지 않음을 표시
    }
});

$(document).ready(function() {
    $('form').on('submit', function(event) {
    var isFormValid = isValid();

    if (!isFormValid) {
        event.preventDefault();
        alert("정확한 값들을 입력하세요.");
    } else if (!isCodeValid) { // 이메일 인증번호의 유효성 검사
        event.preventDefault();
        alert('인증번호를 정확히 입력하세요.');
    } else {
        // 이메일 주소값을 생성하여 필드에 설정
        const emailValue = $('#user_email').val() + $('#user_email_domain').val();
        $('#user_email').prop('disabled', false).val(emailValue);
    	}
	});
});
	function isValid() {
	  // 사용자 이름, 아이디, 비밀번호, 나이, 성별, 전화번호, 평균 등 각 필드의 유효성 검사
	  var userIdValid = $('#user_id').hasClass('valid');
	  var userPassValid = $('#user_pass').hasClass('valid');
	  var userNameValid = $('#user_name').hasClass('valid');
	  var userAgeValid = $('#user_age').hasClass('valid');
	  var userGenderValid = $('#user_gender').hasClass('valid');
	  var userTelValid = $('#user_tel').hasClass('valid');
	  var userAvgValid = $('#user_avg').hasClass('valid');
	  var emailCodeValid = isCodeValid;
	  var idCheckValid = isIdValid;
	  

	  var isAnyInvalid = $('.invalid').length > 0;
	    
	    // 모든 필드의 유효성 검사 결과를 반환. 'invalid' 클래스가 있는지도 확인.
	    return userIdValid && userPassValid && userNameValid && userAgeValid &&
	           userGenderValid && userTelValid && userAvgValid && emailCodeValid && idCheckValid && !isAnyInvalid;
	}

</script>

</head>
<body>
<div class="container">

	<h2>볼링매니아 회원가입</h2>
		<form:form modelAttribute="user" method="post" action="join">
 			<table class="w3-table table-with-shadow">
   			<tr>
   				<td>아이디</td>
   				<td>
   					<form:input path="user_id" class="search-input"/>
   					<input type="hidden" id="hidden_user_id" name="user_id"/>
   						<button class="btn btn-success" type="button" id="id-Check-Btn">중복검사</button>
   					<span id="user_id_error"></span>
        	</td>
        </tr>
   			<tr>
   				<td>비밀번호</td>
   				<td>
   					<form:password path="user_pass" class="search-input"/>
   					<span id="user_pass_error"></span>
       		</td>
       	</tr>
   			<tr>
   				<td>이름</td>
   				<td>
   					<form:input path="user_name" class="search-input"/>
   					<span id="user_name_error"></span>
        	</td>
        </tr>
   			<tr>
   				<td>나이</td>
   				<td>
   					<form:input path="user_age" class="search-input"/>
   					<span id="user_age_error"></span>
        	</td>
        </tr>        
  			<tr>
  				<td>성별</td>
  				<td>
  					<form:select path="user_gender" class="search-input" >
  						<form:option value="">성별 선택</form:option>
  						<form:option value="남성">남성</form:option>
  						<form:option value="여성">여성</form:option>
  					</form:select>
  					<span id="user_gender_error"></span>
  				</td>
  			</tr>
   			<tr>
   				<td>전화번호</td>
   				<td>
   					<form:input path="user_tel"  class="search-input"/>
   					<span id="user_tel_error"></span>
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
            
            <div class="mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
            </div>
            <div class="input-group-addon">
            	<button class="btn btn-success" type="button" id="mail-Check-Btn">메일인증</button>
            </div>
            <span id="mail-check-warn"></span>
        		</div>
  			  </td>
				</tr>
   			<tr>
   				<td>에버점수</td>
   				<td>
   					<form:input path="user_avg" />
   					<span id="user_avg_error"></span>
        	</td>
        </tr>
   			<tr>
   				<td colspan="2">
   					<input type="submit" value="회원가입" class="btn btn-success">
           			 <input type="reset" value="초기화" class="btn btn-success">
  				</td>
  			</tr>
  		</table>
  	</form:form>
  	</div>
  </body>
</html>