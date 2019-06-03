<%@page import="util.UtilClass"%>
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
   location.href = "/LalaClinic/index.jsp";
   </script>
   <%
}
else {
   user = (MemberDto)ologin;
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
<link rel="stylesheet" href="css/bbs.css">
<link rel="stylesheet" href="css/reply.css">

<script type="text/javascript"src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>라라클리닉 역삼점</title>
<style type="text/css">
.layout{
	display:none;
}


</style>
</head>

<body style="margin: 0;">
<div class="categoryTop">
	<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<div class="wrapper" >
<a href="DownList"><h3 id="h3" style="border-bottom:solid 3px #000;">자료 게시판</h3></a>

<section id="page_mark">
   <a href="/LalaClinic/index.jsp"><p align ="right" style="font-size: 13px"> 홈 > </a><span class="bold">자료게시판</span> </p>
</section>

<section id="page_board">
<div class ="tb_Head01" >
<table id="detailTb" class="downDetailTb">
<colgroup>
   <col width="15%"><col width="35%"><col width="15%"><col width="35%">
</colgroup>

<thead>
</thead>

<tbody>
<tr class="titleTr"> 
	<td style="text-align: center"><b>제목</b></td>
	<td>${dto.title}</td>
	<td colspan="2" class="title_right">
   		<strong class="strong">[역삼점] ${dto.name}</strong>&nbsp;등록일 : ${dto.wdate}
	</td>
	<td style="text-align: center"><b>조회수</b></td>
	<td>${dto.readCount}</td>
</tr>
<tr>
   <td style="text-align: center"><b>첨부파일</b></td>
   <td colspan="4">
   <c:choose>
      <c:when test="${empty dto.fileNameAf}">첨부된 파일이 없습니다</c:when>
      <c:when test="${not empty dto.fileNameAf}">
         <input type="button" name="btnDown" value="다운로드"  class="btn btn-secondary"
            onclick="location.href='downfiledown?fileNameBf=${dto.fileNameBf}&fileNameAf=${dto.fileNameAf}&seq=${dto.seq}'">
         <span>${dto.fileNameBf}</span>
      </c:when>
   </c:choose>
   </td>
</tr>
<tr>
	<td style="text-align: center"><b>내용</b></td>
  <td colspan="4" class="t_left" style="padding-left:50px;">
	   <p style="margin:20px 0;line-height:1.8;white-space:pre-line;">
	      ${dto.content}
	   </p>
	   
	   <div class="t_right marT10">
	   <!-- 관리자일 경우 수정,삭제버튼이 표시된다 -->
	   <c:if test="${login.auth eq 1}">
	      <input type="image" src="./image/combine_update.png" onclick="location.href='/LalaClinic/DownUpdate?seq=${dto.seq}'">
	      <input type="image" src="./image/combine_delete.png" onclick="return deletechk();">
	   </c:if>
	   	<input type="image" src="./image/combine_list.png" onclick="location.href='DownList'">
	   </div>
   </td>
</tr>
</tbody>
</table>

<hr style="border-bottom: 1px solid #ebebeb">

<!-- 댓글목록 테이블 시작 -->
<table class="replyTb replyTb_a">
<c:if test="${list.size() eq 0}">
   <tr><td style="text-align:center">작성된 댓글이 없습니다.</td></tr>
</c:if>

<!-- 댓글 리스트 출력 시작 -->
<c:if test="${list.size() > 0 }">
   <c:forEach items="${list}" var="m">
   <c:if test="${m.del eq 0}"> <!-- 삭제된글이 아니라면 이름,작성일 화면에 표시 -->
   <tr>
      <td>
         <!-- 뎁스가 있을시 띄워주는부분 -->
         <c:if test="${m.depth > 0}">
            <c:forEach var="i" begin="1" end="${m.depth}" step="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
            <img src='images/arrow.png' width='20px' height='20px'/>
         </c:if>
         <span><b>${m.name} ( ${m.wdate} )</b></span>
         <span class="adRight">
            <c:if test="${m.depth eq 0}">
				<%-- <button type="button" class="btn btn-outline-primary btnReply" val="${m.seq}">댓글달기</button> --%>
				<a class="btnReply txtEvent" val="${m.seq}">댓글달기</a>
            </c:if>
            <c:if test="${login.id eq m.id }">
               <a id="delReply" class="txtEvent" href="/LalaClinic/DeleteDownReply?seq=${m.seq}&pseq=${dto.seq}">[삭제]</a>
            </c:if>
         </span>
      </td>
   </tr>
   </c:if>
      <!-- 윗단 -->
	
	<!-- 아랫단(내용) 시작 -->
	<tr>
		<td>
			<c:if test="${m.depth > 0}">
			   <c:forEach var="i" begin="1" end="${m.depth}" step="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			<c:if test="${m.del eq 0}"><textarea readonly="readonly" cols="100" style="border: 0px; resize: none;">${m.content}</textarea></c:if>
			<c:if test="${m.del eq 1}"><font color="red"><b>작성자에 의해 삭제된 댓글입니다.</b></font></c:if>
		</td>
	</tr>
	
	<!-- 댓글에 댓글달기는 클릭하면 댓글입력창 생성 -->
	<tr>
      	<td style="border-bottom:2px solid #ebebeb;">
         	<div id="${m.seq}" class="inputReply" style="display: none;">
            <form action="/LalaClinic/DownReplyAddInsert" method="get" onsubmit="return reNullchk02(${m.seq})">
				<input type="hidden" name="pseq" id="pseq" value="${dto.seq}">
				<input type="hidden" name="id" value="${login.id}" >
				<input type="hidden" name="ref" value="${m.ref}">
				<input type="hidden" name="step" value="${m.step}">
				<input type="hidden" name="depth" value="${m.depth}">
				
				<table class="inputReplyTb">
				<col width="20%"><col width="50%"><col width="15%"><col width="15%">
				<tr>
					<td colspan="4"style="border-bottom:1px solid #e9e9e9"></td>
				</tr>
                <tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;${login.name}</td>
                  	<td><textarea rows="3" cols="110" name="content" id="content" style="resize:none;height:auto"></textarea></td>
                  
                  	<td style="padding-left:30px;">
                  		<input type="submit" class="btn btn-outline-primary btn-sm ver_bottm" value="댓글달기">
                  	</td>
                    <td>
                    	<input type="button" value="취소" class="btn btn-outline-warning btn-sm ver_bottom" onclick="cancelReply()">
                    </td>
               </tr>
               </table>
            </form>
         </div>
      </td>
   </tr>
   </c:forEach>
</c:if>
</table><br>

<div class="pgdiv">
<span class="pgspan">
<jsp:include page="../paging.jsp">
   <jsp:param name="actionPath" value="/LalaClinic/DownDetail?seq=${dto.seq}" />
   <jsp:param name="nowPage" value="${paging.nowPage }" />
   <jsp:param name="totalCount" value="${paging.totalCount }" />
   <jsp:param name="countPerPage" value="${paging.countPerPage }" />
   <jsp:param name="blockCount" value="${paging.blockCount }" />
   
   <jsp:param name="seq" value="${dto.seq}"/>
</jsp:include>
</span>
</div>

<form action="/LalaClinic/DownReplyInsert" method="get" onsubmit="return reNullchk01()" class="replyFrm01">
   <input type="hidden" name="pseq" id="pseq" value="${dto.seq}">
   <input type="hidden" name="id" value="${login.id}" >
   <input type="hidden" name="auth" value="${login.auth}">
   
   <table class="inputReplyTb">
   <col width="20%"><col width="60%"><col width="20%">
   <tr>
      <td>${login.name}</td>
      <td><textarea rows="5" cols="100" id="content" name="content" style="resize:none;height:auto"></textarea></td>
      <td><input type="submit" class="btn btn-outline-primary" value="댓글달기"></td>
   </tr>
   </table>
</form>
</div>


</div>
</section>


<script type="text/javascript">
function deletechk(){
   if(confirm("정말 삭제하시겠습니까?")){
      location.href="/LalaClinic/DownDelete?seq="+$("#pseq").val().trim();
   }
   return false;   
}

$(document).ready(function() {
   if($("#findWord").val()==null) {
      $("#findWord").val("");
   }
   
   $(".btnReply").click(function() {
      $("#"+$(this).attr("val")).show();
   });
});

//대댓글입력창 숨기기
function cancelReply(){
	$(".inputReplyTb").hide();
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

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>