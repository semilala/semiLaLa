<%@page import="java.io.IOException"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin==null) {
   %>
 <script type="text/javascript">
	alert("접근권한이 없습니다.");
   location.href="/LalaClinic/index.jsp";
  </script>
   <%
}
else {
   member = (MemberDto)ologin;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
table tr{
    border-bottom: 1px dotted gray; 
   

}
table td,th{
   padding-top: 10px;
   padding-bottom: 10px;
   
}


body{
   font-family: 'Nanum Gothic', sans-serif;
   /* font-size : 10px; */
   background-color: #f9f9f9;
}

a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

</style>


<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>custom_write.jsp</title>
</head>
<body>

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

<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp"> 홈 </a> > <b>고객소리함</b> </p>

<div align="center">
<img alt="" src="../image/custom_write_img6.png">
</div>
<br><br>

<div class ="tb_Head01" align="center">
<form action="/LalaClinic/customInsert" method="post" enctype="multipart/form-data">

<table>
<colgroup>
   <col width="10%"><col width="*">
</colgroup>
<tr>
<th>이름</th>
<td><input type="hidden" name="id" value="<%=member.getName() %>"><%=member.getName() %>
<input type="hidden" name="id" value="<%=member.getId() %>">
</td>
</tr>


<tr>
<th>제목</th>
<td><input type="text" name="title" value="" id="title" style="width: 512px;"></td>
</tr>


<tr>
<th valign="top">내용</th>
<td><textarea rows="15" cols="70" name="content" id="content"></textarea></td>
</tr>


<tr>
<th>파일이름</th>
<td>&nbsp;<input type="file" name="fileName"></td>
</tr>


</table>
<br>
<input type="image" src="../image/accept.png" onclick="return chk()">
</form>
</div>

<br><br><br>





<script type="text/javascript">

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
</div>

<!-- footer -->
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>