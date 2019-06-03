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
	<div style="width: 100%;height:205px;background:url('../image/visual_s1.jpg') no-repeat 50% 0px;"></div>
</div>

<div class="tb_top01">
<h3 style="margin-bottom: 0px;">윤곽주사</h3>
<p align="right" style="margin-bottom: 10px;">
<a href="../botox/botox.jsp">보톡스</a> |
<a href="../botox/filler.jsp">필러</a> |
<a href="../botox/outline.jsp">안면윤곽</a>
</p>
<div class="center" align="center"> 
<section id="page_mark">
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp" style="text-decoration:none;"> 홈 </a> > 보톡스 > <b>윤곽주사</b> </p>
</section>

<section id="page_board">
<img src="../resource/botox_outline.jpg" width="1000px">
</section>
</div>
</div>

<footer>
	<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>
</body>
</html>