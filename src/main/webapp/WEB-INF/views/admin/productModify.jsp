<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 페이지</title>

<link rel="stylesheet" href="../resources/css/admin/productModify.css">


</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">

		<div class="admin_content_subject">
			<span>상품 등록</span>
		</div>

		<div class="admin_content_main">
			<form action="/admin/productModify.do" method="post" id="modifyForm">

				<!-- 상품 이름 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 이름</label>
					</div>
					<div class="form_section_content">
						<input name="name" value="${productInfo.name}"> <span
							class="ck_warn name_warn">상품 이름을 입력해주세요.</span>
					</div>
				</div>

				<!-- 출시일 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 출시일</label>
					</div>
					<div class="form_section_content">
						<input name="publeYear" autocomplete="off" readonly="readonly">
						<span class="ck_warn publeYear_warn">출시일을 선택해주세요.</span>
					</div>
				</div>

				<!-- 카테고리 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>카테고리</label>
					</div>
					<div class="form_section_content">
						<div class="cate_wrap">
							<span>대분류</span> <select class="cate1">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>중분류</span> <select class="cate2">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>소분류</span> <select class="cate3" name="cateCode">
								<option selected value="none">선택</option>
							</select>
						</div>
						<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>
					</div>
				</div>

				<!-- 상품 가격 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 가격</label>
					</div>
					<div class="form_section_content">
						<input name="price" value="${productInfo.price}"> <span
							class="ck_warn price_warn">상품 가격을 입력해주세요.</span>
					</div>
				</div>

				<!-- 상품 재고 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 재고</label>
					</div>
					<div class="form_section_content">
						<input name="stock" value="${productInfo.stock}"> <span
							class="ck_warn stock_warn">상품 재고를 입력해주세요.</span>
					</div>
				</div>

				<!-- 상품 할인율 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 할인율</label>
					</div>
					<div class="form_section_content">
						<input id="discount_interface" maxlength="2" value="0">
						<input name="discount" type="hidden" value="${productInfo.discount}">
						<span class="step_val">
							할인 가격 : <span class="span_discount"></span>
						</span>
						<span class="ck_warn discount_warn">1~99 숫자를 입력해주세요.</span>
					</div>
				</div>

				<!-- 상품 소개 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 소개</label>
					</div>
					<div class="form_section_content bit">
						<textarea name="intro" id="intro_textarea">${productInfo.intro}</textarea>
						<span class="ck_warn intro_warn">상품 소개를 입력해주세요.</span>
					</div>
				</div>

				<div class="form_section">
           			<div class="form_section_title">
           				<label>상품 이미지</label>
           			</div>
           			<div class="form_section_content">
						<input type="file" id ="fileItem" name='uploadFile' style="height: 50px;">
						<div id="uploadResult">
						</div>
           			</div>
           		</div>

				<input type="hidden" name='id' value="${productInfo.id}">

			</form>

			<div class="btn_section">
				<button id="cancelBtn" class="btn btn-primary">취 소</button>
				<button id="modifyBtn" class="btn btn-primary modify_btn">수 정</button>
				<button id="deleteBtn" class="btn btn-danger delete_btn">삭 제</button>
			</div>

		</div>

		<form id="moveForm" action="/admin/productManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
			<input type="hidden" name='id' value="${productInfo.id}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script>

$(document).ready(function(){

	/* 위지윅 적용 */
	/* 책 소개 */
	ClassicEditor
		.create(document.querySelector('#intro_textarea'))
		.catch(error=>{
			console.error(error);
		});

	/* 캘린더 위젯 적용 */
	/* 설정 */
	const config = {
		dateFormat: 'yy-mm-dd', // 날짜 포맷
		showOn : "button",      // 버튼기능 추가
		buttonText:"날짜 선택",   // 버튼 이름 지정

		/* 한글화 */
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
	    changeYear: true, // <select>형식으로 변환
		changeMonth: true
	}
	/* 캘린더 */
	// <input>태그에 value값을 줘도 2022-05-04 00:00:00.0 이런식으로 출력됨
	// 2022-05-04 이런식으로 포맷형식 변경
	$(function() {
		let publeYear = '${productInfo.publeYear}';
		let puble_length = publeYear.indexOf(" "); // 10
		publeYear = publeYear.substring(0, puble_length); // 0 ~ (10-1)
		$( "input[name='publeYear']" ).datepicker(config); // 달력위젯 기능 추가
		$( "input[name='publeYear']" ).datepicker('setDate', publeYear); // ex) 2022-05-04 출력
	});

	/* 카테고리 */
	let cateList = JSON.parse('${cateList}');

	let cate1Array = new Array();
	let cate2Array = new Array();
	let cate3Array = new Array();
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
	let targetCate3 = '${productInfo.cateCode}';

	/* 소분류 */
	for(let i = 0; i < cate3Array.length; i++){
		if(targetCate3 === cate3Array[i].cateCode){
			targetCate3 = cate3Array[i];
		}
	}// for

	for(let i = 0; i < cate3Array.length; i++){
		if(targetCate3.cateParent === cate3Array[i].cateParent){
			cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
		}
	}

	$(".cate3 option").each(function(i,obj){
		if(targetCate3.cateCode === obj.value){
			$(obj).attr("selected", "selected");
		}
	});

	/* 중분류 */
	for(let i = 0; i < cate2Array.length; i++){
		if(targetCate3.cateParent === cate2Array[i].cateCode){
			targetCate2 = cate2Array[i];
		}
	}// for

	for(let i = 0; i < cate2Array.length; i++){
		if(targetCate2.cateParent === cate2Array[i].cateParent){
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

	/* 기존 이미지 출력 */
	let id = '<c:out value="${productInfo.id}"/>';
	let uploadResult = $("#uploadResult");

	$.getJSON("/getAttachList", {id : id}, function(arr){

		console.log("arr : ",arr);

		if(arr.length === 0){


			let str = "";
			str += "<div id='result_card'>";
			str += "<img src='/resources/img/이미지 없음.png'>";
			str += "</div>";

			uploadResult.html(str);
			return;
		}

		let str = "";
		let obj = arr[0];

		let fileCallPath = encodeURIComponent(obj.uploadPath + "/thumbnail_" + obj.uuid + "_" + obj.fileName);
		str += "<div id='result_card'";
		str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
		str += ">";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
		str += "</div>";

		uploadResult.html(str);

	});// GetJSON

}); // $(document).ready

</script>

<script>
/* 카테고리 */
let cateList = JSON.parse('${cateList}');

let cate1Array = new Array();
let cate2Array = new Array();
let cate3Array = new Array();
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


/* 중분류 <option> 태그 */
$(cateSelect1).on("change",function(){

	let selectVal1 = $(this).find("option:selected").val();

	cateSelect2.children().remove();
	cateSelect3.children().remove();

	cateSelect2.append("<option value='none'>선택</option>");
	cateSelect3.append("<option value='none'>선택</option>");

	for(let i = 0; i < cate2Array.length; i++){
		if(selectVal1 === cate2Array[i].cateParent){
			cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
		}
	}// for

});

/* 소분류 <option>태그 */
$(cateSelect2).on("change",function(){

	let selectVal2 = $(this).find("option:selected").val();

	cateSelect3.children().remove();

	cateSelect3.append("<option value='none'>선택</option>");

	for(let i = 0; i < cate3Array.length; i++){
		if(selectVal2 === cate3Array[i].cateParent){
			cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
		}
	}// for

});

/* 할인율 인터페이스 출력 */
let priceInput = $("input[name='price']");
let discountInput = $("input[name='discount']");
let price = priceInput.val();                    // ex) 50000 상품가격
let rawDiscountRate = discountInput.val();       // ex) 0.05  상품 할인율
let discountRate = rawDiscountRate * 100;        // ex) 0.05 * 100 = 5

let discountPrice = price * (1-rawDiscountRate); // ex) 50000 * (1 - 0.05) = 47500
$(".span_discount").html(discountPrice);         // 할인된 가격 출력
$("#discount_interface").val(discountRate);      // 할인율 출력


/* 할인율 Input 설정 */
// 사용자가 할인율을 변경 시 할인된 가격 출력
$("#discount_interface").on("propertychange change keyup paste input", function(){

	let userInput = $("#discount_interface");
	let discountInput = $("input[name='discount']");

	let discountRate = userInput.val();					// 사용자가 입력한 할인값 5
	let sendDiscountRate = discountRate / 100;			// 서버에 전송할 할인값 0.05
	let price = $("input[name='price']").val();			// 원가 50000
	let discountPrice = price * (1 - sendDiscountRate);	// 할인가격 47500

	if(!isNaN(discountRate)){                      // 숫자인 경우
		$(".span_discount").html(discountPrice);   // 할인가격 출력
		discountInput.val(sendDiscountRate);
	}

});
// 사용자가 가격을 변경 시 할인된 가격 출력
$("input[name='price']").on("change", function(){

	let userInput = $("#discount_interface");
	let discountInput = $("input[name='discount']");

	let discountRate = userInput.val();					// 사용자가 입력한 할인값
	let sendDiscountRate = discountRate / 100;			// 서버에 전송할 할인값
	let price = $("input[name='price']").val();			// 원가
	let discountPrice = price * (1 - sendDiscountRate); // 할인가격

	if(!isNaN(discountRate)){
		$(".span_discount").html(discountPrice);
	}

});

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
	moveForm.append('<input type="hidden" name="id" value="${productInfo.id}">');
	moveForm.attr("action", "/admin/productDelete");
	moveForm.attr("method", "post");
	moveForm.submit();
});

/* 수정 버튼 */
$("#modifyBtn").on("click",function(e){

	e.preventDefault();

	/* 체크 변수 */
	let nameCk = false;
	let publeYearCk = false;
	let cateCodeCk = false;
	let priceCk = false;
	let stockCk = false;
	let discountCk = false;
	let introCk = false;

	/* 체크 대상 변수 */
	let name = $("input[name='name']").val();
	let publeYear = $("input[name='publeYear']").val();
	let cateCode = $("select[name='cateCode']").val();
	let price = $("input[name='price']").val();
	let stock = $("input[name='stock']").val();
	let discount = $("#discount_interface").val();
	let intro = $(".bit p").html();

	/* 공란 체크 */
	if(name){
		$(".name_warn").css('display','none');
		nameCk = true;
	} else {
		$(".name_warn").css('display','block');
		nameCk = false;
	}

	if(publeYear){
		$(".publeYear_warn").css('display','none');
		publeYearCk = true;
	} else {
		$(".publeYear_warn").css('display','block');
		publeYearCk = false;
	}

	if(cateCode != 'none'){
		$(".cateCode_warn").css('display','none');
		cateCodeCk = true;
	} else {
		$(".cateCode_warn").css('display','block');
		cateCodeCk = false;
	}

	if(price != 0){
		$(".price_warn").css('display','none');
		priceCk = true;
	} else {
		$(".price_warn").css('display','block');
		priceCk = false;
	}

	if(stock != 0){
		$(".stock_warn").css('display','none');
		stockCk = true;
	} else {
		$(".stock_warn").css('display','block');
		stockCk = false;
	}

	if(!isNaN(discount)){
		$(".discount_warn").css('display','none');
		discountCk = true;
	} else {
		$(".discount_warn").css('display','block');
		discountCk = false;
	}

	if(intro != '<br data-cke-filler="true">'){
		$(".intro_warn").css('display','none');
		introCk = true;
	} else {
		$(".intro_warn").css('display','block');
		introCk = false;
	}

	/* 최종 확인 */
	if(nameCk && publeYearCk && cateCodeCk && priceCk && stockCk && discountCk && introCk){
		//alert('통과');
		$("#modifyForm").submit();
	} else {
		return false;
	}

});

/* 이미지 삭제 버튼 동작 */
$("#uploadResult").on("click", ".imgDeleteBtn", function(e){

	deleteFile();

});

/* 파일 삭제 메서드 */
function deleteFile(){

	$("#result_card").remove();
}

/* 이미지 업로드 */
$("input[type='file']").on("change", function(e){

	/* 이미지 존재시 삭제 */
	if($("#result_card").length > 0){
		deleteFile();
	}

	let formData = new FormData();
	let fileInput = $('input[name="uploadFile"]');
	let fileList = fileInput[0].files;
	let fileObj = fileList[0];

	if(!fileCheck(fileObj.name, fileObj.size)){
		return false;
	}

	formData.append("uploadFile", fileObj);

	$.ajax({
		url: '/admin/uploadAjaxAction',
    	processData : false,
    	contentType : false,
    	data : formData,
    	type : 'POST',
    	dataType : 'json',
    	success : function(result){
    		console.log(result);
    		showUploadImage(result);
    	},
    	error : function(result){
    		alert("이미지 파일이 아닙니다.");
    	}
	});

});

/* var, method related with attachFile */
let regex = new RegExp("(.*?)\.(jpg|png|jpeg)$");
let maxSize = 1048576; //1MB

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}

	if(!regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}

	return true;

}

/* 이미지 출력 */
function showUploadImage(uploadResultArr){

	/* 전달받은 데이터 검증 */
	if(!uploadResultArr || uploadResultArr.length == 0){return}

	let uploadResult = $("#uploadResult");

	let obj = uploadResultArr[0];

	let str = "";

	let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/thumbnail_" + obj.uuid + "_" + obj.fileName);

	str += "<div id='result_card'>";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
	str += "</div>";

	uploadResult.append(str);

}

</script>
</body>
</html>