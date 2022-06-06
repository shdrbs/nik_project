<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/productRegist.css">



<style type="text/css">
#result_card img{
	max-width: 100%;
    height: auto;
    display: block;
    padding: 5px;
    margin-top: 10px;
    margin: auto;
}
#result_card {
	position: relative;
}
.imgDeleteBtn{
    position: absolute;
    top: 0;
    right: 5%;
    background-color: #ef7d7d;
    color: wheat;
    font-weight: 900;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    line-height: 26px;
    text-align: center;
    border: none;
    display: block;
    cursor: pointer;
}

</style>

</head>

<body>
	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">

		<div class="admin_content_subject">
			<span>상품 등록</span>
		</div>

		<div class="admin_content_main">

			<form action="/admin/productRegist.do" method="post" id="registForm">

				<!-- 상품 이름 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 이름</label>
					</div>
					<div class="form_section_content">
						<input name="name">
						<span class="ck_warn name_warn">상품 이름을 입력해주세요.</span>
					</div>
				</div>
				<!-- //상품 이름 -->

				<!-- 상품 출시일 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 출시일</label>
					</div>
					<div class="form_section_content">
						<input name="publeYear" autocomplete="off" readonly="readonly">
						<span class="ck_warn publeYear_warn">상품 출시일을 선택해주세요.</span>
					</div>
				</div>
				<!-- //상품 출시일 -->

				<!-- 카테고리 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>카테고리</label>
					</div>
					<div class="form_section_content">
						<div class="cate_wrap">
							<span>대분류</span>
							<select class="cate1">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>중분류</span>
							<select class="cate2">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>소분류</span>
							<select class="cate3" name="cateCode">
								<option selected value="none">선택</option>
							</select>
						</div>
						<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>
					</div>
				</div>
				<!-- //카테고리 -->

				<!-- 상품 가격 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 가격</label>
					</div>
					<div class="form_section_content">
						<input name="price" placeholder="0">
						<span class="ck_warn price_warn">상품 가격을 입력해주세요.</span>
					</div>
				</div>
				<!-- //상품 가격 -->

				<!-- 상품 재고 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 재고</label>
					</div>
					<div class="form_section_content">
						<input name="stock" placeholder="0">
						<span class="ck_warn stock_warn">상품 재고를 입력해주세요.</span>
					</div>
				</div>
				<!-- //상품 재고 -->

				<!-- 상품 할인율 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 할인율</label>
					</div>
					<div class="form_section_content">
						<input id="discount_interface" maxlength="2" placeholder="0">
						<input name="discount" type="hidden" value="0">
						<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
						<span class="ck_warn discount_warn">1~99 숫자를 입력해주세요.</span>
					</div>
				</div>
				<!-- //상품 할인율 -->

				<!-- 상품 소개 -->
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 소개</label>
					</div>
					<div class="form_section_content bit">
						<textarea name="intro" id="intro_textarea"></textarea>
						<span class="ck_warn intro_warn">책 소개를 입력해주세요.</span>
					</div>
				</div>
				<!-- //상품 소개 -->

				<!-- 상품 이미지 업로드 -->
				<div class="form_section">
          			<div class="form_section_title">
          				<label>상품 이미지</label>
          			</div>
          			<div class="form_section_content">
						<input type="file" id ="fileItem" name='uploadFile' style="height: 50px;">
						<div id="uploadResult">
							<!-- <div id="result_card">
								<div class="imgDeleteBtn">x</div>
								<img src="/resources/img/sLogo.png">
							</div> -->
						</div>
          			</div>
          		</div>

			</form>

			<div class="btn_section">
				<button id="cancelBtn" class="btn btn-danger">취 소</button>
				<button id="registBtn" class="btn btn-primary regist_btn">등 록</button>
			</div>

		</div>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script>

let registForm = $("#registForm")

/* 취소 버튼 */
$("#cancelBtn").click(function() {

	location.href = "/admin/productManage"

});

/* 상품 등록 버튼 */
$("#registBtn").on("click", function(e) {

	e.preventDefault();

	/* 체크 변수 */
	let nameCk = false;       // 상품 이름
	let publeYearCk = false;  // 상품 출시일
	let cateCodeCk = false;   // 카테고리
	let priceCk = false;      // 상품 가격
	let stockCk = false;      // 상품 재고
	let discountCk = false;   // 상품 할인율
	let introCk = false;      // 상품 소개

	/* 체크 대상 변수 */
	let name = $("input[name='name']").val();
	let publeYear = $("input[name='publeYear']").val();
	let cateCode = $("select[name='cateCode']").val();
	let price = $("input[name='price']").val();
	let stock = $("input[name='stock']").val();
	let discount = $("#discount_interface").val();
	let intro = $(".bit p").html();

	/* 상품 등록 유효성 검사(공란 검사) */
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

	if(!isNaN(discount)){ //isNaN(value) : 매개변수가 숫자이면 false 아니면 true를 반환
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

	if(nameCk && publeYearCk && cateCodeCk && priceCk && stockCk && discountCk && introCk) {
		//alert('통과');
		registForm.submit();
	} else {
		return false;
	}

});

/* 위지윅 적용 */
ClassicEditor
	.create(document.querySelector('#intro_textarea'))
	.catch(error=> {
		console.error(error);
	});

/* 달력 위젯(DatePicker) 적용 */
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

/* 달력 */
$(function() {
	$( "input[name='publeYear']" ).datepicker(config);
});

/* 카테고리  */
let cateList = JSON.parse('${cateList}'); // JSON데이터를 javascript객체로 변환

let cate1Array = new Array(); // 남성, 여성
let cate2Array = new Array(); // 상의, 하의, 신발
let cate3Array = new Array(); // 반팔, 셔츠, 바지, 치마 등..
let cate1Obj = new Object();
let cate2Obj = new Object();
let cate3Obj = new Object();

let cateSelect1 = $(".cate1");
let cateSelect2 = $(".cate2");
let cateSelect3 = $(".cate3");

/* 카테고리 배열 초기화 메서드 */
function makeCateArray(obj, array, cateList, tier){
	for(let i = 0; i < cateList.length; i++){
		if(cateList[i].tier === tier){ // 타입비교
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

/* $(document).ready(function(){
	console.log(cate1Array);
	console.log(cate2Array);
	console.log(cate3Array);
}); */

/* 대분류 <option> 태그 */
for(let i = 0; i < cate1Array.length; i++){
	cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
}

/* 중분류 <option> 태그 */
$(cateSelect1).on("change",function(){ // 대분류(cateSelect1)가 사용(선택)되면 실행

	// 선택된 대분류의 selected값을 selectVal1에 저장
	let selectVal1 = $(this).find("option:selected").val(); // ex) 100000

	cateSelect2.children().remove(); 						 // 중분류(cateSelect2)의 자식요소(<option>태그)를 지운다
	cateSelect2.append("<option value='none'>선택</option>"); // 중분류(cateSelect2)에 다시 <option>태그 추가

	cateSelect3.children().remove();                         // 소분류(cateSelect3)의 자식요소(<option>태그)를 지운다
	cateSelect3.append("<option value='none'>선택</option>"); // 소분류(cateSelect3)에 다시 <option>태그 추가

	for(let i = 0; i < cate2Array.length; i++){
		if(selectVal1 === cate2Array[i].cateParent){
			cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
		}
	}
});

/* 소분류 <option>태그 */
$(cateSelect2).on("change",function(){ // 중분류(cateSelect2)가 사용(선택)되면 실행

	let selectVal2 = $(this).find("option:selected").val(); // 선택된 중분류의 selected값을 selectVal2에 저장

	cateSelect3.children().remove();                         // cateSelect3의 자식요소(<option>태그)를 지운다
	cateSelect3.append("<option value='none'>선택</option>");	 // cateSelect3에 다시 <option>태그 추가

	for(let i = 0; i < cate3Array.length; i++){
		if(selectVal2 === cate3Array[i].cateParent){
			cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
		}
	}
});

/* 할인율 Input 설정 */
$("#discount_interface").on("propertychange change keyup paste input", function(){

	let userInput = $("#discount_interface");
	let discountInput = $("input[name='discount']");

	let discountRate = userInput.val();			          	 // 사용자가 입력할 할인값
	let sendDiscountRate = discountRate / 100;				 // 서버에 전송할 할인값
	let price = $("input[name='price']").val();	 	 		 // 원가
	let discountPrice = price * (1 - sendDiscountRate); 	 // 할인가격

	if(!isNaN(discountRate)){
		$(".span_discount").html(discountPrice);
		discountInput.val(sendDiscountRate);
	}
});
/* 상품가격,할인율 순으로 입력을 하고 다시 상품가격을 수정할 경우 할인된 가격이 바로 출력되도록 함 */
$("input[name='price']").on("change", function(){

	let userInput = $("#discount_interface");
	let discountInput = $("input[name='discount']");

	let discountRate = userInput.val();					     // 사용자가 입력한 할인값
	let sendDiscountRate = discountRate / 100;				 // 서버에 전송할 할인값
	let price = $("input[name='price']").val();	 			 // 원가
	let discountPrice = price * (1 - sendDiscountRate); 	 // 할인가격

	if(!isNaN(discountRate)){
		$(".span_discount").html(discountPrice);
	}
});

/* 파일 업로드 */
$("input[type='file']").on("change", function(e){

	/* 이미지 존재시 삭제 */
	if($(".imgDeleteBtn").length > 0){
		deleteFile();
	}

	let formData = new FormData();
	let fileInput = $('input[name="uploadFile"]');
	let fileList = fileInput[0].files; // "type이 file인 <input> 요소(element)"[0].files
	let fileObj = fileList[0];         // file 객체에 접근

	if(!fileCheck(fileObj.name, fileObj.size)){ // 파일이름이 .jpg, .png가 아니고 파일사이즈가 1M를 넘기면 false를 반환
		return false;
	}
	// key와 url 매핑 메서드의 매개변수명이 동일해야 함
	formData.append("uploadFile", fileObj); // true면 formData객체에 추가

	$.ajax({
		url: '/admin/uploadAjaxAction',   // 서버로 요청을 보낼 url
    	processData : false, 			  // 서버로 전송할 데이터를 queryStirng 형태로 변환할지 여부(false로 해여 서버로 파일이 전송 됨)
    	contentType : false,			  // 서버로 전송되는 데이터의 content-type(false로 해여 서버로 파일이 전송 됨)
    	data : formData,				  // 서버로 전송할 데이터
    	type : 'POST',					  // 서버 요청 타입(GET, POST)
    	dataType : 'json', 				  // 서버로부터 반환받을 데이터 타입
    	success : function(result){
    		console.log(result);
    		showUploadImage(result);      // 업로드한 이미지 데이터(filename, uuid, path)를 활용하여 이미지를 출력시키기 위함
    	},
    	error : function(result){
    		alert("이미지 파일이 아닙니다.");
    	}
	});

});

/* 파일 업로드 체크 */
let regex = new RegExp("(.*?)\.(jpg|png|jpeg)$"); // 파일 확장자명이 .jpg 또는 .png 파일만 허용
let maxSize = 1048576;                       // 파일의 크기는 1M로 제한

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){ //
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

	// id 속성 uploadResult인 <div> 태그 요소에 쉽게 접근하기 위해 변수를 선언 및 초기화
	let uploadResult = $("#uploadResult");

	// 서버에서 뷰로 반환할 때 List타입의 데이터를 전송했었고 뷰(view)에서는 해당 데이터를 배열 형태로 전달받는다
	let obj = uploadResultArr[0];

	let str = "";

	// encodeURIComponent() : 문자 A-Z a-z 0-9 - _ . ! ~ * ' ( )을 제외한 모든 문자를 UTF-8로 인코딩하여 이스케이프 문자로 변환
	// 이미지 출력을 요청하는 url 매핑 메서드("/display")에 전달해줄 파일의 경로와 이름을 포함하는 값을 저장하기 위한 변수
	// replace(/\\/g, '/') : 모든 '\'를 '/'로 치환
	// let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/thumbnail_" + obj.uuid + "_" + obj.fileName);
	let fileCallPath = encodeURIComponent(obj.uploadPath + "/thumbnail_" + obj.uuid + "_" + obj.fileName);

	//<div id="result_card">
	//	<img src="/display?fileName=2022/05/17/thumbnail_25233681-2606-44fd-b74b-e49a299ecc02_슬리퍼1.jpg>"
	//	<div class="imgDeleteBtn" data-file="2022/05/17/thumbnail_25233681-2606-44fd-b74b-e49a299ecc02_슬리퍼1.jpg">x</div>
	//</div>
	str += "<div id='result_card'>";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "</div>";

	str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";

	uploadResult.append(str);

}

/* 이미지 삭제 버튼 동작 */
// 'x'를 클릭하였을 때 동작을 하지 않는다
// 'x'가 출력되어 있는 <div> 태그는 웹 페이지가 완전히 렌더링 된 이후 Javascript 코드를 통해 새롭게 출력된(동적으로 출력된) 태그이기 때문
// 따라서 on()을 사용하여 아래와 같이 작성

// 기존 렌더링 될 때 추가되어 있는 '#uploadReulst" <div> 태그를 식별자로 하여 그 내부에 있는
// 'imgDeleteBtn' <div> 태그를 클릭(click) 하였을 때 콜백 함수가 호출된다는 의미
$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
	deleteFile();
});

/* 파일 삭제  */
function deleteFile(){

	let targetFile = $(".imgDeleteBtn").data("file");

	let targetDiv = $("#result_card");

	$.ajax({
		url: '/admin/deleteFile',
		data : {fileName : targetFile},
		dataType : 'text',
		type : 'POST',
		success : function(result){
			console.log(result);

			targetDiv.remove();
			$("input[type='file']").val("");

		},
		error : function(result){
			console.log(result);

			alert("파일을 삭제하지 못하였습니다.")
		}
	});
}

</script>

</body>
</html>
