<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="/resources/css/mypage/mypageModify.css">


	<%@include file="../includes/header.jsp"%>

	<div class="wrapper">

		<div class="wrap">

			<div class="content_area">


			<form id="join_form" method="post">
				<div class="subjecet">
					<span>회원정보 수정</span>
				</div>
				<div class="id_wrap">
					<div class="id_name">아이디</div>
					<div class="id_input_box">
						<input class="id_input" name="memberId" value="${member.memberId }" disabled="disabled">
					</div>
					<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
					<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
					<span class="final_id_ck">아이디를 입력해주세요.</span>

				</div>
				<div class="pw_wrap">
					<div class="pw_name">비밀번호</div>
					<div class="pw_input_box">
						<input class="pw_input" name="memberPw" value="${memberPw }">
					</div>
					<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
					<span class="pw_input_re_1">패쓰워드는 영문/숫자 및 특수문자 최소 1자의 조합으로 8~20사이로 입력하십시오</span>
                	<span class="pw_input_re_2"></span>

				</div>
				<div class="user_wrap">
					<div class="user_name">이름</div>
					<div class="user_input_box">
						<input class="user_input" value="${member.memberName }" disabled="disabled">
					</div>
					<span class="final_name_ck">이름을 입력해주세요.</span>

				</div>
				<div class="phone_wrap">
					<div class="phone_name">연락처</div>
					<div class="phone_input_box">
						<input class="phone_input" value="${member.memberPhone }" name="memberPhone" placeholder="ex) 01011112222">
					</div>
					<span class="final_phone_ck">연락처를 입력해주세요.</span>
					<span class="phone_input_re_1"></span>
	                <span class="phone_input_re_2">숫자만 입력해주세요.</span>

				</div>
				<div class="mail_wrap">
					<div class="mail_name">이메일</div>
					<div class="mail_input_box">
						<input class="mail_input" name="memberMail" value="${member.memberMail }">

					</div>
					<span class="final_mail_ck">이메일을 입력해주세요.</span>
					<span class="mail_input_box_warn"></span>

					<div class="mail_check_wrap">
						<div class="mail_check_input_box" id="mail_check_input_box_false">
							<input class="mail_check_input" disabled="disabled">
						</div>
						<div class="mail_check_button">
							<span>인증번호 전송</span>
						</div>
						<div class="clearfix"></div>
						<span class="final_mailnum_ck">인증번호를 입력해주세요.</span>
						<span id="mail_check_input_box_warn"></span>

					</div>
				</div>
				<div class="address_wrap">
					<div class="address_name">주소</div>
					<div class="address_input_1_wrap">
						<div class="address_input_1_box">
							<input class="address_input_1" name="memberAddr1" readonly="readonly" value="${member.memberAddr1 }">
						</div>
						<div class="address_button" onclick="daum_address()">
							<span>주소 찾기</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class ="address_input_2_wrap">
						<div class="address_input_2_box">
							<input class="address_input_2" name="memberAddr2" readonly="readonly" value="${member.memberAddr2 }">
						</div>
					</div>
					<div class ="address_input_3_wrap">
						<div class="address_input_3_box">
							<input class="address_input_3" name="memberAddr3" readonly="readonly" value="${member.memberAddr3 }">
						</div>
					</div>
					<span class="final_addr_ck">주소를 입력해주세요.</span>

				</div>
			</form>

				<div class="d-flex flex-row join_button_wrap mt-4 mb-4">
					<div class="col-10"></div>
					<div class="col-1">
						<button class="cancel_button btn btn-danger" onClick="location.href='/mypage/mypage'">취소</button>
					</div>
					<div class="col-1">
						<input type="button" class="join_button btn btn-primary" value="수정">
					</div>
				</div>
			</div>

		</div>

	</div>

	<%@include file="../includes/footer.jsp"%>

<script>

var code = ""; //이메일전송 인증번호 저장위한 코드

/* 유효성 검사 통과유무 변수 */
var pwCheck = false;            // 비번
var phoneCheck = false;         // 연락처
var mailCheck = false;          // 이메일
var addressCheck = false        // 주소

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(){

		/* 입력값 변수 */
        var pw = $('.pw_input').val();              // 비밀번호 입력란
        var phone = $('.phone_input').val();        // 연락처 입력란
        var mail = $('.mail_input').val();          // 이메일 입력란
        var addr = $('.address_input_3').val();     // 주소 입력란

        /* 비밀번호 유효성 검사 */
        if(pw == ""){
            $('.final_pw_ck').css('display','block');
            pwCheck = false;
        }else{
            $('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        }

        /* 연락처 유효성 검사 */
        if(phone == ""){
            $('.final_phone_ck').css('display','block');
            phoneCheck = false;
        }else{
            $('.final_phone_ck').css('display', 'none');
            phoneCheck = true;
        }

        /* 이메일 유효성 검사 */
        if(mail == ""){
            $('.final_mail_ck').css('display','block');
            mailCheck = false;
        }else{
            $('.final_mail_ck').css('display', 'none');
            mailCheck = true;
        }

        /* 주소 유효성 검사 */
        if(addr == ""){
            $('.final_addr_ck').css('display','block');
            addressCheck = false;
        }else{
            $('.final_addr_ck').css('display', 'none');
            addressCheck = true;
        }

        /* 최종 유효성 검사 */
        if(pwCheck&&phoneCheck&&mailCheck&&addressCheck ){

			$("#join_form").attr("action", "/mypage/mypageModify.do");
			$("#join_form").submit();
        }

        return false;

	});
});

// 인증번호 이메일 전송
$(".mail_check_button").click(function(){

	var email = $(".mail_input").val();        // 입력한 이메일
	var cehckBox = $(".mail_check_input");     // 인증번호 입력란
	var boxWrap = $(".mail_check_input_box");  // 인증번호 입력란 박스
	var warnMsg = $(".mail_input_box_warn");   // 이메일 입력 경고글

	/* 이메일 형식 유효성 검사 */
    if(mailFormCheck(email)){
        warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
        warnMsg.css("display", "inline-block");
    } else {
        warnMsg.html("올바르지 못한 이메일 형식입니다.");
        warnMsg.css("display", "inline-block");
        return false;
    }

	$.ajax({

        type:"GET",
        url:"mailCheck?email=" + email,
        success:function(data){

            //console.log("data : " + data);
        	cehckBox.attr("disabled",false);
        	boxWrap.attr("id", "mail_check_input_box_true");
        	code = data;

        }

    });

}); // 인증번호 이메일 전송 끝

// 다음 주소 연동
function daum_address(){

	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                // document.getElementById("sample6_extraAddress").value = extraAddr;

                // 주소변수 문자열과 참고항목 문자열 합치기
                addr += extraAddr;

            } else {
                // document.getElementById("sample6_extraAddress").value = '';
            	addr += ' ';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $(".address_input_1").val(data.zonecode);
            $(".address_input_2").val(addr);

            // 커서를 상세주소 필드로 이동한다.
         	// 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
            $(".address_input_3").attr("readonly",false);
            $(".address_input_3").focus();

        }
    }).open();

} // 다음 주소 연동 끝

//비밀번호 유효성 검사
    let check = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}$/i;
$(".pw_input").blur(function() {

	var pw = $('.pw_input').val();

    $('.final_pwck_ck').css('display', 'none');
    $('.final_pw_ck').css('display', 'none');

    if (!check.test(pw)) {
    	$('.pw_input_re_1').css('display','block');
        $('.pw_input_re_2').css('display','none');
        pwCheck = false;
        console.log("dd");
	}else {
		$('.pw_input_re_1').css('display','none');
        $('.pw_input_re_2').css('display','block');
        pwCheck = true;
        console.log("aa");
	}

}); // 비밀번호 유효성 검사 끝

// 연락처 유효성 검사
$('.phone_input').on("propertychange change keyup paste input", function(){

	var phone = $('.phone_input').val();

	$('.final_phone_ck').css("display", "none");

	let check = /^[0-9]+$/;

	if (check.test(phone)) {
		$('.phone_input_re_1').css('display','block');
        $('.phone_input_re_2').css('display','none');
        phoneCheck = false;
	}else {
		$('.phone_input_re_1').css('display','none');
        $('.phone_input_re_2').css('display','block');
        phoneCheck = true;
	}

}); // 연락처 유효성 검사 끝


/* 입력 이메일 형식 유효성 검사 */
function mailFormCheck(email){

	var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;

    return form.test(email);

}

</script>

</body>
</html>