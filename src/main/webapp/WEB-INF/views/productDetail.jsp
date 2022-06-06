<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="/resources/css/productDetail.css">


	<div class="wrapper">

		<div class="wrap">

			<%@include file="includes/header.jsp"%>



			<div class="content_area">


				<div class="content_top">

					<!-- 상품 이미지 -->
					<div class="ct_left_area">
						<div class="image_wrap" data-id="${productInfo.imageList[0].id}"
							data-path="${productInfo.imageList[0].uploadPath}"
							data-uuid="${productInfo.imageList[0].uuid}"
							data-filename="${productInfo.imageList[0].fileName}">
							<img style="width: 100%;">
						</div>
					</div>

					<!-- 상품 정보 -->
					<div class="ct_right_area">

						<!-- 상품 이름 -->
						<div class="title">
							<h1>${productInfo.name}</h1>
						</div>
						<!-- 상품 출시일 -->
						<div class="publeyear">
							<span class="publeyear"> ${productInfo.publeYear} </span>
						</div>

						<!-- 상품 가격 -->
						<div class="price">
							<div class="sale_price">
								정가 :
								<fmt:formatNumber value="${productInfo.price}" pattern="#,###원" />
							</div>
							<div class="discount_price">
								판매가 : <span class="discount_price_number"> <fmt:formatNumber
										value="${productInfo.price - (productInfo.price*productInfo.discount)}"
										pattern="#,###원" /></span> [
								<fmt:formatNumber value="${productInfo.discount*100}"
									pattern="###" />%
								<fmt:formatNumber
									value="${productInfo.price*productInfo.discount}"
									pattern="#,###원" />
								할인]
							</div>
							<div>
								적립 포인트 : <span class="point_span"></span>원
							</div>
						</div>


						<div class="button">
							<div class="button_quantity">
								주문수량 <input type="text" class="quantity_input" value="1">
								<span>
									<button class="plus_btn">+</button>
									<button class="minus_btn">-</button>
								</span>
							</div>
							<div class="button_set">
								<a class="btn_cart">장바구니 담기</a>
								<a class="btn_buy">바로구매</a>
							</div>
						</div>

						<!-- 상품 설명 -->
						<div class="content_middle">
							${productInfo.intro}
						</div>

					</div>
					<!-- //상품 정보 끝 -->
			</div>

						<hr>
						<!-- 상품 리뷰 -->
						<div class="content_bottom">
							<div class="reply_subject">
								<h2>리뷰</h2>
							</div>
							<c:if test="${member != null}">
								<div class="reply_button_wrap">
									<button>리뷰 쓰기</button>
								</div>
							</c:if>

							<div class="reply_not_div"></div>
							<ul class="reply_content_ul">

							</ul>
							<div class="repy_pageInfo_div">
								<ul class="pageMaker">

								</ul>
							</div>
						</div>


				<!-- 주문 form -->
				<form action="/order/${member.memberId}" method="get"
					class="order_form">
					<input type="hidden" name="orders[0].id" value="${productInfo.id}">
					<input type="hidden" name="orders[0].count" value="">
				</form>

		</div>
	</div>
</div>
	<%@include file="includes/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>

<script>
/* gnb_area 로그아웃 버튼 작동 */
$("#gnb_logout_button").click(function() {
	//alert("버튼 작동");
	$.ajax({
		type : "POST",
		url : "/member/logout.do",
		success : function(data) {
			//alert("로그아웃 성공");
			document.location.reload();
		}
	}); // ajax
});

$(document).ready(function(){

	/* 이미지 삽입 */
	const bobj = $(".image_wrap");

	if(bobj.data("id")){
		const uploadPath = bobj.data("path");
		const uuid = bobj.data("uuid");
		const fileName = bobj.data("filename");

		const fileCallPath = encodeURIComponent(uploadPath + "/thumbnail_" + uuid + "_" + fileName);

		bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);
	} else {
		bobj.find("img").attr('src', '/resources/img/이미지 없음.png');
	}

	/* 상품 출시일 */
	const year = "${productInfo.publeYear}";

	let tempYear = year.substr(0,10);

	let yearArray = tempYear.split("-")
	let publeYear = yearArray[0] + "년 " + yearArray[1] + "월 " + yearArray[2] + "일";

	$(".publeyear").html(publeYear);

	/* 포인트 삽입 */
	let salePrice = "${productInfo.price - (productInfo.price*productInfo.discount)}"
	let point = salePrice*0.05;
	point = Math.floor(point);
	$(".point_span").text(point);

	/* 리뷰 리스트 출력 */
	const id = '${productInfo.id}';

	// 첫 번째 파라미터 : 요청 URL
	// 두 번째 파라미터 : 서버에 전송할 데이터
	// 세 번째 파라미터 : 서버로부터 응답을 성공했을 때 동작할 코드
	$.getJSON("/reply/list", {id : id}, function(obj){

		makeReplyContent(obj);

	}); //getJSON

}); //$(document).ready

/* 수량 버튼 조작 */
let quantity = $(".quantity_input").val();

$(".plus_btn").on("click", function(){ // '+'버튼 클리 시 수량 증가

	$(".quantity_input").val(++quantity);
});

$(".minus_btn").on("click", function(){ // '-'버튼 클리 시 수량 감소

	if(quantity > 1){ // '-'버튼을 계속 누를 경우 숫자가 '0'이 될 수 있으므로 '1'보다는 작아질 수 없게 한다
		$(".quantity_input").val(--quantity);
	}
});

/* 서버로 전송할 데이터 */
const form = {
	memberId : '${member.memberId}',
	id : '${productInfo.id}',
	count : '' // count의 경우 '장바구니 담기 버튼' 클릭 직전까지 변경할 수 있기 때문에 빈 값으로 두었다
}
/* 장바구니 버튼 기능 */
$(".btn_cart").on("click", function(e){

	form.count = $(".quantity_input").val();
	$.ajax({
		url: '/cart/add',			// 호출할 url
		type: 'POST',				// 호출 할 방법(GET or POST or PATCH 등)
		data: form,					// 서버로 보낼 데이터
		success: function(result){ 	// 서버가 요청을 성공적으로 수행했을 때 수행될 메서드, 파라미터는 서버가 반환한 값
			cartAlert(result);
		}
	})
});

/* 장바구니 담기 버튼 클릭 시 경고문 */
function cartAlert(result){
	if(result == '0'){
		alert("장바구니에 추가를 하지 못하였습니다.");
	} else if(result == '1'){
		alert("장바구니에 추가되었습니다.");
	} else if(result == '2'){
		alert("장바구니에 이미 추가되어져 있습니다.");
	} else if(result == '5'){
		alert("로그인이 필요합니다.");
	}
}

/* 바로구매 버튼 */
$(".btn_buy").on("click", function(){
	let count = $(".quantity_input").val();
	$(".order_form").find("input[name='orders[0].count']").val(count);
	$(".order_form").submit();
});

/* 리뷰쓰기 */
$(".reply_button_wrap").on("click", function(e){

	e.preventDefault();

	const memberId = '${member.memberId}';
	const id = '${productInfo.id}';

	$.ajax({
		data : {
			id : id,
			memberId : memberId
		},
		url : '/reply/check',
		type : 'POST',
		success : function(result){

			if(result === '1'){
				alert("이미 등록된 리뷰가 존재 합니다.")
			} else if(result === '0'){

				// 팝업창 url설정(memberId는 PathVarialbe 방식으로, id는 쿼리스트링 방식으로 서버에 데이터를 전송 할 수 있도록 URL을 설계)
				let popUrl = "/replyRegist/" + memberId + "?id=" + id;

				console.log(popUrl);
				// 팝업창 설정
				let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";

				// Javascript 팝업창 관련 기능메서드 인 window.open() 를 사용하면 팝업창을 요청 할 수 있다.
				// 첫 파라미터는 url을, 두 번째 파라미터는 팝업창 이름을, 세 번째 파라미터에는 팝업창 관련 설정(크기, 스크롤 방식 등) 값을 가진 객체
				window.open(popUrl,"리뷰 쓰기",popOption);
			}
		}
	}); //ajax

});

/* 댓글 페이지 정보 */
const cri = {
	id : '${productInfo.id}',
	pageNum : 1,
	amount : 10
}

/* 댓글 페이지 이동 버튼 동작 */
$(document).on('click', '.pageMaker_btn a', function(e){

	e.preventDefault();

	let page = $(this).attr("href");
	cri.pageNum = page;

	replyListInit();

 });

/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
let replyListInit = function(){
	$.getJSON("/reply/list", cri , function(obj){

		makeReplyContent(obj);

	});
}

/* 리뷰 수정 버튼 */
$(document).on('click', '.update_reply_btn', function(e){

	e.preventDefault();

	let replyId = $(this).attr("href");
	let popUrl = "/replyUpdate?replyId=" + replyId + "&id=" + '${productInfo.id}' + "&memberId=" + '${member.memberId}';
	let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"

	window.open(popUrl,"리뷰 수정",popOption);

});

/* 리뷰 삭제 버튼 */
$(document).on('click', '.delete_reply_btn', function(e){

	e.preventDefault();

	let replyId = $(this).attr("href");

	$.ajax({
		data : {
			replyId : replyId,
			id : '${productInfo.id}'
		},
		url : '/reply/delete',
		type : 'POST',
		success : function(result){
			replyListInit();
			alert('삭제가 완료되엇습니다.');
		}
	});

});

/* 댓글(리뷰) 동적 생성 메서드 */
function makeReplyContent(obj){

	if(obj.list.length === 0){
		$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');
		$(".reply_content_ul").html('');
		$(".pageMaker").html('');
	} else{

		$(".reply_not_div").html('');

		const list = obj.list;
		const pf = obj.pageInfo;
		const userId = '${member.memberId}';

		/* list */

		let reply_list = '';

		$(list).each(function(i,obj){
			reply_list += '<li>';
			reply_list += '<div class="comment_wrap">';
			reply_list += '<div class="reply_top">';
			/* 아이디 */
			reply_list += '<span class="id_span">'+ obj.memberId+'</span>';
			/* 날짜 */
			reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
			/* 평점 */
			reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
			if(obj.memberId === userId){
				reply_list += '<a class="update_reply_btn" href="'+ obj.replyId +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyId +'">삭제</a>';
			}
			reply_list += '</div>'; //<div class="reply_top">
			reply_list += '<div class="reply_bottom">';
			reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
			reply_list += '</div>';//<div class="reply_bottom">
			reply_list += '</div>';//<div class="comment_wrap">
			reply_list += '</li>';
		});

		$(".reply_content_ul").html(reply_list);

		/* 페이지 버튼 */

		let reply_pageMaker = '';

			/* prev */
			if(pf.prev){
				let prev_num = pf.pageStart -1;
				reply_pageMaker += '<li class="pageMaker_btn prev">';
				reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
				reply_pageMaker += '</li>';
			}
			/* numbre btn */
			for(let i = pf.pageStart; i < pf.pageEnd+1; i++){
				reply_pageMaker += '<li class="pageMaker_btn ';
				if(pf.cri.pageNum === i){
					reply_pageMaker += 'active';
				}
				reply_pageMaker += '">';
				reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
				reply_pageMaker += '</li>';
			}
			/* next */
			if(pf.next){
				let next_num = pf.pageEnd +1;
				reply_pageMaker += '<li class="pageMaker_btn next">';
				reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
				reply_pageMaker += '</li>';
			}

		$(".pageMaker").html(reply_pageMaker);

	}

}

</script>

