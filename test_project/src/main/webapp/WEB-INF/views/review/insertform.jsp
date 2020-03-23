<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<title>/review/insertform.jsp</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>

</head>
<style>
 #star_grade a{
    text-decoration: none;
    color: gray;
}
#star_grade a.on{
    color: red;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:#777;}
</style>
<body>
<div class="container">
	<form action="insert.do" method="post">
		<input type="hidden" name="itemNum" value="${itemNum }" />
		<input type="hidden" name="reviewWriter" value="${sessionScope.userDto.userId}" />
		<input type="hidden" id="likeCount" name="likeCount" value=2 />
		<div class="container">
			<label for="reviewContent">상품 리뷰</label>
			<input type="text" name="reviewContent" id="reviewContent" />
		</div>
		<div class="container">
			<label for="likeCount">평가</label>
			<input type="text" name="likeCount" id="likeCount" /> 
		<p id="star_grade">
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
			<a href="#">★</a>
		</p>
		</div>
		<button id="starBtn" type="submit" >등록</button>
		<button type="reset">취소</button>
		<button type="button" id="back_btn">돌아가기</button>

		<script type="text/javascript">
		$("#back_btn").click(function () {
		location.href="itemList_review.do?itemNum=" + ${itemNum};
		})
		</script>
	</form>
</div>
<script>
	$('#star_grade a').click(function(){
	    $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
	    $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
	      var likeCount = document.querySelectorAll(".on").length*2;
	      $("#likeCount").val(likeCount);
	    return false;
	});
</script>
</body>
</html>