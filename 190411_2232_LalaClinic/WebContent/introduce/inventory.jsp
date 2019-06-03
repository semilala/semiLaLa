<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
.inventory_container { margin:100px 0 0; font-weight:bold; }
.inventory_container_last { margin:88px 0 88px; font-weight:bold; }
.subject { padding:5px 0; overflow:hidden; width:998px; margin:0 auto; font-size:24px; }
.subject img{ margin-bottom:2px; margin-right:12px}

.information { margin:30px auto 0; width:998px; overflow:hidden; }
.font { overflow:hidden; padding:22px 0; text-align:center; background:#000; color:#fff; width:316px; }
.font_line { overflow:hidden; padding:22px 0; text-align:center; background:#000; color:#fff; width:316px; }
.font a { color:#fff; }
.font_line a { color:#fff; }

.container_left { width:316px; float:left; }
.container_center { width:316px; float:left; margin-left:25px; }
.container_right { width:316px; float:left; margin-left:25px; }
</style>


<title>장비소개</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- local CSS -->
<link rel="stylesheet" href="../css/bbs.css">
</head>
<body>
<jsp:include page="../include/include_top.jsp" flush="false"></jsp:include>
<!-- 상단이미지 -->
<div id="sub_visual" >
   <div style="width: 100%;height:205px;background:url('../image/combine_category_bottom.png') no-repeat 50% 0px;"></div>
</div>
<div class="tb_top01">

<h3 style="margin-bottom: 0px;">병원소개/장비소개</h3>

<p align="right" style="margin-bottom: 10px;">
<a href="../introduce/directions.jsp">지점 안내</a> |
<a href="../introduce/inventory.jsp">장비소개</a> |
<a href="../introduce/introduce.jsp">병원 소개</a>
</p>

<div class="center" align="center"> 
<section id="page_mark">
<p align ="right" style="font-size: 13px"> <a href="/LalaClinic/index.jsp" style="text-decoration:none;"> 홈 </a> > 병원소개 > <b>장비소개</b> </p>
</section>

<section id="page_board">
<div class="inventory_container">

<div id="botox_container" class="subject"><img style="vertical-align: bottom;" src="../resource/uni_icon.png">색소 · 홍조</div>
     <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/1.jpg" alt="vrm레이저토닝"/></a></div>
            <div class="font"><a href="/LalaClinic/skin/laser.jsp">VRM 레이저 토닝</a></div>
      </div>
        <div class="container_center">
              <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/37.jpg" alt="블루토닝"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">블루토닝</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/35.jpg" alt="v레이저"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">V-레이저</a></div>
      </div>
   </div>          
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/11.jpg" alt="셀렉ipl"/></a></div>
            <div class="font"><a href="/LalaClinic/skin/laser.jsp">셀렉 IPL</a></div>
      </div>
        <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/24.jpg" alt="루비레이저"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">루비레이저</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/16.jpg" alt="노블렉스"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">노블렉스</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/31.jpg" alt="실펌레이저"/></a></div>
            <div class="font"><a href="/LalaClinic/skin/laser.jsp">실펌 레이저</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/14.jpg" alt="클라리티"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">클라리티 Pro</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/3.jpg" alt="co2"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">CO2 레이저</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/17.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">라셈드</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp" target="_blank"><img src="http://design.uni114.co.kr/images/introduce/inventory/46.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp" target="_blank">콰드로 스타</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp" target="_blank"><img src="http://design.uni114.co.kr/images/introduce/inventory/5.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp" target="_blank">에일린</a></div>
      </div>
   </div>

<!-- 제모 -->          
<div class="inventory_container">
   <div id="skin_container" class="subject"><img src="../resource/uni_icon.png">제모</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp" target="_blank"><img src="http://design.uni114.co.kr/images/introduce/inventory/30.jpg" alt=""/></a></div>
         <div class="font_line"><a href="/LalaClinic/skin/laser.jsp" target="_blank">아포지 Plus</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp" target="_blank"><img src="http://design.uni114.co.kr/images/introduce/inventory/28.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp" target="_blank">아리온</a></div>
      </div>
   </div>
</div>
</div>
<!-- 여드름 -->
<div class="inventory_container">
   <div id="obesity_container" class="subject"><img src="../resource/uni_icon.png">여드름</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/2.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">알레그로</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/40.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">아큐어</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/27.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">아트 레이저</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/15.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">아그네스</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/20.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">미라클리어</a></div>
      </div>
   </div>
</div>

<!-- 모공, 흉터 -->         
<div class="inventory_container">
   <div id="lifting_container" class="subject"><img src="../resource/uni_icon.png">모공 · 흉터</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/4.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">프락셀</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/10.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">인트라셀</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/32.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">스칼렛</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/41.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">CICU 레이저</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/48.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">에어 다이섹터</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/49.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">MIMO 레이저</a></div>
      </div>   
   </div>
</div>
         
<!-- 리프팅 -->
<div class="inventory_container">
   <div id="lifting_container" class="subject"><img src="../resource/uni_icon.png">리프팅</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/22.jpg" alt=""/></a></div>
         <div class="font"><a href="/lifting/shurink.php">슈링크</a></div>
      </div>
   </div>
</div>

<!-- 스킨케어 -->         
<div class="inventory_container">
   <div id="lifting_container" class="subject"><img src="../resource/uni_icon.png">스킨케어</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/21.jpg" alt=""/></a></div>
         <div class="font_line"><a href="/LalaClinic/skin/laser.jsp">프리즘 [이온자임]</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/9.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">아쿠아필 Plus</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/42.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">크라이오</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/43.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">소노&바티민관리</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/18.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">LDM</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/47.jpg" alt=""/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">오투덤 산소테라피</a></div>
      </div>                 
   </div>
   </div>

<!-- 탄력, 다이어트 -->
<div class="inventory_container_last">
   <div id="lifting_container" class="subject"><img src="../resource/uni_icon.png">탄력 · 다이어트</div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/33.jpg" alt="컴포트듀얼"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">컴포트 듀얼</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/29.jpg" alt="엑스웨이브"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">X-WAVE</div></a>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/34.jpg" alt="메가스키니"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">메가 스키니</a></div>
      </div>
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/45.jpg" alt="카복시"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">카복시</a></div>
      </div>
      <div class="container_center">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/13.jpg" alt="엑실리스"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">엑실리스</a></div>
      </div>
      <div class="container_right">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/44.jpg" alt="트리플바디"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">트리플 바디</a></div>
      </div>               
   </div>
   <div class="information">
      <div class="container_left">
         <div><a href="/LalaClinic/skin/laser.jsp"><img src="http://design.uni114.co.kr/images/introduce/inventory/50.jpg" alt="라필로"/></a></div>
         <div class="font"><a href="/LalaClinic/skin/laser.jsp">라필로</a></div>
      </div>              
   </div>
</div>
</section>
</div>
</div>

<footer>
   <jsp:include page="../include/include_footer.jsp" flush="false"></jsp:include>
</footer>

</body>
</html>