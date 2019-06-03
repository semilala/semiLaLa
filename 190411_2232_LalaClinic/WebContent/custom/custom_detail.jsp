<%@page import="java.util.ArrayList"%>
<%@page import="util.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="custom.dto.CustomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">

<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">
<link rel="stylesheet" href="css/reply.css">
<title>custom_detail.jsp</title>
</head>

<%
CustomDto dto = (CustomDto)request.getAttribute("customdetail");

Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {%>
   <script type="text/javascript">
   alert("접근권한이 없습니다.");
   location.href="/LalaClinic/index.jsp";
  </script> <% 
}
else {
   user = (MemberDto)ologin;
   if(!user.getId().equals(dto.getId()) && user.getAuth() == 0){%>
      
      <script type="text/javascript">
   alert("접근권한이 없습니다.");
   location.href="/LalaClinic/index.jsp";
  </script>
      
 <%  }
}
%>

<body>
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="wrapper" >
<section id="page_tab">
   <table class="contentTb">
   <tbody>
      <tr>
         <td style="font-weight:bold;">
            <a href="CombineList">고객소리함</a>
         </td>
      </tr>
   </tbody>
   </table>
</section>
<!-- <section id="page_mark">
   <a href="../member/mainPage.jsp"><p align ="right" style="font-size: 13px"> 홈 > 마이페이지 ></a><span class="bold">고객소리함</span> </p>
</section> -->
<section id="page_mark">
   <a href="/LalaClinic/index.jsp"><p align ="right" style="font-size: 13px"> 홈</a> > <a href="/LalaClinic/MyWriteCustomList">마이페이지</a> ><span class="bold">고객소리함</span> </p>
</section>
<section id="page_board">
<div class ="tb_Head01" >
<form action="custom/custom_update.jsp" method="get" id="frm">
<input type="hidden" value="bf" name="command">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">

<table id="detailTb" align="center" class="contentTb">
<col width="150"><col> <col>
<thead>
</thead>
<tbody>
   <tr class="t_right" style="border-top:solid 2px #ebebeb">
      <td valign="middle"> 
         <span class="right"><img src="./image/question.png" alt="질문"></span>
      </td>
      <td style="text-align:left">
         <span style="font-weight:bold;"><%=dto.getTitle() %></span>
      </td>
      <td class="t_right" style="border-top:solid 2px #ebebeb;padding-right:10px;">
      <strong class="strong">[역삼점] <%=dto.getName() %></strong> &nbsp;등록일 : <%=dto.getWdate().substring(0,dto.getWdate().lastIndexOf(".")) %>                                       </td>
   </tr>
  
<tr class="t_right">
   <td style="font-weight: bold">첨부파일</td>
      <%if(dto.getFileNameAf() == null){
      %>
      <td colspan="2" style="text-align:left">
         <span>첨부된 파일이 없습니다.</span>
      </td>
      <%
      }else{
      %>
      <td colspan="2" style="text-align:left">
         <input type="button" name="btnDown" value="다운" class="btn btn-secondary"
            onclick="location.href='customfiledown?fileNameBf=<%=dto.getFileNameBf()%>&fileNameAf=<%=dto.getFileNameAf() %>&seq=<%=dto.getSeq()%>'">
         <span class="fName">&nbsp;&nbsp;&nbsp;&nbsp;<%=dto.getFileNameBf() %></span>
      </td>
      <%
      }
      %>
</tr>
<tr>
   <td colspan="3" class="t_left">
      <p class="t_pad" style="margin:20px 0;line-height:1.8;white-space:pre-line;">
         <%=dto.getContent() %>
      </p>
   <div class="t_right marT10">
      <a href="MyWriteCustomList"><img src="./image/combine_list.png"></a>
      <%if(user.getAuth() == 0){ %>
         <input type="hidden" name="title" value="<%=dto.getTitle()%>">
         <input type="hidden" name="content" value="<%=dto.getContent()%>">
         <a href="javascript:frm.submit();" ><img src="./image/combine_update.png"></a>
         <a href="customDelete?seq=<%=dto.getSeq()%>" onclick="return delchk()"><img src="./image/combine_delete.png"></a>
   </div>
   <%} %>
   </td>
</tr>
</table><br>
<input type="hidden" name="id" value="<%=dto.getId() %>">
<input type="hidden" name="fileName" value="<%=dto.getFileNameBf()%>">
<input type="hidden" name="wdate" value="<%=dto.getWdate() %>">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">

<%
List<ReplyDto> reply = new ArrayList<>(); 
reply = (List<ReplyDto>)request.getAttribute("reply");
%>
<form action="">

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
         if(re.getDel()==1){
            %>
       <tr>
            <td colspan="2"><font color="red"><b>작성자에 의해 삭제된 댓글입니다.</b></font>
               <hr style="border: 1px solid #e8e8e8;">
            </td>            
             
       </tr>
            <% 
         }
   else if(re.getDel()==0) {%>
      <tr>
        <td>
            <sapn> <%=re.getName() %> (<%=re.getWdate().substring(0,re.getWdate().lastIndexOf(".")) %>)</span>
         </td>
         <td>
            <span class="aaRight">
         <%if(re.getId().equals(user.getId())) {%>
            <a id="del" href="./customReplyDelte?seq=<%=re.getSeq() %>&pseq=<%=dto.getSeq()%>" class="txtEvent">삭제</a>
<%--          <input class="txtEvent" type="button" value="삭제" id="del" onclick="reDel(<%=re.getSeq() %>, <%=dto.getSeq()%>)"> --%>
         <%} %>
             </span>
         </td>
          
      </tr>
      <tr>
         <td colspan="2" height="50px;">
          <p class="t_pad"  style="margin:20px 0;line-height:1.8;white-space:pre-line;">
         <%=re.getContent() %>
         <input type="hidden" name="content" value="  <%=re.getContent() %>">
      </p>
        <%--   <textarea rows="5" cols="130" style="border:none;height:auto;resize: none;" name="content"><%=re.getContent() %></textarea> 
     --%>        <hr style="border: 1px solid #e8e8e8;">
         </td>
      </tr>
       <%
         }
         }%>
        
  
      
   <%   
      
      }
   
   %>
   </tbody>
</table>
</form>
</form>
<form action="./customReplyInsert">
<input type="hidden" name="pseq" value="<%=dto.getSeq() %>">
<input type="hidden" name="id" value="<%=user.getId() %>" >
<input type="hidden" name="auth" value="<%=user.getAuth()%>"> 

<table class="inputReplyTb">
<col width="20%"><col width="60%"><col width="20%">
   <tr>
      <td><%=user.getName() %></td>
      <td>
         <textarea rows="5" cols="100" name="content" id="content" style="resize:none;height:auto"></textarea>
      </td>
      <td>
         <input type="submit" value="댓글달기" class="btn btn-outline-primary" onclick="return reChk()">
      </td>
   </tr>
   
</table>
</form>
      </div>
   </section>
</div>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
<script type="text/javascript">
function reDel( seq, pseq ) {
   location.href="./customReplyDelte?seq="+ seq + "&pseq=" + pseq;
   
};
function reChk() {

   
   if($("#content").val() == null || $("#content").val().trim() == "" ){
      alert("댓글을 입력해주세요.");
      return false;
   }
      
};
function delchk(){
    if(confirm("정말 삭제하시겠습니까?")){
         return true;
      }else{
         return false;
      }
}




</script>

</body>
</html>