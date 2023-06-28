<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>볼링매니아 게임결과</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#memberCount").change(function() {
            var count = $(this).val();
            var formHtml = "";
            for (var i = 1; i <= count; i++) {
                formHtml += "<tr>";
                formHtml += "<td>회원 " + i + " ID:</td>";
                formHtml += "<td><input type='text' name='vi_id' class='vi-id'></td>";
                formHtml += "<td class='validation-message' style='color: red;'></td>";
                formHtml += "<td>총게임수:</td>";
                formHtml += "<td><input type='number' name='vi_game' oninput='calculateAvg(" + (i-1) + ")'></td>";
                formHtml += "<td>총점:</td>";
                formHtml += "<td><input type='number' name='vi_total' oninput='calculateAvg(" + (i-1) + ")'></td>";
                formHtml += "<td>에버점수:</td>";
                formHtml += "<td><input type='number' name='vi_avg'></td>";
                formHtml += "</tr>";
            }
            $("#memberTable").html(formHtml);
        });
        
        // vi_id 입력칸에 입력이 있을 때마다 AJAX 요청 실행
        $(document).on("blur", ".vi-id", function() {
            var user_id = $(this).val();
            var row = $(this).closest("tr");
            var messageElement = row.find(".validation-message");

            // AJAX 요청을 통해 회원 ID가 DB에 존재하는지 검증
            $.ajax({
                url: "checkUser",
                type: "POST",
                data: { user_id: user_id },
                success: function(response) {
                    if (response === "true") {
                        messageElement.text("아이디 검증 완료").css("color", "green");
                    } else {
                        messageElement.text("존재하지 않는 회원입니다").css("color", "red");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                		console.log(user_id);
                    console.log("HTTP Status: " + jqXHR.status); // HTTP 상태 코드
                    console.log("Ajax Error: " + textStatus); // Ajax가 처리하는 에러 메시지
                    console.log("Error Thrown: " + errorThrown); // 서버에서 반환하는 오류 메시지
                    messageElement.text("검증에 실패했습니다");
                }
            });
        });
    });

    function calculateAvg(index) {
        var total = 0;
        var gameCount = 0;
        
        // 입력 필드 값을 순회하며 총게임수와 총점을 계산
        $("input[name='vi_game']").each(function(i, element) {
            if (i === index) {
                gameCount = parseFloat($(element).val());
            }
        });
        
        $("input[name='vi_total']").each(function(i, element) {
            if (i === index) {
                total = parseFloat($(element).val());
            }
        });

        // 총게임수와 총점을 바탕으로 에버점수 계산
        var avg = Math.round(total / gameCount);
        // 계산 결과를 해당 인덱스의 에버점수 필드에 설정
        $("input[name='vi_avg']").eq(index).val(avg);
    }
</script>




</head>
<body>
<h2>게임결과</h2>
<form method="post" action="visit">
    <table>
        <tr>
            <td>참여 회원 수:</td>
            <td>
                <select id="memberCount" name="memberCount">
                    <option value="1">1명</option>
                    <option value="2">2명</option>
                    <option value="3">3명</option>
                    <option value="4">4명</option>
                    <option value="5">5명</option>
                    <option value="6">6명</option>
                    <option value="7">7명</option>
                    <option value="8">8명</option>
                </select>
            </td>
        </tr>
    </table>

    <table id="memberTable"></table>

    <input type="submit" value="점수 등록">
</form>
</body>
</html>
