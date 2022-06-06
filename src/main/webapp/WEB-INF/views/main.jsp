<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.98.0">
<title>Nik Mall</title>

<link rel="stylesheet" href="resources/css/main.css">

</head>

<body>

	<%@include file="includes/header.jsp"%>

	<!-- navi 영역 -->
	<div class="navi_bar_area clearfix">
		<div class="dropdown1">
			<button class="dropbtn">
				남성 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown1-content">
				<c:forEach items="${cate1}" var="cate">
    				<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
    			</c:forEach>
			</div>
		</div>
		<div class="dropdown1">
			<button class="dropbtn">
				여성 <i class="fa fa-caret-down"></i>
			</button>
			<div class="dropdown1-content">
				<c:forEach items="${cate2}" var="cate">
    				<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
    			</c:forEach>
			</div>
		</div>
	</div>

	<main>

	<div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#myCarousel"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#myCarousel"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#myCarousel"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img width="1920" height="500" class="mx-auto d-block img-fluid"
					src="resources/img/bg1.jpg">
			</div>
			<div class="carousel-item">
				<img width="1920" height="500" class="mx-auto d-block img-fluid"
					src="resources/img/bg2.jpg">
			</div>
			<div class="carousel-item">
				<img width="1920" height="500" class="mx-auto d-block img-fluid"
					src="resources/img/bg3.jpg">
			</div>
		</div>

		<button class="carousel-control-prev" type="button"
			data-bs-target="#myCarousel" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#myCarousel" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>

	<!-- Marketing messaging and featurettes
  ================================================== --> <!-- Wrap the rest of the page in another container to center all the content. -->

		<div style="height: 50px;"></div>

		<div class="ls_wrap">

			<div class="ls_div_subject">베스트 상품</div>

			<hr class="featurette-divider">

			<div class="ls_div">
				<c:forEach items="${ls}" var="ls">
					<a class="ls_a" href="/productDetail/${ls.id}">
						<div class="ls_div_content_wrap">
							<div class="ls_div_content">
								<div class="ls_product image_wrap"
									data-id="${ls.imageList[0].id}"
									data-path="${ls.imageList[0].uploadPath}"
									data-uuid="${ls.imageList[0].uuid}"
									data-filename="${ls.imageList[0].fileName}">
									<img class="img_thumbnail">
								</div>
								<div class="ls_category">${ls.cateName}</div>
								<div class="ls_rating">${ls.ratingAvg}</div>
								<div class="ls_name">${ls.name}</div>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>

		<div style="height: 60px;"></div>

		<div class="ls_wrap">

			<div class="ls_div_subject">신상품</div>

			<hr class="featurette-divider">

			<div class="ls_div">
				<c:forEach items="${newProduct}" var="np">
					<a class="ls_a" href="/productDetail/${np.id}">
						<div class="ls_div_content_wrap">
							<div class="ls_div_content">
								<div class="ls_product image_wrap"
									data-id="${np.imageList[0].id}"
									data-path="${np.imageList[0].uploadPath}"
									data-uuid="${np.imageList[0].uuid}"
									data-filename="${np.imageList[0].fileName}">
									<img class="img_thumbnail">
								</div>
								<div class="ls_category">${np.cateName}</div>
								<div class="ls_rating">${np.ratingAvg}</div>
								<div class="ls_name">${np.name}</div>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<!-- /END THE FEATURETTES -->


	</main>

	<%@include file="includes/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>


<script>
$(document).ready(function() {

	$(".ls_div").slick({

		slidesToShow: 5,
		slidesToScroll: 5,
		prevArrow : "<span class='ls_div_content_prev material-icons'>arrow_back_ios</span>", // 이전 화살표 모양 설정
		nextArrow : "<span class='ls_div_content_next material-icons'>arrow_forward_ios</span>", // 다음 화살표 모양 설정

	});

	/* 이미지 삽입 */
	$(".image_wrap") .each( function(i, obj) {

		const bobj = $(obj);

		if (bobj.data("id")) {
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");

			const fileCallPath = encodeURIComponent(uploadPath+ "/thumbnail_"+ uuid+ "_"+ fileName);

			$(this).find("img").attr('src','/display?fileName='+ fileCallPath);

		} else {

			$(this).find("img").attr('src','/resources/img/이미지 없음.png');
		}

	});

}); //$(document).ready

</script>

</body>
</html>
