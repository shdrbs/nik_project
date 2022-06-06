<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<link rel="stylesheet" href="/resources/css/mypage/mypage.css">


<div class="wrapper">

	<div class="wrap">

		<%@include file="../includes/header.jsp"%>

		<div class="content_area">

			<article id="view_box" class="container">

				<h2 class="my-3" style="font-weight: bold;">회원정보</h2>

				<%-- ${LOGIN_USER} --%>

				<form id="view">

					<fieldset>

						<legend class="view_title">기본 정보</legend>

						<!-- 아이디 -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label">아이디</label>
							</div>
							<input hidden="hidden" name="memberId" value="${member.memberId}">
							<div class="col-8 mt-1">${member.memberId}</div>
						</div>

						<!-- 패쓰워드 -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label">비밀번호</label>
							</div>
							<div class="col-8 mt-1">
								<%-- ${LOGIN_USER.pwd} --%>
								********
							</div>
						</div>

						<!-- 회원 이름 -->
						<div class="row">
							<div class="col-4">
								<label class="form-label">이름</label>
							</div>
							<div class="col-8 mt-1">${member.memberName}</div>
						</div>

						<!-- 회원 연락처 -->
						<div class="row">
							<div class="col-4">
								<label class="form-label">연락처</label>
							</div>
							<div class="col-8 mt-1">${member.memberPhone}</div>
						</div>

						<!-- 회원 이메일 -->
						<div class="row">
							<div class="col-4">
								<label class="form-label">이메일</label>
							</div>
							<div class="col-8 mt-1">${member.memberMail}</div>
						</div>

						<%--  <!-- 회원 연락처 : 휴대폰 -->
						      <div class="row">
						      	<div class="col-4">
						      		<label class="form-label w-100">Phone Number</label>
						      	</div>
						      	<div class="col-8 mt-1">
						      		${LOGIN_USER.phone}
						      	</div>
						      </div> --%>

					</fieldset>

					<fieldset>

						<legend class="view_title">주소지</legend>

						<!-- 회원 우편번호 : 검색 -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label">우편번호</label>
							</div>
							<div class="col-2 mt-1">${member.memberAddr1}</div>
							<div class="col-6"></div>
						</div>

						<!-- 회원 주소 : 기본 주소(도로명) -->
						<div class="row my-2">
							<div class="col-4">
								<label class="form-label w-100">주소</label>
							</div>
							<div class="col-8 mt-1">${member.memberAddr2}</div>
						</div>

						<!-- 회원 주소 : 상세주소 -->
						<div class="row">
							<div class="col-4">
								<label class="form-label w-100">상세 주소</label>
							</div>
							<div class="col-8 mt-1">${member.memberAddr3}</div>
						</div>
						<div class="d-flex flex-row-reverse mt-5">
							<a class="modify_btn btn btn-primary me-5" href="/mypage/mypageModify">수정</a>
							<a class="delete_btn btn btn-danger me-2">탈퇴</a>
						</div>
					</fieldset>

				</form>

			</article>


		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>


<script>

$('.delete_btn').click(function() {

	$("#view").attr("action", "/member/delete.do");
	$("#view").submit();
	alert("회원 탈퇴를 완료했습니다.");
});

</script>

</body>
</html>