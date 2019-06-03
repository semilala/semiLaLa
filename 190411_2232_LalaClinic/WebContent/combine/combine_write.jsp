<%@page import="util.UtilClass"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

Calendar cal = Calendar.getInstance();

int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) +1;
int tday = cal.get(Calendar.DATE);
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int thour = cal.get(Calendar.HOUR_OF_DAY);

int ttyear = cal.get(Calendar.YEAR);
int ttmonth = cal.get(Calendar.MONTH) +1;
int ttday = cal.get(Calendar.DATE);
int tthour = cal.get(Calendar.HOUR_OF_DAY);
String inquire = request.getParameter("inquire");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

if(year != null){
	%>
	
	<%
	tyear = Integer.parseInt(year);
}
if(month != null){
	tmonth = Integer.parseInt(month);
}
if(day != null){
	tday = Integer.parseInt(day);
}
System.out.println("year : " + year);
System.out.println("month : " + month);
System.out.println("day : " + day);
System.out.println("tyear : " + tyear);
System.out.println("tmonth : " + tmonth);
System.out.println("tday : " + tday);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- local css  -->
<!-- <link rel="stylesheet" href="css/bbs.css"> -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<!-- <script type="text/javascript" src="./nse_files/js/HuskyEZCreator.js" charset="utf-8"></script> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>


<style type="text/css">
.layer{
   display: none;
}
</style>
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
#h3{
    padding-left:60px;
    margin-left:0px;
	margin-top:30px;
    padding-bottom:30px;
    margin-bottom: 0px!important;
    color:black;
    font-size: 1.75rem;
    font-weight: normal;
}
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}
.bold{
    font-weight: bold!important;
    color:black;
}
.timeLayout{
	vertical-align: bottom;
	height:22px;
}

</style>


</head>
<body style="margin:0px">
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin == null) {
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "../member/login.jsp";
   </script>
   <%
}
else {
   user = (MemberDto)ologin;   
}
%>
<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01" >
<h3 id="h3">상담 및 예약</h3>
</div>
<div align="center" class="center" >

<section id="page_mark">
   <p align ="right" style="font-size: 13px"> 
   		<a href="/LalaClinic/index.jsp">홈</a> > 
   	
   		<a href="/LalaClinic/CombineList" ><span class="bold">상담 및 예약</span> </a>
   	
   </p>
</section>
<section id="page_board">
<div class ="tb_Head01" align="center">

<form action="../CombineWrite" method="post" enctype="multipart/form-data" onsubmit="return nullchk()">

<div  style="width:1000">
<textarea rows="12" cols="140" readonly style="resize: none;">
'LaLa Clinic' 은 (이하 '회사'는) 고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다.

회사는 개인정보취급방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.

회사는 개인정보취급방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.

ο 본 방침은 : 2011 년 04 월 08 일 부터 시행됩니다.

■ 수집하는 개인정보 항목

회사는 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.

ο 수집항목 : 이름 , 나이 , 성별 , 비밀번호 , 휴대전화번호 , 이메일 , 접속 로그 , 쿠키 , 접속 IP 정보

ο 개인정보 수집방법 : 상담문의,예약

■ 개인정보의 수집 및 이용목적

회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.

ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 콘텐츠 제공

ο 회원 관리

이용에 따른 본인확인 , 개인 식별 , 개인 의사 확인 , 연령확인 , 불만처리 등 민원처리 , 고지사항 전달

ο 마케팅 및 광고에 활용

신규 서비스(제품) 개발 및 특화 , 이벤트 등 광고성 정보 전달 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계

■ 개인정보의 보유 및 이용기간

원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.

단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

보존 항목 : 이름 , 나이 , 성별 , 비밀번호 , 휴대전화번호 , 이메일

보존 근거 : 상담문의 확인, 서비스 개선 조사, 상담유형 조사를 위함

보존 기간 : 3년

■ 개인정보의 파기절차 및 방법

회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.

ο 파기절차

회원님이 상담문의신청 및 예약신청 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.

별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.

ο 파기방법

- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.

- 회원DB에서 삭제 방법으로 파기합니다.

■ 개인정보 제공

회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.

- 이용자들이 사전에 동의한 경우

- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우

■ 수집한 개인정보의 위탁

회사는 고객님의 동의없이 고객님의 정보를 외부 업체에 위탁하지 않습니다. 향후 그러한 필요가 생길 경우, 위탁 대상자와 위탁 업무 내용에 대해 고객님에게 통지하고 필요한 경우 사전 동의를 받도록 하겠습니다.

■ 이용자 및 법정대리인의 권리와 그 행사방법

이용자 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다.

이용자 및 문의자는 본인이 작성한 게시글에 대해 삭제를 하였을 경우 본인의 개인정보가 삭제처리 됩니다.

차후 회사가 회원제 운영 및 회원가입형태가 진행이 있을 경우

이용자 혹은 만 14세 미만 아동의 개인정보 조회, 수정을 위해서는 ‘개인정보변경’(또는 ‘회원정보수정’ 등)을 가입해지(동의철회)를 위해서는 “회원탈퇴”를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다.

혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치하겠습니다.

귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다.

또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체없이 통지하여 정정이이루어지도록 하겠습니다.

회사는 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 “회사가 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.

■ 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항

회사는 귀하의 정보를 수시로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 회사의 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다. 회사은(는) 다음과 같은 목적을 위해 쿠키를 사용합니다.

▶ 쿠키 등 사용 목적

- 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공

- 귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서, 귀하는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.

▶ 쿠키 설정 거부 방법

예: 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다. 설정방법 예(인터넷 익스플로어의 경우): 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보 단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.

■ 개인정보에 관한 민원서비스

회사는 고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다.

개인정보관리책임자 성명 : 최 유 경

전화번호 : 02-558-6020

이메일 : mdmarketing@nate.com

귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다.

회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.

기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.

1.개인분쟁조정위원회 (www.1336.or.kr/1336)

2.정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4)

3.대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr/02-3480-3600)

4.경찰청 사이버테러대응센터 (www.ctrc.go.kr/02-392-0330)
</textarea>
<br>
<input type="checkbox" id="agreePrivate"> &nbsp; 이용약관 및 개인정보 취급방침에 동의합니다.
<br><br><br><br>

<table>
<colgroup>
   <col width="20%"> <col width="*">
</colgroup>

<thead>
</thead>

<tbody>
   <tr>
      <th>작성자</th>
      <td>
         <span><%=user.getName() %></span>
         <input type="hidden" value="<%=user.getName() %>" readonly name = "name">
      </td>
   </tr>
   <tr>
      <th>연락처</th>
      <td>
      <span><%=user.getPhone() %></span>
         <input type="hidden" value="<%=user.getPhone() %>" readonly name="phone">
      </td>
   </tr>
   <tr>
      <th>이메일</th>
      <td>
         <span><%=user.getEmail() %></span>
         <input type="hidden" value="<%=user.getEmail() %>" readonly name ="email">
      </td>
   </tr>
    <tr>
      <th>성별</th>
      <td>
         <span><%=user.getGender() %></span>
         <input type ="hidden" readonly name="gender" value="<%=user.getGender() %>">
      </td>
   </tr>
   <tr>
   <th>문의항목</th>
      <td>
         <select name="inquire" id="inquire">
            <option value="default">문의항목을선택해주세요</option>
            <option value="상담">상담</option>
            <option value="예약">예약</option>
         </select>
      </td>
   </tr>
  
   <tr>
      <th>시술항목</th>
      <td>
         <select name="medical">
               <option>보톡스</option>
               <option>필러</option>
               <option>리프팅</option>
         </select>
      </td>
   </tr>
      <tr class="layer">
         <th>희망 예약날짜</th>
         <td>
         
         <input type="text" id="rdate" name="rdate" readonly="readonly">
         <input type="hidden" name="year" id="year" value="0000">
         <input type="hidden" name="month" id="month" value="00">
         <input type="hidden" name="day" id="day" value="00">
         
         <script type="text/javascript">
            $("#rdate").datepicker({
                // 달력에 표시될 텍스트들
                dateFormat:"yy/mm/dd",
                dayNamesMin:['일','월','화','수','목','금','토'],
                monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                //보여줄 년도를 해당년도 ~ 해당년도 + 1 까지
                yearRange: "<%=tyear%>:<%=tyear+1%>" ,
                //선택가능한 날짜를 해당일 OR 해당일  + 1
                minDate: new Date('<%=tyear%>-<%=tmonth%>-<%=tday%>'),
                onSelect:function(d){
                  //alert(d);
                  var arr = d.split("/");
                  $("#year").val(arr[0].trim());
                  $("#month").val(arr[1].trim());
                  $("#day").val(arr[2].trim());
                                    
                  var week = new Date( $("#rdate").datepicker({dateFormat:"yy/mm/dd"}).val() );
                  //alert("요일: " + week.getDay());
                                    
                  var weekday = new Array('일','월','화','수','목','금','토');
                  $("#week").text( weekday[week.getDay()]+"요일" );
               }
            });
         </script>
         <select id="hour" name="hour" class="timeLayout">
            <%
               for(int i = 9; i < 18; i++){
               %>
                  <option <%=(thour+ "").equals(i + "")?"selected='selected'":"" %>
                     value="<%=i%>"><%=i %>시</option>
               <%   
               }
            %>
         </select>
      </td>
      </tr>
   <tr>
      <th>글제목</th>
      <td>
         <input type="text" name="title" id="title" style="width:525.6px;">
      </td>
   </tr>
   <tr>
      <th>내용</th>
      
      <td>
         <textarea rows="10" cols="80" name="content"  style="resize: none;" id="content"></textarea>
      </td>
       
   </tr>
   <tr>
      <th>첨부파일</th>
      <td>
         <input type="file" style="width: 400px;" name="fileload">
      </td>
   </tr>
</tbody>
</table>
<br><br><br>
<input type="hidden" value="<%=user.getId() %>" name="id">
<input type="image" src="../image/accept.png"> 
<a href="../CombineList">
   <img src="../image/combine_cancel.png">
</a>
</div><br></form>
</div>
</section>
<!-- 확인/수정 등 버튼 간격조정 -->

</div>
<br><br><br>
<script type="text/javascript">
function nullchk() {
   var gender = document.getElementsByName("gender");
   
   /*
   if(!$("#agreePrivate").prop("checked")){
      alert("개인정보 취급방침에 동의해주셔야 합니다.");
      $("#agreePrivate").focus();
      return false;
   }
   */
   
   if(!$('#agreePrivate').is(':checked')) {
	      $("#agreePrivate").focus();
	      return alert("개인정보 취급방침에 동의해주셔야 합니다.");
   }
    if(   $("#inquire option:eq(0)").prop("selected")){
        alert("문의항목을 선택해주세요");
        $("#inquire").focus();
        return false;
     }
   if($("#title").val()==null || $("#title").val() == ""){
      alert("제목을 입력해주세요.")
      $("#title").focus();
      return false;
   }
   if($("#content").val()==null || $("#content").val() == ""){
      alert("내용을 입력해주세요.");
      $("#content").focus();
      return false;
   }
   var month = "";
   var day = "";
   var hour ="";
   /* 예약 선택 날짜 제한 */
   if($("#month").val().length<2){
	   month = "0" + $("#month").val();
   }else{
	   month = $("#month").val();
   }
   
   if($("#day").val().length<2){
	   day = "0" + $("#day").val();
   }else{
	   day = $("#day").val();
   }
   
   if($("#hour").val().length<2){
	   hour = "0" + $("#hour").val();
   }else{
	   hour = $("#hour").val();
   }
   
   var day1 = $("#year").val() + month + day + hour;
   day1 = parseInt(day1); /* 선택한 날짜와 시간 */
   var day2 = <%= "" + ttyear + UtilClass.two(String.valueOf(ttmonth)) + UtilClass.two(String.valueOf(ttday)) + UtilClass.two(String.valueOf(tthour)) %>
   day2 = parseInt(day2); /* 현재 날짜와 시간 */
   Number(day1);
   Number(day2);
   /* 현재 시간 +1 시간보다 커야만 예약가능 */
   if($("#inquire").val() == "예약" && day1 <= (day2+1)){
	   alert("예약이 가능한 시간이 아닙니다.");
	   return false;
   }
   return true;

}
$(document).ready(function () {
	
	$("#inquire").change(function(){
      
      var state = $('#inquire option:selected').val();
      if ( state == '예약' ) {
         $('.layer').show();
      } else if( state == '상담') {
         $('.layer').hide();
      }
   });

   
   var inquire = '<%=inquire%>';
   if(inquire != 'null' && inquire !=="" ){
      $('.layer').show();
      $("#inquire").val(inquire).prop("selected",true);
   }else{
      $("#inquire").val("default").prop("selected",true);
   }
   
   var date = '<%=year%>/<%=month%>/<%=day%>';
   $( "#rdate" ).datepicker( "setDate", date);
   $("#year").val("<%=tyear%>");
   $("#month").val("<%=tmonth%>");
   $("#day").val("<%=tday%>");
   
});

</script>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>

</body>
</html>