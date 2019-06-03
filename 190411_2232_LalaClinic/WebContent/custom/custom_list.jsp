<%@page import="member.dto.MemberDto"%>
<%@page import="custom.dao.CustomDao"%>
<%@page import="custom.dao.iCustomDao"%>
<%@page import="paging.PagingBean"%>
<%@page import="custom.dto.CustomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>custom_list.jsp</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<%
CustomDto dto = (CustomDto)request.getAttribute("customdetail");
String choice = request.getParameter("choice");
//검색어
String findWord = request.getParameter("findWord");
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	
%>	
<script type="text/javascript">
	alert("접근권한이 없습니다.");
   location.href="/LalaClinic/index.jsp";
  </script>
<%
}
else {
   user = (MemberDto)ologin;
   
   if(user.getAuth() != 1){
	   %>	
	   <script type="text/javascript">
	   	alert("접근권한이 없습니다.");
	      location.href="/LalaClinic/index.jsp";
	     </script>
	   <%
	   
   }
   
}
List<CustomDto> list = (List<CustomDto>)request.getAttribute("customlist");
 if(list.size() != 0 || list != null){
   
   System.out.println("리스트가 있습니다.");
}
else{
   System.out.println("리스트가 없습니다.");
} 
 
%>
<%

PagingBean paging = new PagingBean();
paging = (PagingBean)request.getAttribute("paging");
if(request.getParameter("nowPage") == null){
   paging.setNowPage(1);   
}else{
   paging.setNowPage(Integer.parseInt(request.getParameter("nowPage")));
}


if(choice.equals("sel")){
   findWord = "";
}

// 검색어를 지정하지 않았을 경우, 빈 문자열로
if(findWord == null){
   findWord = "";
   
}
%>
<script type="text/javascript">
var str='<%=choice %>';
$(document).ready(function(){
//   alert("str = " + str);
   if(str == ""){
      str = "sel";
   }
   document.getElementById("choice").value = str;      
}); 
</script> 
<style type="text/css">

a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

</style>
</head>
<body>
<div>
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01" >
<h3>고객소리함</h3>
</div>

<div align="center" class="center">

<section id="page_mark">
<p align ="right" style="font-size: 13px"><a href="/LalaClinic/index.jsp"> 홈 </a>> <b!important>고객소리함</b> </p>
</section>
<section id="page_board">
<div class ="tb_Head01" >
<table class="contentTb table-hover">
<colgroup>
<col width="8%"> <col width="*">
<col width="9%"> <col width="9%"><col width="13%">
</colgroup>
<thead>
   <th>No</th><th>Subject</th><th>Name</th>
   <th>Date</th><th>Progress</th>
</thead>
<tbody>
<%

if(list.size() !=0 && list != null){
   int no = paging.getStartNum();
for(int i = 0; i < list.size() ; i++){
   CustomDto custom = list.get(i);
%>
<tr>
<td><%=no--%></td>
<td><a href="./customdetail?seq=<%=custom.getSeq() %>" id="btn" onclick="return userChk()"><%=custom.getTitle() %></a></td>
<td><%=custom.getName() %></td>
<td><%=custom.getWdate() %></td>
<td>

<%if(custom.getProgress()==1) {%>
<img alt="" src="./image/combine_answerAf.png">
<%}else{ %>
<img alt="" src="./image/combine_answerBf.png">

<%} %>
</td>
</tr>
<%} }else{%>
<tr>
<td colspan="8">작성된 글이 없습니다.</td>
</tr> 

<%} %> 
</tbody>
</table>
<br>
<div class="pgdiv">
<span class="pgspan">
<jsp:include page="paging.jsp">
   <jsp:param name="actionPath" value="./customList" />
   <jsp:param name="nowPage" value="<%=paging.getNowPage() %>" />
   <jsp:param name="totalCount" value="<%=paging.getTotalCount() %>" />
   <jsp:param name="countPerPage" value="<%=paging.getCountPerPage() %>" />
   <jsp:param name="blockCount" value="<%=paging.getBlockCount() %>" />
   
   <jsp:param name="findWord" value="<%=findWord %>" />
   <jsp:param name="choice" value="<%=choice %>" />
</jsp:include>
</span>
</div>
<br>
<div class="clear"></div>
<div class="search01" >
<form action="./customList">
<select id="choice" name="choice">
<option value="sel">선택</option>
<option value="title">제목</option>
<option value="writer">작성자</option>
<option value="content">내용</option>
</select>

<input class="key" type="text" id="search" value="<%=findWord %>" name="findWord">
<input type="submit" value="전송" onclick="return chk()">

</form>
</div>
</div>
</section>
</div>
<br><br><br>

<script type="text/javascript">

function chk() {
/*   선택항목 및 검색단어 확인용    
 
   alert($("#choice").val());
   alert($("#search").val()); */
   if(findWord.trim() ==""){
      alert("검색할 단어를 입력하여 주십시오");
      return false;
   }
   
};
<%-- function userChk(){
	var user = <%=user.getId()%>;
	var cusUser = <%=dto.getId()%>;
	var auth = <%=user.getAuth()%>;
	Number(auth);
	if(user == cusUser || auth == 1 ){
		return true;
	}
	
	return false;
} --%>
function searchCustom() {
   var word = document.getElementById("search").value;
//   alert(word);
   var choice = document.getElementById("choice").value;
//   alert("choice = " + choice);
   if(word.trim() == ""){
      choice = 'sel';
   } 
   location.href = "customList?nowPage="+<%=paging.getNowPage() %>+"&findWord=" + word + "&choice=" + choice;   
}
</script>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>