<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
String address = "";
if(ologin==null) {
   %>
   <script type="text/javascript">
   //alert("세션이 만료됐습니다. 다시 로그인하세요.");
   //location.href = "../login.jsp";
   </script>
   <%
}
else {
   member = (MemberDto)ologin;
   if(member.getAuth()==1) {
      address = "/LalaClinic/customList";
   }else {
      address = "/LalaClinic/customPath";
   }
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" href="../css/top.css"> -->

<style>
/* * {
   margin: 0;
   padding: 0;
   list-style: none;
} */
/*sub 메뉴 만들기 주의사항. ul li 안에 또 다시 ul li가 삽입되므로 선택자 호출 시 주의해야 한다. 정확하게 아이디로 호출하거나 자식구조를 확인 할 수 있는 자식선택자(후손선택자 아님)를 이용한다.*/
header {
   position: relative;
   z-index: 5;
   margin: 0;
   padding: 0;
}
header #main_menu>.rightF {
   width: 500px;
   height: 40px;
   line-height: 40px;
   font-weight: 900;
   background-color: black;
   color: #fff;
   
   text-align: center;
   cursor: pointer;
   float: right;

   list-style: none;
}
header #main_menu>.rightF>a {
   color: #ffdfea;
   text-decoration: none;
}
header a{
   color: white;
   text-decoration: none;   
}
header #main_menu {
   width: 100%;
   height: 40px;
   line-height: 35px;
   /* margin: 100px auto 0; */
   background-color: black;
   
   margin: 0;
   padding: 0;
}

header #main_menu>.li1 {
   /* width: 223px; */
   width: 150px;
   height: 40px;
   /* line-height: 45px; */
   font-weight: 900;
   background-color: black;
   color: #fff;
   line-height:37px;
   text-align: center;
   float: left;
   cursor: pointer;
   /* transition: 0.5s; */
   
   padding: 0px;
   vertical-align: middle;
   
   /* ========= */
   list-style: none;
}

header #main_menu>.li1>a {
   font-size: 20px;
   vertical-align: middle;
   /* padding-bottom: 40px; */
   color: white;
   text-decoration: none;
   display: inline-block;
   width: 150px;
   height: 40px;
   vertical-align: middle;
}
header #main_menu>.li1>a:hover {
   /* color: black; */
}

header #main_menu>.li1:hover {
   /* background-color: #000099; */
   background-color: #4f4b4c;
   /* padding-bottom: 40px; */
}

.sub_menu {
   display: none;
   margin: 0;
   padding: 0;
}

#main_menu>li:hover .sub_menu {
   display: block;
   /* padding-top: 2.7px; */
}

.sub_menu>li {
   width: 100%;
   height: 35px;
   line-height: 35px;
   font-size: 15px;
   font-weight: 100;
   border-bottom: 1px solid #e3e3e3;
   background-color: #eee;
   
   /* ========= */
   list-style: none;
   
}
.sub_menu>li>a {
   color: black;
      text-decoration: none;
}
.sub_menu>li:hover {
   background-color: #999;
   color: #eee;
}
#topmenu>a {
   color: black;
   text-decoration: none;
}

</style>

<title>라라클리닉 역삼점</title>
</head>

<body>
<div class="includeOuter">
<div align="center">
<img style="cursor: pointer;" src="/LalaClinic/image/lala_logo01.png" onclick="location.href='/LalaClinic/index.jsp'">
</div>
<div align="center">
<div align="right" id="topmenu" style="width: 1100px;">
<%
if(member==null) {
   %>
   <a href="/LalaClinic/member/login.jsp">Login</a>&nbsp;&nbsp;&nbsp;
   <a href="/LalaClinic/member/join.jsp">Join</a>
   <%
}
else {
   if(member.getAuth()==1) {
      %>
      <a href="/LalaClinic/admin/adminMain.jsp">관리페이지</a>&nbsp;&nbsp;&nbsp;
      <%
   }
   %>
   <a href="/LalaClinic/Logout">Logout</a>&nbsp;&nbsp;&nbsp;
   <%
   if(member.getAuth()==0) {
      %>
      <a href="/LalaClinic/CalendarView">MyPage</a>
      <%
   }
};
%>
</div>
</div>

<div align="center" style="background: black;font-family: 'Nanum Gothic', sans-serif;">
<div style="width: 1100px;" class="innerDiv">
<header>
   <ul id="main_menu">
      <li class="li1"><a href="/LalaClinic/botox/botox.jsp">보톡스</a>
            <ul class="sub_menu">
               <li><a href="/LalaClinic/botox/botox.jsp">보톡스</a></li>
               <li><a href="/LalaClinic/botox/filler.jsp">필러</a></li>
               <li><a href="/LalaClinic/botox/outline.jsp">윤곽주사</a></li>
            </ul>
         </li>
         <li class="li1"><a href="/LalaClinic/skin/laser.jsp">피부클리닉</a>
            <ul class="sub_menu">
               <li><a href="/LalaClinic/skin/laser.jsp">제모</a></li>
               <li><a href="/LalaClinic/skin/red.jsp">안면홍조</a></li>
               <li><a href="/LalaClinic/skin/dot.jsp">점/사마귀</a></li>
            </ul>
         </li>
         <li class="li1"><a href="/LalaClinic/lifting/lifting.jsp">리프팅</a>
            <ul class="sub_menu">
               <li><a href="/LalaClinic/lifting/lifting.jsp">블루로즈 포르테</a></li>
               <li><a href="/LalaClinic/lifting/shurink.jsp">슈링크</a></li>
               <li><a href="/LalaClinic/lifting/silhouette.jsp">실루엣 소프트</a></li>
               <li><a href="/LalaClinic/lifting/anti.jsp">안티에이징 주사</a></li>
            </ul>
         </li>
         <li class="rightF">
            <a href="/LalaClinic/introduce/directions.jsp">병원소개 &nbsp;&nbsp;</a>
            <a href="/LalaClinic/CombineList" >상담및예약&nbsp;&nbsp;</a>
            <a href="/LalaClinic/reviewList">시술후기&nbsp;&nbsp;</a>
            <a href="<%=address %>" onclick="return authCheck(<%=ologin%>);">고객소리함&nbsp;&nbsp;</a>
            <a href="/LalaClinic/DownList">자료게시판</a>
         </li>
   </ul>
</header>
</div>
</div>

<script type="text/javascript">
function authCheck(login) {
   var ologin = login;
   if(ologin==null) {
      alert("로그인을 해주십시오");
      return false;
   }
}
</script>
</div> <!-- 최고div -->
</body>
</html>