<%@page import="member.dto.MemberDto"%>
<%@page import="custom.dto.CustomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.layer{
   display: none;
}
.filebtnlayer{
   display: none;
}
.changebtnlayer{
   display: none;
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
<meta charset="UTF-8">
<title>custom_update.jsp</title>
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;

String id = request.getParameter("id");
String sseq = request.getParameter("seq");
String fileload = request.getParameter("fileName");
String title = request.getParameter("title");
String content = request.getParameter("content");

if(ologin==null ) {
   %>
  <script type="text/javascript">
	alert("접근권한이 없습니다.");
   location.href="/LalaClinic/index.jsp";
  </script>
   <%
}
else {
   member = (MemberDto)ologin;
   if( !member.getId().equals(id)){
	   %>
	   <script type="text/javascript">
	 	alert("접근권한이 없습니다.");
	    location.href="/LalaClinic/index.jsp";
	   </script>
	    <% 
   }
   
}
%>
<%




if(fileload == null || fileload.equals("null")){
   fileload = " ";
   
}

%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body style="margin:0;">
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01" >
<h3>고객소리함</h3>
</div>
<div align="center" class="center" >

<p id="page_mark" align ="right" style="font-size: 13px"> 홈 > <b>고객소리함</b> </p>
<section id="page_board">
<div align="center">
<img alt="" src="../image/custom_write_img6.png">
</div>
<br><br>

<div class ="tb_Head01" align="center">
<form action="../customUpdate" method="post" enctype="multipart/form-data">
<table>
<colgroup>
   <col width="20%"><col width="*">
</colgroup>
<tr>
<th>글번호</th>
<td><input type="hidden" name="seq" value="<%=sseq %>"><%=sseq %></td>
</tr>
<tr>
<th>이름</th>
<td><input type="hidden" name="name" value="<%=member.getName() %>"><%=member.getName() %></td>
</tr>

<tr>
<th>제목</th>
<td><input type="text" id="title" name="title" value="<%=title %>"></td>
</tr>


<tr>
<th valign="top">내용</th>
<td><textarea rows="15" cols="70" id="content" name="content"><%=content %></textarea></td>
</tr>


<tr>
<tr class="changebtnlayer">
      <th>첨부파일</th>
      <td>
         <input type="text" readonly style="border:none" id="fileName" value="<%=fileload==null?"첨부된 파일이 없습니다":fileload%>"> &nbsp;
         <input type="button" value="변경" name="changefile" id="changefile" onclick="viewBtn()">
<%--        	 <%if(fileload == null || fileload.equals("")) {%> --%>
<!--        	 첨부된 파일이 없습니다. -->
<%--        	 <%}else{ %> --%>
         <input type="button" value="삭제" name="deletefile" id="deletefile" onclick="deleteFile()">
<%--       		<%} %> --%>
      </td>
   </tr>
   <tr class="filebtnlayer">
      <th>첨부파일</th>
      <td>
<!--          <input type="file"  style="width: 400px;" name="fileload" onclick="fileload()"> -->
         <input type="file" style="width: 400px" name ="fileload" onclick="fileLoad()">
         <input type="button" id="offbtn"  value="취소" onclick="offBtn()">
      </td>
   </tr>
</tr>

</table>

<br>
<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="filechk" id="filechk" value="ex">
<input type="image" src="../image/accept.png" onclick="return chk()">

</form>
</div>
</section>
<!-- 확인/수정 등 버튼 간격조정 -->
<br><br>
</div>
<br><br><br>
<script type="text/javascript">

function fileLoad(){
   $("#filechk").val("up");
}

function viewBtn(){
   $('.filebtnlayer').show();
   $('.changebtnlayer').hide();
}
function offBtn(){
   $('.filebtnlayer').hide();
   $('.changebtnlayer').show();
}
function deleteFile(){
   $("#fileName").val("");
   $("#filechk").val("del");
}

$(document).ready(function () {
      $('.changebtnlayer').show();
});
function chk() {
   if($("#title").val() == null || $("#title").val() == ""){
      alert("제목을 입력해주세요");
      $("#title").focus();
      return false;
   }
   else if($("#content").val() == null || $("#content").val() == ""){
      alert("내용을 입력해주세요");
      $("#content").focus();
      return false;
   }

}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>