<%@page import="javax.naming.ldap.Rdn"%>
<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reviewWrite</title>


<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- JQuery 사용 인터넷에서 바로 실행 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<style type="text/css">

/* a태그 css */
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

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

</head>
<body>
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = new MemberDto();   // 
System.out.println("ologin = " + ologin);
if(ologin == null) {
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "../member/login.jsp";
   </script>
   <%
}
else {
   member = (MemberDto)ologin;   
}
%>
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01" >
<h3>고객 후기 글쓰기</h3>
</div>

<div align="center" class="center" >

<p id="page_mark" align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp"> 홈 </a> > <b>시술후기</b> </p>
<section id="page_board">
<div align="center">
<img alt="" src="../image/review_write_img.png">
</div>
<br><br>

<div class ="tb_Head01" align="center">
<form action="../reviewWrite" method="post" enctype="multipart/form-data" onsubmit="return nullchk()">
<table>
<colgroup>
   <col width="20%"><col width="*">
</colgroup>
<tr>
   <th>ID</th>
   
   <td><%=member.getId() %>
      <input type="hidden" name="id" value="<%=member.getId()%>">
   </td>
   
</tr>

<tr>
   <th>제목</th>
   <td>
      <input type="text" id="title" name="title" size="50">
   </td>
</tr>

<tr>
   <th>관리내용</th>
   <td>
      <select name="management" id="management">
         <option value="default">선택</option>
         <option value="보톡스">보톡스</option>
         <option value="피부클리닉">피부클리닉</option>
         <option value="리프팅">리프팅</option>
      </select>
   </td>
</tr>

<tr>
   <%--파일 업로드는 input타입을 file로 해주어야 한다.! getParameter로 받을 수 없다. --%>
   <th>첨부파일</th>
   <td>
      <input type="file" name="fileload" style="width: 400px">
   </td>
</tr>

<tr>
   <th>내용</th>
   <td>
      <textarea rows="20" cols="100" id="content" name="content" style="resize: none;"></textarea>
   </td>
</tr>



</table>
<br>
 <input type="image" src="../image/combine_write.png" >
</form>
</div>
</section>
<!-- 확인/수정 등 버튼 간격조정 -->
</div>
<br><br>

<script type="text/javascript">
function nullchk() {
   if($("#title").val()==null || $("#title").val() == ""){
      alert("제목을 입력해주세요.")
      $("#title").focus();
      return false;
   }   
   if(   $("#management option:eq(0)").prop("selected")){
        alert("관리내용을 선택해주세요");
        return false;
     }   
   if($("#content").val().trim()==null || $("#content").val().trim() == ""){
      alert("내용을 입력해주세요.");
      $("#content").focus();
      return false;
   }   
   return true;
}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>