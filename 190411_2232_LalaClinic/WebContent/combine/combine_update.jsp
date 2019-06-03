<%@page import="util.UtilClass"%>
<%@page import="combine.dto.CombineDto"%>
<%@page import="member.dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto user = new MemberDto();
if(ologin == null) {
   %>
   <script type="text/javascript">
   alert("로그인 후 이용해 주세요.");
   location.href = "./member/login.jsp";
   </script>
   <%
}
else {
   user = (MemberDto)ologin;   
}

%>
<%

Calendar cal = Calendar.getInstance();

CombineDto com = (CombineDto)request.getAttribute("dto");

if(!user.getId().equals(com.getId())){
	 %>
	   <script type="text/javascript">
	   alert("접근권한이 없습니다.");
	   location.href = "/LalaClinic/CombineList";
	   </script>
	 <%
}

int year = Integer.parseInt(com.getRdate().substring(0,4));
int month = Integer.parseInt(com.getRdate().substring(4,6));
int day = Integer.parseInt(com.getRdate().substring(6,8));
int hour = Integer.parseInt(com.getRdate().substring(8,10));
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) +1;
int tday = cal.get(Calendar.DATE);
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int thour = cal.get(Calendar.HOUR_OF_DAY);
/* 
//현재 시간이 16시가 넘으면 다음날로 넘어가되 현재 날짜가 그달의 마지막날이면
//현재 달의 +1 날짜는 1일 시간은 9시 로셋팅
if(thour >= 16){
   
   if(tday == lastDay){
      tday = 1;
      tmonth += 1;
   }else{
      tday += 1;
   }
   
   thour = 9;
//16시 이전이면 hour는 현재시간 +1
}else{
   thour += 1;   
}
 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- <script type="text/javascript" src="./nse_files/js/HuskyEZCreator.js" charset="utf-8"></script> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<!-- 문의항목별 예약날짜 on/off -->
<style type="text/css">
.layer{
   display: none; 
}
.filebtnlayer{
   display: none;
}
.changebtnlayer{
   display: none;
}
.timeLayout{
	vertical-align: bottom;
	height:22px;
}
.filebtn {

  background-image : url('./image/combine_update.png'); 

  background-position:top right; 

  background-repeat:no-repeat;
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
/* #page_mark{ */
/*     margin:1rem 1rem 1rem 0; */
/* } */
a{text-decoration: none;}
a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}
.bold{
    font-weight: bold!important;
    color:black;
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
#page_mark {
    clear: all;
    position: absolute;
    width: 1080px;
    text-align: right;
    padding: 20px 10px;
    z-index: 2;
    color: #959595;
    font-size: 9pt;
}
.tb_top01 h3{
	margin-left:60px;
	margin-top:30px;
	margin-bottom:30px;
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
</style>
</head>
<body style="margin:0px">


<div class="categoryTop">
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
</div>

<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('/LalaClinic/image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>



<div class="tb_top01" >
<h3 id="h3">상담 및 예약</h3>
</div>


<div align="center" class="center" >
<div align="center" class="center" >

<section id="page_mark">
   <p align ="right" style="font-size: 13px"> 
   		<a href="/LalaClinic/index.jsp">홈</a> > 
   	
   		<a href="/LalaClinic/CombineList" ><span class="bold">상담 및 예약</span> </a>
   	
   </p>
</section>
<section id="page_board">
<div class ="tb_Head01" align="center">
<form action="./CombineUpdate" method="post" enctype="multipart/form-data" onsubmit="return nullchk()">
<input type="hidden" value="af" name="command">

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
         <span><%=com.getName() %></span>
         <input type="hidden" value="<%=com.getName() %>" readonly name = "name">
      </td>
   </tr>
   <tr>
      <th>연락처</th>
      <td>
         <span><%=com.getPhone() %></span>
         <input type="hidden" value="<%=com.getPhone() %>" readonly name="phone">
      </td>
   </tr>
   <tr>
      <th>이메일</th>
      <td>
         <span><%=com.getEmail() %></span>
         <input type="hidden" value="<%=com.getEmail() %>" readonly name ="email">
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
         <select name="medical" id="medical">
               <option value="보톡스">보톡스</option>
               <option value="필러">필러</option>
               <option value="리프팅">리프팅</option>
         </select>
      </td>
   </tr>
      <tr class="layer">
         <th>희망 예약날짜</th>
         <td>
         
         <input type="text" id="rdate" name="rdate" readonly="readonly">
         <input type="hidden" name="year" id="year" value="<%=year%>">
         <input type="hidden" name="month" id="month" value="<%=month%>">
         <input type="hidden" name="day" id="day" value="<%=day%>">
         
         <script type="text/javascript">
            $("#rdate").datepicker({
                // 달력에 표시될 텍스트들
                dateFormat:"yy/mm/dd",
                dayNamesMin:['일','월','화','수','목','금','토'],
                monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                //보여줄 년도를 해당년도 ~ 해당년도 + 1 까지
<%--                 yearRange: "<%=tyear%>:<%=tyear+1%>" , --%>
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
                  <option <%=(hour+ "").equals(i + "")?"selected='selected'":"" %>
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
         <input type="text" name="title" id="title" value="<%=com.getTitle() %>" style="width:525.6px;">
      </td>
   </tr>
   <tr>
      <th>내용</th>
      
      <td>
         <textarea rows="10" cols="80" name=content  style="resize: none;" id="content"><%=com.getContent() %></textarea>
      </td>
       
   </tr>
   
   <tr class="changebtnlayer">
      <th>첨부파일</th>
      <td>
         <input type="text" readonly style="border:none" id="fileName" value='<%=com.getFileNameBf()==null?"첨부된 파일이 없습니다.":com.getFileNameBf() %>'> &nbsp;
         <input type="button" value="변경" name="changefile" id="changefile" onclick="viewBtn()">
         <input type="button" value="삭제" name="deletefile" id="deletefile" onclick="deleteFile()">
      </td>
   </tr>
   <tr class="filebtnlayer">
      <th>첨부파일</th>
      <td>
<!--          <input type="file"  style="width: 400px;" name="fileload" onclick="fileload()"> -->
         <input type="file" style="width: 400px" name ="fileload" onclick="fileLoad()">
         <input type="button" id="offbtn"  value="취소" onclick="offBtn()">
      </td>
   </tr>
   
</tbody>
</table>
<br><br>
<input type="hidden" value="<%=com.getId() %>" name="id">
<%System.out.println("update view seq " + com.getSeq()); %>
<input type="hidden" value="<%=com.getSeq() %>" name="seq">
<input type="hidden" name="filechk" id="filechk" value="ex">
<input type="image" src="./image/accept.png"> 
<a href="./CombineList" >
   <img src="./image/combine_cancel.png">
</a>
<!-- <input type="submit" value="전송" onclick="submitContents(this)" /> -->
</form></div></section><br>
</div>
</div>
<!-- 확인/수정 등 버튼 간격조정 -->


<br><br><br>
<script type="text/javascript">
var filechk = false;
function nullchk() {
   var gender = document.getElementsByName("gender");
   
    if(   $("#inquire option:eq(0)").prop("selected")){
        alert("문의항목을 선택해주세요");
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
   var day2 = <%= "" + tyear + UtilClass.two(String.valueOf(tmonth)) + UtilClass.two(String.valueOf(tday)) + UtilClass.two(String.valueOf(thour)) %>
   day2 = parseInt(day2); /* 현재 날짜와 시간 */
   Number(day1);
   Number(day2);
   /* 현재 시간 +1 시간보다 커야만 예약가능 */
   if($("#inquire").val() == "예약" && day1 <= (day2+1)){
	   alert("예약이 가능한 시간이 아닙니다.");
	   $("#hour").val("<%=hour%>").prop("selected",true);
	   return false;
   }
   return true;

}

function fileLoad(){
   $("#filechk").val("up");
   
}
function viewBtn(){
   $('.filebtnlayer').show();
   $('.changebtnlayer').hide();
}
function offBtn(){
   $('.filebtnlayer').hide();
   $('.changebtnlayer').show();
}
function deleteFile(){
   $("#fileName").val("");
   $("#filechk").val("del");
}

$(document).ready(function () {

   
   // 변경/삭제 버튼 보여주게하는 default값
   $('.changebtnlayer').show();   
   //예약 or 상담시 보여주는 view 변화
   $("#inquire").change(function(){
      var state = $('#inquire option:selected').val();
      if ( state == '예약' ) {
         $('.layer').show();
      } else if( state == '상담') {
         $('.layer').hide();
      }
   });
   
   //기존값들 불러와줌
   if("<%=com.getInquire()%>" == "상담"){
      $("#inquire").val("상담").prop('selected',true);
   }else if("<%=com.getInquire()%>" == '예약'){
      $("#inquire").val("예약").prop('selected',true);
      $('.layer').show();
   }
   
   if("<%=com.getGender()%>" == "M"){
      $("#gender").val("남").prop("checked",true);
   }else if("<%=com.getGender()%>" == 'F'){
      $("#gender").val("예약").prop("checked",true);
   }
   
   if("<%=com.getMedical()%>" == "보톡스"){
      $("#medical").val("보톡스").prop('selected',true);
   }else if("<%=com.getMedical()%>" == '필러'){
      $("#medical").val("필러").prop('selected',true);
   }else if("<%=com.getMedical()%>" == '리프팅'){
      $("#medical").val("리프팅").prop('selected',true);
   }
   
    var date = '<%=year%>/<%=month%>/<%=day%>';
    $( "#rdate" ).datepicker( "setDate", date);
   $("#hour").val("<%=hour%>").prop("selected",true);
   $("#year").val("<%=year%>");
   $("#month").val("<%=month%>");
   $("#day").val("<%=day%>");
   
});

</script>

<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</body>
</html>