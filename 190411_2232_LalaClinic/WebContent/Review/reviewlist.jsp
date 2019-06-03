<%@page import="paging.PagingBean"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="review.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
Object obj = request.getAttribute("reviewlist");
List<ReviewDto> reviewlist =(List<ReviewDto>)obj;
%>

<%

PagingBean paging = new PagingBean();
paging = (PagingBean)request.getAttribute("paging");
if(request.getParameter("nowPage") == null){
   paging.setNowPage(1);   
}else{
   paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
}

String choice = "";
//검색어
String findWord = "";

choice = request.getParameter("choice");
findWord = request.getParameter("findWord");


//System.out.println("choice = " + choice);

if(choice == null || choice.equals("")){
   choice = "title";   
}

//검색어를 지정하지 않았을 경우, 빈 문자열로
if(findWord == null){
   findWord = "";
   choice = "title";
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reviewlist</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">
<style type="text/css">
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}
</style>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>
<body>
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
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp" style="text-decoration:none;"> 홈 </a> > <b>시술 후기</b> </p>
</section>
<section id="page_board">
<div class="tb_Head01">
<table class="contentTb table-hover">

<colgroup>
<col width="8%"> <col width="9%"><col width="*">
<col width="9%"> <col width="9%"><col width="13%">
</colgroup>

<thead>
<tr align="center">
   <th>No</th><th>Program</th><th>Subject</th><th>Name</th>
   <th>Date</th><th>Hit</th>
</tr>
</thead>

<tbody>
<%
if(reviewlist == null || reviewlist.size() == 0 ){
   %>
   <tr>
      <td colspan="6" align="center">작성된 후기가 없습니다.</td>
   </tr>
   <%
}else{
   int no = paging.getStartNum();
   for(int i = 0; i < reviewlist.size(); i++){
      ReviewDto rdto = reviewlist.get(i);
      %>
      
      <tr>
         <td><%=no-- %></td>
         <td><%=rdto.getManagement() %></td>
         <td>
            <a href="reviewDetail?seq=<%=rdto.getSeq()%>"><%=rdto.getTitle()%></a>
         </td>
         <td><%=rdto.getName() %></td>
         <td><%=rdto.getWdate() %></td>
         <td><%=rdto.getReadcount() %></td>
      </tr>      
      <%
   }   
}
%>
</tbody>
</table>
<br>
<div class="pgdiv">
<span class="pgspan">
   <jsp:include page="../paging.jsp">
      <jsp:param name="actionPath" value="./reviewList"/>
      <jsp:param name="nowPage" value="<%=paging.getNowPage() %>" />
      <jsp:param name="totalCount" value="<%=paging.getTotalCount() %>" />
      <jsp:param name="countPerPage" value="<%=paging.getCountPerPage() %>" />
      <jsp:param name="blockCount" value="<%=paging.getBlockCount() %>" />
   
      <jsp:param name="findWord" value="<%=findWord %>" />
      <jsp:param name="choice" value="<%=choice %>" />
   </jsp:include>
</span>
<span class="writeBtn">
   <a href="reviewWrite">
      <img   src="./image/combine_write.png" alt="글쓰기" >
   </a>
</span>
</div>
<br>
<div class="clear"></div>
<div class="search01" >
   <form action="./reviewList" onsubmit="chk()">
   <select id="choice" name="choice">
      <option value="management">관리내용</option>
      <option value="title">제목</option>
      <option value="writer">작성자</option>
      <option value="content">내용</option>
   </select>
   &nbsp;
   <input class="key" type="text" id="findWord" name="findWord" size="20">
   <input type="submit" id="btn"value="검색">
   </form>
   </div>
</div>
</section>
</div>
<br><br>

<script type="text/javascript">

$(document).ready(function () {

   $("#findWord").val("<%=findWord%>");
   $("#choice").val("<%=choice%>").prop("selected",true);
   
});

</script>

</div>
<footer>
   <jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>
</body>
</html>