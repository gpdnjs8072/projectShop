<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/shop/detailList.jsp</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
<style>
	img{
		width:100px;
		heigth:auto;
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
				<c:forEach var="list2" items="${list }">
				<p><strong>[${sessionScope.userDto.userName }]</strong> 님의 주문번호 : ${list2.orderNum} 의  주문 상세내역입니다.</p>
				</c:forEach>
				<br/>
				<table>
					<c:forEach var="list" items="${list }">
					<tr>
						<th>주문번호</th>
						<td>${list.orderNum}</td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>${userDto.userId }</td>
					</tr>
					<tr>
						<th>수신자</th>
						<td>${list.orderRec }</td>
					</tr>
					<tr>
						<th>연락처1</th>
						<td>${list.orderPhone1 }</td>
						<th>연락처2</th>
						<td>${list.orderPhone2 }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${list.userAddr1 }</td>
						<td>${list.userAddr2 }</td>
						<td>${list.userAddr3 }</td>
					</tr>
					<tr>
						<th>주문날짜</th>
						<td>
						<fmt:parseDate value="${list.orderDate }" var="orderDate" pattern="yyyy-MM-dd HH:mm:ss.S" scope="page"/>
						<fmt:formatDate value="${orderDate }" pattern="yyyy.MM.dd"/>
						</td>
						
					</tr>
					<tr>
						<th>지불방법</th>
						<c:choose>
						<c:when test="${list.payment eq 'card'}">
							<td>카드결제</td>
						</c:when>
						<c:when test="${list.payment eq 'cash'}">
							<td>현금결제</td>
						</c:when>
						<c:otherwise>
							<td>휴대폰결제</td>
						</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th>총 가격</th>
						<td><fmt:formatNumber value="${list.allPrice }" 
		                     pattern="###,###,###"/>원</td>
					</tr>
					</c:forEach>
				</table>
				<br/>
				<br/>
				<br/>
				<table>
					<thead>
						<tr>
							<th>이미지</th>
							<th>아이템 명</th>
							<th>수량</th>
							<th>가격</th>
							<th>총 가격</th>
							<th>리뷰</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="tmp" items="${list2 }">
							<tr>
								<td>
									<img src="../resources${tmp.itemImg }"/>
								</td>
								<td>${tmp.itemName }</td>
								<td>${tmp.quantity }</td>
								<td><fmt:formatNumber value="${ tmp.itemPrice}" pattern="###,###,###"/>원</td>
								<td>
								<fmt:formatNumber value="${tmp.quantity *tmp.itemPrice }" pattern="###,###,###"/>원
								<input type="hidden" value=${tmp.itemNum } name="itemNum" id="${tmp.itemNum }" />
								</td>
								<td>
								
									<button  type="button" id="${tmp.itemNum }">리뷰쓰기</button>
								</td>
								
								
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<script>
					var itemNum=null;
					$("button[type=button]").click(function(){
						itemNum=$(this).attr("id");
						console.log(itemNum);
						$.ajax({
							url:"checkreview.do",
							type:"post",     //요청 메소드
							data:{"itemNum":itemNum},   //요청파라미터:전달받은 아이템번호
							success:function(responseData){   //성공적으로 응답을 하면은 이 함수가 호출됨 ,응답한 데이터는 ()안으로 들어옴,페이지 전환x
								if(responseData.isExist){ //이미 존재하는 리뷰
									location.href="../review/insertform.do?itemNum="+itemNum;	
								}else{	
									alert("이미 리뷰를 작성했습니다.");
								}
							
							}
						});
					});
				</script>
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