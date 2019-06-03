<%@page import="member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

%>
   
<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin==null) {
   %>
   <script type="text/javascript">
   //alert("세션이 만료됐습니다. 다시 로그인하세요.");
   //location.href = "login.jsp";
   </script>
   <%
}
else {
   member = (MemberDto)ologin;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>라라클리닉 역삼점</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">
   
   
<style type="text/css">

#iframe {
    float: left;
    width: 533px;
    background: #000;
    border: 1px solid #e8e8e8;
    overflow: hidden;
    height: 270px;
}
</style>   
   <!-- 팝업시작1 -->
<style type="text/css">
#main_banner { background:rgba(0, 0, 0, 0.9); z-index:9999; width:100%; height:100%; position:fixed; top:0; left:0; display:none; }
#popup_img { position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); width:1000px; }
#popup_close { position:relative; float:right; margin-bottom:5px; }
#popup_close2 { position:relative; float:left; margin-bottom:5px; }
#space_left { float:left; clear:both; }
#space_right { float:left;}
</style>
<!-- 팝업끝 -->
   
</head>

<body>
<!-- 팝업시작2 -->
<div id="main_banner" style="display: none;">
   <div id="popup_img">
      <div id="popup_close">
            <a href="javascript:void(0);" onclick="javascript:oneday();">
         <img style="width:25px; height:25px; " src="../member/images/popup_close_img.png" title>
         </a>
      </div>
      <div >
         <input type="checkbox" id="popup_close2"><font color="white">오늘 하루 보지않기</font>
      </div>
      <div id="space">
      <img src="../member/images/popUp_img.jpg">
      </div>
   </div>
</div>
<!-- 팝업끝 -->
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>

<div align="center">
<!-- <div style="width: 1100px;"> -->


<!-- 슬라이드? -->
<div id="carouselExampleIndicators" class="carousel slide"
   data-ride="carousel">
   <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0"
         class="active"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
   </ol>
   <div class="carousel-inner">
      <div class="carousel-item active">
         <img src="../member/images/s2.jpg" class="d-block w-100"
            alt="...">
      </div>
      <div class="carousel-item">
         <img src="../member/images/s3.jpg" class="d-block w-100"
            alt="...">
      </div>
      <div class="carousel-item">
         <img src="../member/images/s4.jpg" class="d-block w-100"
            alt="...">
      </div>
      <div class="carousel-item">
         <img src="../member/images/s1.jpg" class="d-block w-100"
            alt="...">
      </div>
   </div>
   <a class="carousel-control-prev" href="#carouselExampleIndicators"
      role="button" data-slide="prev"> <span
      class="carousel-control-prev-icon" aria-hidden="true"></span> <span
      class="sr-only">Previous</span>
   </a> <a class="carousel-control-next" href="#carouselExampleIndicators"
      role="button" data-slide="next"> <span
      class="carousel-control-next-icon" aria-hidden="true"></span> <span
      class="sr-only">Next</span>
   </a>
</div>
<!-- </div> -->

<!-- 하단이미지 -->
<div style="width: 1100px;">

<div style="padding-top: 30px; padding-bottom: 8px">
<a href="../botox/filler.jsp">
<img alt="" src="../member/images/mainDeco_img1.jpg" style="height:320px; width:533px; float: left;">
</a>
<a href="../lifting/lifting.jsp">
<img alt="" src="../member/images/mainDeco_img2.jpg" style="height:320px; width:533px; float: rigth;">
</a>
</div>

<div style="padding-top: 8px; padding-bottom: 10px;">
<a href="../skin/laser.jsp">
<img alt="" src="../member/images/mainDeco_img3.jpg" style="height:320px; width:533px; float: left;">
</a>
<a href="../botox/filler.jsp">
<img alt="" src="../member/images/mainDeco_img4.jpg" style="height:320px; width:533px; float: rigth;">
</a>
</div>

<div style="padding-top: 6px; padding-bottom: 50px;">
<div id="iframe">
<video style="float: left;" width="533px" height="270px" controls autoplay loop muted >
   <source src="../member/images/video_main.mp4" type="video/mp4"></source>
</video>
</div>
<img alt="" src="../member/images/mainDeco_img5.jpg" style="height:270px; width:533px; float: rigth;">
</div>
</div>
</div>


<div style="width: 100%">
<img style="height:220px; width: 100%;" src="../member/images/main_visual_bottom.png">

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<textarea id="editor"></textarea>

<a class="submitEditor" href="#">입력하기</a>
<form action="/submit">
<input type="hidden" id="haha" />

</form>
<script type="text/javascript">
var editor = CKEDITOR.replace( 'editor' );
$('.submitEditor').bind('click', function(e) {
	e.preventDefault();
	console.log(editor.getData())
	$('#haha').val(editor.getData())
})

/*
CKEDITOR.cofnig.plugins = [
	'', ''
]
*/
</script>

</div>

<!-- Tocplus 15.1 -->
<script type="text/javascript">

tocplusTop=1150;
tocplusLeft=5;
tocplusMinimizedImage='http://kr07.tocplus007.com/img/minimized_ko.gif';
tocplusHAlign='right';
tocplusWidth=300;
tocplusHeight=420;
tocplusUserName='손님';
tocplusFrameColor='#e6e6e6';
tocplusFloatingWindow=true;
var tocplusHost = (("https:" == document.location.protocol) ? "https://" : "http://");
document.write(unescape("%"+"3Cscript src='" + tocplusHost + "kr07.tocplus007.com/chatLoader.do?userId=black8594' type='text/javascript'"+"%"+"3E"+"%"+"3C/script"+"%"+"3E"));
</script>
<!-- End of Tocplus -->

<!-- 팝업시작3 -->
<script type="text/javascript">

  
      getCookieMobile();  
   
      

   
  function getCookieMobile () {
       var cookiedata = document.cookie;
      
       if ( cookiedata.indexOf("todayCookie=done") < 0 ){
            $("#main_banner").show();
       }
       else {
           $("#main_banner").remove();
       }
   }
    $("#popup_close").click(function () {
       //alert("들옴");
        if( $("#popup_close2").is(":checked") ) {
           setCookieMobile( "todayCookie", "done" , 1); 
          // alert("체크들옴");
        }else{
           
          // alert("체크안들옴");
        }
       
    
        $("#main_banner").hide();
    });

 
function setCookieMobile ( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

 

  
</script>
<!-- 팝업끝 -->



<!-- Optional JavaScript -->
   <!-- jQuery first, then Popper.js, then Bootstrap JS -->
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
      integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
      crossorigin="anonymous"></script>
   <script
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
      integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
      crossorigin="anonymous"></script>
   <script
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
      integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
      crossorigin="anonymous"></script>
<footer>
<jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>
</body>
</html>