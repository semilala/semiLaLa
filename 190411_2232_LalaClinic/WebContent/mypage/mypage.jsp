<%@page import="util.UtilClass"%>
<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	System.out.println("null");
	%>
	<script type="text/javascript">
	alert("로그인해야 합니다.");
	location.href = "../index.jsp";
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
<link rel="stylesheet" href="/LalaClinic/css/myPageMenu.css">
<link rel="stylesheet" href="/LalaClinic/css/bbs.css">

<style type="text/css">
.tb_Head01 .contentTb tbody td{text-align: left;padding: 17px 0;border-bottom: 1px dotted #e8e8e8; font-size:12pt;}
.tb_Head01 .contentTb tbody td.myDetailRight{text-align: center;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<!-- 상단 부메뉴0 -->
<div class="tb_top01">

<h3 style="margin-bottom: 0px;">
    <a href="/LalaClinic/CalendarView">내 일정</a> |
   	<a href="/LalaClinic/MyDetail"><b>내 정보</b></a> |
   	<a href="/LalaClinic/MyWriteCombineList">내글 확인</a>
</h3>
   
<p align="right" style="margin-bottom: 10px;"> <b>MyPage</b> &nbsp;&nbsp; > &nbsp;
	<a href="/LalaClinic/MyWriteCombineList">상담및예약</a> |
    <a href="/LalaClinic/MyWriteReviewList">시술후기</a> |
    <a href="/LalaClinic/MyWriteCustomList">고객소리함</a>
</p>

<div align="center" class="center">

<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/CalendarView">MyPage</a> > 
	<a href="/LalaClinic/MyDetail"><span class="bold">내정보</span></a>
</p>
</section>

<!-- <input type="hidden" name="auth" value="1"> -->

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
	<col width="20%"><col width="*">
</colgroup>

<thead>
</thead>

<tbody>
<tr>
	<th>아이디</th>
	<td>${dto.id}</td>
</tr>
<tr>
	<th>이름</th>
	<td>${dto.name}</td>
</tr>
<tr>
	<th>성별</th>
	<td>${dto.gender}</td>
</tr>
<tr>
	<th>이메일</th>
	<td>${dto.email}</td>
</tr>
<tr>
	<th>연락처</th>
	<td>${dto.phone}</td>
</tr>
<tr>
	<th>생년월일</th>
	<c:set var="b" value="${dto.birth }" />
		<%
		String bday = (String)pageContext.getAttribute("b");
		int[] b = UtilClass.getTimeFormatInt(bday, 0);
		pageContext.setAttribute("b", b);
		%>
	<td>${b[0]}년 ${b[1]}월 ${b[2]}일 </td>
</tr>
<tr>
	<th>주소</th>
	<td>${dto.address}</td>
</tr>
<tr>
	<td colspan="2" class="myDetailRight">
		<button type="button" class="btn btn-outline-primary" onclick="location.href='MyUpdateView?id=${dto.id}'">수정</button>
		<button type="button" class="btn btn-outline-dark" onclick="confirm('정말 탈퇴하시겠습니까?')==true? location.href='MyDelete?id=${dto.id}':''">탈퇴</button>
		<%-- <input type="button" id="deleteBtn" value="회원탈퇴" onclick="confirm('정말 탈퇴하시겠습니까?')==true? location.href='MyDelete?id=${dto.id}':''"> --%>
	</td>
</tr>
</tbody>
</table><br>
</div></section></div></div>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>