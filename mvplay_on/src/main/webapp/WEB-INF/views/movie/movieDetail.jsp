<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVPlayer</title>
<link rel="stylesheet" href="../resources/css/movie/movietest.css">
<link rel="stylesheet" href="../resources/css/main.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script>

</script>  
  
</head>
<body>
<div id = "container">
<form id="moveForm" action="/admin/movieDetail" method="get">
   <input type="hidden" name="pageNum" value="${page.cri.pageNum}">
   <input type="hidden" name="amount" value="${page.cri.amount}">
   <input type="hidden" name="keyword" value="${page.cri.keyword}">
</form>
<input type="hidden" value="${movieInfo.movieId}" name="movieId">
<input type="hidden" value="${movieInfo.movieCheck}" name="movieCheck">
	<!-- 헤더 -->
	<header>
		<%@include file="../includes/header.jsp" %>
	</header>
		<!-- 네비 (왼쪽 사이드 메뉴) -->
		<nav>
		<%@include file="../includes/nav.jsp" %>
		</nav>
		<!-- 메인 content -->
		<div class="main_content">
			<div class="posterFrame">
				<div class="poster">
					<c:if test="${movieInfo.poster != null}">
						<!-- <img src="/resources/img/${movieInfo.poster}" width="300px"> -->
						<img class="moviePoster" alt="영화 포스터" src="/resources/img/${movieInfo.poster}" width="300px">
					</c:if>
					<c:if test="${movieInfo.poster == null}">
						<img class="moviePoster" alt="임시 포스터" src="/resources/img/noimg.png" width="300px">
					</c:if>
				</div>
				
				<div class="textArea_movieInfo">
					<div class="inlineBlock">
						<!-- 영화 제목 -->
						<h1 class="movieTitle">${movieInfo.movieTitle}</h1>
					</div>
					<!-- 권한 체크 용도 -->
					<div style="padding-bottom:10px; color: #f82f62;">
					<c:choose>
								<c:when test="${movieInfo.movieCheck == 0 }">
								* 구독 가능한 영화입니다.
								</c:when>
								<c:when test="${movieInfo.movieCheck == 1 }">
								* 구매만 가능한 영화입니다.
								</c:when>
								<c:when test="${movieInfo.movieCheck == 2 }">
								* 대여만 가능한 영화입니다.
								</c:when>
								<c:when test="${movieInfo.movieCheck == 3 }">
								* 구매/대여 가능한 영화입니다.
								</c:when>
							</c:choose>
					</div>
					<div class="info"> 
						<ul>
							<!-- 영화 평점 -->
							<li class="star">
								<label>평균 <fmt:formatNumber value="${movieInfo.rating}" pattern="0.0"></fmt:formatNumber>점</label>
							</li>
							<!-- 영화 개봉일 -->
							<li>
								<fmt:formatDate value="${movieInfo.movieDate}" pattern="yyyy년"></fmt:formatDate>
							</li>
							<!-- 영화 장르 -->
							<li>
								<c:out value="${movieInfo.cate1}"></c:out>, <c:out value="${movieInfo.cate2}"></c:out>
							</li>
						</ul>
					</div>
						<div class="inlineBlock">
							<!-- 영화 줄거리 -->
							<div class="movieContent">
							${movieInfo.movieContent}
							</div>
						</div>
						
						<!-- 수정 중 -->
						<div class="buttons">
						<div class="inlineBlock">
							
								<!-- 구매 또는 구독 버튼 
								영화 테이블  0: 멤버십/ 1:구매 /2:대여 / 3:구매+대여 / 8:임시(개봉전) / 9:신규이용 불가
								-->
								
								<!-- 멤버십 전용 구독 버튼 -->
								<c:if test="${movieInfo.movieCheck == 0}">
									<!-- 유저 권한 확인 : 로그인 x일 경우 로그인 창으로 -->
									<c:if test="${member.userId == null}">
										<button id="subscribeBtn" class="btn" >구독하기</button>
									</c:if>

									<!-- 유저 권한 확인 1-일반 회원일 경우 : 구독하기 결제창으로 -->
									<c:if test="${member.ugrade == 1}">
										<button id="subscribeBtn" class="btn" onclick="location.href='../purchase/subscribe1'">구독하기</button>
									</c:if>

									<!-- 유저 권한 확인 2-베이직 / 또는 3-프리미엄 회원일 경우 / 0-관리자의 경우 -->
									<c:if test="${member.ugrade == 2 || member.ugrade == 3 || member.ugrade == 0}">
										<button id="subscribeBtn" class="btn" onclick="location.href='/movie/moviePlay?movieId=${movieInfo.movieId}'">재생하기</button>		
									</c:if>
								</c:if><!--멤버십 전용 끝 -->
								
								<!-- 구매/대여 전용 -->
								<c:if test="${movieInfo.movieCheck == 1 || movieInfo.movieCheck == 3 }">
									<!-- 유저 권한 확인 : 로그인 x일 경우 로그인 창으로 -->
									<c:if test="${member.userId == null}">
										<button class="btn_buy_btn">구매하기</button>
									</c:if>
									
									<!-- 유저 구매기록 확인 구매기록이 없다면 : 구매하기창으로 -->
									<c:if test="${member.userId != null}">
									<c:choose>
										<c:when test='${purchase_result}'>
											<button class="btn_buy_btn" onclick="location.href='/movie/moviePlay?movieId=${movieInfo.movieId}'">재생하기</button>	
										</c:when>
										<c:otherwise>
											<button  class="btn_buy_btn" onclick="location.href='../purchase/vod?movieId=${movieInfo.movieId}'">구매하기</button>
										</c:otherwise>
									</c:choose>
									</c:if>
								</c:if><!-- 구매/대여 전용 끝-->
								
								<!-- 대여 전용 -->
								<c:if test="${movieInfo.movieCheck == 2}">
									<!-- 유저 권한 확인 : 로그인 x일 경우 로그인 창으로 -->
									<c:if test="${member.userId == null}">
										<button class="btn_buy_btn">대여하기</button>
									</c:if>
									
									<!-- 유저 구매기록 확인 구매기록이 없다면 : 구매하기창으로 -->
									<c:choose>
										<c:when test='${purchase_result}'>
											<button class="btn_buy_btn" onclick="location.href='/movie/moviePlay?movieId=${movieInfo.movieId}'">재생하기</button>	
										</c:when>
										<c:otherwise>
											<button class="btn_buy_btn" onclick="location.href='../purchase/vod?movieId=${movieInfo.movieId}'">대여하기</button>
										</c:otherwise>
									</c:choose>
								</c:if><!-- 대여 전용 끝-->
								
							
							<button id="likeBtn" class="wishValue" onclick="changeImage()"></button>
							<!-- <button id="likeBtn" class="wishValue"></button> -->
							<%@include file="rating.jsp" %>
						
						</div><!-- inlineBlock -->
					</div><!-- 버튼들 -->
						
						
						
						
					<%-- <div class="buttons">
						<div class="inlineBlock">
							<c:choose>
								<c:when test="${member.userId == null }"> <!-- 로그인이 안되어 있을 경우 로그인 화면으로 보내버림 -->
								<button id="subscribeBtn" class="btn" onclick="javascript:btns()">구독하기</button>
								</c:when>
								<c:when test="${member.userId != null }"> <!-- 로그인이 되어있을 경우 구독 페이지로 보내주는 버튼 -->
								
								
								<button id="subscribeBtn" class="btn" onclick="location.href='../purchase/subscribe1'">구독하기</button>
								</c:when>
							</c:choose>
							<!-- 로그인이 되어 있고, movieCheck의 값이 1(구매) or 3(대여, 구매 가능)일 경우 구매 버튼이 보임 -->
							<c:if test="${movieInfo.movieCheck == 1 || movieInfo.movieCheck == 3 }">
								<c:if test="${member.userId != null}">
								<button id="buyBtn" class="btn_buy_btn" onclick="location.href='../purchase/vod?movieId=${movieInfo.movieId}'">구매하기</button>
								</c:if>
							</c:if>
							<c:if test="${member.ugrade == 0}">
							<p>관리자 전용 각 단계 이동 버튼</p>
							<button id="buyBtn_1" class="btn_buy_btn" onclick="location.href='../purchase/subscribe1?movieId=${movieInfo.movieId}'">구독하기(일반회원)</button>
							<button id="buyBtn_2" class="btn_buy_btn" onclick="location.href='../purchase/subscribe2?movieId=${movieInfo.movieId}'">구독하기(베이직)</button>
							<button id="buyBtn_3" class="btn_buy_btn" onclick="location.href='../purchase/subscribe3?movieId=${movieInfo.movieId}'">구독하기(프리미엄)</button>
							</c:if>
							<button id="likeBtn" class="btn_like_btn">보고싶어요</button>
							<%@include file="rating.jsp" %>
						</div>
					</div>	 --%>	<!-- 버튼 로직 수정중 완료시 삭제예정 -->
				</div>
			</div>	
			<br><br><br>
			
					<!-- 댓글 영역 -->
				<div class="replyArea">	
					<div class="shape">
						<div class="reply_subject">
							<h2>Review</h2>
						</div>
						
						<c:if test="${member != null}">
						<div class="reply_button_wrap">
							<button>리뷰 쓰기</button>
						</div>
						</c:if>		
					</div>
					<div class="reply_not_div">
						
					</div>
						<ul class="reply_content_ul">
						</ul>
					
					<div class="repy_pageInfo_div"> 
						<ul class="pageMaker">
						</ul>
					</div>
				</div>	
			</div>
		</div>
		<!-- 푸터 -->
		<%@include file="../includes/footer.jsp" %>
	</div>  <!-- id="container" -->
<script>

//시직하자마자-적용 안됨
$(document).ready(function(){

	let purchase_result = '<c:out value="${purchase_result}" />';
		
	//위시리스트 등록/취소 결과-적용 안됨
	let wishResult = '<c:out value="${wish_result}" />';
	
	checkWishResult(wishResult);
	
	function checkWishResult(result){
		if(result === ''){
			return;
		}
		alert(wishResult);
	}
	
	
	//위시리스트
	let wishValue = parseInt('<c:out value="${wishInfo}" />');
	
	//위시리스트 값이 유효한지 확인 후 설정
	if (!isNaN(wishValue) && wishValue >=0) {
	    setWishList();
	}
	
	function setWishList() {
		//let wishIcon = document.querySelectorAll('.wishValue');
		let wishIcon = document.querySelectorAll('#likeBtn');
		//let wishRemoveIcon = document.querySelectorAll('#likeBtn');
		wishIcon.classList.remove('unfilled')
		wishIcon.classList.toggle('clicked');
	}	
}); //$(document).ready(function()

		
function changeImage() {
	var button = document.getElementById("likeBtn");
	button.classList.toggle("clicked");
}		 

//버튼 눌러서 연결
$(".reply_button_wrap").on("click", function(e){
	
	e.preventDefault();
	
	const userId = '${member.userId}';
	const movieId = '${movieInfo.movieId}';
	
	$.ajax({
		data : {
			userId : userId,
			movieId : movieId
		},
		url : '/movie/check',
		type : 'POST',
		success : function(result){

			if(result === '1'){
				alert("이미 등록된 리뷰가 존재 합니다.")
			} else if(result === '0'){
				
				let popUrl = "/movie/replyWrite/" + userId + "?movieId=" + movieId;
				//console.log(popUrl);
				let popOption = "width = 490px, height=360px, top=300px, left=300px, scrollbars=yes";
				
				window.open(popUrl,"리뷰 쓰기",popOption);					
			}				
			
		}
	});

	
});


//리뷰 리스트
const movieId = '${movieInfo.movieId}';	
	$.getJSON("/movie/list", {movieId : movieId}, function(obj){
		
		makeReplyContent(obj);
		
	});

/* 댓글 페이지 정보 */
 const cri = {
	movieId : '${movieInfo.movieId}',
	pageNum : 1,
	amount : 10
}
	
/* 댓글 페이지 이동 버튼 동작 */
$(document).on('click', 'pageMaker btn a', function(e) {
	e.preventDefault();
	
	let page = $(this).attr("href");	
	cri.pageNum = page;		
	
	replyListInit();
});
	
	
/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
let replyListInit = function(){
	$.getJSON("/movie/list", cri , function(obj){
		
		makeReplyContent(obj);
		
	});		
}	

/* 댓글(리뷰) 동적 생성 메서드 */
function makeReplyContent(obj){
		if(obj.list.length === 0){
			$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');
			$(".reply_content_ul").html('');
		} else {
			$(".reply_not_div").html('');
			
			const list = obj.list;
			const pf = obj.pageInfo;
			const userId = '${member.userId}';
			const rating = '${movieInfo.rating}';
			 			
			/* list */
			
			let reply_list = '';			
			
			$(list).each(function(i,obj){
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="reply_top">';
				/* 아이디 */
				reply_list += '<span class="id_span">'+ obj.userId+'</span>';
				/* 날짜 */
				reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
				/* 평점 */
				reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
				if(obj.userId === userId){
					reply_list += '<a class="update_reply_btn" href="'+ obj.replyNum +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyNum +'">삭제</a>';
				}
				reply_list += '</div>'; //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				reply_list += '<div class="reply_bottom_txt">'+ obj.replyContent +'</div>';
				reply_list += '</div>';//<div class="reply_bottom">
				reply_list += '</div>';//<div class="comment_wrap">
				reply_list += '</li>';
				//console.log("댓글 정보들 : "+obj.regDate);
				//console.log("댓글 번호들 : "+obj.replyNum);
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

/* 리뷰 수정 버튼 */
$(document).on('click', '.update_reply_btn', function(e){
		
	const userId = '${member.userId}';
	const movieId = '${movieInfo.movieId}';
	//const replyNum = '${replyNum}';
	
	e.preventDefault();
	let replyNum = $(this).attr("href");		 
	let popUrl = "/movie/replyUpdate?replyNum=" + replyNum + "&movieId=" + '${movieInfo.movieId}' + "&userId=" + '${member.userId}';	
	let popOption = "width = 490px, height=360px, top=300px, left=300px, scrollbars=yes"	
		
	window.open(popUrl,"리뷰 수정 버튼 눌림",popOption);			
	 
});	
 
/* 리뷰 삭제 버튼 */
$(document).on('click', '.delete_reply_btn', function(e){
	e.preventDefault();
	let replyNum = $(this).attr("href");
	$.ajax({
		data : {
			replyNum : replyNum,
			movieId : '${movieInfo.movieId}'
		},
		url : '/movie/replyDelete',
		type : 'POST',
		success : function(result){
			replyListInit();
			alert('삭제가 완료되엇습니다.');
			//console.log(replyNum);
		}
	});		
		
});	

//로그인 안하고 구매, 구독 시도 시...
function btns(){
	alert("로그인 이후 이용 가능합니다.");
	location.href = "/member/login";
}

//결과를 못 불러옴
let wishResult = '<c:out value="${wish_result}" />';

/* 보고 싶어요 버튼 */
$("#likeBtn").on('click', function(e){
	
	e.preventDefault();
	
	//AJAX 요청 보내기
	let formData = new FormData();
	formData.append('userId', '${member.userId}'); // userId 추가
	formData.append('movieId','${movieInfo.movieId}' ); //movieId
	
	$.ajax({
		url : '/movie/wish',
		processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(ok) {
        	alert("보고싶어요에 등록/취소 되었습니다");
            //console.log("평가가 성공적으로 전송되었습니다.");
        },
        error: function (request, status, error) {
            alert("로그인 해주세요.");
        
        }
	});
});


//구매
$(".btn_buy_btn").on('click', function(e){
	
	e.preventDefault();
	
	const userId = '${member.userId}';
	const movieId = '${movieInfo.movieId}';
	
	//console.log("userId for buy : "+${member.userId});
	//console.log("movieId for buy : "+${movieInfo.movieId});
	
	if(userId === ""){
		alert("로그인 후 이용하실 수 있습니다.");
	} else {
		$.ajax({
			data : {
				userId : userId,
				movieId : movieId
			},
			url : '/purchase/vod',
			type : 'POST',
			success : function(result){
				if(result === '1'){
				alert("이미 등록된 리뷰가 존재 합니다.")
				} else if(result === '0'){ 
						
				let popUrl = "/movie/replyWrite/" + userId + "?movieId=" + movieId;
				//console.log(popUrl);
				let popOption = "width = 490px, height=360px, top=300px, left=300px, scrollbars=yes";
							
				window.open(popUrl,"리뷰 쓰기",popOption);					
					}				
					
				}
			});
		}
	
});

//구독
$(".btn").on('click', function(e){
	e.preventDefault();
	
	const userId = '${member.userId}';
	const movieId = '${movieInfo.movieId}';
	
	if(userId === ""){
		alert("로그인 후 이용하실 수 있습니다.");
	}
	
});


</script>
</body>
</html>