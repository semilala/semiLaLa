<%@page import="combine.dto.CombineDto"%>
<%@page import="java.util.List"%>
<%@page import="util.UtilClass"%>
<%@page import="java.util.Calendar"%>
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

<%
Calendar cal = Calendar.getInstance(); //오늘시간 다들어감
cal.set(Calendar.DATE, 1); //1일로 설정

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR); //현재연도 세팅
if(UtilClass.nvl(syear)==false) { //파라미터가 넘어온 경우
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH)+1; //0~11
if(UtilClass.nvl(smonth)==false) {
	month = Integer.parseInt(smonth);
}

if(month < 1) {
	month = 12;
	year--;
}
if(month > 12) {
	month = 1;
	year++;
}

cal.set(year, month-1, 1); //연월일 세팅

//요일
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
System.out.println("dayofweek: " + dayOfWeek);

//이미지들
// <<
String pp1 = String.format(
		"<button style='margin-bottom:20px; color:black;' type='button' class='btn btn-outline-light' onclick='location.href=\"%s?year=%d&month=%d\"'><<</button>" ,
		"AdminCalendarView", year-1, month);

// <
String p1 = String.format(
		"<button style='margin-bottom:20px; color:black;' type='button' class='btn btn-outline-light' onclick='location.href=\"%s?year=%d&month=%d\"'><</button>" ,
		"AdminCalendarView", year, month-1);

// >
String n1 = String.format(
		"<button style='margin-bottom:20px; color:black;' type='button' class='btn btn-outline-light' onclick='location.href=\"%s?year=%d&month=%d\"'>></button>" ,
		"AdminCalendarView", year, month+1);

// >>
String nn1 = String.format(
		"<button style='margin-bottom:20px; color:black;' type='button' class='btn btn-outline-light' onclick='location.href=\"%s?year=%d&month=%d\"'>>></button>" ,
		"AdminCalendarView", year+1, month);

List<CombineDto> list = (List<CombineDto>)request.getAttribute("list");
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
<link rel="stylesheet" href="css/calendar.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style TYPE="text/css">
/* 
body {
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
}

td {font-family: "돋움"; font-size: 9pt; color:#595959;}
th {font-family: "돋움"; font-size: 9pt; color:#000000;}
select {font-family: "돋움"; font-size: 9pt; color:#595959;}

.divDotText {
	overflow:hidden;
	text-overflow:ellipsis;
}

A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
 */
</style>
       
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
	<a href="/LalaClinic/AdminCalendarView"><span class="bold">예약관리</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<colgroup>
	<col width="14.285714286%">
	<col width="14.285714286%">
	<col width="14.285714286%">
	<col width="14.285714286%">
	<col width="14.285714286%">
	<col width="14.285714286%">
	<col width="14.285714286%">
</colgroup>
<thead>
<tr height="100">
	<td colspan="7" align="center" valign="middle">
		<%=pp1 %>&nbsp;<%=p1 %>&nbsp;&nbsp;
		<font color="black" style="font-size: 50px;">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year,month) %>
		</font>
		<%=n1 %>&nbsp;<%=nn1 %>
	</td>
</tr>
<tr height="30">
	<th align="center"><font color="red">Sun</font></th>
	<th align="center">Mon</th>
	<th align="center">Tue</th>
	<th align="center">Wed</th>
	<th align="center">Thu</th>
	<th align="center">Fri</th>
	<th align="center">Sat</th>
</tr>
</thead>

<tbody>
<tr height="130" align="left" valign="top">
<%
//윗쪽의 빈칸
for(int i=1; i<dayOfWeek; i++) {
	%>
	<td bgcolor="#edeaea">&nbsp;</td>
	<%
}

//날짜
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i=1; i<=lastDay; i++) {
	%>
	<td>
		<%=UtilClass.callistAdmin(year, month, i) %>
		<%-- <%=UtilClass.showPen(year, month, i) %> --%>
		<%=UtilClass.makeTableAdmin(year, month, i, list) %>
	</td>
	<%
	if( (i+dayOfWeek-1)%7==0 && i!=lastDay ) {
		%>
		</tr>
		<tr height="130" align="left" valign="top">
		<%
	}
}

//밑의 빈칸
for(int i=0; i<(7-(dayOfWeek+lastDay-1)%7)%7; i++) {
	%>
	<td bgcolor="#edeaea">&nbsp;</td>
	<%
}
%>
</tr>
</tbody>
</table><br>
<div align="center">
	<button type="button" class="btn btn-outline-primary" onclick="location.href='admin/adminMain.jsp'">관리 메인메뉴</button><br>
</div>
</div> <!-- end <div class ="tb_Head01"> -->
</section> <!-- page_board section end -->
</div> <!-- end <div align="center" class="center"> -->

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>