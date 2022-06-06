<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 조회 페이지</title>

<link rel="stylesheet" href="../resources/css/admin/productDetail.css">

</head>
<body>
	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">

		<div class="admin_content_subject">
			<span>상품 상세</span>
		</div>

		<div class="admin_content_main">

			<!-- 상품 이름 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이름</label>
				</div>
				<div class="form_section_content">
					<input name="name"
						value="<c:out value="${productInfo.name}"/>" disabled>
				</div>
			</div>

			<!-- 등록 날짜 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>등록 날짜</label>
				</div>
				<div class="form_section_content">
					<input
						value="<fmt:formatDate value='${productInfo.regDate}' pattern='yyyy-MM-dd'/>"
						disabled>
				</div>
			</div>

			<!-- 최근 수정 날짜 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>최근 수정 날짜</label>
				</div>
				<div class="form_section_content">
					<input
						value="<fmt:formatDate value='${productInfo.updateDate}' pattern='yyyy-MM-dd'/>"
						disabled>
				</div>
			</div>

			<!-- 출시일 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 출시일</label>
				</div>
				<div class="form_section_content">
					<input name="publeYear" autocomplete="off" readonly="readonly"
						value="<c:out value="${productInfo.publeYear}"/>" disabled>
				</div>
			</div>

			<!-- 카테고리 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>카테고리</label>
				</div>
				<div class="form_section_content">
					<div class="cate_wrap">
						<span>대분류</span>
						<select class="cate1" disabled>
							<option value="none">선택</option>
						</select>
					</div>
					<div class="cate_wrap">
						<span>중분류</span>
						<select class="cate2" disabled>
							<option value="none">선택</option>
						</select>
					</div>
					<div class="cate_wrap">
						<span>소분류</span>
						<select class="cate3" name="cateCode" disabled>
							<option value="none">선택</option>
						</select>
					</div>
				</div>
			</div>

			<!-- 상품 가격 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 가격</label>
				</div>
				<div class="form_section_content">
					<input name="price"
						value="<c:out value="${productInfo.price}"/>" disabled>
				</div>
			</div>

			<!-- 상품 재고 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 재고</label>
				</div>
				<div class="form_section_content">
					<input name="stock"
						value="<c:out value="${productInfo.stock}"/>" disabled>
				</div>
			</div>

			<!-- 상품 할인율 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 할인율</label>
				</div>
				<div class="form_section_content">
					<input id="discount_interface" maxlength="2" disabled>
				</div>
			</div>

			<!-- 상품 소개 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 소개</label>
				</div>
				<div class="form_section_content bit">
					<textarea name="intro" id="intro_textarea">${productInfo.intro}</textarea>
				</div>
			</div>

			<!-- 이미지 출력 태그 -->
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이미지</label>
				</div>
				<div class="form_section_content">
					<div id="uploadReslut">
					</div>
				</div>
			</div>

			<div class="btn_section">
				<button id="cancelBtn" class="btn btn-primary">상품 목록</button>
				<button id="modifyBtn" class="btn btn-primary product_btn">수정</button>
			</div>

		</div>

		<form id="moveForm" action="/admin/productManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
		</form>

	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script>

$(document).ready(function(){

	/* 할인율 값 삽입 */
	let discount = '${productInfo.discount}' * 100; // DB에서 값을 가져와서 100을 곱한다 ex) 0.05 * 100 = 5
	$("#discount_interface").attr("value", discount); // ex) <input value="5">

	/* 출시일 값 가공 */
	let publeYear = '${productInfo.publeYear}'; // 2022-05-21 00:00:00.0

	// 인덱스 0번부터 찾기 시작해서 찾는 값의 인덱스를 반환 찾는 값이 없으면 -1을 반환
	let length = publeYear.indexOf(" "); // 10

	publeYear = publeYear.substring(0, length); // 인덱스 0번 ~ 10-1번까지만 출력 0~9

	$("input[name='publeYear']").attr("value", publeYear); // ex) <input value="2022-05-15">

	/* 상품 소개(위지윅) */
	ClassicEditor
		.create(document.querySelector('#intro_textarea'))
		.then(editor => {
				editor.isReadOnly = true; // 위지윅을 사용한 경우 태그에 readonly,disabled속성을 줘도
										  //수정이 가능해서 위지윅 스크립트에  isReadOnly를 줘야 수정이 불가능 함
			})
		.catch(error=>{
			console.error(error);
		});

	/* 카테고리 */
	let cateList = JSON.parse('${cateList}'); // JSON데이터를 javascript객체로 변환

	let cate1Array = new Array(); // 대분류
	let cate2Array = new Array(); // 중분류
	let cate3Array = new Array(); // 소분류
	let cate1Obj = new Object();
	let cate2Obj = new Object();
	let cate3Obj = new Object();

	let cateSelect1 = $(".cate1");
	let cateSelect2 = $(".cate2");
	let cateSelect3 = $(".cate3");

	/* 카테고리 배열 초기화 메서드 */
	function makeCateArray(obj,array,cateList, tier){
		for(let i = 0; i < cateList.length; i++){
			if(cateList[i].tier === tier){
				obj = new Object();

				obj.cateName = cateList[i].cateName;
				obj.cateCode = cateList[i].cateCode;
				obj.cateParent = cateList[i].cateParent;

				array.push(obj);

			}
		}
	}

	/* 배열 초기화 */
	makeCateArray(cate1Obj,cate1Array,cateList,1);
	makeCateArray(cate2Obj,cate2Array,cateList,2);
	makeCateArray(cate3Obj,cate3Array,cateList,3);

	let targetCate2 = '';
	let targetCate3 = '${productInfo.cateCode}'; // 소분류 cateConde ex)202001

	/* 소분류 */
	// targetCate3에는 cateCode만 저장되어 있는데 cateParent, cateName도 포함하기 위한 코드
	for(let i = 0; i < cate3Array.length; i++){
		if(targetCate3 === cate3Array[i].cateCode){
			targetCate3 = cate3Array[i];
		}
	}

	for(let i = 0; i < cate3Array.length; i++){
		if(targetCate3.cateParent === cate3Array[i].cateParent){
			// ex) <option value="202001">치마</option>
			cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
		}
	}

	// 클래스명이 cate3인 하위에 있는 <option>태그 갯수 만큼 반복
	$(".cate3 option").each(function(i,obj){ // i = index, obj = 해당 선택자의 객체 ex) <option value="202001">치마</option>
		if(targetCate3.cateCode === obj.value){ // 202001 === <option value="202001">치마</option>
			$(obj).attr("selected", "selected"); // seleced속성 추가 <option value="202001" selected="selected">치마</option>
		}
			console.log(i);
			console.log(obj); // <option value="202001">
	});

	/* 중분류 */
	// DB에서 가져온 소분류의 cateParent를 중분류랑 비교해서 true면 cate2Array값을 targetCate2에 저장
	for(let i = 0; i < cate2Array.length; i++){
		if(targetCate3.cateParent === cate2Array[i].cateCode){ // 202000 === 202000
			targetCate2 = cate2Array[i];
		}
	}

	for(let i = 0; i < cate2Array.length; i++){
		if(targetCate2.cateParent === cate2Array[i].cateParent){ // 200000 === 200000
			// ex) <option value="200000">하의</option>
			cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
		}
	}

	$(".cate2 option").each(function(i,obj){
		if(targetCate2.cateCode === obj.value){
			$(obj).attr("selected", "selected");
		}
	});

	/* 대분류 */
	for(let i = 0; i < cate1Array.length; i++){
		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
	}

	$(".cate1 option").each(function(i,obj){
		if(targetCate2.cateParent === obj.value){
			$(obj).attr("selected", "selected");
		}
	});

	/* 이미지 정보 호출 */
	let id = '<c:out value="${productInfo.id}"/>';
	let uploadReslut = $("#uploadReslut");

	// getJSON() : GET 방식으로 요청 및 응답을 하는 서버로부터 JSON으로 인코딩 된 데이터를 전달받기 위해 사용
	// 첫 번째 인자로는 서버에 요청할 GET방식의 url을
	// 두 번째 인자는 서버에 요청을 할 때 전달할 데이터
	// 세 번째 인자는 성공적으로 서버로부터 데이터를 전달받았을 때 실행할 콜백함수를 작성
	$.getJSON("/getAttachList", {id : id}, function(arr){

		if(arr.length === 0){ // 이미지 없을 경우 실행

			let str = "";
			str += "<div id='result_card'>";
			str += "<img src='/resources/img/이미지 없음.png'>";
			str += "</div>";

			uploadReslut.html(str);

			return;
		}

		let str = "";
		let obj = arr[0];

		// str 변수에 uploadResult 태그에 삽입될 코드를 값으로 부여
		let fileCallPath = encodeURIComponent(obj.uploadPath + "/thumbnail_" + obj.uuid + "_" + obj.fileName);
		str += "<div id='result_card'";
		str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
		str += ">";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "</div>";

		// html() 메서드를 사용해서 str변수에 저장된 값들이 uploadReuslt 태그 내부에 추가
		uploadReslut.html(str);

	});// GetJSON

}); // $(document).ready

/* 상품 목록 이동 버튼 */
$("#cancelBtn").on("click", function(e){
	e.preventDefault();
	$("#moveForm").submit();
});

/* 수정 페이지 이동 버튼 */
$("#modifyBtn").on("click", function(e){
	e.preventDefault();
	let addInput = '<input type="hidden" name="id" value="${productInfo.id}">'; // 상품 id값을 controller로 넘기기 위함
	$("#moveForm").append(addInput);
	$("#moveForm").attr("action", "/admin/productModify");
	$("#moveForm").submit();
});

</script>
</body>
</html>