<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="resources/css/search.css">




	<div class="wrapper">

		<div class="wrap">

			<%@include file="includes/header.jsp"%>

			<div class="clearfix"></div>

			<div class="content_area">
				<!-- 게시물 o -->
				<c:if test="${listcheck != 'empty'}">
					<div class="search_filter">
						<div class="filter_button_wrap">
							<button class="filter_button filter_active" id="filter_button_a">남성</button>
							<button class="filter_button" id="filter_button_b">여성</button>
						</div>
						<div class="filter_content filter_a">
							<c:forEach items="${filter_info}" var="filter">
								<c:if test="${filter.cateGroup eq '1'}">
									<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
								</c:if>
							</c:forEach>
						</div>
						<div class="filter_content filter_b">
							<c:forEach items="${filter_info}" var="filter">
								<c:if test="${filter.cateGroup eq '2'}">
									<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
								</c:if>
							</c:forEach>
						</div>
						<form id="filter_form" action="/search" method="get">
							<input type="hidden" name="keyword">
							<input type="hidden" name="cateCode">
							<input type="hidden" name="type">
						</form>
					</div>

					<div class="list_search_result">
						<table class="type_list">

							<tbody id="searchList>">
								<c:forEach items="${list}" var="list">
									<tr>
										<td class="image">
											<div class="image_wrap" data-id="${list.imageList[0].id}"
												data-path="${list.imageList[0].uploadPath}"
												data-uuid="${list.imageList[0].uuid}"
												data-filename="${list.imageList[0].fileName}">
												<img style="width: 90%;">
											</div>
										</td>
										<td class="detail">
											<div class="category">[${list.cateName}]</div>
											<div class="title">
												<a href="/productDetail/${list.id}"> ${list.name} </a>
											</div>
											<div class="publeyear">
												<fmt:parseDate var="publeYear" value="${list.publeYear}"
													pattern="yyyy-MM-dd" />
												<fmt:formatDate value="${publeYear}" pattern="yyyy-MM-dd" />
											</div>
										</td>
										<td class="info">
											<div class="rating">평점(추후 추가)</div>
										</td>
										<td class="price">
											<div class="org_price">
												<del>
													<fmt:formatNumber value="${list.price}" pattern="#,###원" />
												</del>
											</div>
											<div class="sell_price">
												<strong> <fmt:formatNumber
														value="${list.price * (1-list.discount)}" pattern="#,###원" />
												</strong>
											</div>
										</td>
										<td class="option"></td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>

					<!-- 페이지 이동 인터페이스 -->
					<div class="pageMaker_wrap">
						<ul class="pageMaker">

							<!-- 이전 버튼 -->
							<c:if test="${pageMaker.prev }">
								<li class="pageMaker_btn prev"><a class="page_num"
									href="${pageMaker.pageStart -1}">이전</a></li>
							</c:if>

							<!-- 페이지 번호 -->
							<c:forEach begin="${pageMaker.pageStart }"
								end="${pageMaker.pageEnd }" var="num">
								<li
									class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
									<a class="page_num" href="${num}">${num}</a>
								</li>
							</c:forEach>

							<!-- 다음 버튼 -->
							<c:if test="${pageMaker.next}">
								<li class="pageMaker_btn next"><a class="page_num"
									href="${pageMaker.pageEnd + 1 }">다음</a></li>
							</c:if>
						</ul>
					</div>

					<form id="moveForm" action="/search" method="get">
						<input type="hidden" name="pageNum"
							value="${pageMaker.cri.pageNum}"> <input type="hidden"
							name="amount" value="${pageMaker.cri.amount}"> <input
							type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
						<input type="hidden" name="type" value="${pageMaker.cri.type}">
						<input type="hidden" name="cateCode"
							value="<c:out value="${pageMaker.cri.cateCode}"/>">
					</form>
				</c:if>
				<!-- 게시물 x -->
				<c:if test="${listcheck == 'empty'}">
					<div class="table_empty">검색결과가 없습니다.</div>
				</c:if>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>

<script>

/* 페이지 이동 버튼 */
const moveForm = $('#moveForm');

$(".pageMaker_btn a").on("click", function(e) {

	e.preventDefault();

	moveForm.find("input[name='pageNum']").val($(this).attr("href"));

	moveForm.submit();

});

$(document).ready(function() {

	// 검색 타입 selected
	const selectedType = '<c:out value="${pageMaker.cri.type}"/>';

		if (selectedType != "") {
			$("select[name='type']").val(selectedType).attr("selected", "selected");
		}

	/* 이미지 삽입 */
	// each(index, item)
	$(".image_wrap").each(function(i, obj) {

		const bobj = $(obj);

		console.log(i);
		console.log(obj);
		console.log(bobj.data("id"));

		if (bobj.data("id")) {
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");

			const fileCallPath = encodeURIComponent(uploadPath
					+ "/thumbnail_"
					+ uuid
					+ "_"
					+ fileName);

			$(this).find("img").attr('src','/display?fileName='+ fileCallPath);

		} else {

			$(this).find("img").attr('src','/resources/img/이미지 없음.png');
		}

	});


	/* 검색 필터 */
	let buttonA = $("#filter_button_a");
	let buttonB = $("#filter_button_b");

	buttonA.on("click", function() {
		$(".filter_b").css("display", "none");
		$(".filter_a").css("display", "block");
		buttonA.attr("class","filter_button filter_active");
		buttonB.attr("class", "filter_button");
	});

	buttonB.on("click", function() {
		$(".filter_a").css("display", "none");
		$(".filter_b").css("display", "block");
		buttonB.attr("class","filter_button filter_active");
		buttonA.attr("class", "filter_button");
	});

	$(".filter_content a").on("click",function(e) {

		e.preventDefault();

		let type = '<c:out value="${pageMaker.cri.type}"/>';
		if (type === 'T') {
			type = type + 'C';
		}

		let keyword = '<c:out value="${pageMaker.cri.keyword}"/>';
		let cateCode = $(this).attr("href");

		$("#filter_form input[name='keyword']").val(keyword);
		$("#filter_form input[name='cateCode']").val(cateCode);
		$("#filter_form input[name='type']").val(type);
		$("#filter_form").submit();

	});

});// $(document).ready

</script>

