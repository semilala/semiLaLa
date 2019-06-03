package combine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import combine.dto.CombineDto;
import db.DBClose;
import db.DBConnection;
import member.dto.MemberDto;
import paging.PagingBean;
import paging.PagingUtil;
import util.ReplyDto;

public class CombineDao implements iCombineDao {

	private static CombineDao comDao = new CombineDao();

	public CombineDao() {
		DBConnection.initConnect();
	}
	public static CombineDao getInstance() {
		return comDao;
	}

	@Override
	public boolean intsertCombine(CombineDto dto) {
		// TODO Auto-generated catch block
		String sql = " INSERT INTO COMBINE (SEQ, ID, INQUIRE, MEDICAL, "
				+" RDATE, TITLE, CONTENT, FILENAMEBF,FILENAMEAF, PROGRESS, WDATE, TNAME) "
				+" VALUES(SEQ_COMBINE.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?,"
				+" SYSDATE, 'COMBINE') ";

		Connection conn = null;
		PreparedStatement psmt= null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertCombine() suc");

			psmt= conn.prepareStatement(sql);

			int i = 1;
			psmt.setString(i++, dto.getId());
			psmt.setString(i++, dto.getInquire());
			psmt.setString(i++, dto.getMedical());
			psmt.setString(i++,dto.getRdate());
			psmt.setString(i++, dto.getTitle());
			psmt.setString(i++, dto.getContent());
			psmt.setString(i++, dto.getFileNameBf());
			psmt.setString(i++, dto.getFileNameAf());
			psmt.setInt(i++,dto.getProgress());
			System.out.println("2/6 insertCombine() suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 insertCombine() suc");

		} catch (Exception e) {
			System.out.println("insertCombine() fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}



	@Override
	public boolean updateCombine(CombineDto dto) {
		// TODO Auto-generated catch block
		// 첨부파일을 삭제하거나 변경할시 여기로 들어옴
		String sql  = " UPDATE COMBINE "
				+" SET INQUIRE = ? , MEDICAL = ? , RDATE = ? , TITLE = ? , "
				+" CONTENT = ? , FILENAMEBF = ? , FILENAMEAF = ? "
				+" WHERE SEQ = ? ";

		System.out.println("Update seq : " + dto.getSeq());
		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0 ;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateCombine suc");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getInquire());
			psmt.setString(2, dto.getMedical());
			psmt.setString(3, dto.getRdate());
			psmt.setString(4, dto.getTitle());
			psmt.setString(5, dto.getContent());
			psmt.setString(6, dto.getFileNameBf());
			psmt.setString(7, dto.getFileNameAf());
			psmt.setInt(8, dto.getSeq());
			System.out.println("2/6 updateCombine suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 updateCombine suc");

		} catch (Exception e) {
			System.out.println("updateCombine fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}

	@Override
	public boolean deleteCombine(int seq) {
		// TODO Auto-generated catch block
		String sql = " DELETE COMBINE "
				+" WHERE SEQ = ? ";
		String sql1 = " UPDATE REPLY "
				+ " SET DEL = 1 "
				+ " WHERE TNAME = 'COMBINE' "
				+ " AND PSEQ = ? "; //PSEQ 가 SEQ


		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0 ;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 deleteCombine suc");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 deleteCombine suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 deleteCombine suc");

			psmt.close();

			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			System.out.println("2/6 UpDdeleteCombine suc");

			psmt.executeUpdate();
			System.out.println("3/6 UpDdeleteCombine suc");
			System.out.println("여기서 내가 가져온 seq 는 무엇 ? " + seq);

			conn.commit();
		} catch (Exception e) {
			System.out.println("deleteCombine fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return count>0?true:false;

	}


	@Override
	public CombineDto detailCombine(int seq) {
		// TODO Auto-generated catch block
		String sql = " SELECT SEQ, C.ID, INQUIRE, MEDICAL,  " + 
				" RDATE, TITLE, CONTENT, FILENAMEBF, FILENAMEAF, PROGRESS, WDATE, TNAME,"
				+ " M.NAME, M.PHONE, M.EMAIL, M.GENDER "
				+ " FROM COMBINE C, MEMBER M"
				+ " WHERE C.ID = M.ID "
				+ " AND SEQ = ? ";
		Connection conn = null;
		PreparedStatement psmt= null;
		ResultSet rs = null;

		CombineDto dto = new CombineDto();

		try {

			conn = DBConnection.getConnection();
			System.out.println("1/6 detailCombine suc");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 detailCombine suc");

			rs = psmt.executeQuery();
			System.out.println("3/6 detailCombine suc");
			if(rs.next()) {
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setInquire(rs.getString(3));
				dto.setMedical(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setTitle(rs.getString(6));
				dto.setContent(rs.getString(7));
				dto.setFileNameBf(rs.getString(8));
				dto.setFileNameAf(rs.getString(9));
				dto.setProgress(rs.getInt(10));
				dto.setWdate(rs.getString(11));
				dto.setTname(rs.getString(12));
				dto.setName(rs.getString(13));
				dto.setPhone(rs.getString(14));
				dto.setEmail(rs.getString(15));
				dto.setGender(rs.getString(16));
			}
			System.out.println("4/6 detailCombine suc");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;
	}
	@Override
	public boolean updateExCombine(CombineDto dto) {
		// TODO Auto-generated catch block
		//첨부파일을 수정시 유지하면 여기로 들어옴

		String sql = " UPDATE COMBINE "
				+" SET INQUIRE=?, MEDICAL=?, RDATE=?, TITLE=?, "
				+" CONTENT=?"
				+" WHERE SEQ=? ";
		System.out.println("Update seq : " + dto.getSeq());
		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0 ;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateCombine suc");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getInquire());
			psmt.setString(2, dto.getMedical());
			psmt.setString(3, dto.getRdate());
			psmt.setString(4, dto.getTitle());
			psmt.setString(5, dto.getContent());
			psmt.setInt(6, dto.getSeq());
			System.out.println("2/6 updateCombine suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 updateCombine suc");

		} catch (Exception e) {
			System.out.println("updateCombine fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}

	public List<CombineDto> getCustomPagingList(PagingBean paging, String searchWord, String choice) {
		// TODO Auto-generated catch block
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<CombineDto> list = new ArrayList<>();
		String sqlWord = "";

		if(searchWord.equals("") || searchWord == null) {

		}else {
			if(choice.equals("title")) {
				sqlWord = " TITLE LIKE '%" + searchWord.trim() + "%' ";
			}else if(choice.equals("writer")) {
				sqlWord = " M.NAME LIKE '%" + searchWord.trim() + "%' ";
			}else if (choice.equals("content")) {
				sqlWord = " CONTENT LIKE '%" + searchWord.trim() + "%' ";
			}
		}

		try {	
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsPagingList Success");

			//게시글이 총 몇개인지 검색
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM COMBINE C, MEMBER M"
					+ " WHERE C.ID = M.ID ";
			if(sqlWord != "" && sqlWord !=null) {
				totalSql += " AND " + sqlWord;
			}

			System.out.println("sqlWord: " + sqlWord);
			System.out.println("choice : " + choice);
			System.out.println("searchWord : " + searchWord);
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
			/*
            		// 시작넘버부터 ~ 10개의 레코드를 가져옴
            String sql =  "SELECT SEQ, C.ID, INQUIRE, MEDICAL, "
            		+ " RDATE, TITLE, CONTENT, FILENAMEBF, FILENAMEAF, PROGRESS, WDATE, "
            		+ "TNAME, M.NAME"
            		// 시작넘버 부터 모든 레코드를 가져옴
                    + " FROM (SELECT SEQ, C.ID, INQUIRE, MEDICAL,  RDATE, TITLE, CONTENT, "
                    + " 	 FILENAMEBF, FILENAMEAF, PROGRESS, WDATE, TNAME, M.NAME FROM "
            					// 검색된 값을 불러옴
                    + "      (SELECT SEQ, C.ID, INQUIRE, MEDICAL,  RDATE, TITLE, CONTENT,"
                    + "		 FILENAMEBF, FILENAMEAF, PROGRESS, WDATE, TNAME, M.NAME FROM COMBINE C, MEMBER M"
                    + " 	 WHERE C.ID = M.ID ";	
		            if(sqlWord != "" && sqlWord !=null) {
		            	sql += " AND " + sqlWord;
		            }
		      sql   += "      ORDER BY SEQ ASC) C, MEMBER M"      
                    + " WHERE ROWNUM <=" + paging.getStartNum() + ""   // 시작번호
                    + " ORDER BY SEQ DESC) C, MEMBER M "   
                    + " WHERE C.ID = M.ID AND ROWNUM <=" + paging.getCountPerPage()   // 10개까지
            		+ " ORDER BY SEQ DESC ";
			 */

			String sql = " SELECT * FROM "
					+ "         (SELECT * FROM "
					// 검색된 값을 불러옴
					+ "            (SELECT SEQ, C.ID, INQUIRE, MEDICAL, RDATE, TITLE, CONTENT, FILENAMEBF, FILENAMEAF, PROGRESS, WDATE, TNAME, M.NAME "
					+ "            FROM COMBINE C, MEMBER M "
					+ "           WHERE C.ID = M.ID ";

			if(sqlWord != "" && sqlWord !=null) {
				sql += " AND " + sqlWord;
			}

			sql   += "            ORDER BY SEQ ASC)"      
					+ "       WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
					+ "       ORDER BY SEQ DESC) "   
					+ " WHERE ROWNUM <=" + paging.getCountPerPage()   // 10개까지
					+ " ORDER BY SEQ DESC ";
			System.out.println(sql);
			psmt = conn.prepareStatement(sql);         
			System.out.println("2/6 getBbsPagingList Success");      

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsPagingList Success");

			while(rs.next()) {
				CombineDto dto = new CombineDto();

				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setInquire(rs.getString(3));
				dto.setMedical(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setTitle(rs.getString(6));
				dto.setContent(rs.getString(7));
				dto.setFileNameBf(rs.getString(8));
				dto.setFileNameAf(rs.getString(9));
				dto.setProgress(rs.getInt(10));
				dto.setWdate(rs.getString(11));
				dto.setTname(rs.getString(12));
				dto.setName(rs.getString(13));

				list.add(dto);
			}

			System.out.println("4/6 getBbsPagingList Success");
		} catch (Exception e) {
			System.out.println("4/6 getBbsPagingList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);		
		}
		return list;
	}
	@Override
	public List<ReplyDto> getReplyList(int seq, PagingBean paging) {
		// TODO Auto-generated catch block
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReplyDto> list = new ArrayList<>();

		try {	
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList Success");

			//게시글이 총 몇개인지 검색
			String totalSql = " SELECT COUNT(R.SEQ) "
					+ " FROM REPLY R, MEMBER M, COMBINE C "
					+ " WHERE R.ID = M.ID "
					+ " AND R.PSEQ = C.SEQ "
					+ "	AND R.TNAME = C.TNAME "
					+ " AND R.PSEQ = ? ";



			System.out.println("total sql : " + totalSql);
			psmt = conn.prepareStatement(totalSql);	
			psmt.setInt(1, seq);

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


			String sql = " SELECT * FROM "
					+ "         (SELECT * FROM "
					// 검색된 값을 불러옴
					+ "            (SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE,R.DEL, R.PSEQ, R.REF, R.STEP, R.DEPTH, M.NAME  "
					+ "            FROM  COMBINE C,REPLY R, MEMBER M  "
					+ "            WHERE R.PSEQ = C.SEQ "
					+ "			   AND R.TNAME = C.TNAME "
					+ "			   AND R.ID = M.ID "
					+ "			   AND R.PSEQ = " + seq		  
					+ "            ORDER BY R.REF DESC,STEP DESC)"      
					+ "       	WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
					//                    + "       	WHERE ROWNUM <=" + 10 + " "   // 시작번호
					+ "       	ORDER BY REF ASC,STEP ASC) "   
					+ "    WHERE ROWNUM <=" + paging.getCountPerPage()   // 10개까지
					//                    + "    WHERE ROWNUM <=" + 10   // 10개까지
					+ "    ORDER BY REF ASC,STEP ASC ";
			System.out.println(sql);
			psmt = conn.prepareStatement(sql);
			//            psmt.setInt(1, seq);
			System.out.println("2/6 getReplyList Success");      

			rs = psmt.executeQuery();
			System.out.println("3/6 getReplyList Success");

			while(rs.next()) {
				int i = 1;
				ReplyDto dto = new ReplyDto();

				dto.setSeq(rs.getInt(i++));
				dto.setId(rs.getString(i++));
				dto.setContent(rs.getString(i++));
				dto.setTname(rs.getString(i++));
				dto.setWdate(rs.getString(i++));
				dto.setDel(rs.getInt(i++));
				dto.setPseq(rs.getInt(i++));
				dto.setRef(rs.getInt(i++));
				dto.setStep(rs.getInt(i++));
				dto.setDepth(rs.getInt(i++));
				dto.setName(rs.getString(i++));

				list.add(dto);
			}
			System.out.println("4/6 getReplyList Success");
		} catch (Exception e) {
			System.out.println("getReplyList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);		
		}

		return list;

	}
	public boolean insertCombineReply(ReplyDto dto, int seq, int auth) {
		// TODO Auto-generated catch block
		String sql = " INSERT INTO REPLY "
				+ " (SEQ, ID, CONTENT, TNAME, WDATE, DEL,PSEQ,REF, STEP, DEPTH ) "
				+ " VALUES(SEQ_REPLY.NEXTVAL, ?, ?,  "
				+ " 'COMBINE',SYSDATE,0,?,SEQ_REPLY.CURRVAL,0,0) ";

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

			String sql1 = " UPDATE COMBINE "
					+" SET PROGRESS = ? "
					+" WHERE SEQ = ? ";

			psmt = conn.prepareStatement(sql1);
			if(auth == 0) {
				psmt.setInt(1, 0);
			}else if(auth == 1) {
				psmt.setInt(1, 1);
			}
			psmt.setInt(2, seq);
			System.out.println(" 1/2 Update Combine Answerchk succ");
			psmt.executeQuery();
			System.out.println(" 2/2 Update Combine Answerchk succ");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertCustomRelpy fail");
		}finally {
			DBClose.close(conn, psmt, null);         
		}
		return count>0?true:false;
	}
	@Override
	public boolean insertCombineAddReply(ReplyDto dto, int seq, int auth) {
		// TODO Auto-generated catch block
		String sql1 = " UPDATE COMBINE "
				+" SET PROGRESS = ? "
				+" WHERE SEQ = ? ";
		Connection conn= null;
		PreparedStatement psmt = null;

		int count = 0;


		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 insertCombineAddReply succ");

			psmt = conn.prepareStatement(sql1);
			if(auth == 0) {
				psmt.setInt(1, 0);
			}else if(auth == 1) {
				psmt.setInt(1, 1);
			}
			psmt.setInt(2, seq);
			System.out.println(" 1/2 Update Combine Answerchk succ");
			psmt.executeQuery();
			System.out.println(" 2/2 Update Combine Answerchk succ");
			
			psmt.clearBatch();
			psmt.close();
			
			String sql2 = " INSERT INTO REPLY (SEQ, ID, CONTENT, TNAME, WDATE, DEL,PSEQ,REF, STEP, DEPTH) "
					+" VALUES (SEQ_REPLY.NEXTVAL, ?, ? ,'COMBINE', SYSDATE, 0, ?, ?, "
					+ "(SELECT MAX(STEP)+ 1 FROM REPLY WHERE TNAME = 'COMBINE' AND REF = ? AND PSEQ = ? ) , ?)";

			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getPseq());
			psmt.setInt(4, dto.getRef());
			psmt.setInt(5, dto.getRef());
			psmt.setInt(6, dto.getPseq());
			psmt.setInt(7, dto.getDepth() + 1);
			System.out.println(dto.getDepth() + 1);
			System.out.println("3/6 insertCombineAddReply succ");

			System.out.println(sql2);
			count = psmt.executeUpdate();
			System.out.println("4/6 insertCombineAddReply succ");
			conn.commit();
		} catch (Exception e) {
			System.out.println("insertCombineAddReply fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {

				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {

				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}
	@Override
	public boolean deleteCombineReply(int seq) {
		// TODO Auto-generated catch block
		String sql  = " UPDATE REPLY "
				+ " SET DEL = 1 "
				+ " WHERE SEQ = ? "
				+ " AND TNAME= 'COMBINE'";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0 ;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteCombineReply suc");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 deleteCombineReply suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 deleteCombineReply suc");

		} catch (Exception e) {
			System.out.println("deleteCombineReply fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}

		return count>0?true:false;
	}


}