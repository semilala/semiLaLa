<%@page import="review.dto.ReviewDto"%>
<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reviewUpdate</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  

<!-- JQuery 인터넷에서 바로 실행 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">

<!-- css -->
<style type="text/css">

a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

.filebtnlayer{
   display: none;
}
.changebtnlayer{
   display: none;
}
.filebtn {

  background-image : url('./image/combine_update.png'); 

  background-position:top right; 

  background-repeat:no-repeat;
}

</style>


</head>
<body style="margin:0px">
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = new MemberDto();   // 
// System.out.println("ologin = " + ologin);

// 수정할 리뷰 dto를 받아옴
ReviewDto rdto = (ReviewDto)request.getAttribute("getReview");
System.out.println("rdto.toString : " + rdto.toString());
if(ologin == null) {   // 로그인 안하면 안됨
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "./member/login.jsp";
   </script>
   <%
}else {
   member = (MemberDto)ologin;
   if(!member.getId().equals(rdto.getId())){   // 자기글 아니면 안됨
      %>
      <script type="text/javascript">
         alert("접근권한이 없습니다.");
         location.href = "/LalaClinic/index.jsp";
        </script>
      <%
   }
}

%>
<!-- 상단 -->
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<!-- 상단이미지 -->
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/lala_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<div class="tb_top01">
<h3>시술 후기</h3>

<div class="center" align="center"> 

<section id="page_mark">
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp"> 홈 </a> > <b>시술 후기</b> </p>
</section>

<section id="page_board">
<div class="tb_Head01">

<form action="reviewUpdate" method="post" enctype="multipart/form-data" onsubmit="return nullchk()">
<table class="contentTb">

<colgroup>
<col width="10%"><col width="30%"><col width="10%"><col width="30%">
</colgroup>

<tbody>
<tr>
   <td><b>관리내용</b></td>
   <td>
      <input type="hidden" id="mana" value="<%=rdto.getManagement()%>">
      <select id="management" name="management" class="form-control">
         <option value="선택">선택</option>      
         <option value="보톡스"
         <%if(rdto.getManagement().equals("보톡스")){ %>
            selected="selected"
         <%} %>
         >보톡스</option>         
         <option value="피부클리닉"
         <%if(rdto.getManagement().equals("피부클리닉")){ %>
            selected="selected"
         <%} %>
         >피부클리닉</option>
         <option value="리프팅"
         <%if(rdto.getManagement().equals("리프팅")){ %>
            selected="selected"
         <%} %>
         >리프팅</option>
      </select>
   </td>
   <td><b>작성자</b></td>
   <td><%=rdto.getId()%>
      <input type="hidden" size="30" name='id' value="<%=rdto.getId() %>" readonly="readonly">
      <input type="hidden" name='seq' value="<%=rdto.getSeq()%>">
   </td>
</tr>

<tr>
   <td><b>제목</b></td>
   <td><input type="text" class="form-control" size="30" id="title" name='title' value="<%=rdto.getTitle() %>" ></td>
   <td><b>조회수</b></td>
   <td><%=rdto.getReadcount() %></td>
</tr>

<tr class="changebtnlayer">
      <td><b>첨부파일</b></td>
      <td colspan="3">
      <%if(rdto.getFileNameBf() == null){
         %>
         첨부된 파일이 없습니다.   
         <input type="button" value="파일업로드" name="changefile" id="changefile" onclick="viewBtn()">      
         <%
         }else{
            %>
            <input type="text" readonly style="border:none" id="fileName" value="<%=rdto.getFileNameBf() %>"> &nbsp;
            <input type="button" value="변경" name="changefile" id="changefile" onclick="viewBtn()">
            <input type="button" value="삭제" name="deletefile" id="deletefile" onclick="deleteFile()">            
            <%
         }
      %>
      </td>
   </tr>
   <tr class="filebtnlayer">
      <td><b>첨부파일</b></td>
      <td colspan="3">
         <input type="file" style="width: 250px" name ="fileload" onclick="fileLoad()">
         <input type="button" id="offbtn"  value="취소" onclick="offBtn()">
      </td>
   </tr>

<tr>
   <td><b>내용</b></td>
   <td colspan="3">
   <textarea rows="20" cols="120" id="content" name="content" style="resize: none;"><%=rdto.getContent() %></textarea>
   </td>
</tr>
<tr align="center">
   <td colspan="4">
      <input type="image" src="./image/accept.png"> 
      <!-- <input type="submit" value="내용 수정" > -->
   </td>
</tr>
</tbody>
</table> 
<input type="hidden" name="filechk" id="filechk" value="ex">
</form>
</div>
</section>
</div>
<br><br>
</div>
<script type="text/javascript">
$(document).ready(function() {
   // 변경/삭제 버튼 보여주게하는 default값
   $('.changebtnlayer').show();   
});

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

function nullchk() {
   if($("#title").val()==null || $("#title").val().trim() == ""){
      alert("제목을 입력해주세요.")
      $("#title").focus();
      return false;
   }   
   if(   $("#management option:eq(0)").prop("selected")){
        alert("관리내용을 선택해주세요");
        return false;
     }   
   if($("#content").val().trim() ==null || $("#content").val().trim() == ""){
      alert("내용을 입력해주세요.");
      $("#content").focus();
      return false;
   }   
   return true;
}
</script>

<footer>
   <jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>
</body>
</html>