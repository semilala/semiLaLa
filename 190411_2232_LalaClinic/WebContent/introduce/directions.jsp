<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="/LalaClinic/css/myPageMenu.css">
<link rel="stylesheet" href="/LalaClinic/css/bbs.css">

<!-- <link rel="stylesheet" type="text/css" href="/resources/css/select.css" /> -->

<style type="text/css">
.contact .bus { padding: 8px; line-height: 24px; padding-left: 34px; }	
.time_table { border-collapse:collapse; }
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
	<div style="width: 100%;height:205px;background:url('/LalaClinic/image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<div class="tb_top01">
<h3 style="margin-bottom: 0px;">병원소개/소개</h3>

<p align="right" style="margin-bottom: 10px;">
<a href="../introduce/directions.jsp">지점 안내</a> |
<a href="../introduce/inventory.jsp">장비소개</a> |
<a href="../introduce/introduce.jsp">병원 소개</a>
</p>

<!-- <div style="width: 1100px; border: 1px solid black;" align="center">
<div style="width: 1000px; border: 1px solid black;"> -->

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="../introduce/directions.jsp">병원소개</a> >  
	<a href="../introduce/directions.jsp"><span class="bold">지점안내</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<table class="contentTb">
<!-- <table class="time_table"> -->
<colgroup>
	<col width="20%"><col width="80%">
</colgroup>
<tbody>
<tr>
	<th style="background:#eeeeee; padding:30px 0; text-align: center;">진료시간</th>
	<td style="background:#f6f6f6; font-size:10pt;">
		<div style="float:left; padding-left:70px;">
			<span style="font-weight:bold;">평  일</span><br>
			am 10:00 ~ pm 09:00<span style="color:#01babd; padding-left:2px;">야간진료</span>
		</div>
		<div style="float:left; padding-left:70px;">
			<span style="font-weight:bold;">주  말</span> <br>
			am 10:00 ~ pm 05:00
		</div>
		<div style="float:left; padding-left:70px;">
			<span style="font-weight:bold;">점  심</span><br>
			점심시간없이 진료
		</div>
	</td>
</tr>
</tbody>
</table>

<table class="contentTb">
<colgroup>
	<col width="20%"><col width="80%">
</colgroup>
<tbody>
<tr>
	<td colspan="2">
		<div>
			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.3494688899823!2d127.03036990421329!3d37.49967499667214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x44de069ccaf4f59!2zS0jslYTsubTrjbDrr7g!5e0!3m2!1sko!2skr!4v1554409644692!5m2!1sko!2skr" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		</div>
	</td>
</tr>
<tr>
	<th colspan="2" style="font-size:13pt; font-weight:bold; letter-spacing:-0.5px; height:59px; color:#000;">
		라라클리닉 역삼본점
	</th>
</tr>
<tr>
	<th style="background:#eeeeee; padding:30px 0; text-align: center;">주소</th>
	<td style="background:#f6f6f6; font-size:10pt; text-align: left;">
		<div style="float:left; padding-left:30px;">
			서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F<br>(T: 1544-9970 / F: 02-562-2378)
		</div>
	</td>
</tr>
<tr>
	<th style="background:#eeeeee; padding:30px 0; text-align: center;">버스</th>
	<td style="background:#f6f6f6; font-size:10pt; text-align: left;">
		<div style="float:left; padding-left:30px;">
			역삼역.포스코P&amp;S타워 정류장<br>
			<img src="../resource/bus_blue.jpg" alt="지선"> 146 / 740 / 341 / 360<br>
			<img src="../resource/bus_red.jpg" alt="간선"> 1100 / 1700 / 2000 / 7007 / 8001
		</div>
	</td>
</tr>
<tr>
	<th style="background:#eeeeee; padding:30px 0; text-align: center;">지하철</th>
	<td style="background:#f6f6f6; font-size:10pt; text-align: left;">
		<div style="float:left; padding-left:30px;">
			지하철 2호선 역삼역 3번출구 100m
		</div>
	</td>
</tr>
</tbody>
</table>
</div>
</section>
</div>
</div> <!-- end <div class="tb_top01"> -->

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>