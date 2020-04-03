<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>review/list.jsp</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
<style>
	img{
		width:100px;
		height:auto;
	}
</style>
</head>
<body>
<div id="root">
	<header>
		<div class="header_box">
			<nav id="nav">
				<div class="navbar-right">
					<%@ include file="../include/nav.jsp" %>
				</div>
				<div id="index_logo_div">
					<a href="../index.do"><img id="index_logo_img" src="${pageContext.request.contextPath }/resources/images/project.png"/></a>
				</div>
				<div class="navbar-left">
						<%@ include file="../include/users_aside.jsp" %>						
				</div>
			</nav>
		</div>
	</header>
	<section id="container">	
	<div id="container_box">
			<div class="container">
				<br/>
				<br/>
				<br/>
				<p style="font-weight:bold;">리뷰 평점 : 
					<span class="wrap-star"> 
						<span class='star-rating'>
								 <span style="width:<fmt:formatNumber value="${avg *10}" pattern=".0"/>%"></span>
						</span> 
					</span>
				</p>
				<br/>
				<br/>
				<table>
					<thead>
						<tr>
							<th>글 번호</th>
							<th>이미지</th>
							<th>아이템명</th>
							<th>리뷰</th>
							<th>별점</th>
							<th>좋아요</th>
							<th>작성자</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="tmp" items="${requestScope.list }" varStatus="status">
							<tr>
								<td>${status.count}</td>  <!-- <td>${tmp.reviewNum}</td> -->
								<td><a href="../Users_Item/itemView_form.do?itemNum=${tmp.itemNum }"><img src="../resources${tmp.itemImg }" /></a></td>
								<td>${tmp.itemName }</td>
								<td><a href="detail.do?reviewNum=${tmp.reviewNum }">${tmp.reviewContent }</a></td>
								<td>
								<span class="wrap-star"> 
									<span class='star-rating'>
										<span style="width:<fmt:formatNumber value="${tmp.likeCount *10}" pattern=".0"/>%"></span>
									</span> 
								</span>
								</td>
								<td><span class="glyphicon glyphicon-thumbs-up"></span>
									${tmp.upCount }</td>
								<td>${tmp.reviewWriter }</td>
								<td>${tmp.regdate }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${empty list  }">
					<p style="text-align: center;">해당 아이템의 리뷰가 없습니다.</p>
				</c:if>
				<div class="page-display">
					<ul class="pagination pagination-sm">
						<c:choose>
							<c:when test="${startPageNum ne 1 }">
								<li><a
									href="itemList_review.do?pageNum=${startPageNum-1 }&itemNum=${itemNum}">&laquo;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="javascript:">&laquo;</a></li>
							</c:otherwise>
						</c:choose>
						<%-- step="1" 은 기본값이다. --%>
						<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }"
							step="1">
							<c:choose>
								<c:when test="${i eq pageNum }">
									<li class="active"><a
										href="itemList_review.do?pageNum=${i }&itemNum=${itemNum}">${i }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li><a
										href="itemList_review.do?pageNum=${i }&itemNum=${itemNum}">${i }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${endPageNum < totalPageCount }">
								<li><a
									href="itemList_review.do?pageNum=${endPageNum+1}&itemNum=${itemNum}">&raquo;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled">
									<!-- "javascript:" 이것만 쓰면 동작하지않음 --> <a href="javascript:">&raquo;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>	
	</section>
	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../include/footer.jsp" %>
		</div>
	</footer>
	</div>
	

</body>
</html>