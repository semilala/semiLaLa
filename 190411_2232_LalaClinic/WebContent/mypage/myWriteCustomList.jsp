<%@page import="paging.PagingBean"%>
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

PagingBean paging = new PagingBean();
paging = (PagingBean)request.getAttribute("paging");
if(request.getParameter("nowPage") == null){
	paging.setNowPage(1);	
}
else{
	paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
}

String choice = ""; //검색옵션
String findWord = ""; //검색어

if(choice == null || choice.equals("")){
	choice = "sel";	
}
if(choice.equals("sel")){
	findWord = "";
}

// 검색어를 지정하지 않았을 경우, 빈 문자열로
if(findWord == null){
	findWord = "";
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
<link rel="stylesheet" href="css/myPageMenu.css">
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

<!-- 상단 부메뉴0 -->
<div class="tb_top01">

<h3 style="margin-bottom: 0px;">
    <a href="/LalaClinic/CalendarView">내 일정</a> |
   	<a href="/LalaClinic/MyDetail">내 정보</a> |
   	<a href="/LalaClinic/MyWriteCombineList"><b>내글 확인</b></a>
</h3>
   
<p align="right" style="margin-bottom: 10px;"> <b>MyPage</b> &nbsp;&nbsp; > &nbsp;
	<a href="/LalaClinic/MyWriteCombineList">상담및예약</a> |
    <a href="/LalaClinic/MyWriteReviewList">시술후기</a> |
    <a href="/LalaClinic/MyWriteCustomList"><b>고객소리함</b></a>
</p>

<div align="center" class="center">

<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/CalendarView">MyPage</a> > 
	<a href="/LalaClinic/MyWriteCombineList">내 글 확인</a> > 
	<a href="/LalaClinic/MyWriteCustomList"><span class="bold">고객소리함</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
<col width="8%"> <col width="*">
<col width="9%"> <col width="9%"><col width="13%">
</colgroup>

<thead>
	<tr>
		<th>No</th>			<!-- 넘버 -->
		<th>Subject</th>	<!-- 제목 -->
		<th>Name</th>		<!-- 이름 -->
		<th>Date</th>		<!-- sysdate -->
		<th>Answer</th>
	</tr>
</thead>

<tbody>
<c:if test="${cuslist.size() eq 0 }">
		<tr>
			<td colspan="6" align="center">작성된 글이 없습니다.</td>
		</tr>
</c:if>
<c:if test="${cuslist.size() > 0 }">
	<c:set var="no" value="${paging.startNum }" />
	<c:forEach items="${cuslist}" var="m" varStatus="i">
			<tr>
				<td>${no }<c:set var="no" value="${no-1 }" /></td>
				<td><a href="/LalaClinic/customdetail?seq=${m.seq }">${m.title }</a></td>
				<td>${m.name }</td>
				<td>${m.wdate }</td>
				<td>
				<c:if test="${m.progress eq 1}"><img alt="" src="./image/combine_answerAf.png"></c:if>
				<c:if test="${m.progress eq 0}"><img alt="" src="./image/combine_answerBf.png"></c:if>
				</td>
			</tr>
		</c:forEach>
</c:if>
</tbody>
</table><br>

<!-- 페이징 -->
<div class="pgdiv">
<span class="pgspan">
<jsp:include page="./paging.jsp">
	<jsp:param name="actionPath" value="/LalaClinic/MyWriteCustomList" />
	<jsp:param name="nowPage" value="${paging.nowPage }" />
	<jsp:param name="totalCount" value="${paging.totalCount }" />
	<jsp:param name="countPerPage" value="${paging.countPerPage }" />
	<jsp:param name="blockCount" value="${paging.blockCount }" />
	
 	<jsp:param name="findWord" value="${param.findWord }" />
	<jsp:param name="choice" value="${param.choice }" />
</jsp:include>
</span>
</div>
</div>

<!-- 검색 폼 -->
<div class="clear"></div>
<div class="search01">
<form action="/LalaClinic/MyWriteCustomList" onsubmit="return check()">
	<select id="sOption" name="sOption">
		<option value="title" <c:if test="${param.sOption eq 'title'}">selected="selected"</c:if> >제목</option>
		<option value="content" <c:if test="${param.sOption eq 'content'}">selected="selected"</c:if> >내용</option>
	</select>
	<c:if test="${empty param.sWord}">
		<input class="key" type="text" name="sWord" id="sWord" value="">
	</c:if>
	<c:if test="${not empty param.sWord}">
		<input class="key" type="text" name="sWord" id="sWord" value="${param.sWord}">
	</c:if>
	<input class="searchBtn" type="image" src="./image/search.png">
</form>
</div>
</section> <!-- page_board section end -->
</div> <!-- end <div align="center" class="center"> -->
</div>
<script type="text/javascript">
function check() {
	alert("sOption: " + $("#sOption").val());
	alert("sWord: " + $("#sWord").val());
	
	return true;
}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>