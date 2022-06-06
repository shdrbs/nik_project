<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 페이지</title>

<link rel="stylesheet" href="../resources/css/admin/memberModify.css">


</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">

		<div class="admin_content_subject">
			<span>회원수정</span>
		</div>

		<div class="admin_content_main">
			<form action="/admin/memberModify.do" method="post" id="modifyForm">

				<!-- 회원 이름 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>회원 이름</label>
					</div>
					<div class="form_section_content">
						<input name="memberName" value="${memberInfo.memberName}">
					</div>
				</div>

				<!-- 회원 아이디 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>아이디</label>
					</div>
					<div class="form_section_content">
						<input name="memberId" value="${memberInfo.memberId}" disabled="disabled">
					</div>
				</div>

				<!-- 비밀번호 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>비밀번호</label>
					</div>
					<div class="form_section_content">
						<input value="********" disabled="disabled">
					</div>
				</div>

				<!-- 이메일 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>이메일</label>
					</div>
					<div class="form_section_content">
						<input name="memberMail" value="${memberInfo.memberMail}">
					</div>
				</div>

				<!-- 연락처 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>연락처</label>
					</div>
					<div class="form_section_content">
						<input name="memberPhone" value="${memberInfo.memberPhone}">
					</div>
				</div>

				<!-- 충전금액 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>충전금액</label>
					</div>
					<div class="form_section_content">
						<input name="money" value="${memberInfo.money}">
					</div>
				</div>

				<!-- 포인트 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>포인트</label>
					</div>
					<div class="form_section_content">
						<input name="point" value="${memberInfo.point}">
					</div>
				</div>

				<!-- 우편번호 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>우편번호</label>
					</div>
					<div class="form_section_content bit">
						<input name="memberAddr1" id="intro_textarea" value="${memberInfo.memberAddr1}">
					</div>
				</div>

				<!-- 주소 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>주소</label>
					</div>
					<div class="form_section_content bit">
						<input name="memberAddr2" id="intro_textarea" value="${memberInfo.memberAddr2}">
					</div>
				</div>

				<!-- 상세주소 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상세주소</label>
					</div>
					<div class="form_section_content bit">
						<input name="memberAddr3" id="intro_textarea" value="${memberInfo.memberAddr3}">
					</div>
				</div>
				<input name="memberId" hidden="hidden" value="${memberInfo.memberId}">

			</form>

			<div class="btn_section">
				<button id="cancelBtn" class="btn btn-primary">취 소</button>
				<button id="modifyBtn" class="btn btn-primary modify_btn">수 정</button>
				<button id="deleteBtn" class="btn btn-danger delete_btn">삭 제</button>
			</div>

		</div>

		<form id="moveForm" action="/admin/memberManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
			<input type="hidden" name='memberId' value="${memberInfo.memberId}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script>

/* 취소 버튼 */
$("#cancelBtn").on("click", function(e){
	e.preventDefault();
	$("#moveForm").submit();
});

/* 삭제 버튼 */
$("#deleteBtn").on("click", function(e){
	e.preventDefault();
	let moveForm = $("#moveForm");
	moveForm.find("input").remove();
	moveForm.append('<input type="hidden" name="memberId" value="${memberInfo.memberId}">');
	moveForm.attr("action", "/admin/memberDelete");
	moveForm.attr("method", "post");
	moveForm.submit();
});

/* 수정 버튼 */
$("#modifyBtn").on("click",function(e){
	e.preventDefault();

	$("#modifyForm").submit();
});

</script>
</body>
</html>