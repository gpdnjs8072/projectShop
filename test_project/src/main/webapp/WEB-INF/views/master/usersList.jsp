<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/resources/style/total.jsp"></jsp:include>
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
						<%@ include file="../include/header.jsp" %>
					</div>
					<div class="navbar-left">
							<%@ include file="../include/master_aside.jsp" %>						
					</div>
				</nav>
			</div>
		</header>
		<section id="container">
			<div id="container_box">
				<h2>유저 배송상태 관리</h2>
				<div id="container_box">
					<table>
						 <thead>
							 <tr>
							   <th>아이디</th>
							   <th>이름</th>
							   <th>주소</th>
							   <th>전화번호1</th>
							   <th>전화번호2</th>
							   <th>주소1</th>
							   <th>주소2</th>
							   <th>주소3</th>
							   <th>주문날짜</th>
							   <th>상품명</th>
							   <th></th>
							 </tr>
						 </thead>
						 <tbody>
						  <c:forEach items="${orderList}" var="orderList">
							  <tr>
								   <td>${orderList.userId }</td>
								   <td>${orderList.orderRec }</td>
								   <td>${orderList.orderPhone1 }</td>
								   <td>${orderList.orderPhone2 }</td>
								   <td>${orderList.userAddr1 }</td>
								   <td>${orderList.userAddr2 }</td>
								   <td>${orderList.userAddr3 }</td>
								   <td>${orderList.orderDate }</td>
								   <td>${orderList.itemName }</td>
							   		<td>
								    <select class="itemResult" name="itemResult" id="${orderList.delivery}">	
								    	<option value="배송준비" <c:if test="${orderList.result eq '배송준비'}">selected</c:if>>배송준비</option>
								    	<option value="배송중"<c:if test="${orderList.result eq '배송중'}">selected</c:if>>배송중</option>					
								    	<option value="배송완료"<c:if test="${orderList.result eq '배송완료'}">selected</c:if>>배송완료</option>					
							   		</select>					     
							   		</td>
							
							  </tr>   
						  </c:forEach>
						 </tbody>
					</table>
					<!--
					<script type="text/javascript">	
						$("select").on("change",function(){
								var resultArray = [];
								var tag=$(this).attr("id");
								var target=$(this).val();
								resultArray.push(target);
								resultArray.push(tag);
					 		$.ajax({
								url:"resultUpDate.do",
								type:"post",
								data: {"resultArray":resultArray},
								success:function(responseData){
									if(responseData.isSuccess){									
										location.reload();	
									}else {
										alert("실패");
									}
								}	
								});
							});
					</script>
					-->
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