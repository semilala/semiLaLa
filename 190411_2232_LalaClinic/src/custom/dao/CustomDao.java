package custom.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;

import custom.dto.CustomDto;
import db.DBClose;
import db.DBConnection;
import paging.PagingBean;
import paging.PagingUtil;
import util.ReplyDto;

public class CustomDao implements iCustomDao {

   
   private static CustomDao customdao = new CustomDao();

   private CustomDao() {

      DBConnection.initConnect();

   }
   public static CustomDao getInstance() {

      return customdao;

   }
   @Override
   public boolean insertCustom(CustomDto dto) {

      String sql = " INSERT INTO CUSTOM "
            + " (SEQ, ID, TITLE, CONTENT, FILENAMEAF, FILENAMEBF, WDATE, TNAME, PROGRESS) "
            + " VALUES(SEQ_CUSTOM.NEXTVAL,"
            + " ?,?,?,?,?,SYSDATE, 'CUSTOM',0) ";

      int count = 0;

      Connection conn = null;
      PreparedStatement psmt = null;

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 insertCustom success");

         psmt = conn.prepareStatement(sql);
         System.out.println("2/6 insertCustom success");
         psmt.setString(1, dto.getId());
         psmt.setString(2, dto.getTitle());
         psmt.setString(3, dto.getContent());
         psmt.setString(4, dto.getFileNameAf());
         psmt.setString(5, dto.getFileNameBf());

         count = psmt.executeUpdate();
         System.out.println("3/6 insertCustom success");
      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("insertCustom fail");
      }finally {
         DBClose.close(conn, psmt, null);         
      }

      return count>0?true:false;
   }

   //   @Override
//   public List<CustomDto> allPrint() {
//
//      String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, WDATE "
//            + " FROM CUSTOM "
//            + " ORDER BY SEQ DESC ";
//      Connection conn = null;
//      PreparedStatement psmt= null;
//      ResultSet rs = null;
//      
//      List<CustomDto> list = new ArrayList<>();
//      
//      try {
//         conn = DBConnection.getConnection();
//         System.out.println("1/6 allPrint suc");
//         
//         psmt = conn.prepareStatement(sql);
//         System.out.println("2/6 allPrint suc");
//         
//         rs =  psmt.executeQuery();
//         System.out.println("3/6 allPrint suc");
//         
//         
//         while(rs.next()) {
//            CustomDto dto = new CustomDto();
//            
//            dto.setSeq(rs.getInt("SEQ"));
//            dto.setId(rs.getString("ID"));
//            dto.setTitle(rs.getString("TITLE"));
//            dto.setContent(rs.getString("CONTENT"));
//            dto.setFileNameAf(rs.getString("fileNameAf"));
//            dto.setFileNameAf(rs.getString("fileNameBf"));
//            dto.setWdate(rs.getString("WDATE"));
//            
//            list.add(dto);
//         }
//         
//         
//         
//      } catch (Exception e) {
//
//         System.out.println("allPrint fail");
//         e.printStackTrace();
//      }finally {
//         DBClose.close(conn, psmt, rs);
//      }
//      
//      return list;
//   }
   
   public CustomDto detail(CustomDto dto) {
      String sql = " SELECT SEQ, C.ID, TITLE, CONTENT, FILENAMEBF, FILENAMEAF , WDATE, TNAME, PROGRESS, M.NAME"
            + "  FROM CUSTOM C , MEMBER M "
            + " WHERE C.ID = M.ID AND SEQ = ? ";
            
            

      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;

      //List<CustomDto> list = new ArrayList<>();

      try {
         conn = DBConnection.getConnection();


         System.out.println("1/6 detail suc");

         psmt = conn.prepareStatement(sql);
         System.out.println("2/6 detail suc");
         psmt.setInt(1, dto.getSeq());

         rs = psmt.executeQuery();
         System.out.println("3/6 detail suc");

         if(rs.next()) {

            System.out.println("4/6 detail suc");
            dto = new CustomDto(
                  rs.getInt(1),
                  rs.getString(2),
                  rs.getString(3),
                  rs.getString(4),
                  rs.getString(5),
                  rs.getString(6),
                  rs.getString(7),
                  rs.getString(8),
                  rs.getInt(9)
                  );
            dto.setName(rs.getString(10));
            
         }
         
         System.out.println("5/6 detail suc");


      } catch (Exception e) {
         System.out.println(" detail fail");
         e.printStackTrace();
      }finally {

         DBClose.close(conn, psmt, rs);
      }
      
      return dto;
   }
   
   @Override
   public boolean update(CustomDto dto) {
      String sql = " UPDATE CUSTOM "
            + " SET TITLE=?, CONTENT=?, FILENAMEAF=?, FILENAMEBF=? "
            + " WHERE SEQ = ? ";

      int count = 0;

      Connection conn = null;
      PreparedStatement psmt = null;



      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 update success");

         psmt = conn.prepareStatement(sql);
         System.out.println("2/6 update success");
         
         psmt.setString(1, dto.getTitle());
         psmt.setString(2, dto.getContent());
         psmt.setString(3, dto.getFileNameAf());
         psmt.setString(4, dto.getFileNameBf());
         psmt.setInt(5, dto.getSeq());
         System.out.println("3/6 update success");
         count = psmt.executeUpdate();
         System.out.println("4/6 update success");

      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("update fail");
      }finally {
         DBClose.close(conn, psmt, null);         
      }



      return count>0?true:false;
   }
   
   public List<CustomDto> getCustomPagingList(PagingBean paging, String searchWord, String choice) {
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      List<CustomDto> list = new ArrayList<>();
      String sWord = "";
      if(choice.equals("title")) {   // 제목
         sWord = " AND TITLE LIKE '%" + searchWord.trim() + "%'";
      }else if(choice.equals("writer")) {   // 작성자
         sWord = " AND NAME='" + searchWord.trim() + "' ";
      }else if(choice.equals("content")) { // 내용
         sWord = " AND CONTENT LIKE '%" + searchWord.trim() + "%'";
      } 
      
         
         /*String sql = " SELECT * FROM "
               + " (SELECT * FROM "
               + "      (SELECT * FROM CUSTOM "
               + "      ORDER BY REF ASC, STEP DESC) "      
               + " WHERE ROWNUM <=" + paging.getStartNum() + ""   // 시작번호
               + " ORDER BY REF DESC, STEP ASC) "   
               + " WHERE ROWNUM <=" + paging.getCountPerPage();   // 10개까지
*/         try {   
         conn = DBConnection.getConnection();
         System.out.println("1/6 getBbsPagingList Success");
         
         String totalSql = " SELECT COUNT(SEQ) "
               + " FROM CUSTOM C, MEMBER M "
               + " WHERE C.ID = M.ID "
               + sWord;
         
         psmt = conn.prepareStatement(totalSql);         
         
         rs = psmt.executeQuery();
         
         int totalCount = 0;
         rs.next();
         totalCount = rs.getInt(1);
          paging.setTotalCount(totalCount);
            paging = PagingUtil.setPagingInfo(paging);
            System.out.println("totalCount:" + totalCount );
            
            psmt.close();
            rs.close();
            System.out.println("paging.getStartNum():"+paging.getStartNum());
            System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
            /*String sql =  " SELECT * FROM "
                    + " (SELECT SEQ, ID, NAME, TITLE, CONTENT, WDATE, FILENAMEAF, FILENAMEBF FROM "
                    + "      (SELECT C.SEQ, C.ID, M.NAME, C.TITLE, C.CONTENT, C.TITLE, C.WDATE "
                    + "          C.FILENAMEAF, C.FILENAMEBF "
                    + "         FROM CUSTOM C , MEMBER M "
                    + "         WHERE C.ID = M.ID "
                    + "         " + sWord
                    + "      ORDER BY C.SEQ ASC) "      
                    + " WHERE ROWNUM <=" + paging.getStartNum() + ""   // 시작번호
                    + " ) "   
                    + " WHERE ROWNUM <=" + paging.getCountPerPage();   // 10개까지
*/
            
            String sql =  "SELECT * "
                      + " FROM (SELECT *  FROM "
                      + "      (SELECT SEQ, C.ID, TITLE, CONTENT,"
                      + "       FILENAMEBF, FILENAMEAF, WDATE, PROGRESS , M.NAME FROM CUSTOM C, MEMBER M "
                      + "     WHERE C.ID = M.ID " 
                      + " " +sWord
                    + "      ORDER BY SEQ ASC)"      
                      + " WHERE ROWNUM <=" + paging.getStartNum() + ""   // 시작번호
                      + " ORDER BY SEQ DESC) "   
                      + " WHERE ROWNUM <=" + paging.getCountPerPage()   // 10개까지
                    + " ORDER BY SEQ DESC ";
            psmt = conn.prepareStatement(sql);         
            System.out.println("2/6 getBbsPagingList Success");      
            
            rs = psmt.executeQuery();
            System.out.println("3/6 getBbsPagingList Success");
            
         while(rs.next()) {
            /*CustomDto dto = new CustomDto(
                  rs.getInt(1),
                  rs.getString(2), 
                  rs.getString(3),
                  rs.getString(4),
                  rs.getString(5),
                  rs.getString(6),
                  rs.getString(7)
                  
                  );*/
            CustomDto dto = new CustomDto();
            dto.setSeq(rs.getInt(1));
            dto.setId(rs.getString(2));
            dto.setTitle(rs.getString(3));
            dto.setContent(rs.getString(4));
            dto.setFileNameBf(rs.getString(5));
            dto.setFileNameAf(rs.getString(6));
            dto.setWdate(rs.getString(7));
            dto.setProgress(rs.getInt(8));
            dto.setName(rs.getString(9));
            list.add(dto);            
            System.out.println(dto.toString());
            System.out.println(dto.getName());
            System.out.println(rs.getInt(1)+
                  rs.getString(2)+ 
                  rs.getString(3)+
                  rs.getString(4)+
                  rs.getString(5)+
                  rs.getString(6)+
                  rs.getString(7)+
                  rs.getInt(8)
                  );
            
         }
         System.out.println("4/6 getBbsPagingList Success");
         
         System.out.println(list.toString());
      } catch (Exception e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, rs);      
      }
            
      return list;
   }
   @Override
   public boolean updateExCustom(CustomDto dto) {
      System.out.println(dto.toString());
      
      String sql = " UPDATE CUSTOM "
      + " SET TITLE=?, CONTENT=?"
      + " WHERE SEQ = ? ";
      System.out.println("Update seq : " + dto.getSeq());
      Connection conn = null;
      PreparedStatement psmt = null;
      
      int count = 0 ;
      
      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 updateExCustom suc");
         
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, dto.getTitle());
         psmt.setString(2, dto.getContent());
      
         psmt.setInt(3, dto.getSeq());
         System.out.println("2/6 updateExCustom suc");
         
         count = psmt.executeUpdate();
         System.out.println("3/6 updateExCustom suc");
         
      } catch (Exception e) {
         System.out.println("updateExCustom fail");
         e.printStackTrace();
      } finally {
         DBClose.close(conn, psmt, null);
      }
      
      return count>0?true:false;
   }
   @Override
   public boolean insertCustomRelpy(ReplyDto dto,int auth) {

      String sql = " INSERT INTO REPLY "
            + " (SEQ, ID, CONTENT, TNAME, WDATE, DEL,PSEQ,REF, STEP, DEPTH ) "
            + " VALUES(SEQ_REPLY.NEXTVAL, ?, ?,  "
            + " 'CUSTOM',SYSDATE,0,?,0,0,0) ";

      int count = 0;

      Connection conn = null;
      PreparedStatement psmt = null;

      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 insertCustomRelpy success");

         psmt = conn.prepareStatement(sql);
         System.out.println("2/6 insertCustomRelpy success");
         psmt.setString(1, dto.getId());
         psmt.setString(2, dto.getContent());
         psmt.setInt(3, dto.getPseq());
         

         count = psmt.executeUpdate();
         System.out.println("3/6 insertCustomRelpy success");
      
         psmt.close();
            
            String sql1 = " UPDATE CUSTOM "
                     +" SET PROGRESS = ? "
                     +" WHERE SEQ = ? ";
            psmt = conn.prepareStatement(sql1);
            if(auth == 0) {
               psmt.setInt(1, 0);
            }else if(auth == 1) {
               psmt.setInt(1, 1);
            }
            psmt.setInt(2, dto.getPseq());
            System.out.println(" 1/2 Update custom Answerchk succ");
            psmt.executeQuery();
            System.out.println(" 2/2 Update custom Answerchk succ");
      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("insertCustomRelpy fail");
      }finally {
         DBClose.close(conn, psmt, null);         
      }

      return count>0?true:false;
   }
   @Override
   public List<ReplyDto> replyDetail(int pseq) {
      
            
            Connection conn = null;
            PreparedStatement psmt = null;
            ResultSet rs = null;
            
            List<ReplyDto> list = new ArrayList<>();
            
            try {   
               conn = DBConnection.getConnection();
               System.out.println("1/6 getReplyList Success");
               /*
               //게시글이 총 몇개인지 검색
               String totalSql = " SELECT COUNT(R.SEQ) "
                     + " FROM REPLY R, MEMBER M, COMBINE C "
                     + " WHERE R.ID = M.ID "
                         + " AND R.PSEQ = C.SEQ "
                         + "   AND R.TNAME = C.TNAME ";
               
                     
               
               System.out.println("total sql : " + totalSql);
               psmt = conn.prepareStatement(totalSql);         
               
               rs = psmt.executeQuery();
               
               //총게시글수
               int totalCount = 0;
               rs.next();
               totalCount = rs.getInt(1);
                paging.setTotalCount(totalCount);
                //startNum 셋팅 
                  paging = PagingUtil.setPagingInfo(paging);
                  System.out.println("totalCount:" + totalCount );
                  
                  psmt.close();
                  rs.close();
                  System.out.println("paging.getStartNum():"+paging.getStartNum());
                  System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
                  */
               
                  String sql = " SELECT * FROM "
                          + "         (SELECT * FROM "
                                 // 검색된 값을 불러옴
                          + "            (SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.PSEQ, R.REF, R.STEP, R.DEPTH,R.DEL, M.NAME  "
                          + "            FROM  CUSTOM C,REPLY R, MEMBER M  "
                          + "            WHERE R.PSEQ = C.SEQ "
                          + "            AND R.TNAME = C.TNAME "
                          + "            AND R.ID = M.ID "   
                          + "            AND R.PSEQ = ?"
                          + "            ORDER BY R.SEQ ASC)"      
//                          + "          WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
                          + "          WHERE ROWNUM <=" + 10 + " "   // 시작번호
                          + "          ORDER BY SEQ ASC) "   
//                          + "    WHERE ROWNUM <=" + paging.getCountPerPage()   // 10개까지
                          + "    WHERE ROWNUM <=" + 10   // 10개까지
                          + "    ORDER BY SEQ ASC ";
                  
                  System.out.println(sql);
                  psmt = conn.prepareStatement(sql);
                  System.out.println("2/6 getReplyList Success");      
                  psmt.setInt(1, pseq);
                  
                  rs = psmt.executeQuery();
                  System.out.println("3/6 getReplyList Success");
                  System.out.println("rs.size() : " + rs.getFetchSize());
                  
                  while(rs.next()) {
                     int i = 1;
                  ReplyDto dto = new ReplyDto();
                  
                  dto.setSeq(rs.getInt(i++));
                  dto.setId(rs.getString(i++));
                  dto.setContent(rs.getString(i++));
                  dto.setTname(rs.getString(i++));
                  dto.setWdate(rs.getString(i++));
                  dto.setPseq(rs.getInt(i++));
                  dto.setRef(rs.getInt(i++));
                  dto.setStep(rs.getInt(i++));
                  dto.setDepth(rs.getInt(i++));
                  dto.setDel(rs.getInt(i++));
                  dto.setName(rs.getString(i++));
                  int row_cnt = rs.getRow();
                  list.add(dto);
               }
               System.out.println("4/6 getReplyList Success");
            } catch (Exception e) {
               System.out.println("4/6 getReplyList fail");
               e.printStackTrace();
            } finally {
               DBClose.close(conn, psmt, rs);      
            }
            
            
            return list;
            
         
   }
   @Override
   public boolean replyDelte(int seq,int pseq) {

      
      String sql = " UPDATE REPLY "
            + " SET DEL = 1 "
            + " WHERE SEQ = ? AND PSEQ =?";

      int count = 0;

      Connection conn = null;
      PreparedStatement psmt = null;



      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 replyDelte success");

         psmt = conn.prepareStatement(sql);
         System.out.println("2/6 replyDelte success");
         psmt.setInt(1, seq);
         psmt.setInt(2, pseq);
         
         System.out.println("3/6 replyDelte success");
         count = psmt.executeUpdate();
         System.out.println("4/6 replyDelte success");

      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("replyDelte fail");
      }finally {
         DBClose.close(conn, psmt, null);         
      }



      return count>0?true:false;
   }
   @Override
   public boolean deleteCustom(int seq) {
      
      String sql1 = " DELETE FROM CUSTOM "
            + " WHERE SEQ = ? ";
      
      int count = 0;

      Connection conn = null;
      PreparedStatement psmt = null;



      try {
         conn = DBConnection.getConnection();
         System.out.println("1/6 deleteCustom success");

         psmt = conn.prepareStatement(sql1);
         psmt.setInt(1, seq);
         System.out.println("2/6 deleteCustom success");
      
      
         
         System.out.println("3/6 deleteCustom success");
         count = psmt.executeUpdate();
         System.out.println("4/6 deleteCustom success");

      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("deleteCustom fail");
      }finally {
         DBClose.close(conn, psmt, null);         
      }



      return count>0?true:false;
   }
   
   
}