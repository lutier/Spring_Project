<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<title>Spring Project</title>
</head>
<body>
	<div class="container">
		<div class="wrapper">
			<div class="wrapper_head">
				<div class="wrapper_title">
					<span>Spring Project</span>
				</div>
				<nav class="wrapper_menu">
					<a href="/"><span class="menu-item">홈</span></a>
					<a href="/board/list"><span class="menu-item">게시판</span></a>
					<c:choose>
						<c:when test="${not empty auth }">
							&nbsp;&nbsp;환영합니다.&nbsp;<c:out value="${auth.user_name }"/>님&nbsp;&nbsp;&nbsp;
							<a href="/member/logout"><span class="menu-item">로그아웃</span></a>
						</c:when>
						<c:otherwise>
							<a href="/member/login"><span class="menu-item">로그인</span></a>
							<a href="/member/signup"><span class="menu-item">회원가입</span></a>
						</c:otherwise>
					</c:choose>
				</nav>
			</div>
			--------------------------------------------------------------------------------------