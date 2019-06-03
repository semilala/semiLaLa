<%@page import="util.UtilClass"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
request.setCharacterEncoding("UTF-8");

//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin==null) {
	System.out.println("null");
	%>
	<script type="text/javascript">
	alert("로그인해야 합니다.");
	location.href = "/LalaClinic/index.jsp";
	</script>
	<%
}
else {
	user = (MemberDto)ologin;
	if(user.getAuth()!=1) {
		%>
		<script type="text/javascript">
		alert("권한이 없습니다.");
		location.href = "/LalaClinic/index.jsp";
		</script>
		<%	
	}
}

MemberDto dto = (MemberDto)request.getAttribute("dto");
String[] emailArr = dto.getEmail().split("@");
String[] phoneArr = dto.getPhone().split("-");

Calendar cal = Calendar.getInstance();
int[] arr = UtilClass.getTimeFormatInt(dto.getBirth(), 0);
int year = arr[0];
int month = arr[1];
int day = arr[2];

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
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
<link rel="stylesheet" href="/LalaClinic/css/myPageMenu.css">
<link rel="stylesheet" href="/LalaClinic/css/bbs.css">

<style type="text/css">
.tb_Head01 .contentTb tbody td{text-align: left;padding: 17px 0;border-bottom: 1px dotted #e8e8e8; font-size:12pt;}
.tb_Head01 .contentTb tbody td.myDetailRight{text-align: center;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.poesis.kr/post/popup.min.js" charset="UTF-8"></script>
<title>라라클리닉 역삼점</title>
</head>

<body>
<!-- 상단메뉴 include -->
<div class="categoryTop">
	<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<!-- 상단 이미지 -->
<div id="sub_visual" >
	<div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<!-- 상단 부메뉴 -->
<div class="tb_top01" >
	<h3>회원정보 수정</h3>
</div>

<div align="center" class="center">
<!-- 상단우측 카테고리 section -->
<section id="page_mark">
<p align ="right" style="font-size: 13px">
	<a href="/LalaClinic/index.jsp">홈</a> > 
	<a href="/LalaClinic/admin/adminMain.jsp">관리자</a> >  
	<a href="#"><span class="bold">회원정보수정</span></a>
</p>
</section>

<!-- 메인 section -->
<section id="page_board">
<div class ="tb_Head01">
<form action="/LalaClinic/MemberUpdate" method="post" onsubmit="return check()">
<input type="hidden" name="auth" value="1">
<table class="contentTb">
<colgroup>
	<col width="20%"><col width="*">
</colgroup>

<thead>
</thead>

<tbody>
<tr>
	<td>아이디</td>
	<td>${dto.id}<input type="hidden" name="id" value="${dto.id}"></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td>
		<input type="password" name="pwd" id="pwd" size="20" value="${dto.pwd}">
	</td>
</tr>
<tr>
	<td>이름</td>
	<td>
		<input type="text" name="name" id="name" size="20" value="${dto.name}">
	</td>
</tr>
<tr>
	<td>성별</td>
	<td>
		<input type="radio" name="gender" <c:if test="${dto.gender eq '남성'}"> checked="checked"</c:if> value="남성">남성
		<input type="radio" name="gender" <c:if test="${dto.gender eq '여성'}"> checked="checked"</c:if> value="여성">여성
	</td>
</tr>
<tr>
	<td>이메일</td>
	<td>
		<input type="text" name="email1" id="email1" value="<%=emailArr[0]%>">@
		<input type="text" name="email2" id="email2" value="<%=emailArr[1]%>">&nbsp;
		<select id="email3">
			<option selected="selected">직접입력</option>
			<option value="naver.com">naver.com</option>
		 	<option value="hanmail.net">hanmail.net</option>
		 	<option value="gmail.com">gmail.com</option>
		</select>
		<input type="hidden" name="email" id="email" size="20" value="${dto.email}">
	</td>
</tr>
<tr>
	<td>연락처</td>
	<td>
		<select id="phone1">
			<option value="010" <%if(emailArr[0].equals("010")) { %>selected="selected" <%} %>>010</option>
			<option value="011" <%if(emailArr[0].equals("011")) { %>selected="selected" <%} %>>011</option>
		</select>-
		<input type="text" id="phone2" size="10" value="<%=phoneArr[1]%>">-
		<input type="text" id="phone3" size="10" value="<%=phoneArr[2]%>">
		<input type="hidden" name="phone" id="phone" size="20" value="">
	</td>
</tr>
<tr>
	<td>생년월일</td>
	<td>
		<select name="year">
		<%
		for(int i=tyear-50; i<=tyear; i++) {
			%>
			<option <%=year==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
			<%
		}
		%>
		</select>년
		<select name="month">
		<%
		for(int i=1; i<=12; i++) {
			%>
			<option <%=month==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
			<%
		}
		%>
		</select>월
		<select name="day">
		<%
		for(int i=1; i<=31; i++) {
			%>
			<option <%=day==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
			<%
		}
		%>
		</select>일
	</td>
</tr>
<tr>
	<td>주소</td>
	<td>
		<div>
			<input type="text" name="address" id="address" size="50" value="${dto.address}" readonly="readonly">
			<input type="button" id="addressBtn" value="주소 재입력">
			<div id="inputAddressDiv" style="display: none;">
			    <p>
			        <label>우편번호</label><input type="text" size="4" class="postcodify_postcode6_1" id="post1" readonly="readonly" /> &ndash;
			        <label></label><input type="text" size="4" class="postcodify_postcode6_2" id="post2" readonly="readonly" /> &nbsp;
			        <!-- <button id="search_button">검색</button> -->
			        <!-- <a id="search_button">[검색]</a> -->
			        <input type="button" value="검색" id="search_button">
			    </p>
			    <p><label>주소</label><input type="text" class="postcodify_address" id="address1" readonly="readonly"/></p>
			    <p><label>상세주소</label><input type="text" class="postcodify_details" id="address2"/></p>
			</div>
		</div>
	</td>
</tr>
<tr>
	<td colspan="2" class="myDetailRight">
		<button type="submit" class="btn btn-outline-primary" onclick="location.href='/LalaClinic/MemberUpdate">수정</button>
		<button type="button" class="btn btn-outline-success" onclick="location.href='/LalaClinic/MemberList'">목록</button>
		<button type="button" class="btn btn-outline-info" onclick="location.href='admin/adminMain.jsp'">메인</button>
	</td>
</tr>
</tbody>
</table>
</form>
</div>
</section>
</div>

<script type="text/javascript">
$("#search_button").postcodifyPopUp();

var wid = "";
var addvar = 0;

$(function() {
	
	$("#addressBtn").click(function() {
		$("#address").val("");
		$("#inputAddressDiv").show();
	});
	
	$("#email3").change(function() {
		$("#email2").val($("#email3").val());
	});
});

function check() {
	if($("#pwd").val().trim()=="") {
		alert("비밀번호를 입력해야 합니다.");
		$("#pwd").focus();
		return false;
	}
	if($("#name").val().trim()=="") {
		alert("이름을 입력해야 합니다.");
		$("#name").focus();
		return false;
	}
	if($("#email1").val().trim()=="" || $("#email2").val().trim()=="") {
		alert("이메일을 입력해야 합니다.");
		return false;
	}
	if($("#phone2").val().trim()=="" || $("#phone3").val().trim()=="") {
		alert("연락처를 입력해야 합니다.");
		return false;
	}
	if( $("#address").val().trim()=="" && ( $("#address1").val().trim()=="" || $("#address2").val().trim()=="" ) ) {
		alert("주소를 입력해야 합니다.");
		return false;
	}
	
	$("#email").val( $("#email1").val() + "@" + $("#email2").val() );
	$("#phone").val( $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val() );
	if($("#address").val()=="") {
		var adrs = "["+$("#post1").val()+"-"+$("#post2").val()+"] " + $("#address1").val() + " " + $("#address2").val();
		$("#address").val(adrs);
	}
	
	if(valcPwd()==false || valcName()==false || valcEmail()==false || valcPhone()==false) {
		return false;
	}
	return true;
}
	
function valcPwd() {
	var regSpace = /\s/g;
	if( regSpace.test($("#pwd").val().trim())==true ) {
		alert("비밀번호에 공백이 있습니다");
		return false;
	}
	
	var regId = /^[a-z0-9_]{3,15}$/;
	if( regId.test($("#pwd").val())==false ) {
		alert("비밀번호 형식이 잘못되었습니다");
		return false;
	}
	
	return true;
}

function valcPhone() {
	var regPhone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	if( regPhone.test($("phone").val())==false ) {
		alert("잘못된 연락처입니다");
		return false;
	}
}

function valcName() {
	var regName = /\s/g;
	if( regSpace.test($("#name").val().trim())==true ) {
		alert("이름에 공백이 있습니다");
		return false;
	}
	return true;
}

function valcEmail() {
	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if( regEmail.test($("#email").val().trim())==false ) {
		alert("잘못된 이메일 형식입니다");
		return false;
	}
	return true;
}
</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>