<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div class="content_wrap">

	<h2>환불 신청</h2><br>
	<div class="wrap">
	
	<!-- 영화 구매 정보 영역 -->
	<div class="purchase_table_area">
		<%@ include file="../includes/header.jsp"%>
	<form action="/purchase/refund" method="post" id="refundForm">		
	
		<input type="hidden" name="id" value='<c:out value="${purchaseInfo.id}"/>' >
		<input type="hidden" name="refundPrice" value='<c:out value="${purchaseInfo.buyPrice}"/>' >
		<input type="hidden" name="userId" value='<c:out value="${purchaseInfo.userId}"/>' >
		
		<table class="table_purchase">
				
			<tr>
				<th>영화 제목</th>
				<td><a class="move" href='<c:out value="${purchaseInfo.movieId}"/>'><c:out value="${purchaseInfo.movieName}"/></a></td>
			</tr>
			<tr>
				<th>구매일</th><td><fmt:formatDate value="${purchaseInfo.startDate}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th>환불 금액</th><td><c:out value="${purchaseInfo.buyPrice}"/></td>
			</tr>
			<c:if test="${!empty purchaseInfo.refundStatus}">
				<input type="hidden" name="refundId" value="${purchaseInfo.refundId }">
				<tr>
					<th>환불 진행 사항</th><td><c:out value="${purchaseInfo.refundStatus}"/>
					<c:if test="${purchaseInfo.refundStatus != '환불완료'}">
						<input type="submit" value="환불신청">
					</c:if>
					</td>
				</tr>
			</c:if>
			
		
		</table>
	</form>	
	</div>
	</div><!-- wrap -->

</div><!-- admin_content_wrap -->

<footer>
	<%@ include file="../includes/footer.jsp"%>
</footer>


</body>
</html>