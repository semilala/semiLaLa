<%@page import="reply.dao.iReplyDao"%>
<%@page import="reply.dto.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="review.dto.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;
//System.out.println("mem : " + mem.getGender());

ReviewDto rdto = (ReviewDto)request.getAttribute("rdto");
//System.out.println("rdto : " + rdto.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reviewDetail</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">

<style type="text/css">
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

</style>

<!-- JQuery 인터넷에서 바로 실행 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<body style="margin:0px">
<%
if(mem == null){
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "./member/login.jsp";
   </script>
   <%
}else{
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
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp"> 홈 </a> > 커뮤니티 > <b>시술 후기</b> </p>
</section>

<section id="page_board">
<div class="tb_Head01">
<table class="contentTb">
<colgroup>
<col width="10%"><col width="30%"><col width="10%"><col width="30%">
</colgroup>
<tbody>
<tr>
   <td><b>작성자</b></td>
   <td><%=rdto.getName() %></td>
   <td><b>관리내용</b></td>
   <td><%=rdto.getManagement() %></td>
</tr>

<tr>
   <td><b>제목</b></td>
   <td><%=rdto.getTitle() %></td>
   <td><b>조회수</b></td>
   <td><%=rdto.getReadcount() %></td>
</tr>

<tr>
   <td><b>파일 이름</b></td>
   <%
   if(rdto.getFileNameAf() == null){
   %>
   <td>첨부된 파일이 없습니다.</td>   
   <td><b>작성일</b></td>
   <td><%=rdto.getWdate() %></td>   
   <%
   }else{
   %>
   <td><%=rdto.getFileNameBf() %>&nbsp;
   <input type="button" name="btnDown" value="다운로드" class="btn btn-secondary"
               onclick="location.href=
                  'filedown?fileNameBf=<%=rdto.getFileNameBf()%>&fileNameAf=<%= rdto.getFileNameAf()%>&seq=<%=rdto.getSeq()%>'">
   </td>
   <td><b>작성일</b></td>
   <td><%=rdto.getWdate() %></td>
      <%
   }
   %>
</tr>

<tr>
   <td><b>내용</b></td>
<td colspan="3" class="t_left">

<%if(rdto.getFileNameAf() == null){ 
   }else{
      %>
      <div align="center">
      <img alt="이미지없음" src="filedown?fileNameAf=<%=rdto.getFileNameAf()%>"style="max-width: 1000px" width="auto;" height="auto;">
      </div>
      <%
   }
   %>
   <br>
      <p style="margin:20px 0;line-height:1.8;white-space:pre-line;">
      <%=rdto.getContent() %>
      </p>
</td>
</tr>
<%
   if(mem.getId().equals(rdto.getId())){   // 자신의 글이라면
%>   
   <tr>
      <td colspan="4" align="center">
         <a href="reviewUpdate?seq=<%=rdto.getSeq()%>">
            <img alt="image" src="./image/combine_update.png">
         </a>
         <a href="reviewDelete?seq=<%= rdto.getSeq()%>" onclick="return deletechk()">
            <img alt="image" src="./image/combine_delete.png">
         </a>
         <a href="reviewList">
            <img alt="image" src="./image/combine_list.png">
         </a>
      </td>
   </tr>   
   <%}else{ %>
   <tr>
      <td colspan="4" align="center">
         <a href="reviewList">
            <img alt="image" src="./image/combine_list.png">
         </a>
      </td>
   </tr>   
   <%} %>
</tbody>
</table>
</div>
</section>
</div>
</div>
<br><br>

<%-- 댓글 영역 --%>
<div class="container" align="center" style="width: 600">
<table class="table table-sm replyTb">
<col width="25%"><col width="*"><col width="18%">
<%
List<ReplyDto> replyList = (List<ReplyDto>)request.getAttribute("plist");

if(replyList == null || replyList.size() == 0){
   
}else{
   for(int i = 0; i < replyList.size(); i++){
      ReplyDto pdto = replyList.get(i);
      
      if(pdto.getDel() == 1){ // 삭제 했을 때
      %>
         <tr>
            <td colspan="3" align="center"><font color="red"><b>작성자에 의해 삭제된 댓글입니다.</b></font>
         </tr>         
         
      <%
      }else{   // 삭제 안 했을 때  
         %>         
         <tr>
            <td><%=arrow(pdto.getDepth())%><%=pdto.getName()%>&nbsp;(<%=pdto.getWdate() %>)</td>
            <td>
               <input type="hidden" id="<%=pdto.getSeq()%>" value="<%=pdto.getSeq()%>">
               <p style="margin:20px 0;line-height:1.8;white-space:pre-line;">
                  <%=pdto.getContent() %>
               </p>            
            </td>
            <td align="center">
               <input type="button" name="answer" onclick="answer(<%=pdto.getSeq() %>)" value="답글달기" class="btn btn-outline-primary btn-sm">
            
            <%if(mem.getId().equals(pdto.getId())){ // 로그인한 사람과 같으면
            %>
               <input type="button" onclick="location.href='./replyDelete?seq=<%=pdto.getSeq() %>&pseq=<%=pdto.getPseq() %>'" value="삭제" class="btn btn-outline-danger btn-sm">             
            <%
               }
            %>
            </td>
         </tr>
         <%} %>
         
         <tr>
         <td colspan="3">
            <div id="demo<%=pdto.getSeq()%>" class="answerlayer" style="display: none;">
            
            <form action="replyAnswer" onsubmit="return reNullchk02(<%=pdto.getSeq() %>)" class="replyFrm02">
               <input type="hidden" name="seq" value="<%=pdto.getSeq()%>">
               <input type="hidden" name="id" value="<%=mem.getId()%>">
               <input type="hidden" name="tname" value="<%=pdto.getTname()%>">
               <input type="hidden" name="pseq" value="<%=pdto.getPseq()%>">
            
            <table class="table">
            <col width="25%"><col width="*"><col width="18%">
                  <tr> 
                     <td><%=arrow(pdto.getDepth())%><br><%=mem.getName()%></td> 
                     <td><textarea rows="3" cols="100%" name="content" id="content" style="resize:none;"></textarea></td>
                     <td>
                     <input type="submit" value="댓글달기" class="btn btn-outline-primary btn-sm">
                     <input type="button" value="취소" onclick="cancelReply(<%=pdto.getSeq() %>)" class="btn btn-outline-warning btn-sm"></td>
                  </tr>
            </table>
            </form>            
            </div>               
         </td>
         </tr>
         <%   
   } // for문 끝
}
%>
   </table>
</div>

<%!
// 댓글용 이미지용 함수
public String arrow(int depth){
   String rs = "<img src='./images/arrow.png' width='20px' height='20px'/>";
   String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
   
   String ts = "";
   
   for(int i = 0; i < depth; i++){
      ts += nbsp;
   }
   return depth==0?"":ts + rs;
}
%>
<br>

<%-- 댓글 입력 폼 --%>
<div align="center">
   <form action="replyInsert" onsubmit="return reNullchk01()" class="replyFrm01">
      <input type="hidden" name="pseq" value="<%=rdto.getSeq()%>">
      <input type="hidden" name="tname" value="<%=rdto.getTname()%>">
      <table>
         <tr>
            <td><input type="hidden" name="id" value="<%=mem.getId()%>">
               <%=mem.getName()%></td>
            <td><textarea rows="3" cols="80" name="content" id="content" style="resize: none;"></textarea></td>
            <td>
               <button type="submit" class="btn btn-outline-primary btn-sm">댓글달기</button>
            </td>
         </tr>
      </table>
   </form>
</div>
<br><br>
<script type="text/javascript">
// 댓글창 보이기
function answer(seq) {
   $("#demo" + seq).show();
}

//댓글입력창 숨기기
function cancelReply(seq){
   //$(".answerlayer").hide();
   $("#demo"+seq).hide();
}

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
   if( $.trim($("#demo" + id + " #content").val())=="" || $.trim($("#demo" + id + " #content").val())==null){
      alert("내용을 입력해 주세요");
      return false;
   }
   return true;
}
</script>
<%} %>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>