<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/css/includes/header.css">

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

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<!-- slick js -->
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- daum 주소 서비스 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
</style>

</head>
<body>

	<header class="d-flex p-3 bg-dark text-white">
		<div class="container">
		<a class="" href="/">
		<img class="logo-img" src="/resources/img/logo.PNG">
		</a>
			<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">

				<ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
					<!-- gnb : 로그인한 상태 -->
					<c:if test="${member != null }">
						<c:if test="${member.adminCk == 1 }">
							<li class="ms-3"><a class="gnb" href="/admin/main">관리자</a></li>
						</c:if>
					</c:if>
					<li class="ms-3"><a class="gnb" href="/qna/qnaList">Q&amp;A</a></li>
					<li class="ms-3"><a class="gnb" href="/mypage/mypage">마이룸</a></li>
					<li class="ms-3"><a class="gnb" href="/cart/cart">장바구니</a></li>
				</ul>

				<form action="/search" method="get"
					class="d-flex col-12 col-lg-auto mb-3 mb-lg-0 me-lg-1">
					<input name="type" value="T" hidden="hidden">
					<input type="text" name="keyword"
						class="form-control form-control-dark text-white bg-dark me-1" placeholder="Search...">
					<button style="width: 100px;" class="btn btn-warning me-2">검색</button>
				</form>

				<div class="text-end d-flex">
					<!-- gnb : 비 로그인한 상태 -->
					<c:if test="${member == null}">
						<li class="ms-2 btn btn-outline-light">
							<a class="gnb"class="" href="/member/login">로그인</a>
						</li>
						<li class="ms-2 btn btn-outline-light">
							<a class="gnb" href="/member/join">회원가입</a>
						</li>
					</c:if>

					<!-- gnb : 로그인한 상태 -->
					<c:if test="${member != null }">
						<li class="ms-2 btn btn-outline-light">
							<a class="gnb" id="gnb_logout_button" href="/member/logout.do">로그아웃</a>
						</li>
					</c:if>
				</div>



			</div>
		</div>

	</header>

