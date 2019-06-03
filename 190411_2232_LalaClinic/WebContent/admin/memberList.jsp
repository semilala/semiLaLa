<%@page import="java.util.List"%>
<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%
request.setCharacterEncoding("UTF-8");

//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	System.out.println("null");
	%>
	<script type="text/javascript">
	alert("로그인해야 합니다.");
	location.href = "/LalaClinic/index.jsp";
	</script>
	<%
}
else {
	user = (MemberDto)ologin;
	if(user.getAuth()!=1) {
		%>
		<script type="text/javascript">
		alert("권한이 없습니다.");
		location.href = "/LalaClinic/index.jsp";
		</script>
		<%	
	}
}
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>라라클리닉 역삼점</title>
</head>
<body>
<!-- 상단메뉴 include -->
<div class="categoryTop">
	<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<!-- 상단 이미지 -->
<div id="sub_visual" >
	<div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<!-- 상단 부메뉴 -->
<div class="tb_top01" >
	<h3>회원 목록</h3>
</div>

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/admin/adminMain.jsp">관리자</a> >  
	<a href="/LalaClinic/MemberList"><span class="bold">회원목록</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
	<col width="25%"><col width="25%"><col width="25%"><col width="25%">
</colgroup>
<thead>
	<tr>
		<th>No</th>
		<th>ID</th>
		<th>Name</th>
		<th>Gender</th>
	</tr>
</thead>

<tbody>
	<c:set var="no" value="${paging.startNum}" />
	<c:forEach items="${list}" var="m">
	<tr>
		<td>${no}<c:set var="no" value="${no-1}" /></td>
		<td><a href="MemberDetail?id=${m.id}">${m.id}</a></td>
		<td>${m.name}</td>
		<td>${m.gender}</td>
	</tr>
	</c:forEach>
</tbody>
</table><br>

<!-- 페이징 -->
<div class="pgdiv">
<span class="pgspan">
<jsp:include page="../paging.jsp">
	<jsp:param name="actionPath" value="/LalaClinic/MemberList" />
	<jsp:param name="nowPage" value="${paging.nowPage }" />
	<jsp:param name="totalCount" value="${paging.totalCount }" />
	<jsp:param name="countPerPage" value="${paging.countPerPage }" />
	<jsp:param name="blockCount" value="${paging.blockCount }" />
	
 	<jsp:param name="findWord" value="${param.findWord }" />
	<jsp:param name="choice" value="${param.choice }" />
</jsp:include>
</span>
</div>
<button style="float: right;" type="button" class="btn btn-outline-primary" onclick="location.href='admin/adminMain.jsp'">관리 메인메뉴</button>
</div><br> <!-- tb_Head01 end -->

<!-- 검색 폼 -->
<div class="clear"></div>
<div class="search01">
<form action="/LalaClinic/MemberList" onsubmit="return check()">
	<select id="choice" name="choice">
		<option value="id" <c:if test="${param.choice eq 'id'}">selected="selected"</c:if> >ID</option>
		<option value="name" <c:if test="${param.choice eq 'name'}">selected="selected"</c:if> >이름</option>
	</select>
	<c:if test="${empty param.findWord}">
		<input class="key" type="text" name="findWord" id="findWord" value="">
	</c:if>
	<c:if test="${not empty param.findWord}">
		<input class="key" type="text" name="findWord" id="findWord" value="${param.findWord}">
	</c:if>
	<input class="searchBtn" type="image" src="./image/search.png">
</form><br>
</div>
</section> <!-- page_board section end -->
</div> <!-- end <div align="center" class="center"> -->

<script type="text/javascript">
$(document).ready(function() {
	if($("#findWord").val()==null) {
		$("#findWord").val("");
	}
});

function check() {
	alert("choice: " + $("#choice").val());
	alert("findWord: " + $("#findWord").val());
	
	return true;
}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>

















