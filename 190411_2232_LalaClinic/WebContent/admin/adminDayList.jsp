<%@page import="util.UtilClass"%>
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
	<h3>예약 관리</h3>
</div>

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/admin/adminMain.jsp">관리자</a> >  
	<a href="/LalaClinic/AdminList"><span class="bold">예약관리</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
	<col width="10%"><col width="10%"><col width="*"><col width="10%"><col width="30%">
</colgroup>
<thead>
<tr>
	<th>No</th>
	<th>시술항목</th>
	<th>제목</th>
	<th>작성자</th>
	<th>예약일정</th>
</tr>
</thead>

<tbody>
	<c:if test="${list.size() eq 0}">
		<tr><td colspan="5">예약된 일정이 없습니다.</td></tr>
	</c:if>
	<c:if test="${list.size() > 0 }">
		<c:set var="no" value="${list.size()}" />
		<c:forEach items="${list}" var="m">
			<tr>
				<td>${no}<c:set var="no" value="${no-1}" /></td>
				<td>${m.medical}</td>
				<td><a href="/LalaClinic/CombineDetail?seq=${m.seq}">${m.title}</a></td>
				<td>${m.name}</td>
				<td>${m.rdate}</td>
			</tr>
		</c:forEach>
	</c:if>
</tbody>
</table><br>
<div align="center">
	<button type="button" class="btn btn-outline-primary" onclick="location.href='/LalaClinic/AdminCalendarView'">달력으로</button><br>
</div>
</div> <!-- end <div class ="tb_Head01"> -->
</section> <!-- page_board section end -->
</div> <!-- end <div align="center" class="center"> -->

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>