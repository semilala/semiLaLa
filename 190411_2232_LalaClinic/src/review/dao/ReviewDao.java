package review.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import paging.PagingBean;
import paging.PagingUtil;
import review.dto.ReviewDto;

public class ReviewDao implements iReviewDao {
	private static ReviewDao reviewdao = new ReviewDao();

	public ReviewDao() {
		DBConnection.initConnect();
	}

	public static ReviewDao getInstance() {
		return reviewdao;
	}

	// 리뷰 게시판 목록 리스트(검색)
	@Override
	public List<ReviewDto> allPrint(String choice, String searchWord) {
		String sql = " SELECT R.SEQ, R.ID, R.TITLE, R.CONTENT, R.FILENAMEBF, R.FILENAMEAF, R.MANAGEMENT, R.READCOUNT, R.WDATE, R.TNAME, M.NAME " + 
				" FROM REVIEW R, MEMBER M " + 
				" WHERE R.ID = M.ID ";

		String sqlWord = "";
		if(searchWord.equals("") || searchWord == null) {

		}else {
			if(choice.equals("title")) {
				sqlWord = " AND TITLE LIKE '%" + searchWord.trim() + "%' ";
			}else if(choice.equals("writer")) {
				sqlWord = " AND ID='" + searchWord.trim() + "' ";
			}else if (choice.equals("content")) {
				sqlWord = " AND CONTENT LIKE '%" + searchWord.trim() + "%' ";
			}
		}

		sql += sqlWord;		

		sql += " ORDER BY SEQ DESC ";

		System.out.println("sql : " + sql);

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReviewDto> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();	// 디비 연결
			System.out.println("1/6 getReviewList Suc");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getReviewList Suc");

			rs = psmt.executeQuery();
			System.out.println("3/6 getReviewList Suc");
			while(rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setSeq(rs.getInt("SEQ"));			// seq,
				dto.setId(rs.getString("ID"));			// id,
				dto.setTitle(rs.getString("TITLE"));		// title,
				dto.setContent(rs.getString("CONTENT"));	// content,
				dto.setFileNameBf(rs.getString("FILENAMEBF"));	// FILENAMEBF,
				dto.setFileNameAf(rs.getString("FILENAMEAF"));	// FILENAMEAF,
				dto.setManagement(rs.getString("MANAGEMENT"));	// management,
				dto.setReadcount(rs.getInt("READCOUNT"));		// readcount,
				dto.setWdate(rs.getString("WDATE"));		// wdate,
				dto.setTname(rs.getString("TNAME"));		// tname,
				dto.setName(rs.getString("NAME"));		// name
				//System.out.println(dto.toString());
				list.add(dto);
			}
			System.out.println("3/6 getReviewList Suc");
		} catch (Exception e) {
			System.out.println("getReviewList Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return list;
	}

	// 리뷰 게시판 페이징 + 검색
	@Override
	public List<ReviewDto> getReviewPagingList(PagingBean paging, String searchWord, String choice) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReviewDto> list = new ArrayList<>();
		String sqlWord = "";

		if(searchWord.equals("") || searchWord == null) {

		}else {
			if(choice.equals("title")) {
				sqlWord = " TITLE LIKE '%" + searchWord.trim() + "%' ";
			}else if(choice.equals("writer")) {
				sqlWord = " M.NAME='" + searchWord.trim() + "' ";
			}else if (choice.equals("content")) {
				sqlWord = " CONTENT LIKE '%" + searchWord.trim() + "%' ";
			}else if (choice.equals("management")) {
				sqlWord = " MANAGEMENT LIKE '%" + searchWord.trim() + "%' ";
			}
		}

		try {	
			conn = DBConnection.getConnection();
			System.out.println("1/6 getBbsPagingList Success");

			//게시글이 총 몇개인지 검색
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM REVIEW R, MEMBER M"
					+ " WHERE R.ID = M.ID ";
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
			// 시작넘버부터 ~ 10개의 레코드를 가져옴
			String sql =  " SELECT * "
					// 시작넘버 부터 모든 레코드를 가져옴
					+ " FROM (SELECT * "
					// 검색된 값을 불러옴					
					+ " 		FROM (SELECT SEQ, R.ID, TITLE, CONTENT, FILENAMEBF, FILENAMEAF, MANAGEMENT, READCOUNT, WDATE, TNAME, "
					+ " 			M.NAME FROM REVIEW R, MEMBER M "
					+ " 	 		WHERE R.ID = M.ID ";	

			if(sqlWord != "" && sqlWord !=null) {
				sql += " AND " + sqlWord;
			}
			
			sql   += " ORDER BY SEQ ASC) "      
					+ " WHERE ROWNUM <=" + paging.getStartNum() + ""   // 시작번호
					+ " ORDER BY SEQ DESC) "   
					+ " WHERE ROWNUM <=" + paging.getCountPerPage()   // 10개까지
					+ " ORDER BY SEQ DESC ";

			System.out.println(sql);
			psmt = conn.prepareStatement(sql);         
			System.out.println("2/6 getBbsPagingList Success");      

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsPagingList Success");

			while(rs.next()) {
				ReviewDto dto = new ReviewDto();
				
				dto.setSeq(rs.getInt("SEQ"));			// seq,
				dto.setId(rs.getString("ID"));			// id,
				dto.setTitle(rs.getString("TITLE"));		// title,
				dto.setContent(rs.getString("CONTENT"));	// content,
				dto.setFileNameBf(rs.getString("FILENAMEBF"));	// FILENAMEBF,
				dto.setFileNameAf(rs.getString("FILENAMEAF"));	// FILENAMEAF,
				dto.setManagement(rs.getString("MANAGEMENT"));	// management,
				dto.setReadcount(rs.getInt("READCOUNT"));		// readcount,
				dto.setWdate(rs.getString("WDATE"));		// wdate,
				dto.setTname(rs.getString("TNAME"));		// tname,
				dto.setName(rs.getString("NAME"));		// name

				list.add(dto);
				System.out.println(rs.getInt("SEQ"));
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

	// 리뷰 게시판 목록 리스트
	@Override
	public List<ReviewDto> getReviewList() {
		String sql = " SELECT R.SEQ, R.ID, R.TITLE, R.CONTENT, R.FILENAMEBF, R.FILENAMEAF, R.MANAGEMENT, R.READCOUNT, R.WDATE, R.TNAME, M.NAME " + 
				" FROM REVIEW R, MEMBER M " + 
				" WHERE R.ID = M.ID " + 
				" ORDER BY SEQ DESC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReviewDto> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();	// 디비 연결
			System.out.println("1/6 getReviewList Suc");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getReviewList Suc");

			rs = psmt.executeQuery();
			System.out.println("3/6 getReviewList Suc");
			while(rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setSeq(rs.getInt("SEQ"));			// seq,
				dto.setId(rs.getString("ID"));			// id,
				dto.setTitle(rs.getString("TITLE"));		// title,
				dto.setContent(rs.getString("CONTENT"));	// content,
				dto.setFileNameBf(rs.getString("FILENAMEBF"));	// FILENAMEBF,
				dto.setFileNameAf(rs.getString("FILENAMEAF"));	// FILENAMEAF,
				dto.setManagement(rs.getString("MANAGEMENT"));	// management,
				dto.setReadcount(rs.getInt("READCOUNT"));		// readcount,
				dto.setWdate(rs.getString("WDATE"));		// wdate,
				dto.setTname(rs.getString("TNAME"));		// tname,
				dto.setName(rs.getString("NAME"));		// name
				//System.out.println(dto.toString());
				list.add(dto);
			}
			System.out.println("3/6 getReviewList Suc");
		} catch (Exception e) {
			System.out.println("getReviewList Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return list;
	}

	// 리뷰 게시판 글쓰기
	@Override
	public boolean insertReview(ReviewDto dto) {
		String sql = " INSERT INTO REVIEW "
				+ " (SEQ, ID, TITLE, CONTENT, FILENAMEBF, FILENAMEAF, MANAGEMENT, READCOUNT, WDATE, TNAME) "
				+ " VALUES(SEQ_REVIEW.NEXTVAL, ?, ?, ?, ?, ?, ?, 0, SYSDATE, 'review') ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertReview Suc");

			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFileNameBf());
			psmt.setString(5, dto.getFileNameAf());
			psmt.setString(6, dto.getManagement());
			System.out.println("2/6 insertReview Suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 insertReview Suc");

		} catch (Exception e) {
			System.out.println("insertReview Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	// 리뷰 수정
	// 첨부파일을 삭제하거나 변경할시 여기로 들어옴
	@Override
	public boolean updateReview(ReviewDto dto) {
		String sql = " UPDATE REVIEW "
				+ " SET TITLE=?, CONTENT=?, FILENAMEBF=?, FILENAMEAF=?, MANAGEMENT=? "
				+ " WHERE SEQ= ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateReview Suc");

			System.out.println("seq : " + dto.getSeq());
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getFileNameBf());
			psmt.setString(4, dto.getFileNameAf());
			psmt.setString(5, dto.getManagement());
			psmt.setInt(6, dto.getSeq());
			System.out.println("2/6 updateReview Suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 updateReview Suc");

		} catch (Exception e) {
			System.out.println("updateReview Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}

		System.out.println("count : " + count);
		return count > 0 ? true : false;
	}

	// 리뷰 수정
	//첨부파일을 수정시 유지하면 여기로 들어옴
	@Override
	public boolean updateExReview(ReviewDto dto) {
		String sql = " UPDATE REVIEW "
				+ " SET TITLE=?, CONTENT=?, MANAGEMENT=? "
				+ " WHERE SEQ= ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateExReview Suc");

			System.out.println("seq : " + dto.getSeq());
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getManagement());
			psmt.setInt(4, dto.getSeq());
			System.out.println("2/6 updateExReview Suc");

			count = psmt.executeUpdate();
			System.out.println("3/6 updateExReview Suc");

		} catch (Exception e) {
			System.out.println("updateExReview Fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}

		System.out.println("count : " + count);
		return count > 0 ? true : false;
	}

	// 리뷰 디테일
	@Override
	public ReviewDto getReivew(int seq) {
		String sql = " SELECT R.SEQ, R.ID, R.TITLE, R.CONTENT, R.FILENAMEBF, R.FILENAMEAF, R.MANAGEMENT, R.READCOUNT, R.WDATE, R.TNAME, M.NAME"
				+ " FROM REVIEW R, MEMBER M "
				+ " WHERE R.ID = M.ID AND SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ReviewDto rdto = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReivew Suc");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getReivew Suc");

			rs = psmt.executeQuery();
			System.out.println("3/6 getReivew Suc");
			// SEQ, ID, TITLE, CONTENT, FILENAME, MANAGEMENT, READCOUNT, WDATE, TNAME, REF, STEP, DEPTH
			if(rs.next()) {
				rdto = new ReviewDto();
				rdto.setSeq(rs.getInt("SEQ"));				// seq,
				rdto.setId(rs.getString("ID"));				// id,
				rdto.setTitle(rs.getString("TITLE"));		// title,
				rdto.setContent(rs.getString("CONTENT"));	// content,
				rdto.setFileNameBf(rs.getString("FILENAMEBF"));	// FILENAMEBF,
				rdto.setFileNameAf(rs.getString("FILENAMEAF"));	// FILENAMEAF,
				rdto.setManagement(rs.getString("MANAGEMENT"));	// management,
				rdto.setReadcount(rs.getInt("READCOUNT"));		// readcount,
				rdto.setWdate(rs.getString("WDATE"));		// wdate,
				rdto.setTname(rs.getString("TNAME"));		// tname,
				rdto.setName(rs.getString("NAME"));		// name
			}
			System.out.println("4/6 getReivew Suc");

		} catch (Exception e) {
			System.out.println("getReivew Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}				
		return rdto;
	}

	// 리뷰 삭제
	@Override
	public boolean deleteReview(int seq) {
		String sql = " DELETE FROM REVIEW "
				+ "	WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 deleteReview Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 deleteReview Success");

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			System.out.println("3/6 deleteReview Success");


		} catch (Exception e) {
			System.out.println("deleteReview Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ;
	}


	// 조회수 증가
	@Override
	public void updateReadcount(int seq) {
		String sql = " UPDATE REVIEW "
				+ " SET READCOUNT = READCOUNT + 1 "
				+ " WHERE SEQ = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 updateReadcount Success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 updateReadcount Success");

			psmt.executeUpdate();	// 실행
			System.out.println("3/6 updateReadcount Success");


		} catch (Exception e) {
			System.out.println("updateReadcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}	
	}

}












