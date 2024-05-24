<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 환불 신청</title>
<style>
.admin_content_wrap{}
.qboard_area{
	width: 100%;
	margin: 0 auto;
	align: center;
}

/* 문의 게시판 */
.table_purchase{
	border-collapse: collapse;
	color: #292929;
	border:2px solid black;
	
}
.table_purchase th{
	min-width: 70px;
	background-color: #f7f7f7;
	text-align: center;
	height: 46px;
	border: 1px solid black;
	padding: 20px;
}
.table_purchase td{
	width: 300px;
	text-align: left;
	height: 34px;
	border: 1px solid black;
	padding: 20px;
	
}
/* 문의게시판-제목 th */
.table_title{
	width: 350px;
}





</style>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
<header>
	<%@ include file="../includes/admin/header.jsp"%>
</header>


<div class="admin_content_wrap">

	<h2>관리자 - 환불 신청</h2><br>
	<div class="wrap">
	
	<!-- 영화 구매 정보 영역 -->
	<div class="purchase_table_area">
	<form action="/admin/refund" method="post">		
		<input type="hidden" name="refundPrice" value="${purchaseInfo.buyPrice}">
		<table class="table_purchase">
			<tr>
				<th>구매자</th><td><c:out value="${purchaseInfo.id}"/></td>
			</tr>		
			<tr>
				<th>영화 제목</th><td><c:out value="${purchaseInfo.movieName}"/></td>
			</tr>
			<tr>
				<th>구매일</th><td><fmt:formatDate value="${purchaseInfo.startDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th>구매 금액</th><td><c:out value="${purchaseInfo.buyPrice}"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="환불하기"></td>
			</tr>
		
		</table>
	</form>	
	</div><!-- 영화 구매 정보 영역 purchase_detail_area -->
	
	
	
	<!-- 위치 기억 임시 -->
	<div class="qboard_area">
		<form id="moveForm" action="/admin/purchase" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
	</div><!-- "qboard_area"-->
	</div><!-- wrap -->

</div><!-- admin_content_wrap -->

<footer>
	<%@ include file="../includes/admin/footer.jsp"%>
</footer>


<script>
let moveForm = $('#moveForm');
//let searchForm = $('#searchForm');


//페이지 이동 버튼
$(".pageMaker_btn a").on("click", function(e){
	e.preventDefault();
	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	
	moveForm.submit();
	
});

</script>
</body>
</html>