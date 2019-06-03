<%@page import="paging.PagingBean"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="combine.dto.CombineDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	%>
	<script type="text/javascript">
	//alert("세션이 만료됐습니다. 다시 로그인하세요.");
	//location.href = "login.jsp";
	</script>
	<%
}
else {
	user = (MemberDto)ologin;
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

<style type="text/css">
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>라라클리닉 역삼점</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">

</style>
</head>
<body>
<div class="categoryTop">
	<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
	<div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<!-- <div class="tb_top01" > -->
<div class="tb_top01" >
<h3>자료 게시판</h3>
</div>
<div align="center" class="center"> <!-- style="background-color: #fff">-->

<section id="page_mark">
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp">홈</a> > <a href="/LalaClinic/DownList"><span class="bold">자료게시판</span></a></p>
</section>
<section id="page_board">
<div class ="tb_Head01"><!--  style="width:1000"> -->
<table class="contentTb">
<colgroup>
<col width="10%"> <col width="*"><col width="20%"><col width="20%"> <col width="10%">
</colgroup>
<thead>
	<tr>
		<th>No</th>
		<th>Subject</th>
		<th>Name</th>
		<th>Date</th>
		<th>Hit</th>
	</tr>
</thead>

<tbody>
<c:if test="${list.size() > 0}">
	<c:set var="no" value="${paging.startNum}" />
	<c:forEach items="${list}" var="m">
	<tr>
		<td>${no}<c:set var="no" value="${no-1}" /></td>
		<td><a href="/LalaClinic/DownDetail?seq=${m.seq}" onclick="return authchk(${login});">${m.title}</a></td>
		<td>${m.name}</td>
		<td>${m.wdate}</td>
		<td>${m.readCount}</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${list.size() eq 0}">
<tr><td colspan="5">등록된 자료가 없습니다.</td></tr>
</c:if>

</tbody>
</table><br>

<%-- <c:if test="${login.auth eq 1}">
<a href="down/downWrite.jsp">
	<img src="./image/combine_write.png" alt="글쓰기">
</a>
</c:if> --%>

<%-- <script type="text/javascript">
function loginchk() {
	if("<%=ologin%>" == null){
		alert("로그인후에 사용 가능합니다.");
		return false;
	}
}
</script> --%>
<div class="pgdiv">
<span class="pgspan">
<jsp:include page="../paging.jsp">
	<jsp:param name="actionPath" value="/LalaClinic/AdminList" />
	<jsp:param name="nowPage" value="${paging.nowPage }" />
	<jsp:param name="totalCount" value="${paging.totalCount }" />
	<jsp:param name="countPerPage" value="${paging.countPerPage }" />
	<jsp:param name="blockCount" value="${paging.blockCount }" />
	
 	<jsp:param name="findWord" value="${param.findWord }" />
	<jsp:param name="choice" value="${param.choice }" />
</jsp:include>
</span>
<c:if test="${login.auth eq 1}">
<span class="writeBtn">
	<a href="down/downWrite.jsp">
		<img   src="./image/combine_write.png" alt="글쓰기" >
	</a>
</span>
</c:if>
</div><br>

<!-- 검색 폼 -->
<div class="clear"></div>
<div class="search01" >
<form action="/LalaClinic/DownList" method="get">
<select id="choice" name="choice">
	<option value="title" <c:if test="${param.choice eq 'title'}"> selected="selected"</c:if> >제목</option>
	<option value="content" <c:if test="${param.choice eq 'content'}">selected="selected"</c:if> >내용</option>
</select>
<c:if test="${empty param.findWord}">
	<input class="key" type="text" id="findWord" name="findWord" value="">
</c:if>
<c:if test="${not empty param.findWord}">
	<input class="key" type="text" id="findWord" name="findWord" value="${param.findWord}">
</c:if>
<input class="searchBtn" type="image" src="./image/search.png">
<!-- <input type="submit" value="검색"> -->
</form>
</div>

</div>
</section>
</div>
<script type="text/javascript">
$(document).ready(function() {
	if($("#findWord").val()==null) {
		$("#findWord").val("");
	}
});

//디테일 권한 검사
function authchk( id ){
	var ologin = id;
	if(ologin==null) {
		alert("로그인을 해야합니다");
		return false;
	}
	return true;
}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>