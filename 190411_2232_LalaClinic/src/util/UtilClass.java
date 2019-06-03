package util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

import combine.dto.CombineDto;

//import dto.CalendarDto;

public class UtilClass {
   //문자열이 들어왔을 때 비어있거나 널이면 true리턴
   public static boolean nvl(String msg) {
      return msg==null || msg.trim().equals("")? true:false;
   }
   
   //날짜를 클릭하면, 그날의 일정이 모두 보이도록 하는 callist.jsp로 이동시키는 함수
   public static String callist(int year, int month, int day) {
      String s = "";
      
      s = String.format("<a href='%s?year=%d&month=%d&day=%d'>", "/LalaClinic/CalendarDayList", year, month, day);
      s += String.format("<span class='date'>%2d</span>", day);
      s += "</a>";
      
      return s;
   }
   
   public static String callistAdmin(int year, int month, int day) {
      String s = "";
      
      s = String.format("<a href='%s?year=%d&month=%d&day=%d'>", "/LalaClinic/AdminCalendarDayList", year, month, day);
      s += String.format("<span class='date'>%2d</span>", day);
      s += "</a>";
      
      return s;
   }
   
   //일정을 추가하기 위한 calwrite.jsp로 이동하기 위한 함수로,
   //이미지(펜)를 클릭시 처리하는 함수
   public static String showPen(int year, int month, int day) {
      String s = "";
      
      String image = "<img src='./mypage/images/pen_20x20.png'>";
      
      s = String.format("<a href='%s?year=%d&month=%d&day=%d&inquire=예약'>%s</a>", 
            "combine/combine_write.jsp", year, month, day, image);
      return s;
   }
   
   //1. 월 앞에 0을 붙여서 2자리로 만들어주는 함수
   public static String two(String msg) {
      return msg.trim().length()<2? "0"+msg.trim():msg.trim();
   }
   
   //각 날짜별로 테이블을 생성하는 함수
   public static String makeTable(int year, int month, int day, List<CombineDto> list) {
      String s = "";
      String dates = (year+"") + two(month+"") + two(day+""); //20190314
      
      //날짜당 테이블 하나 생성
      s += "<table class='contentCal'>";
      s += "<colgroup><col width='100%'></colgroup>";
      
      int count = 0;
      for(CombineDto dto : list) {
         if(dto.getRdate().substring(0, 8).equals(dates)) {
            count++;
         }   
      }
      if(count>0) {
         s += "<thead>";
         s += "<tr>";
         s += "<th>";
         /*s += "<font style='font-size:8; font-color:red;'>예약: " + count + "개</font>";*/
         s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", "/LalaClinic/CalendarDayList", year, month, day);
         s += "예약: " + count + "";
         s += "</a>";
         s += "</th>";
         s += "</tr>";
         s += "</thead>";
      }
      
      count = 0;
      s += "<tbody>";
      for(CombineDto dto : list) {
         if(dto.getRdate().substring(0, 8).equals(dates)) {
            if(count<2) {
               s += "<tr>";
               s += "<td>";
               
               s += "<a href='/LalaClinic/CombineDetail?seq=" + dto.getSeq() + "'>";
               s += dot3( dto.getTitle() );
               s += "</a>";
               
               s += "</td>";
               s += "</tr>";
            }
            count++;
         }
         
      }
      s += "</tbody>";
      s += "</table>";
      
      return s;
   }
   
   //각 날짜별로 테이블을 생성하는 함수 (관리자용 - 이름보이게)
   public static String makeTableAdmin(int year, int month, int day, List<CombineDto> list) {
      String s = "";
      String dates = (year+"") + two(month+"") + two(day+""); //20190314
      
      //날짜당 테이블 하나 생성
      s += "<table class='contentCal'>";
      s += "<colgroup><col width='100%'></colgroup>";
      
      int count = 0;
      for(CombineDto dto : list) {
         if(dto.getRdate().substring(0, 8).equals(dates)) {
            count++;
            System.out.println("rdate: " + dto.getRdate().substring(0, 8) + ", dates: " + dates + ", count: " + count);
         }   
      }
      if(count>0) {
         s += "<thead>";
         s += "<tr>";
         s += "<th>";
         /*s += "<font style='font-size:8; color:red;'>예약: " + count + "개</font>";*/
         s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", "/LalaClinic/AdminCalendarDayList", year, month, day);
         s += "예약: " + count + "";
         s += "</a>";
         s += "</th>";
         s += "</tr>";
         s += "</thead>";
      }
      
      count = 0;
      for(CombineDto dto : list) {
         if(dto.getRdate().substring(0, 8).equals(dates)) {
            if(count<2) {
               s += "<tr>";
               s += "<td>";
               
               s += "<a href='/LalaClinic/CombineDetail?seq=" + dto.getSeq() + "'>";
               //s += "<font style='font-size:6; color:black;'>";
               s += dot3( dto.getName() + "-" + dto.getMedical() );
               //s += "</font>";
               s += "</a>";
               
               s += "</td>";
               s += "</tr>";
            }
            count++;
         }
         
      }
      s += "</table>";
      
      return s;
   }
   
   //제목이 너무 길면, ...으로 한줄로 만드는 함수
   //ex) 데이트약속이 7시 -> 데이트약... 이렇게 만들어줌
   public static String dot3(String msg) {
      String s = "";
      
      if(msg.length()>7) {
         s = msg.substring(0, 7);
         s += "..."; 
      }
      else {
         s = msg.trim();
      }
      
      return s;
   }
   
   //날짜문자열을 잘라줄 함수
   public static String getTimeFormat(String msg) {
      String s = String.format("%s-%s-%s %s:%s", 
            msg.substring(0, 4),
            msg.substring(4, 6),
            msg.substring(6, 8),
            msg.substring(8, 10),
            msg.substring(10, 12)
            );
      
      return s;
   }
   
   //날짜문자열을 잘라줄 함수
   public static String[] getTimeFormat(String msg, int i) {
      /*int[] str = new int[5];
      str[0] = Integer.parseInt(msg.substring(0, 4));
      str[1] = Integer.parseInt(msg.substring(4, 6));
      str[2] = Integer.parseInt(msg.substring(6, 8));
      str[3] = Integer.parseInt(msg.substring(8, 10));
      str[4] = Integer.parseInt(msg.substring(10, 12));*/
      
      String[] str = new String[5];
      str[0] = msg.substring(0, 4);
      str[1] = msg.substring(4, 6);
      str[2] = msg.substring(6, 8);
      str[3] = msg.substring(8, 10);
      
      return str;
   }
   
   //날짜문자열을 잘라줄 함수
   public static int[] getTimeFormatInt(String msg, int i) {
      /*int[] str = new int[5];
      str[0] = Integer.parseInt(msg.substring(0, 4));
      str[1] = Integer.parseInt(msg.substring(4, 6));
      str[2] = Integer.parseInt(msg.substring(6, 8));
      str[3] = Integer.parseInt(msg.substring(8, 10));
      str[4] = Integer.parseInt(msg.substring(10, 12));*/
      
      int[] arr = new int[5];
      arr[0] = Integer.parseInt(msg.substring(0, 4));
      arr[1] = Integer.parseInt(msg.substring(4, 6));
      arr[2] = Integer.parseInt(msg.substring(6, 8));
      //str[3] = msg.substring(8, 10);
      
      return arr;
   }
   
   //날짜문자열을 잘라줄 함수
   public static String getRdateString(String msg) {
      
      String str = "";
      
      String[] s = new String[5];
      s[0] = msg.substring(0, 4);
      s[1] = msg.substring(4, 6);
      s[2] = msg.substring(6, 8);
      s[3] = msg.substring(8, 10);
      
      str = String.format("%s년 %s월 %s일 %s시", s[0], two(s[1]), two(s[2]), two(s[3]));
      
      return str;
   }
   
   //대댓글 화살표함수
   public static String arrow(int depth){
      String rs = "<img src='./images/arrow.png' width='20px' height='20px'/>";
      String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";   // 여백

      String ts = "";   
      for(int i = 0;i < depth; i++){
         ts += nbsp;
      }   
      return depth==0?"":ts + rs;
   }
   
   public static String nbsp(int depth) {
      String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";   // 여백

      String ts = "";   
      for(int i = 0;i < depth; i++){
         ts += nbsp;
      }   
      return depth==0?"":ts;
   }
   
   //회원탈퇴시 뒤에 붙일 숫자생성용 함수
   public static String makeTrash() {
      String str = "";
      
      Date time = new Date();
      SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");
      str = format.format(time);
      
      return "trash"+str;
   }
   
   public static String[] processUploadFile(FileItem fileItem, String dir) throws IOException{

      String fileNameBf = fileItem.getName(); // 경로 + 파일명 (원본)
      String fileNameAf = "";      // 변경후 파일명
      long sizeInBytes = fileItem.getSize(); // 파일 크기
      String extension = "";
      SimpleDateFormat format1 = new SimpleDateFormat( "yyyyMMddHHmmssSSS");
      Date time = new Date();
      String time1 = format1.format(time);   //수정후 파일명
      
      // 파일이 정상일 때
      if(sizeInBytes > 0){   // d:\\temp\\abc.txt  d:/temp/abc.txt

         int idx = fileNameBf.lastIndexOf("\\");
         if(idx == -1){
            idx = fileNameBf.lastIndexOf("/");
         }
         fileNameBf = fileNameBf.substring(idx+1);   //파일명취득
         
         int exIndex = fileNameBf.lastIndexOf(".");   //확장자취득
         
         extension = fileNameBf.substring(exIndex);
         
         fileNameAf = time1 + extension;    //임시파일명 + 확장자
         
         File uploadFile = new File(dir,fileNameAf);
         try{
            fileItem.write(uploadFile);   //실제 파일을 올리는 부분
         }catch(Exception e){}
      }
      
      String fileName[] = {fileNameBf,fileNameAf};
      System.out.println("fileName[0] " + fileName[0]);
      System.out.println("fileName[1]" + fileName[1]);
      return fileName; 

   }   
}