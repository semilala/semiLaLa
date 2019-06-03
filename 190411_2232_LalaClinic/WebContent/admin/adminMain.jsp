<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

//if(request.getAttribute("mdto")!=null) {
	/* MemberDto mdto = (MemberDto)request.getAttribute("mdto");
	if(mdto!=null) {
		session.setAttribute("login", mdto);
		session.setMaxInactiveInterval(10);
	} */
//}
%>
	
<%
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
<link rel="stylesheet" href="/LalaClinic/css/bbs.css">

<style type="text/css">
.bgBlack {
	background-color: black;
	color: white;
	text-align: center;
	font-size: 15px;
}
</style>

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
	<div style="width: 100%;height:205px;background:url('/LalaClinic/image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<!-- 상단 부메뉴 -->
<div class="tb_top01" >
	<h3>관리메뉴</h3>
</div>

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/admin/adminMain.jsp"><span class="bold">관리자</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
	<col width="20%"><col width="20%"><col width="20%"><col width="20%"><col width="20%">
</colgroup>
<tbody>
<tr>
	<th class="bgBlack">관리자관리</th>
	<td><a href="../admin/adminJoin.jsp">관리자 등록</a></td>
	<td><a href="/LalaClinic/AdminList">관리자 목록</a></td>
	<td></td>
	<td></td>
</tr>
<tr>
	<th class="bgBlack">회원관리</th>
	<td><a href="/LalaClinic/MemberList">회원 목록</a></td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<tr>
	<th class="bgBlack">예약관리</th>
	<td><a href="/LalaClinic/AdminCalendarView">예약일정 확인</a></td>
	<td></td>
	<td></td>
	<td></td>
</tr>
</tbody>
</table><br>

<!-- <div>
<p>1. 관리자 관리</p>
<ul>
	<li><a href="../admin/adminJoin.jsp">[관리자 등록]</a></li>
	<li><a href="/LalaClinic/AdminList">[관리자 목록]</a></li>
</ul>
</div><br>-->

<!-- <div>
<p>2. 회원 관리</p>
<ul>
	<li><a href="/LalaClinic/MemberList">[회원 목록]</a></li>
</ul>
</div>

<div>
<p>3. 예약 관리</p>
<ul>
	<li><a href="/LalaClinic/AdminCalendarView">[예약 일정 확인]</a></li>
</ul>
</div> -->
</div>
</section>
</div>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>