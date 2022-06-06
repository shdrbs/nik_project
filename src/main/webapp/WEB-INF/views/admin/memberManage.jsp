<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="../resources/css/admin/memberManage.css">



	<%@include file="../includes/admin/header.jsp"%>

<article>

	<div class="admin_content_wrap">

		<div class="admin_content_subject">
			<span>회원 관리</span>
		</div>

		<div class="member_table_wrap" style="overflow-x: auto;">
		<form id="modify_form" method="get">
			<!-- 회원 리스트 O -->
			<c:if test="${listcheck != 'empty'}">
				<table class="member_table" style="width: 1700px;">
					<thead>
						<tr>
							<td class="th_column_1"></td>
							<td class="th_column_1">회원 이름</td>
							<td class="th_column_2">아이디</td>
							<td class="th_column_4">비밀번호</td>
							<td class="th_column_4">이메일</td>
							<td class="th_column_4">연락처</td>
							<td class="th_column_4">충전금액</td>
							<td class="th_column_4">포인트</td>
							<td class="th_column_5">우편번호</td>
							<td class="th_column_5">주소</td>
							<td class="th_column_4">회원체크</td>
							<td class="th_column_6">가입날짜</td>
						</tr>
					</thead>
					<c:forEach items="${list}" var="list">
						<tr>
							<td><a class="modify_btn btn btn-primary" href='<c:out value="${list.memberId}"/>'>수정</a></td>
							<td>${list.memberName}</td>
							<td>${list.memberId}</td>
							<td>********</td>
							<td>${list.memberMail}</td>
							<td>${list.memberPhone}</td>
							<td>${list.money}</td>
							<td>${list.point}</td>
							<td>${list.memberAddr1}</td>
							<td>
								${list.memberAddr2}<br>
								${list.memberAddr3}
							</td>
							<td>${list.adminCk == 0 ? "일반회원" : "관리자"}</td>
							<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<!-- 회원 리스트 X -->
			<c:if test="${listCheck == 'empty'}">
				<div class="table_empty">등록된 회원이 없습니다.</div>
			</c:if>
			</form>
		</div>




		<!-- 검색 영역 -->
		<div class="search_wrap">
			<form id="searchForm" action="/admin/memberManage" method="get">
				<div class="search_input">
					<input type="text" name="keyword"
						value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
					<input type="hidden" name="type" value="G">
					<button class='btn btn-secondary search_btn' style="--bs-btn-padding-x: .5rem;">검 색</button>
				</div>
			</form>
		</div>

		<!-- 페이지 인터페이스 영역 -->
		<div class="pageMaker_wrap">
			<ul class="pageMaker">

				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev }">
					<li class="pageMaker_btn prev">
						<a href="${pageMaker.pageStart -1}">이전</a>
					</li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
					<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next">
						<a href="${pageMaker.pageEnd + 1 }">다음</a>
					</li>
				</c:if>
			</ul>
		</div>

		<form id="moveForm" action="/admin/memberManage" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>
</article>


	<%@include file="../includes/admin/footer.jsp"%>

<script>

$(document).ready(function() {

	/* 수정 성공 이벤트 */
	let modify_result = '${modify_result}';

	if(modify_result == 1){
		alert("수정 완료");
	}

	/* 삭제 결과 경고창 */
	let delete_result = '${delete_result}';

	if(delete_result == 1){
		alert("삭제 완료");
	}

});

let searchForm = $('#searchForm');
let moveForm = $('#moveForm');

/* 검색 버튼 동작 */
$("#searchForm button").click(function() {

	e.preventDefault();

	/* 검색 키워드 유효성 검사 */
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하십시오");
		return false;
	}

	searchForm.find("input[name='pageNum']").val("1");
	searchForm.submit();

});

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){

	e.preventDefault();

	moveForm.find("input[name='pageNum']").val($(this).attr("href"));

	moveForm.submit();

});


/* 상품 조회 페이지 */
$(".modify_btn").on("click", function(e){

	e.preventDefault();

	moveForm.find("input").remove();
	moveForm.append("<input type='hidden' name='memberId' value='"+$(this).attr("href") + "'>");
	moveForm.attr("action", "/admin/memberModify");
	moveForm.submit();

});

</script>

