<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>라라클리닉 역삼점</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- local CSS -->
<link rel="stylesheet" href="../css/bbs.css">
</head>
<body>
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>

<!-- 상단이미지 -->
<div id="sub_visual" >
	<div style="width: 100%;height:205px;background:url('../image/visual_s4.jpg') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01">

<h3 style="margin-bottom: 0;">리프팅/블루로즈 포르테</h3>
<p align="right" style="margin-bottom: 10px;">
<a href="../lifting/lifting.jsp">블루로즈 포르테</a> |
<a href="../lifting/shurink.jsp">슈링크</a> |
<a href="../lifting/silhouette.jsp">실루엣 소프트</a> |
<a href="../lifting/anti.jsp">안티에이징 주사</a>
</p>

<div class="center" align="center"> 
<section id="page_mark">
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp" style="text-decoration:none;"> 홈 </a> > 리프팅 > <b>블루로즈 포르테</b> </p>
</section>

<section id="page_board">
<img src="../resource/lifting_bluerose.jpg" width="1000px;">
</section>
</div>
</div>

<footer>
	<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>
</body>
</html>