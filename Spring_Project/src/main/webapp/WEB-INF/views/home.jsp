

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ include file="./includes/header.jsp" %>

<br>
<link rel="stylesheet" href="/resources/css/home.css" type="text/css">    
<script>
$(function() {
	let msg = "${msg}";
	if(msg == "") {
		return;
		}
	let txt;
	if(msg === "logout"){
		txt = "로그아웃 되었습니다.";
		history.replaceState(null, null, location.pathname);
	}
	alert(txt);
});

$(document).ready(function() {
    var slideContents = $("#slider");
    var slideImages = $(".slide-image");
    var currentIndex = 0;

    // 첫 번째 이미지 표시
    slideImages.eq(currentIndex).addClass("active");

    // 이미지 전환 함수
    function slideShow() {
        currentIndex = (currentIndex + 1) % slideImages.length;
        slideContents.css("transform", "translateX(-" + currentIndex * 33.33 + "%)");
    }

    // 3초마다 이미지 전환
    setInterval(slideShow, 3000);
});

</script>

<%-- <h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<br>
 --%>
<div class="wrapper_main">
	<div id="slide">
		<div class="slider" id="slider">
				<a href="/"><img class="slide-image" src="./resources/img/slide1.jpeg" alt="슬라이드1"></a>
	            <a href="/"><img class="slide-image" src="./resources/img/slide2.jpeg" alt="슬라이드2"></a>
	            <a href="/"><img class="slide-image" src="./resources/img/slide3.jpeg" alt="슬라이드3"></a>
		</div>
	</div>
	<%-- <div class="itemWrap" id="itemWrap">
		<c:forEach items="${list }" var="item">
			<div class="item" id="item">
				<div class="imgBox" id="imgBox">
					<img src="${item.src }" id="item_img"/>
				</div>
					<p>이름 : ${item.title }</p>
					<p>인기 : ${item.rank }</p>
			</div>
		</c:forEach>
	</div> --%>
</div>

<%@include file="./includes/footer.jsp" %>