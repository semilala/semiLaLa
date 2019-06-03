<%@page import="util.UtilClass"%>
<%@page import="java.util.ArrayList"%>
<%@page import="paging.PagingBean"%>
<%@page import="util.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="combine.dto.CombineDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
System.out.println("----------------2");
CombineDto com = (CombineDto)request.getAttribute("com");

List<ReplyDto> reply = new ArrayList<>(); 
reply = (List<ReplyDto>)request.getAttribute("reply");
%>
<%
String year = com.getRdate().substring(0, 4);
String month = com.getRdate().substring(4, 6);
String day = com.getRdate().substring(6, 8);
String hour = com.getRdate().substring(8, 10);
%>

<%

PagingBean paging = new PagingBean();
paging = (PagingBean)request.getAttribute("paging");
if(request.getParameter("nowPage") == null){
   paging.setNowPage(1);   
}else{
   paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
}
System.out.println("----------------3");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript"src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.layout{
display:none;
}
.inputReply{
display:none;
}

</style>
<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">
<link rel="stylesheet" href="css/reply.css">
</head>
<body>
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin == null) {
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "./member/login.jsp";
   </script>
   <%
}
else {
   user = (MemberDto)ologin;   
}
if(!user.getId().equals(com.getId()) && user.getAuth() == 0){
    %>
      <script type="text/javascript">
      alert("접근권한이 없습니다.");
      location.href = "/LalaClinic/CombineList";
      </script>
    <%
}
%>

<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="wrapper" >
<!-- <section id="page_tab"> -->
<!-- 
   <table class="contentTb">
   <tbody>
      <tr>
         <td style="font-weight:bold;">
            <a href="CombineList"><h3>상담 및 예약</h3></a>
         </td>
      </tr>
   </tbody>
   </table> -->
   <a href="CombineList"><h3 id="h3">상담 및 예약</h3></a>
<!-- </section> -->
<div align="center" class="center" >

<section id="page_mark">
   <p align ="right" style="font-size: 13px"> 
         <a href="/LalaClinic/index.jsp">홈</a> > 
      
         <a href="/LalaClinic/CombineList" ><span class="bold">상담 및 예약</span> </a>
      
   </p>
</section>
<section id="page_board">
<div class ="tb_Head01" >
<form action="./CombineUpdate" method="get">
<input type="hidden" value="bf" name="command">
<table id="detailTb">
<colgroup>
   <col width="70"> <col> <col>
</colgroup>

<thead>
</thead>

<tbody>
   <tr class="t_right"> 
      <td align="center" style="border-top:solid 2px #ebebeb"><img src="./image/question.png" alt="질문"></td>
      <td valign="middle" class="t_left" style="border-top:solid 2px #ebebeb"><h3 class="h3"><%=com.getTitle() %></h3></td>
      <td colspan="2" class="t_right" style="border-top:solid 2px #ebebeb;padding-right:10px;">
      [역삼점] <b><%=com.getName() %></b> &nbsp;등록일 : <%=com.getWdate().substring(0,com.getWdate().lastIndexOf(".")) %>                                       </td>
   </tr>
   <tr class="layout t_right" style="border-top:solid 2px #ebebeb">
      <th>시술항목</th>
      <td style="text-align:left">
         <input type="hidden" value="<%=com.getMedical() %>" name="medical">
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><%=com.getMedical() %></span>
      </td>
      <td></td>
      <td style="text-align:right">
         <b>희망 예약날짜</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <span><%=year%>년 <%=month%>월 <%=day %>일 <%=hour %>시</span>
      </td>
   </tr>
   <tr>
      <td style="text-align: center"><b>첨부파일</b></td>
      <%if(com.getFileNameAf() == null){
      %>
      <td colspan="3">
         <span>첨부된 파일이 없습니다.</span>
      </td>
      <%
      }else{
      %>
      <td colspan="3">
         <input type="button" name="btnDown" value="다운로드"
            class="btn btn-secondary" onclick="location.href='filedown?fileNameBf=<%=com.getFileNameBf()%>&fileNameAf=<%=com.getFileNameAf() %>&seq=<%=com.getSeq()%>'">
         <span><%=com.getFileNameBf() %></span>
      </td>
      <%
      }
      %>
   </tr>
   <tr style="border-top:solid 2px #ebebeb"> 
      <td></td>
      <td colspan="4" class="t_left">
         <p style="margin:20px 0;line-height:1.8;white-space:pre-line;">
            <%=com.getContent() %>
         </p>
         
         <div class="t_right marT10">
         <%
         if(user.getId() != null){
            if(user.getId().equals(com.getId())){
         %>
            <input type="image" src="./image/combine_update.png" class="ver_bottom"> 
            <a href="./CombineDelete?seq=<%=com.getSeq() %>" onclick="return deletechk()" class="ver_bottom">
               <img src="./image/combine_delete.png" class="ver_bottom">
            </a>
         <%
            }
         }
         %>   
         <a href="./CombineList"><img src="./image/show_list.png" alt="목록" class="ver_bottom"></a>
         </div>               
      </td>

         
   </tr>
   <%-- 
   <tr>
      <th>성명</th>
      <td>
         <span><%=com.getName() %></span>
         <input type="hidden" value="<%=com.getName() %>"  name = "name">&nbsp;
      </td>
   </tr>
   --%>
   <input type="hidden" value="<%=com.getInquire() %>" name= "inquire" id="inquire">
   <%--
   <tr>
      <th>글제목</th>
      <td>
         <span><%=com.getTitle() %></span>
         <input type="hidden" value="<%=com.getTitle() %>"name="title">
      </td>
   </tr>
   <tr>
      <th>내용</th>
      <td>
         <textarea style="border:none;resize: none;" rows="10" cols="80" name=content readonly><%=com.getContent() %></textarea>
      </td>
   </tr>
   --%>
   
   
</tbody>
</table>
<hr style="border-bottom: 1px solid #ebebeb">
<input type="hidden" value="<%=com.getSeq() %>" name="seq">

</form>
<table class="replyTb">

   <%
   System.out.println("reply size() = " + reply.size());
   if(reply.size() < 1){
   %>
      <tr>
         <td colspan="2" style="text-align: center;">작성된 댓글이 없습니다.</td>
      </tr>
<%
   }else{
      for(int i = 0 ; i < reply.size(); i++){
         ReplyDto re = reply.get(i);
         if(re.getDel() == 1){
   %>
         <tr>
            <td></td><td colspan="2"><font color="red"><%=UtilClass.arrow(re.getDepth()) %><b>작성자에 의해 삭제된 댓글입니다.</b></font>
         </tr>
      <%
         }else{
      %>
         <tr>
            <td></td>
               <td>
                  <%=UtilClass.arrow(re.getDepth()) %><sapn><%=re.getName() %> (<%=re.getWdate().substring(0,re.getWdate().lastIndexOf(".")) %>) </sapn>
                  <span class="aRight">
                  <%
                  if(re.getDepth()==0){
                  %>   
                     <a class="btnReply txtEvent" val1 ="<%=re.getSeq()%>">댓글달기</a>
<%--                      <input type="button" value="댓글달기" class="btnReply rainbowLink" val1 ="<%=re.getSeq()%>"> --%>
                  <%
                  }
                  %>
            
       <%
             if(user.getId().equals(re.getId())){   
      %>
                 <a id="delReply" href="./CombineReplyDelete?seq=<%=re.getSeq() %>&pseq=<%=com.getSeq()%>" class="txtEvent">삭제</a>
                </span>
       <%
             }
       %>
             </td>
         </tr>
         
         <tr>
            <td></td>
            <td>
               <%=UtilClass.nbsp(re.getDepth()) %>
               <textarea id="showContent"readonly="readonly" rows="5" cols="140" style="border:none;height:auto;resize: none;"><%=re.getContent() %></textarea>
            </td>
         </tr>
   <%
         }
   %>
      <tr>
         <td colspan="2">
            <div id="<%=re.getSeq()%>" Class="inputReply" style="display:none" >
            
               <form action="./CombineReplyAddInsert" method="get" id="addRep" onsubmit="return reNullchk02(<%=re.getSeq() %>)" class="replyFrm02">
                  <input type="hidden" name="pseq" value="<%=com.getSeq() %>">
                  <input type="hidden" name="id" value="<%=user.getId() %>">
                  <input type="hidden" name="auth" value="<%=user.getAuth() %>">
                  <input type="hidden" name="ref" id="ref" value="<%=re.getRef()%>" >
                  <input type="hidden" name="step" id="step" value="<%=re.getStep() %>">
                  <input type="hidden" name="depth" id="depth" value="<%=re.getDepth()%>">
                  <table class="inputReplyTb"> 
                  <col width="20%"><col width="50%"><col width="15%"><col width="15%">
                     <tr>
                        <td colspan="4"style="border-bottom:1px solid #e9e9e9"></td>
                     </tr>
                     <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;<%=user.getName() %></td>
                        <td><textarea rows="3" cols="110" name="content" id="content" style="resize:none;height:auto"></textarea></td>
                           <td style="padding-left:30px;"><input type="submit" value="댓글달기" class="btn btn-outline-primary btn-sm ver_bottm"></td>
                           <td><input type="button" value="취소" class="btn btn-outline-warning btn-sm ver_bottom" onclick="cancelReply('<%=re.getSeq()%>')"></td>
                      </tr>
                  </table>
               </form>
               
            </div>
            <hr style="border: 1px solid #e8e8e8;">
         </td>
      </tr>
   <%
      }
   }
   %>
</table><br>
<div class="pgdiv">
<span class="pgspan">
<jsp:include page="../paging.jsp">
   <jsp:param name="actionPath" value="./CombineDetail"/>
   <jsp:param name="nowPage" value="<%=paging.getNowPage() %>" />
   <jsp:param name="totalCount" value="<%=paging.getTotalCount() %>" />
   <jsp:param name="countPerPage" value="<%=paging.getCountPerPage() %>" />
   <jsp:param name="blockCount" value="<%=paging.getBlockCount() %>" />
   
   <jsp:param name="seq" value="<%=com.getSeq() %>"/>
</jsp:include>
</span>
</div>
<form action="./CombineReplyInsert" method="get" onsubmit="return reNullchk01()" class="replyFrm01">
   <input type="hidden" name="pseq" id="pseq" value="<%=com.getSeq()%>">
   <input type="hidden" name="id" value="<%=user.getId() %>" >
   <input type="hidden" name="auth" value="<%=user.getAuth() %>">
   
   <table class="inputReplyTb">
   <col width="20%"><col width="60%"><col width="20%">
   <tr>
      <td><%=user.getName() %></td>
      <td><textarea rows="5" cols="100" name="content" id="content" style="resize:none;height:auto"></textarea></td>
      <td><input type="submit" value="댓글달기" class="btn btn-outline-primary"></td>
   </tr>
   </table>
</form>
      </div>
   </section>
</div>
</div>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
<script type="text/javascript">

//대댓글입력창
$(".btnReply").click(function() {
    $("#"+$(this).attr("val1")).show();
 });

//대댓글입력창 숨기기
function cancelReply( divid ){
   $($("#" + divid)).hide();
}

//디테일에서 문의항목이 상담이냐 예약이냐에따라 보이는게 다름
$(document).ready(function () {
   if($("#inquire").val() == '예약'){
      $(".layout").show();
   }else if($("#inquire").val() == '상담'){
      $(".layout").hide();
   }
   
   
   
});

//게시글 삭제할건지물어봄
function deletechk(){
   if(confirm("정말 삭제하시겠습니까?")){
      return true;
   }else{
      return false;
   }
}
function reNullchk01() {
   if( $.trim($(".replyFrm01 #content").val())=="" || $.trim($(".replyFrm01 #content").val())==null){
      alert("내용을 입력해 주세요");
      return false;
   }
   return true;
}
function reNullchk02( id ) {
   if( $.trim($("#" + id + " #content").val())=="" || $.trim($("#" + id + " #content").val())==null){
      alert("내용을 입력해 주세요");
      return false;
   }
   return true;
}
</script>
</body>
</html>