<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
	<style>
		 body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
		 ul { padding:0; margin:0; list-style:none;  }
		
		 div#root { width:90%; margin:0 auto; }
		 
		 header#header { font-size:60px; padding:20px 0; }
		 header#header h1 a { color:#000; font-weight:bold; }
		 
		 nav#nav { padding:10px; text-align:right; }
		 nav#nav ul li { display:inline-block; margin-left:10px; }
		
		 section#container { padding:20px 0; border-top:2px solid #eee; border-bottom:2px solid #eee; }
		 section#container::after { content:""; display:block; clear:both; }
		 aside { float:left; width:200px; }
		 div#container_box { float:right; width:calc(100% - 200px - 20px); }
		 
		 aside ul li { text-align:center; margin-bottom:10px; }
		 
		 footer#footer { background:#f9f9f9; padding:20px; }
		 footer#footer ul li { display:inline-block; margin-right:10px; }
		 aside ul li a { display:block; width:100%; padding:10px 0;}
		 aside ul li a:hover { background:#eee; }
	</style>

	<h2>카테고리</h2>	
		<ul>
			<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=100&cateLevel=1">악세서리</a>
				<ul class="low">
					<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=101&cateLevel=2">반지</a></li>
					<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=102&cateLevel=2">귀걸이</a></li>
					<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=103&cateLevel=2">목걸이</a></li>
				</ul>
			</li>
			<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=200&cateLevel=1">여성의류</a></li>
			<li><a href="${pageContext.request.contextPath }/Users_Item/itemList.do?cateCode=300&cateLevel=1">남성의류</a></li>
			<li><a href="${pageContext.request.contextPath }/Users_Item/itemAllList.do">전체 상품 목록</a></li>	
			<li><a href="${pageContext.request.contextPath }/qna/list.do">QnA</a></li>
			<li><a href="${pageContext.request.contextPath }/notice/list.do">Notice</a></li>
			<li><a href="${pageContext.request.contextPath }/review/list.do">상품 리뷰</a></li>
		</ul>
