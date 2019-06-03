<%@page import="util.UtilClass"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
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

Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
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
.tb_Head01 .contentTb tbody td{text-align: left;padding: 17px 0;border-bottom: 1px dotted #e8e8e8; font-size:12pt;}
.tb_Head01 .contentTb tbody td.myDetailRight{text-align: center;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.poesis.kr/post/popup.min.js" charset="UTF-8"></script>
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
	<h3>회원 정보</h3>
</div>

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/admin/adminMain.jsp">관리자</a> >  
	<a href="#"><span class="bold">회원정보</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<input type="hidden" name="auth" value="1">
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
		<button type="button" class="btn btn-outline-primary" onclick="location.href='MemberUpdate?id=${dto.id}'">수정</button>
		<button type="button" class="btn btn-outline-success" onclick="location.href='/LalaClinic/MemberList'">목록</button>
		<button type="button" class="btn btn-outline-info" onclick="location.href='admin/adminMain.jsp'">메인</button>
	</td>
</tr>
</tbody>
</table><br>

</div> <!-- end <div class ="tb_Head01"> -->
</section>
</div> <!-- end <div align="center" class="center"> -->

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>