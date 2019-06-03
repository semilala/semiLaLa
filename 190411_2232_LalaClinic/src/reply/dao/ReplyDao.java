package reply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import reply.dto.ReplyDto;

public class ReplyDao implements iReplyDao{
	
	private static ReplyDao replydao = new ReplyDao();

	public ReplyDao() {		
		DBConnection.initConnect();
	}

	public static ReplyDao getInstance() {
		return replydao;
	}
	
	// 게시판 리뷰 등록
	@Override
	public boolean insertReply(int pseq, ReplyDto dto) {
		String sql = " INSERT INTO REPLY "
				+ " (SEQ, ID, CONTENT, TNAME, WDATE, DEL, PSEQ, REF, STEP, DEPTH) "
				+ " VALUES(SEQ_REPLY.NEXTVAL, ?, ?, ?, SYSDATE, 0, ?, "
				+ " (SELECT NVL(MAX(REF), 0)+1 FROM REPLY), 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertReply Suc");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getTname());
			psmt.setInt(4, pseq);
			System.out.println("2/6 insertReply Suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 insertReply Suc");

		} catch (Exception e) {
			System.out.println("insertReply Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	// 댓글 가져오기(리스트)
	@Override
	public List<ReplyDto> getReplyList(int pseq, String tname) {
		String sql = " SELECT R.SEQ, R.ID, R.CONTENT, R.TNAME, R.WDATE, R.DEL, R.PSEQ, R.REF, R.STEP, R.DEPTH, M.NAME "
				+ " FROM REPLY R, MEMBER M "
				+ " WHERE R.ID = M.ID AND PSEQ = ? AND TNAME = ? "
				+ " ORDER BY REF ASC, STEP ASC ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		System.out.println(sql);
		List<ReplyDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReplyList suc");
			
			psmt= conn.prepareStatement(sql);
			psmt.setInt(1, pseq);
			psmt.setString(2, tname);
			System.out.println("2/6 getReplyList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getReplyList suc");
		
			while(rs.next()) {
				ReplyDto dto = new ReplyDto();	// 생성자
				dto.setSeq(rs.getInt("SEQ"));			// seq,
				dto.setId(rs.getString("ID"));			// id,
				dto.setContent(rs.getString("CONTENT"));	// content,
				dto.setTname(rs.getString("TNAME"));		// tname,
				dto.setWdate(rs.getString("WDATE"));		// wdate,
				dto.setDel(rs.getInt("DEL"));
				dto.setPseq(rs.getInt("pseq"));				// pseq
				dto.setRef(rs.getInt("ref"));				// ref
				dto.setStep(rs.getInt("step"));				// step
				dto.setDepth(rs.getInt("depth"));				// depth
				dto.setName(rs.getString("NAME"));		// name
				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("getReplyList Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}		
		return list;
	}
	
	// 답글 작성
	@Override
	public boolean replyAnswer(int seq, ReplyDto dto) {
		// update 
				String sql1 = " UPDATE REPLY "
						+ " SET STEP = STEP + 1 "
						+ " WHERE REF = (SELECT REF FROM REPLY WHERE SEQ=? ) "
						+ "     AND STEP > (SELECT STEP FROM REPLY WHERE SEQ =? ) ";
				
				// insert
				String sql2 = " INSERT INTO REPLY "
						+ " (SEQ, ID, CONTENT, TNAME, WDATE, DEL, PSEQ, REF, STEP, DEPTH) "
						+ " VALUES(SEQ_REPLY.NEXTVAL, ?, ?, ?, SYSDATE, 0, ?, "
						+ "     (SELECT REF FROM REPLY WHERE SEQ=? ), "	// REF
						+ "     (SELECT STEP FROM REPLY WHERE SEQ=?) + 1, "	// STEP
						+ "     (SELECT DEPTH FROM REPLY WHERE SEQ=?) + 1) ";  // DEPTH
						
				
				Connection conn = null;
				PreparedStatement psmt = null;
				
				int count = 0;
				
				try {
					
					conn = DBConnection.getConnection();
					conn.setAutoCommit(false);
					System.out.println("1/6 replyAnswer Success");
					// ------------------ update ----------------
					psmt = conn.prepareStatement(sql1);
					psmt.setInt(1, seq);
					psmt.setInt(2, seq);
					System.out.println("2/6 replyAnswer Success");
					
					count = psmt.executeUpdate();
					System.out.println("3/6 replyAnswer Success");
					
					// psmt를 초기화 해줌
					psmt.clearParameters();
					//--------------------------------------------
					
					//------------------ insert -----------------------
					psmt = conn.prepareStatement(sql2);
					
					psmt.setString(1, dto.getId());	//id
					psmt.setString(2, dto.getContent());	// content
					psmt.setString(3, dto.getTname());		// tname
					psmt.setInt(4, dto.getPseq());			// pseq
					psmt.setInt(5, seq);			// ref
					psmt.setInt(6, seq);			// step
					psmt.setInt(7, seq);			// depth
					System.out.println("4/6 replyAnswer Success");
					
					count = psmt.executeUpdate();
					conn.commit();
					System.out.println("5/6 replyAnswer Success");		
					
				} catch (Exception e) {
					System.out.println("replyAnswer fail");			
					try {	// 롤백
						conn.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					
					e.printStackTrace();
				} finally {
					
					try {
						conn.setAutoCommit(true);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					DBClose.close(conn, psmt, null);
					System.out.println("6/6 replyAnswer Success");
				}
				
				return count > 0 ? true : false;
	}

	// 리플 삭제
	@Override
	public boolean deleteReply(int seq) {
		String sql = " UPDATE REPLY "
				+ " SET DEL = 1 "
				+ "	WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteReply Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 deleteReply Success");
			
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			System.out.println("3/6 deleteReply Success");
			
			
		} catch (Exception e) {
			System.out.println("deleteReply Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ;
	}

	
	
	
	
}
