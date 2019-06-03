<%@page import="paging.PagingBean"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="combine.dto.CombineDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	
}
else {
	user = (MemberDto)ologin;
}
%>
<%
List<CombineDto> list = (List<CombineDto>)request.getAttribute("list");
for(int i = 0; i < list.size(); i++){
	System.out.println("combine_list listz[" + i + "] : " + list.get(i));
}
%>

<%

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

String choice = "";
//검색어
String findWord = "";
choice = request.getParameter("choice");
findWord = request.getParameter("findWord");
System.out.println("combineList.jsp 에서 choice : " + choice);
System.out.println("combineList.jsp 에서 findWord : " + findWord);
if(choice == null || choice.trim().equals("")){
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
<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<link rel="stylesheet" href="css/bbs.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
var str='<%=choice %>';
$(document).ready(function(){
//	alert("str = " + str);
	if(str == ""){
		str = "title";
	}
	document.getElementById("choice").value = str;		
});
</script> 
</head>
<body>

<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
	<div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01" >
<h3>상담 및 예약</h3>
</div>
<div align="center" class="center">
<section id="page_mark">
<a href="/LalaClinic/index.jsp"><p align ="right" style="font-size: 13px"> 홈 > </a><span class="bold">상담 및 예약</span> </p>
</section>
<section id="page_board">
<div class ="tb_Head01" >
<table class="contentTb table-hover">
<colgroup>
<col width="8%"> <col width="7%"><col width="7%"><col width="*">
<col width="9%"> <col width="9%"><col width="13%">
</colgroup>
<thead>
	<tr>
		<th>No</th>			<!-- 넘버 -->
		<th>Category</th>	<!-- 예약or상담 -->
		<th>Program
		<!-- <div class="menubar">
		   <ul>
		      <li><a href="#" id="current">Program</a>
		         <ul>
		           <li><a href="#">Sliders</a></li>
		           <li><a href="#">Galleries</a></li>
		           <li><a href="#">Apps</a></li>
		           <li><a href="#">Extensions</a></li>
		         </ul>
		   </ul>
		</div> -->
		</th>	<!-- 시술종류 -->
		<th>Subject</th>	<!-- 제목 -->
		<th>Name</th>		<!-- 이름 -->
		<th>Date</th>		<!-- sysdate -->
		<th>Progress</th>	<!-- 답변완료or대기 -->
	</tr>
</thead>

<tbody>
	<%
	if(list.size() < 1){
	%>
		<tr>
			<td colspan="7" align="center">작성된 글이 없습니다.</td>
		</tr>
	<%
	}else{
		int no = paging.getStartNum();
		for(int i = 0 ; i < list.size(); i++){
			CombineDto cb = list.get(i);
		%>
			<tr>
				<td><%=no--%></td>
		
		
				<td>
					<%=cb.getInquire()%>
				</td>
				<td> <%=cb.getMedical() %> </td>
				<td>
					<a href = "CombineDetail?seq=<%=cb.getSeq()%>" onclick="return authchk('<%=cb.getId()%>')">
						<%=cb.getTitle() %>
					</a>
				</td>
				<td> <%=cb.getName() %> </td>
				<td> <%=cb.getWdate().substring(0, cb.getWdate().lastIndexOf(".")) %></td>
				
				<td> 
				<%
				if(cb.getProgress() == 0){
				%>
					<img src="./image/combine_answerBf.png" alt="답변대기">
				<%
				}else{
				%>
					<img src="./image/combine_answerAf.png" alt="답변완료">
				<%
				}
				%>
					<input type="hidden" name="progress" value="<%=cb.getProgress() %>"> 
				</td>
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
		<jsp:param name="actionPath" value="./CombineList"/>
		<jsp:param name="nowPage" value="<%=paging.getNowPage() %>" />
		<jsp:param name="totalCount" value="<%=paging.getTotalCount() %>" />
		<jsp:param name="countPerPage" value="<%=paging.getCountPerPage() %>" />
		<jsp:param name="blockCount" value="<%=paging.getBlockCount() %>" />
		
		<jsp:param name="findWord" value="<%=findWord %>" />
		<jsp:param name="choice" value="<%=choice %>" />
	</jsp:include>
</span>
<span class="writeBtn">
	<a href="./combine/combine_write.jsp" onclick="return loginchk()">
		<img   src="./image/combine_write.png" alt="글쓰기" >
	</a>
	</span>
</div>
<br>
<div class="clear"></div>
<div class="search01" >
 	<form action="./CombineList" method="get">
	<select id="choice" name="choice">
		<option value="title" selected="selected">제목</option>
		<option value="writer">작성자</option>
		<option value="content">내용</option>
	</select>
	<input class="key" type="text" id="findWord" value="" name="findWord">
	<input class="searchBtn" type="image" src="./image/search.png">
 	</form>
</div>
</div>
</section>
</div>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
<script type="text/javascript">
$(document).ready(function () {
	
	var fw = '<%=findWord%>';
	$("#findWord").val(fw);
	if("<%=choice%>" !=null || $.trim("<%=choice%>" ) != ""){
		$("#choice").val("<%=choice%>").prop("selected",true);
	}else{
		$("#choice").val("title").prop("selected",true);
	}
});

//디테일 권한 검사
function authchk( id ){
	var ologin = '<%=ologin%>';
	
	if(ologin != null){
		if("<%=user.getId()%>" == id || "<%=user.getAuth()%>" == 1 ){
			return true;
		}
	}
	alert("페이지 권한이 없습니다.");
	return false;
}

//로그인체크
function loginchk() {
	var logchk = '<%=ologin%>';
	if(logchk == 'null' || logchk ==""){
		alert("로그인후에 사용 가능합니다.");
		return false;
	}
}
</script>
</body>
</html>