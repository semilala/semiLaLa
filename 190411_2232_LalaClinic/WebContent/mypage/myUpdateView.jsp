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
   location.href = "../index.jsp";
   </script>
   <%
}
else {
   user = (MemberDto)ologin;
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
<style type="text/css">
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

<!-- local CSS -->
<link rel="stylesheet" href="css/myPageMenu.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.poesis.kr/post/popup.min.js" charset="UTF-8"></script>
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- local CSS -->
<link rel="stylesheet" href="./css/bbs.css">
</head>
<body>
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('./image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<!-- 상단 부메뉴0 -->
<div class="tb_top01">

<h3 style="margin-bottom: 0px;">
    <a href="/LalaClinic/CalendarView">내 일정</a> |
      <a href="/LalaClinic/MyDetail"><b>내 정보 수정</b></a> |
      <a href="/LalaClinic/MyWriteCombineList">내글 확인</a>
</h3>
   
<p align="right" style="margin-bottom: 10px;"> <b>MyPage</b> &nbsp;&nbsp; > &nbsp;
   <a href="/LalaClinic/MyWriteCombineList">상담및예약</a> |
    <a href="/LalaClinic/MyWriteReviewList">시술후기</a> |
    <a href="/LalaClinic/MyWriteCustomList">고객소리함</a>
</p>

<div align="center" class="center" >

<p id="page_mark" align ="right" style="font-size: 13px"> MyPage > <b>내 정보 수정</b> </p>
<section id="page_board">
<br><br>

<div class ="tb_Head01" align="center">

<form action="/LalaClinic/MyUpdate" method="post" onsubmit="return check()" >
<input type="hidden" name="auth" value="0">

<table>
<colgroup>
   <col width="20%"><col width="*">
</colgroup>
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
      <input type="radio" name="gender" <c:if test="${(dto.gender eq '남성')}"> checked="checked"</c:if> value="남성">남성
      <input type="radio" name="gender" <c:if test="${(dto.gender eq '여성')}"> checked="checked"</c:if> value="여성">여성
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
          <option value="daum.net">daum.net</option>
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
         <%-- <option <%=year.equals(i+"")? "selected='selected'":"" %> value="<%=i %>"><%=i %></option> --%>
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
      //for(int i=1; i<=cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
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
                 <a id="search_button">[검색]</a>
             </p>
             <p><label>주소</label><input type="text" class="postcodify_address" id="address1" readonly="readonly"/></p>
             <p><label>상세주소</label><input type="text" class="postcodify_details" id="address2"/></p>
         </div>
      </div>
   </td>
</tr>

</table>
<br>
<input type="submit" id="submitBtn" value="수정">
</form>
</div>
</section>
<!-- 확인/수정 등 버튼 간격조정 -->
</div>
<br>
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
   
   if($("#address").val() == "" || $("#address").val() == null){
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
</div>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>

</body>
</html>