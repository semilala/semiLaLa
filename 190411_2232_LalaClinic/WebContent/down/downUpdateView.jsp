<%@page import="member.dto.MemberDto"%>
<%@page import="combine.dto.CombineDto"%>
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
   alert("로그인해야 합니다.");
   location.href = "../index.jsp";
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
<link rel="stylesheet" href="/LalaClinic/css/reply.css">

<style type="text/css">
.layout{
display:none;
}
</style>
<style type="text/css">
.tb_top01{
   margin: auto;
   width: 1100px;
}
.tb_top01 h3{
   margin-left:60px;
   margin-top:30px;
   margin-bottom:30px;
}
.center{
   margin: auto;
   text-align: center;
   border-top : 4px solid black;
    width: 1100px;
     background-color : #fff; 
}
.tb_head01{
    width:1000px;
}

table td,th{
   padding-top: 10px;
   padding-bottom: 10px;
   text-align: left;
}


body{
   font-family: 'Nanum Gothic', sans-serif;
   /* font-size : 10px; */
   background-color: #f9f9f9;
}
#page_mark{
    margin:1rem 1rem 1rem 0;
}
.tb_Head01 {width:100%;}
.tb_Head01 table {width:100%;}
.tb_Head01 table th{text-align: left;font-size: 10pt;font-weight: bold; padding: 8px 0;border-bottom: 2px dotted #e8e3e3;}
.tb_Head01 table thead th {height:33px;font-size:12px;font-weight:normal;border-top: 2px dotted #e8e3e3;border-bottom:2px dotted #e8e3e3;}
.tb_Head01 table tbody td{text-align: left;padding: 17px 0;border-bottom: 2px dotted #e8e3e3; font-size:10pt;}
/* #page_board {
    clear: all;
    margin: 0;
    padding: 50px 50px 15px 50px;
    z-index: 1;
    text-align: left;
    font-size: 10pt;
} */
#page_board {
    clear: all;
    margin: 0 0 50px 0;
    padding: 50px 50px 50px 50px;
    z-index: 1;
    text-align: left;
    font-size: 10pt;
    background-color : #fff;
}
.h3{
    text-align: left;
    font-size: 10pt;
    margin:0;
    font-weight: bold;
}

</style>

<script type="text/javascript"src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>라라클리닉 역삼점</title>
</head>

<body>
<div class="categoryTop">
	<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<div class="wrapper">
<a href="DownList"><h3 id="h3" style="border-bottom:solid 3px #000;">자료 게시판</h3></a>

<!-- <div align="center" class="center" > -->

<section id="page_mark">
	<p align ="right" style="font-size: 13px">
		<a href="/LalaClinic/index.jsp"> 홈 > </a>
		<span class="bold">자료게시판</span> 
	</p>
</section>

<section id="page_board">
<div class ="tb_Head01" align="center">
<form action="/LalaClinic/DownUpdate" method="post" enctype="multipart/form-data" onsubmit="return nullchk();">
<input type="hidden" value="bf" name="command">

<table >
<colgroup>
   <col width="15%"><col width="35%"><col width="15%"><col width="35%">
</colgroup>

<thead>
</thead>

<tbody>
<tr>
	<th>제목</th>
	<td><input type="text" id="title" name="title" value="${dto.title}"></td>
	<th>등록일</th>
	<td>${dto.wdate}</td>
</tr>
<tr>
	<th>작성자</th>
	<td>${dto.name}</td>
	<th>조회수</th>
	<td>${dto.readCount}</td>
</tr>
<tr>
	<th>내용</th>
	<td colspan="3">
	   <textarea rows="10" cols="80" name="content" style="resize: none;" id="content">${dto.content}</textarea>
	</td>
</tr>
<tr>
	<th>첨부파일</th>
	<td><span id="filebf">${dto.fileNameBf}</span>&nbsp;<input type="button" value="파일변경" id="btnChange"></td>
	<td colspan="2">
	   <div id="fileDiv" style="display: none;"><input type="file" style="width: 400px;" name="fileload" id="fileload"></div>
	</td>
</tr>
</tbody>
</table><br>

<input type="hidden" name="seq" value="${dto.seq}">
<input type="hidden" name="id" value="${login.id}">
<input type="hidden" name="filechk" id="filechk" value="ex">

<input type="image" src="./image/accept.png" style="vertical-align: middle;"> 
<a href="/LalaClinic/DownDetail?seq=${dto.seq}" >
   <img src="./image/combine_cancel.png" style="vertical-align: middle;">
</a>
</form>

</div> <!-- end <div class ="tb_Head01"> -->
</section> <!-- end <section id="page_board"> -->
</div> <!-- end <div class="wrapper"> -->


<script type="text/javascript">
function nullchk() {
   if($("#title").val()==null || $("#title").val() == ""){
      alert("제목을 입력해주세요.")
      $("#title").focus();
      return false;
   }
   if($("#content").val()==null || $("#content").val() == ""){
      alert("내용을 입력해주세요.");
      $("#content").focus();
      return false;
   }
   if( $("#filechk").val()=='up' && ($("#fileload").val()==null || $("#fileload").val()=="") ) {
      alert("파일을 등록해 주세요.");
      return false;
   }
   
   return true;
}

$(document).ready(function() {
   $("#btnChange").click(function() {
      $("#filebf").html("");
      $("#filechk").val("up");
      $("#fileDiv").show();
   });
});
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>
