<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
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



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
table{
   /*  border-bottom: 1px dotted #e8e3e3;  */
   
   
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
#page_board {
    clear: all;
    margin: 0;
    padding: 50px 50px 15px 50px;
    z-index: 1;
    text-align: left;
    font-size: 10pt;
}

</style>
<title>라라클리닉 역삼점</title>
<!-- <script type="text/javascript" src="./nse_files/js/HuskyEZCreator.js" charset="utf-8"></script> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>


<style type="text/css">
/* .layer{
   display: none;
} */
</style>
</head>
<body>

<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<div class="tb_top01" >
<h3>자료 등록</h3>
</div>
<div align="center" class="center" >

<p id="page_mark" align ="right" style="font-size: 13px"> 홈 > <b>자료게시판</b> </p>
<section id="page_board">

<br>

<div class ="tb_Head01" align="center">
<form action="/LalaClinic/DownWrite" method="post" enctype="multipart/form-data" onsubmit="return nullchk()">
<table>
<colgroup>
   <col width="20%"> <col width="*">
</colgroup>

<thead>
</thead>

<tbody>
<tr>
   <th>작성자</th>
   <td>${login.name}</td>
</tr>
<tr>
   <th>글제목</th>
   <td><input type="text" name="title" id="title" style="width: 502px;"></td>
</tr>
<tr>
   <th>내용</th>
   <td><textarea rows="10" cols="80" name="content" style="resize: none;" id="content"></textarea></td>
</tr>
<tr>
   <th>첨부파일</th>
   <td>
      <input type="file" style="width: 400px;" name="fileload" id="fileload">
   </td>
</tr>
</tbody>
</table><br><br>
<input type="hidden" value="${login.id}" name="id">
<input type="image" src="../image/accept.png"> 
</form>
</div>
</section>
<!-- 확인/수정 등 버튼 간격조정 -->
<br>
</div>
<br><br><br>

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
   if($("#fileload").val()==null || $("#fileload").val()=="") {
      alert("파일을 등록해 주세요.");
      return false;
   }
   
   return true;
}
</script>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>

</body>
</html>