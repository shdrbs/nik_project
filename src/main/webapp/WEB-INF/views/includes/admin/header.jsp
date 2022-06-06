<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/carousel/">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">

<!-- slick css-->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

<!-- google material(icon) -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- 위지윅 -->
<script src="https://cdn.ckeditor.com/ckeditor5/34.1.0/classic/ckeditor.js"></script>


<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<!-- slick js -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- 달력위젯 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- Favicons -->
<link rel="apple-touch-icon"
	href="/docs/5.2/assets/img/favicons/apple-touch-icon.png"
	sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png"
	sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png"
	sizes="16x16" type="image/png">
<link rel="mask-icon"
	href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg"
	color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">


<style>
@media ( min-width : 768px) { .bd-placeholder-img-lg { font-size: 3.5rem; } }
.b-example-divider { height: 3rem; background-color: rgba(0, 0, 0, .1); border: solid rgba(0, 0, 0, .15); border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15); }
.b-example-vr { flex-shrink: 0; width: 1.5rem; height: 100vh; }
.bi { vertical-align: -.125em; fill: currentColor; }
.nav-scroller { position: relative; z-index: 2; height: 2.75rem; overflow-y: hidden; }
.nav-scroller .nav { display: flex; flex-wrap: nowrap; padding-bottom: 1rem; margin-top: -1px; overflow-x: auto;
	text-align: center; white-space: nowrap; -webkit-overflow-scrolling: touch; }

.carousel-control-next, .carousel-control-prev {width: 15%; height: 15%; top: 45%;}
.carousel-control-next-icon, .carousel-control-prev-icon {width: 4rem; height: 4rem;}

.wrapper{width:100%; min-height: 80%; position: relative;}
.footer_wrap{bottom: 0;}
</style>

</head>
<body>

<div class="wrapper">

		<!-- gnv_area -->
		<div class="top_gnb_area">
			<ul class="list">
				<li><a class="admin_gnb_top" href="/">메인 페이지</a></li>
				<li><a class="admin_gnb_top" href="/member/logout.do">로그아웃</a></li>
				<li><a class="admin_gnb_top" href="/qna/qnaList">Q&amp;A</a></li>
			</ul>
		</div>
	<div class="wrap">

		<!-- top_subject_area -->
		<div class="admin_top_wrap">
			<span>관리자 페이지</span>

		</div>
		<!-- contents-area -->
		<div class="admin_wrap">

			<!-- 네비영역 -->
			<div class="admin_navi_wrap">
				<ul>
					<li><a class="admin_list_01" href="/admin/productRegist">상품등록</a></li>
					<li><a class="admin_list_02" href="/admin/productManage">상품관리</a></li>
					<lI><a class="admin_list_05" href="/admin/memberManage">회원 관리</a></lI>
					<li><a class="admin_list_06" href="/admin/orderList">주문 현황</a></li>
				</ul>
			</div>


