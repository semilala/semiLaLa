<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) + 1;
int tday = cal.get(Calendar.DATE);
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
body{
   font-family: 'Nanum Gothic', sans-serif;
   /* font-size : 10px; */
   background-color: #f9f9f9;
}
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

#page_board {
    clear: all;
    margin: 0;
    padding: 50px;
    z-index: 1;
    text-align: left;
    font-size: 10pt;
}

#page_mark{
    margin:1rem 1rem 1rem 0;
}
/*유앤아이 소식지*/
.tb_Head01 {width:100%;}
.tb_Head01 table {width:100%;}
.tb_Head01 table th{text-align: left;font-size: 10pt;font-weight: bold; padding: 8px 0;border-bottom: 2px dotted #e8e3e3;}
.tb_Head01 table thead td {height:33px;font-size:12px;font-weight:normal;border-top: 2px dotted #e8e3e3;border-bottom:2px dotted #e8e3e3;}
.tb_Head01 table tbody td{text-align: left;padding: 17px 0;border-bottom: 2px dotted #e8e3e3; font-size:10pt;}

</style>


<!-- boot CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- boot js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<!-- local CSS -->
<!-- <link rel="stylesheet" href="css/bbs.css"> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="//cdn.poesis.kr/post/popup.min.js" charset="UTF-8"></script>
<!-- <script src="//cdn.poesis.kr/post/search.min.js"></script> -->

<title>라라클리닉 역삼점</title>
</head>

<body>
<!-- 상단메뉴 include -->
<div class="categoryTop">
   <jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<!-- 상단 이미지 -->
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>

<!-- 상단 텍스트 -->
<div class="tb_top01" >
<h3>회원 가입</h3>
</div>

<div align="center" class="center">
<p id="page_mark" align ="right" style="font-size: 13px"> 홈 > <b>회원가입</b></p>

<section id="page_board">
<!-- 회원가입 폼 -->
<div class ="tb_Head01" >
<form action="../InsertMember" method="post" onsubmit="return check()">
<table class="joinTable">
<colgroup>
<col width="20%"><col width="*">
</colgroup>
<tbody>
<tr>
   <th>아이디</th>
   <td>
      <input type="text" name="id" id="id" size="20">&nbsp;<input type="button" id="btn" value="id확인">
      <span>( 3~20자, 영문, 숫자만 가능합니다. )</span>
   </td>
</tr>
<tr>
   <th>비밀번호</th>
   <td>
      <input type="password" name="pwd" id="pwd" size="20">
      <span>( 3~20자, 영문, 숫자만 가능합니다. )</span>
   </td>
</tr>
<tr>
   <th>이름</th>
   <td>
      <input type="text" name="name" id="name" size="20">
   </td>
</tr>
<tr>
   <th>성별</th>
   <td>
      <input type="radio" name="gender" checked="checked" value="남성">남성
      <input type="radio" name="gender" value="여성">여성
   </td>
</tr>
<tr>
   <th>이메일</th>
   <td>
      <input type="text" name="email1" id="email1" >&nbsp;@&nbsp;
      <input type="text" name="email2" id="email2" >&nbsp;
      <select id="email3">
         <option selected="selected">직접입력</option>
         <option value="naver.com">naver.com</option>
          <option value="hanmail.net">hanmail.net</option>
          <option value="gmail.com">gmail.com</option>
      </select>
      <input type="hidden" name="email" id="email" size="20" value="">
   </td>
</tr>
<tr>
   <th>연락처</th>
   <td>
      <select id="phone1">
         <option value="010" selected="selected">010</option>
         <option value="011">011</option>
      </select>-
      <input type="text" id="phone2" size="10">-
      <input type="text" id="phone3" size="10">
      <input type="hidden" name="phone" id="phone" size="20" value="">
   </td>
</tr>
<tr>
   <th>생년월일</th>
   <td>
      <select name="year">
      <%
      for(int i=tyear-50; i<=tyear; i++) {
         %>
         <%-- <option <%=year.equals(i+"")? "selected='selected'":"" %> value="<%=i %>"><%=i %></option> --%>
         <option <%=tyear==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
         <%
      }
      %>
      </select>년
      <select name="month">
      <%
      for(int i=1; i<=12; i++) {
         %>
         <option <%=tmonth==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
         <%
      }
      %>
      </select>월
      <select name="day">
      <%
      //for(int i=1; i<=cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
      for(int i=1; i<=31; i++) {
         %>
         <option <%=tday==i? "selected='selected'":"" %> value="<%=i %>"><%=i %></option>
         <%
      }
      %>
      </select>일
   </td>
</tr>
<tr>
   <th>주소</th>
   <td>
      <div>
          <p>
              <label>우편번호&nbsp;</label><input type="text" size="4" class="postcodify_postcode6_1" id="post1" readonly="readonly" /> &ndash;
              <label></label><input type="text" size="4" class="postcodify_postcode6_2" id="post2" readonly="readonly" /> &nbsp;
              <input type="button" value="검색" id="postcodify_search_button">
          </p>
          <p><label style="padding-left:30px">주소&nbsp;</label><input type="text" class="postcodify_address" id="address1" readonly="readonly" style="width:450px;"/></p>
          <p><label>상세주소&nbsp;</label><input type="text" class="postcodify_details" id="address2" style="width:450px;"></p>
      </div>
      <input type="hidden" name="address" id="address" size="20" value="">
   </td>
</tr>
</tbody>
</table><br>
<div align="center">
<p>id 중복체크를 하셔야 회원가입 버튼이 활성화 됩니다.</p>
   	<input type="image" src="../image/join_btn.gif" id="submitBtn" disabled="disabled" style="vertical-align: bottom;">
   	<a href="/LalaClinic/index.jsp">
   		<img src="../image/combine_cancel.png" style="width:92px;height:54px; vertical-align: bottom;">
	</a>
</div>

</form>

</div>
</section>
</div>

<script type="text/javascript">
/* $("#search_button").postcodifyPopUp(); */

var idck = false;
var wid = "";

$(document).ready(function() {
   $("#postcodify_search_button").postcodifyPopUp();
   
   $("#id").on("focus", function() {
      $("#submitBtn").attr("disabled", true);
   });
   
   $("#email3").change(function() {
      $("#email2").val($("#email3").val());
   });
   
   $("#btn").click(function() {
      if( $("#id").val().trim() != "" ) {
         if(valcId()==true) {
            $.ajax({
               type: "post",
               data: { "id" : $("#id").val().trim() },
               url: "../IdSameCheck",
               
               success: function( data ) {
                  if(data.trim()=='fail') {
                     alert("사용중인 ID입니다.");
                     $("#id").val("");
                     idck = false;
                  }
                  else if(data.trim()=='success') {
                     alert("사용할 수 있습니다.");
                     wid = $("#id").val().trim();
                     $("#submitBtn").attr("disabled", false);
                     idck = true;
                  }
               },
               error: function() {
                  alert("error");
               }
            }); // end ajax
         }
      }
      else {
         alert("ID를 입력해야 합니다.");
         $("#id").focus();
      }
   });
});

function check() {
   if($("#id").val().trim()=="") {
      alert("ID를 입력해야 합니다.");
      $("#id").focus();
      return false;
   }
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
   if($("#address1").val().trim()=="" || $("#address2").val().trim()=="") {
      alert("주소를 입력해야 합니다.");
      return false;
   }
   
   if( !($("#id").val().trim()==wid) ) {
      idck = false;
   }
   
   if(idck==false) {
      alert("id 중복체크를 해주세요.");
      return false;
   }
   
   $("#email").val( $("#email1").val() + "@" + $("#email2").val() );
   $("#phone").val( $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val() );
   var adrs = "["+$("#post1").val()+"-"+$("#post2").val()+"] " + $("#address1").val() + " " + $("#address2").val();
   $("#address").val(adrs);
   
   if(valcPwd()==false || valcName()==false || valcEmail()==false || valcPhone()==false) {
      return false;
   }
   
   idck = false;
   return true;
}

function valcPhone() {
   var regPhone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
   if( regPhone.test($("phone").val())==false ) {
      alert("잘못된 연락처입니다");
      return false;
   }
}

function valcId() {
   var regSpace = /\s/g;
   if( regSpace.test($("#id").val().trim())==true ) {
      alert("ID에 공백이 있습니다");
      return false;
   }
   
   var regId = /^[a-z0-9_]{3,15}$/;
   if( regId.test($("#id").val())==false ) {
      alert("ID 형식이 잘못되었습니다");
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