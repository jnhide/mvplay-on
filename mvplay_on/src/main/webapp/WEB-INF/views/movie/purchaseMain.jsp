<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독 페이지</title>
<link rel="stylesheet" href="../resources/css/main.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<!-- slide js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<style type="text/css">
	img.icon {
		width: 70px;
		height: 70px;
		object-fit: contain;
		margin-left: 8px;
	}
		img.ricon {
		width: 50px;
		height: 50px;
		object-fit: contain;
		margin-left: 8px;
	}
</style>
</head>
<body>
<div id = "container">
	<!-- 헤더 -->
 	<%@include file="../includes/header.jsp" %>
 		<%@include file="../includes/nav.jsp" %>
		<div class="main_content">
			<div class="show_list">
				 <section class="list"> <!-- 영화 신작 -->
					 <c:if test="${listcheck != 'empty'}">
					 
					 <c:forEach items="${cate1List}" var="cate1List">
						<h1 class="list_name"><c:out value='${cate1List.cate1}'/><img src="/resources/icon/${cate1List.cate1}.png" class="icon"></h1>
						<div class="swiper-container swiper1">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<c:forEach items="${movieList}" var="movieList">
										<c:if test="${movieList.cate1==cate1List.cate1}">
											<ul>
												<li>
													<a class="move" href="/movie/movieDetail?movieId=${movieList.movieId}">

														<img src="/resources/img/${movieList.poster}" class="poster">
													</a>
												</li>
												<li class="subject">
													<a class="move" href="/movie/movieDetail?movieId=${movieList.movieId}">
														<c:out value="${movieList.movieTitle}"></c:out><br>
													</a>
												</li>
												<li class="iinn">
													<img class="star_rate" src="/resources/icon/star-fill.svg">
													<span class="r"><fmt:formatNumber value="${movieList.rating}" pattern="0.0#" /></span>
													<span class="c"><c:out value="${movieList.cate1}"></c:out></span>
												</li>		
											</ul>
											</c:if>
										
										</c:forEach><!-- 영화 리스트 end -->
										
										
									</div>
								</div> <!-- swiper-wrapper -->
								<br><br>
						</div> <!-- swiper-container -->	
						</c:forEach><!-- 카테고리 end -->
					</c:if>
				</section>
				<section class="list">  <!-- 영화 랭킹 -->
					<c:if test="${listcheck != 'empty'}">
					<h1 class="list_name">Ranking</h1>
						<div class="swiper-container swiper2">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<c:forEach items="${movieRank}" var="movieRank" end="6">
										<ul>
											<li>
												<a class="move" href="/movie/movieDetail?movieId=${movieRank.movieId}">
													<img src="/resources/img/${movieRank.poster}" class="poster">
												</a>
											</li>
											<li class="subject">
												<a class="move" href="/movie/movieDetail?movieId=${movieRank.movieId}">
													<c:out value="${movieRank.movieTitle}"></c:out><br>
												</a>
											</li>
											<li class="iinn">
												<img class="star_rate" src="/resources/icon/star-fill.svg">
												<span class="r"><c:out value="${movieRank.rating}"></c:out></span>
												<span class="c"><c:out value="${movieRank.cate1}"></c:out></span>
											</li>		
										</ul>
									</c:forEach>
								</div>
							</div>
						</div> <!-- swiper2 -->
					</c:if>
				</section>
			</div> <!-- showlist -->
		</div> <!-- main-content -->
	<!-- FOOTER -->
	<%@include file="../includes/footer.jsp" %>
</div>  <!-- id="container" -->


<!-- swiper script -->
<script>
document.addEventListener("DOMContentLoaded", function() {

    var mySwiper = new Swiper('.swiper-container', {
        slidesPerView: 6,
        slidesPerGroup: 6,
        observer: true,
        observeParents: true,
        spaceBetween: 20,
        /* centeredSlides : true, */
        
    	loopFillGroupWithBlank : true,

    	loop : false, //true 무한 반복
    	
        breakpoints: {
            1280: {
                slidesPerView: 4,
                slidesPerGroup: 4,
            },
            720: {
                slidesPerView: 2,
                slidesPerGroup: 2,
            }
        }
    });
    
});
</script>
</body>
</html>
