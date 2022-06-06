<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nik Mall</title>

<link rel="stylesheet" href="/resources/css/mypageModify.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">

<!-- google material(icon) -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
		crossorigin="anonymous"></script>

<!-- daum 주소 서비스 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
a.gnb{text-decoration: none;color: white;}
a:hover {color: #FFC107;}
.logo-img{float: left; width: 60px; height: 100%;}
.search-icon {font-size: 1.5em; font-weight: bold;}
#gnb_logout_button {cursor: pointer;}
</style>

</head>
<body>
	<div class="wrapper">
		<header class="p-3 bg-dark text-white">
			<a class="" href="/"> <img class="logo-img"
				src="/resources/img/logo.PNG">
			</a>
			<div class="container">
				<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<ul
						class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
						<!-- gnb : 로그인한 상태 -->
						<c:if test="${member != null }">
							<c:if test="${member.adminCk == 1 }">
								<li class="ms-3"><a class="gnb" href="/admin/main">관리자</a></li>
							</c:if>
							<li class="ms-3"><a class="gnb"
								href="/mypage/${member.memberId }">마이룸</a></li>
							<li class="ms-3"><a class="gnb"
								href="/cart/${member.memberId}">장바구니</a></li>
						</c:if>
						<li class="ms-3"><a class="gnb" href="#">고객센터</a></li>
					</ul>

					<form action="/search" method="get"
						class="d-flex col-12 col-lg-auto mb-3 mb-lg-0 me-lg-1">
						<select name="type" hidden="hidden">
							<option value="T">상품 이름</option>
						</select> <input type="text" name="keyword"
							class="form-control form-control-dark text-white bg-dark me-1"
							placeholder="Search...">
						<button style="width: 100px;" class="btn btn-warning me-2">검색</button>
					</form>

					<div class="text-end">
						<!-- gnb : 비 로그인한 상태 -->
						<c:if test="${member == null}">
							<li class="ms-2 btn btn-outline-light"><a class="gnb"
								class="" href="/member/login">로그인</a></li>
							<li class="ms-2 btn btn-outline-light"><a class="gnb"
								href="/member/join">회원가입</a></li>
						</c:if>

						<!-- gnb : 로그인한 상태 -->
						<c:if test="${member != null }">
							<li class="ms-2 btn btn-outline-light">
								<a class="gnb admin_gnb_top" href="/member/logout.do">로그아웃</a>
							</li>
						</c:if>
					</div>

				</div>
			</div>
		</header>

		<div class="wrap">

			<article id="update_box" class="container">

				<h2>Update Us</h2>

				<form id="update" action="${contextPath}/mypage/mypageModify.do" method="post" name="formm">

					<fieldset>

						<legend class="update_title">Basic Info</legend>

						<!-- 아이디 -->
						<div class="row my-3">
							<div class="col-4">
								<label class="form-label">User ID</label>
							</div>
							<div class="col-8">
								<input type="text" id="id" name="memberId"
									class="id_input form-control bg-light" readonly
									value="${member.memberId}">
							</div>
						</div>

						<!-- 신규(변경) 패쓰워드 -->
						<div class="row my-3">
							<div class="col-4">
								<label class="form-label">Password</label>
							</div>
							<div class="col-8">
								<input type="text" id="pwd" name="memberPw" class="form-control"
									value=" " maxlength="20">
							</div>
						</div>

						<!-- 신규(변경) 패쓰워드 에러 메시지 -->
						<div class="row text-danger">
							<div class="col-4"></div>
							<div class="col-8" id="pwd_err_msg">
								<spring:hasBindErrors name="memberDTO">
									${errors.getFieldError("pwd").defaultMessage}
								</spring:hasBindErrors>
							</div>
						</div>

						<!-- 패쓰워드(재입력) -->
						<div class="row mb-3">
							<div class="col-4">
								<label class="form-label w-100">Retype-Password</label>
							</div>
							<div class="col-8">
								<input type="text" id="pwdCheck" name="pwdCheck"
									class="form-control" value=" " maxlength="20">
							</div>
						</div>

						<!-- 패쓰워드(재입력) 에러 메시지 -->
						<div class="row text-danger">
							<div class="col-4"></div>
							<div class="col-8" id="pwd_err_msg">
								<spring:hasBindErrors name="memberDTO">
									${errors.getFieldError("pwdCheck").defaultMessage}
								</spring:hasBindErrors>
								${pwd_err_msg}
							</div>
						</div>

						<!-- 회원 이름 -->
						<div class="row mb-3">
							<div class="col-4">
								<label class="form-label">Name</label>
							</div>
							<div class="col-8">
								<input type="text" id="name" name="memberName"
									class="form-control bg-light" readonly
									value="${member.memberName}">
							</div>
						</div>

						<!-- 회원 이메일 -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label">E-Mail</label>
							</div>
							<div class="col-8">
								<input type="text" id="email" name="memberMail"
									class="mail_input form-control" value="${member.memberMail}">
								<sapn class="mail_input_box_warn"></sapn>
							</div>
						</div>

						<div class="row my-2">
							<div class="col-4"></div>
							<div class="col-5 mail_check_input_box"
								id="mail_check_input_box_false">
								<input type="text" class="mail_check_input form-control"
									disabled="disabled">
							</div>
							<div class="col-3 mail_check_button btn btn-primary">
								<span>인증번호 전송</span>
							</div>
						</div>
						<div class="row my-2">
							<div class="col-4"></div>
							<div class="col-8">
								<span id="mail_check_input_box_warn"></span>
							</div>
						</div>


						<!-- 회원 이메일 에러 메시지 -->
						<div class="row text-danger">
							<div class="col-4"></div>
							<div class="col-8" id="email_err_msg">
								<spring:hasBindErrors name="memberDTO">
									${errors.getFieldError("email").defaultMessage}
								</spring:hasBindErrors>
								${email_err_msg}
							</div>
						</div>

					</fieldset>


					<fieldset>

						<legend class="update_title">Optional</legend>

						<!-- 회원 우편번호 : 검색 -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label">Zip Code</label>
							</div>
							<div class="col-2">
								<input type="text" id="zipNum" name="memberAddr1"
									class="form-control bg-light" readonly
									value="${member.memberAddr1}">
							</div>
							<div class="col-6">
								<input type="button" value="주소 찾기"
									class="btn btn-outline-secondary" onClick="daum_address()">
								<input type="button" id="address_init_btn" value="주소 초기화"
									class="btn btn-outline-secondary ms-1">
							</div>
						</div>

						<!-- 회원 주소 : 기본 주소(도로명) -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label w-100">Address(Basic)</label>
							</div>
							<div class="col-8">
								<input type="text" id="address1" name="memberAddr2"
									class="form-control bg-light" readonly
									value="${member.memberAddr2}">
							</div>
						</div>

						<!-- 회원 주소 : 상세주소 -->
						<div class="row">
							<div class="col-4">
								<label class="form-label w-100">Address(Detail)</label>
							</div>
							<div class="col-8">
								<input type="text" id="address2" name="memberAddr3"
									class="form-control" value="${member.memberAddr3}">
							</div>
						</div>

						<!-- 회원 주소 에러 메시지 -->
						<div class="row text-danger">
							<div class="col-4"></div>
							<div class="col-8" id="address_err_msg">${address_err_msg}</div>
						</div>

					</fieldset>

					<div id="buttons" class="row mb-3">
						<div class="col-2"></div>
						<div class="col-5 ps-5 pe-3">
							<input type="submit" id="update_submit"
								class="btn btn-outline-secondary px-5" value="회원정보 수정">
						</div>
						<div class="col-4">
							<input type="reset" class="btn btn-outline-secondary px-5"
								value="취소">
						</div>
						<div class="col-1"></div>
					</div>

				</form>

			</article>

		</div>
	</div>


	<!-- Footer 영역 -->
		<div class="footer_wrap">
			<div class="footer_nav">
				<div class="footer_nav_container">
					<ul>
						<li>회사소개</li>
						<span class="line">|</span>
						<li>이용약관</li>
						<span class="line">|</span>
						<li>고객센터</li>
						<span class="line">|</span>
						<li>광고문의</li>
						<span class="line">|</span>
					</ul>
				</div>
			</div>
			<footer>
				<p class="float-end">
					<a class="material-icons footer_home_button" style="font-size: 50px;"
						href="#">keyboard_double_arrow_up</a>
				</p>
				<div class="footer">
					<div class="footer_container">
						<div class="footer_left">
							<img src="/resources/img/logo.PNG">
						</div>
						<div class="footer_right">
							(주) NikMall 대표이사 : OOO <br> 사업자등록번호 : ooo-oo-ooooo <br>
							대표전화 : oooo-oooo(발신자 부담전화) <br> <br> COPYRIGHT(C) <strong>www.naver.com</strong>
							ALL RIGHTS RESERVED.
						</div>
					</div>
				</div>
			</footer>
		</div>



<script>

var code = ""; //이메일전송 인증번호 저장위한 코드

/* 유효성 검사 통과유무 변수 */
var idCheck = false;            // 아이디
var pwCheck = false;            // 비번
var pwckCheck = false;          // 비번 확인
var pwckcorCheck = false;       // 비번 확인 일치 확인
var nameCheck = false;          // 이름
var mailCheck = false;          // 이메일
var mailnumCheck = false;       // 이메일 인증번호 확인
var addressCheck = false        // 주소

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$(".join_button").click(function(){

		/* 입력값 변수 */
        var id = $('.id_input').val();              // id 입력란
        var pw = $('.pw_input').val();              // 비밀번호 입력란
        var pwck = $('.pwck_input').val();          // 비밀번호 확인 입력란
        var name = $('.user_input').val();          // 이름 입력란
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

        /* 비밀번호 확인 유효성 검사 */
        if(pwck == ""){
            $('.final_pwck_ck').css('display','block');
            pwckCheck = false;
        }else{
            $('.final_pwck_ck').css('display', 'none');
            pwckCheck = true;
        }

        /* 이름 유효성 검사 */
        if(name == ""){
            $('.final_name_ck').css('display','block');
            nameCheck = false;
        }else{
            $('.final_name_ck').css('display', 'none');
            nameCheck = true;
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
        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&mailCheck&&mailnumCheck&&addressCheck ){

			$("#join_form").attr("action", "/member/join");
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

// 인증번호 비교
$(".mail_check_input").blur(function(){

	var inputCode = $(".mail_check_input").val();        // 입력코드
    var checkResult = $("#mail_check_input_box_warn");   // 비교 결과

    if(inputCode == code){                               // 일치할 경우
        checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct");
        mailnumCheck = true;
    } else {                                             // 일치하지 않을 경우
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
        mailnumCheck = false;
    }

}); // 인증번호 비교 끝

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

// 비밀번호 확인 일치 유효성 검사
$('.pwck_input').on("propertychange change keyup paste input", function(){

	var pw = $('.pw_input').val();
    var pwck = $('.pwck_input').val();
    $('.final_pwck_ck').css('display', 'none');
    $('.final_pw_ck').css('display', 'none');

    if(pw == pwck){
        $('.pwck_input_re_1').css('display','block');
        $('.pwck_input_re_2').css('display','none');
        pwckcorCheck = true;
    }else{
        $('.pwck_input_re_1').css('display','none');
        $('.pwck_input_re_2').css('display','block');
        pwckcorCheck = false;
    }

}); // 비밀번호 확인 일치 유효성 검사 끝

// 이름 유효성 검사
$('.user_input').on("propertychange change keyup paste input", function(){

	var name = $('.user_input').val();

	$('.final_name_ck').css("display", "none");

}); // 이름 유효성 검사 끝

/* 입력 이메일 형식 유효성 검사 */
function mailFormCheck(email){

	var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;

    return form.test(email);

}

</script>

</body>
</html>