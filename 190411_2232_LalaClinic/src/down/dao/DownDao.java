package down.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import down.dto.DownDto;
import paging.PagingBean;
import paging.PagingUtil;
import util.ReplyDto;
import util.UtilClass;

public class DownDao implements iDownDao {

	private static DownDao dao = new DownDao();
	
	private DownDao() {
		DBConnection.initConnect();
	}	
	
	public static DownDao getInstance() {
		return dao;
	}
	
	//자료게시판 - 전체출력(+검색)
	@Override
	public List<DownDto> getDownPagingList(PagingBean paging, String choice, String findWord) {
		
		String str = "";
		String str2 = "";
		if( !(findWord==null || findWord.equals("")) ) {
			str = " AND " + choice + " LIKE '%" + findWord.trim() + "%' ";
			str2 = " WHERE " + choice + " LIKE '%" + findWord.trim() + "%' ";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<DownDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getDownPagingList suc");
			
			String totalSql = " SELECT COUNT(SEQ) FROM DOWN " + str2;
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 getDownPagingList suc");
			
			rs = psmt.executeQuery();
			rs.next();
			int totalCount = 0;
			totalCount = rs.getInt(1);
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPagingInfo(paging);
			System.out.println("3/6 getDownPagingList suc");
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ " 		(SELECT * FROM "
					+ "				(SELECT SEQ,D.ID,TITLE,CONTENT,FILENAMEBF,FILENAMEAF,READCOUNT,WDATE,TNAME, M.NAME "
					+ " 			FROM DOWN D, MEMBER M "
					+ " 			WHERE D.ID = M.ID " + str
					+ " 			ORDER BY SEQ ASC) "
					+ " 		WHERE ROWNUM <=" + paging.getStartNum() + " "
					+ " 		ORDER BY SEQ DESC) "
					+ " 	WHERE ROWNUM <=" + paging.getCountPerPage();
			System.out.println("downlist sql: " + sql);
			
			psmt = conn.prepareStatement(sql);
			System.out.println("4/6 getDownPagingList suc");
			
			rs = psmt.executeQuery();
			System.out.println("5/6 getDownPagingList suc");
			
			while(rs.next()) {
				DownDto dto = new DownDto();
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setFileNameBf(rs.getString("FILENAMEBF"));
				dto.setFileNameAf(rs.getString("FILENAMEAF"));
				dto.setReadCount(rs.getInt("READCOUNT"));
				dto.setWdate(rs.getString("WDATE"));
				dto.setTname(rs.getString("TNAME"));
				dto.setName(rs.getString("NAME"));
				
				System.out.println(dto.toString());
				list.add(dto);
			}
			System.out.println("6/6 getDownPagingList suc");
		} catch (Exception e) {
			System.out.println("getDownPagingList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//자료게시판 - 글입력
	@Override
	public boolean insertDown(DownDto dto) {
		
		String sql = " INSERT INTO DOWN "
				+ " (SEQ,ID,TITLE,CONTENT,FILENAMEBF,FILENAMEAF,READCOUNT,WDATE,TNAME) "
				+ " VALUES(SEQ_DOWN.NEXTVAL,?,?,?,?,?,0,SYSDATE,'DOWN') ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertDown suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFileNameBf());
			psmt.setString(5, dto.getFileNameAf());
			System.out.println("2/6 insertDown suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertDown suc");
		} catch (Exception e) {
			System.out.println("insertDown fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//자료게시판 - 글디테일
	@Override
	public DownDto detailDown(int seq) {
		String sqlCountUp = " UPDATE DOWN SET READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		String sql = " SELECT SEQ,D.ID,TITLE,CONTENT,FILENAMEBF,FILENAMEAF,READCOUNT,WDATE,TNAME,M.NAME " 
				+ " FROM DOWN D, MEMBER M " 
				+ " WHERE D.ID = M.ID "
				+ " AND SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		DownDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 detailDown suc");
			
			psmt = conn.prepareStatement(sqlCountUp);
			psmt.setInt(1, seq);
			psmt.executeQuery();
			System.out.println("3/6 detailDown suc");
			
			psmt.clearBatch();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("4/6 detailDown suc");
			
			rs = psmt.executeQuery();
			System.out.println("5/6 detailDown suc");
			
			if(rs.next()) {
				dto = new DownDto();
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setFileNameBf(rs.getString("FILENAMEBF"));
				dto.setFileNameAf(rs.getString("FILENAMEAF"));
				dto.setReadCount(rs.getInt("READCOUNT"));
				dto.setWdate(rs.getString("WDATE"));
				dto.setTname(rs.getString("TNAME"));
				dto.setName(rs.getString("NAME"));
			}
			System.out.println("6/6 detailDown suc");
		} catch (Exception e) {
			System.out.println("detailDown fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}

	//자료게시판 - 업데이트(파일수정x)
	@Override
	public boolean updateExDown(DownDto dto) {
		String sql = " UPDATE DOWN "
				+ " SET ID=?, TITLE=?, CONTENT=?, WDATE=SYSDATE "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateExDown suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setInt(4, dto.getSeq());
			System.out.println("2/6 updateExDown suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateExDown suc");
		} catch (Exception e) {
			System.out.println("updateExDown fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//자료게시판 - 업데이트(파일수정o)
	@Override
	public boolean updateUpDown(DownDto dto) {
		String sql = " UPDATE DOWN "
				+ " SET ID=?, TITLE=?, CONTENT=?, WDATE=SYSDATE, FILENAMEBF=?, FILENAMEAF=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateUpDown suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFileNameBf());
			psmt.setString(5, dto.getFileNameAf());
			psmt.setInt(6, dto.getSeq());
			System.out.println("2/6 updateUpDown suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 updateUpDown suc");
		} catch (Exception e) {
			System.out.println("updateUpDown fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//자료게시판 - 댓글목록
	@Override
	public List<ReplyDto> getReplyList(int seq, PagingBean paging) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReplyDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList Success");
			
			String totalSql = " SELECT COUNT(R.SEQ) "
					+ " FROM DOWN D, REPLY R, MEMBER M "
					+ " WHERE D.TNAME = R.TNAME "
					+ " AND D.SEQ = R.PSEQ "
					+ " AND R.ID = M.ID "
					+ " AND R.PSEQ=" + seq;
			System.out.println("total sql : " + totalSql);
			
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 getReplyList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getReplyList Success");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1);
			paging.setTotalCount(totalCount);
			paging = PagingUtil.setPagingInfo(paging);
			psmt.close();
			rs.close();
			
			System.out.println("//////////startNum: " + paging.getStartNum());
			System.out.println("//////////countPerPage: " + paging.getCountPerPage());
			
			String sql = " SELECT * FROM "
					+ " 		(SELECT * FROM "
					+ " 			(SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.PSEQ, R.REF, R.STEP, R.DEPTH, R.DEL, M.NAME "
					+ " 			FROM DOWN D, REPLY R, MEMBER M "
					+ " 			WHERE D.SEQ = R.PSEQ "
					+ " 			AND D.TNAME = R.TNAME "
					+ " 			AND R.ID = M.ID "
					+ " 			AND R.PSEQ = " + seq + " "
					+ " 			ORDER BY REF DESC, STEP DESC) "
					+ " 		WHERE ROWNUM <=" + paging.getStartNum() + " "
					+ " 		ORDER BY REF ASC, STEP ASC) "
					+ " 	WHERE ROWNUM <=" + paging.getCountPerPage()
					+ " 	ORDER BY REF ASC, STEP ASC ";
			System.out.println(sql);
			
			psmt = conn.prepareStatement(sql);
			System.out.println("4/6 getReplyList Success");
			
			rs = psmt.executeQuery();
			System.out.println("5/6 getReplyList Success");
			
			while(rs.next()) {
				ReplyDto dto = new ReplyDto();
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setTname(rs.getString("TNAME"));
				dto.setWdate(rs.getString("WDATE"));
				dto.setPseq(rs.getInt("PSEQ"));
				dto.setRef(rs.getInt("REF"));
				dto.setStep(rs.getInt("STEP"));
				dto.setDepth(rs.getInt("DEPTH"));
				dto.setDel(rs.getInt("DEL"));
				dto.setName(rs.getString("NAME"));
				
				list.add(dto);
			}
			System.out.println("6/6 getReplyList Success");
		} catch (Exception e) {
			System.out.println("getReplyList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//자료게시판 - 댓글입력
	@Override
	public boolean insertDownReply(ReplyDto dto, int seq, int auth) {
		
		String sql = " INSERT INTO REPLY "
				+ " (SEQ,ID,CONTENT,TNAME,WDATE, "
				+ " PSEQ,REF,STEP,DEPTH,DEL) "
				+ " VALUES(SEQ_REPLY.NEXTVAL,?,?,'DOWN',SYSDATE, "
				+ " ?,SEQ_REPLY.CURRVAL,0,0,0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertDownReply success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getPseq());
			System.out.println("2/6 insertDownReply success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertDownReply success");
			
		} catch (Exception e) {
			System.out.println("insertDownReply fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//본문글 삭제
	@Override
	public boolean deleteDown(int seq, String tname) {
		String sql = " DELETE FROM DOWN "
				+ " WHERE SEQ=" + seq;
		String sqlreply = " UPDATE REPLY "
				+ " SET DEL=1 "
				+ " WHERE PSEQ=" + seq + " AND TNAME='" + tname + "' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println(" 1 deleteDownReply succ");
			
			psmt = conn.prepareStatement(sqlreply);
			System.out.println(" 2 deleteDownReply succ");
			
			psmt.executeQuery();
			psmt.close();
			
			psmt = conn.prepareStatement(sql);
			System.out.println(" 3 deleteDownReply succ");
			
			count = psmt.executeUpdate();
			System.out.println(" 4 deleteDownReply succ");
			
			
		} catch (Exception e) {
			System.out.println(" deleteDownReply fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//자료게시판 - 댓글 개별삭제
	@Override
	public boolean deleteDownReply(int seq) {
		
		String sqlreply = " UPDATE REPLY "
				+ " SET DEL=1 "
				+ " WHERE SEQ=" + seq;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println(" 1 deleteDownReply succ");
			
			psmt = conn.prepareStatement(sqlreply);
			System.out.println(" 2 deleteDownReply succ");
			
			count = psmt.executeUpdate();
			System.out.println(" 2 deleteDownReply succ");
			
		} catch (Exception e) {
			System.out.println(" deleteDownReply fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	@Override
	public boolean insertDownAddReply(ReplyDto dto, int seq) {
		System.out.println("pseq: " + dto.getPseq());
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		String sql = "";
		String sql1 = "";
		if(dto.getDepth()>0) {
			sql1 = " UPDATE REPLY SET STEP=STEP+1 WHERE TNAME='DOWN' AND PSEQ=? AND REF=? AND STEP>? AND DEPTH=? ";
			sql = " INSERT INTO REPLY "
					+ " (SEQ,ID,CONTENT,TNAME,WDATE, "
					+ " PSEQ,REF,STEP,DEPTH,DEL) "
					+ " VALUES(SEQ_REPLY.NEXTVAL,?,?,'DOWN',SYSDATE, "
					+ " ?,?, "
					+ " (SELECT NVL(MAX(STEP),0)+1 FROM REPLY WHERE TNAME='DOWN' AND PSEQ=? AND REF=? AND DEPTH>? ), " //step
					+ "?,0) ";
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 insertDownAddReply success");
				
				psmt = conn.prepareStatement(sql1);
				psmt.setInt(1, dto.getPseq());
				psmt.setInt(2, dto.getRef());
				psmt.setInt(3, dto.getStep());
				psmt.setInt(4, dto.getDepth());
				psmt.executeQuery();
				psmt.clearBatch();
				psmt.close();
				
				System.out.println("5: " + dto.getPseq());
				System.out.println("6: " + dto.getRef());
				System.out.println("7: " + dto.getStep());
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getContent());
				psmt.setInt(3, dto.getPseq());
				psmt.setInt(4, dto.getRef());
				psmt.setInt(5, dto.getPseq());
				psmt.setInt(6, dto.getRef());
				psmt.setInt(7, dto.getDepth());
				psmt.setInt(8, dto.getDepth()+1);
				System.out.println("2/6 insertDownAddReply success");
				
				count = psmt.executeUpdate();
				System.out.println("3/6 insertDownAddReply success");
				
			} catch (Exception e) {
				System.out.println("insertDownAddReply fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);
			}
		}
		else if(dto.getDepth()==0) {
			sql1 = " UPDATE REPLY SET STEP=STEP+1 WHERE TNAME='DOWN' AND PSEQ=? AND REF=? AND STEP>? ";
			sql = " INSERT INTO REPLY "
					+ " (SEQ,ID,CONTENT,TNAME,WDATE, "
					+ " PSEQ,REF,STEP,DEPTH,DEL) "
					+ " VALUES(SEQ_REPLY.NEXTVAL,?,?,'DOWN',SYSDATE, "
					+ " ?,?, "
					+ " (SELECT MAX(STEP)+1 FROM REPLY WHERE TNAME='DOWN' AND PSEQ=? AND REF=? ), " //step
					+ "?,0) ";
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/6 insertDownAddReply success");
				
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getContent());
				psmt.setInt(3, dto.getPseq());
				psmt.setInt(4, dto.getRef());
				psmt.setInt(5, dto.getPseq());
				psmt.setInt(6, dto.getRef());
				psmt.setInt(7, dto.getDepth()+1);
				System.out.println("2/6 insertDownAddReply success");
				
				count = psmt.executeUpdate();
				System.out.println("3/6 insertDownAddReply success");
				
			} catch (Exception e) {
				System.out.println("insertDownAddReply fail");
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, null);
			}
		}
		
		return count>0? true:false;
	}
}





















