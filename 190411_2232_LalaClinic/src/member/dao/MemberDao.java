package member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import combine.dto.CombineDto;
import custom.dto.CustomDto;
import db.DBClose;
import db.DBConnection;
import member.dto.MemberDto;
import paging.PagingBean;
import paging.PagingUtil;
import review.dto.ReviewDto;
import util.UtilClass;

public class MemberDao implements iMemberDao {
	
	private static MemberDao memberDao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnect();
	}
	
	public static MemberDao getInstance() {
		return memberDao;
	}

	//로그인체크
	@Override
	public MemberDto loginCheck(String id, String pwd) {
		
		String sql = " SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
				+ " FROM MEMBER "
				+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mdto = null;
		
		System.out.println("0/6 logincheck suc");
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 logincheck suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/6 logincheck suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 logincheck suc");
			
			if(rs.next()) {
				mdto = new MemberDto(
						rs.getString("ID"),//id,
						rs.getString("PWD"),//pwd,
						rs.getString("NAME"),//name, 
						rs.getString("GENDER"),//gender,
						rs.getString("EMAIL"),//email, 
						rs.getString("PHONE"),//phone, 
						rs.getString("BIRTH"),//birth,
						rs.getString("ADDRESS"),//address, 
						rs.getInt("AUTH"));//,auth);
			}
			
		} catch (Exception e) {
			System.out.println("logincheck fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return mdto;
	}

	//id중복체크
	@Override
	public boolean idSameCheck(String id) {
		
		String sql = " SELECT ID FROM MEMBER "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 idsamecheck suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 idsamecheck suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 idsamecheck suc");
			
			if(rs.next()) {
				count = 1;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count>0? true:false;
	}

	//회원가입
	@Override
	public boolean insertMember(MemberDto dto) {
		
		String sql = " INSERT INTO MEMBER "
				+ " (ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH) "
				+ " VALUES(?,?,?,?,?,?,?,?,?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 insertmember suc");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 insertMember suc");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getGender());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getPhone());
			psmt.setString(7, dto.getBirth());
			psmt.setString(8, dto.getAddress());
			psmt.setInt(9, dto.getAuth());
			
			count = psmt.executeUpdate();
			System.out.println("3/6 insertMember suc");
			
		} catch (Exception e) {
			System.out.println("insertMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//관리자 전체목록
	@Override
	public List<MemberDto> adminAllPrint(PagingBean paging, String choice, String findWord) {
		String str = "";
		if( !(findWord==null || findWord.equals("")) ) { 
			str = " AND " + choice + " LIKE '%" + findWord.trim() + "%'";
		}	
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 adminAllPrint suc");
			
			String totalSql = " SELECT COUNT(ID) "
					+ " FROM MEMBER "
					+ " WHERE AUTH=1 " + str;
			
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 adminAllPrint suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 adminAllPrint suc");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //실행결과의 총 글갯수를 받는듯
			
		    paging.setTotalCount(totalCount); //pagingbean에 총 글갯수 세팅
            paging = PagingUtil.setPagingInfo(paging); //하단 페이지링크가 몇개 생길지 계산
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ "			(SELECT * FROM "
					+ " 			(SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
					+ " 			FROM MEMBER "
					+ " 			WHERE AUTH=1 " + str
					+ " 			ORDER BY ID ASC) "
					+ " 		WHERE ROWNUM <=" + paging.getStartNum() + " "
					+ " 		ORDER BY ID DESC) "
					+ " 	WHERE ROWNUM <=" + paging.getCountPerPage();
	        System.out.println("adminAllPrint() sql: " + sql);
			
			psmt = conn.prepareStatement(sql);
			System.out.println("4/6 adminAllPrint suc");
			
			rs = psmt.executeQuery();
			System.out.println("5/6 adminAllPrint suc");
			
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setId(rs.getString("ID"));
				dto.setPwd("PWD");
				dto.setName(rs.getString("NAME"));
				dto.setGender(rs.getString("GENDER"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setBirth(rs.getString("BIRTH"));
				dto.setAddress(rs.getString("ADDRESS"));
				dto.setAuth(rs.getInt("AUTH"));
				
				list.add(dto);
			}
			System.out.println("6/6 adminAllPrint suc");
		} catch (Exception e) {
			System.out.println("adminAllPrint fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//관리자 디테일
	@Override
	public MemberDto adminDetail(String id) {
		String sql = " SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
				+ " FROM MEMBER "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 adminDetail suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 adminDetail suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 adminDetail suc");
			
			if(rs.next()) {
				dto = new MemberDto();
				dto.setId(rs.getString("ID"));
				dto.setPwd(rs.getString("PWD"));
				dto.setName(rs.getString("NAME"));
				dto.setGender(rs.getString("GENDER"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setBirth(rs.getString("BIRTH"));
				dto.setAddress(rs.getString("ADDRESS"));
				dto.setAuth(rs.getInt("AUTH"));
			}
			
		} catch (Exception e) {
			System.out.println("adminDetail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}

	//관리자 수정
	@Override
	public boolean adminUpdate(MemberDto dto) {
		String sql = " UPDATE MEMBER SET PWD=?,NAME=?,GENDER=?,EMAIL=?,PHONE=?,BIRTH=?,ADDRESS=? "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 adminupdate suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getPwd());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getGender());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getBirth());
			psmt.setString(7, dto.getAddress());
			psmt.setString(8, dto.getId());
			System.out.println("2/6 adminupdate suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 adminupdate suc");
			
		} catch (Exception e) {
			System.out.println("adminupdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//회원디테일
	@Override
	public MemberDto myDetail(String id) {
		String sql = " SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
				+ " FROM MEMBER "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 myDetail suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 myDetail suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 myDetail suc");
			
			if(rs.next()) {
				dto = new MemberDto();
				dto.setId(rs.getString("ID"));
				dto.setPwd(rs.getString("PWD"));
				dto.setName(rs.getString("NAME"));
				dto.setGender(rs.getString("GENDER"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setBirth(rs.getString("BIRTH"));
				dto.setAddress(rs.getString("ADDRESS"));
				dto.setAuth(rs.getInt("AUTH"));
			}
			
		} catch (Exception e) {
			System.out.println("myDetail fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}

	//회원 수정
	@Override
	public boolean myUpdate(MemberDto dto) {
		String sql = " UPDATE MEMBER SET PWD=?,NAME=?,GENDER=?,EMAIL=?,PHONE=?,BIRTH=?,ADDRESS=? "
				+ " WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 myupdate suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getPwd());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getGender());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getBirth());
			psmt.setString(7, dto.getAddress());
			psmt.setString(8, dto.getId());
			System.out.println("2/6 myupdate suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 myupdate suc");
			
		} catch (Exception e) {
			System.out.println("myupdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0? true:false;
	}

	//내가쓴글 - 상담및예약 목록
	@Override
	public List<CombineDto> myCombineList(String id, PagingBean paging, String sWord, String sOption) {
		String str = "";
		if( !(sWord==null || sWord.equals("")) ) { 
			str = " AND " + sOption + " LIKE '%" + sWord.trim() + "%'";
		}

		Connection conn = null;
		PreparedStatement psmt= null;
		ResultSet rs = null;
		
		List<CombineDto> list = new ArrayList<>();
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("1/6 myCombineList suc");
			
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM COMBINE "
					+ " WHERE ID= '" + id + "' "
					+ str;
			System.out.println("++++++++++++++++++++" + totalSql);
			
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 myCombineList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 myCustomList Success");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //실행결과의 총 글갯수를 받는듯
			System.out.println("////////////////////" + totalCount);
		    paging.setTotalCount(totalCount); //pagingbean에 총 글갯수 세팅
            paging = PagingUtil.setPagingInfo(paging); //하단 페이지링크가 몇개 생길지 계산
            
            psmt.close();
            rs.close();
            
            String sql =  " SELECT * FROM "
                    + " 		(SELECT * FROM "
    				+ " 			(SELECT C.SEQ, C.ID, C.INQUIRE, C.MEDICAL, "
    				+ "				C.RDATE, C.TITLE, C.CONTENT, C.FILENAMEBF, C.FILENAMEAF, C.PROGRESS, C.WDATE, "
    				+ " 			C.TNAME, "
    				+ "				M.NAME, M.BIRTH, M.GENDER, M.EMAIL, M.PHONE, M.ADDRESS "
    				+ " 			FROM COMBINE C, MEMBER M "
    				+ " 			WHERE C.ID = M.ID AND C.ID= '" + id + "' " + str
    				+ " 			ORDER BY C.SEQ ASC) "
    				+ "			WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
                    + " 		ORDER BY SEQ DESC) "   
                    + " 	WHERE ROWNUM <=" + paging.getCountPerPage();   // 10개까지
            System.out.println("combine sql: " + sql);
            
            psmt = conn.prepareStatement(sql);
            System.out.println("4/6 myCustomList Success");
			
			rs =  psmt.executeQuery();
			System.out.println("5/6 myCombineList suc");
			
			while(rs.next()) {
				CombineDto dto = new CombineDto();
				
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setInquire(rs.getString("INQUIRE"));
				dto.setMedical(rs.getString("MEDICAL"));
				dto.setRdate(rs.getString("RDATE"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setFileNameBf(rs.getString("FILENAMEBF"));
				dto.setFileNameAf(rs.getString("FILENAMEAF"));
				dto.setProgress(rs.getInt("PROGRESS"));
				dto.setWdate(rs.getString("WDATE"));
				dto.setTname(rs.getString("TNAME"));
				dto.setName(rs.getString("NAME"));
				dto.setBirth(rs.getString("BIRTH"));
				dto.setGender(rs.getString("GENDER"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setAddress(rs.getString("ADDRESS"));
				
				list.add(dto);
			}
			System.out.println("6/6 myCombineList suc");
			
		} catch (Exception e) {
			System.out.println("myCombineList fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//내가쓴글 - 시술후기 목록
	@Override
	public List<ReviewDto> myReviewList(String id, PagingBean paging, String sWord, String sOption) {
		String str = "";
		if( !(sWord==null || sWord.equals("")) ) { 
			str = " AND " + sOption + " LIKE '%" + sWord.trim() + "%'";
		}

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReviewDto> list = new ArrayList<>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getReviewList Suc");
			
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM REVIEW "
					+ " WHERE ID= '" + id + "' "
					+ str;

			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 getReviewList Suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getReviewList Suc");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //실행결과의 총 글갯수를 받는듯
		    paging.setTotalCount(totalCount); //pagingbean에 총 글갯수 세팅
            paging = PagingUtil.setPagingInfo(paging); //하단 페이지링크가 몇개 생길지 계산
            
            psmt.close();
            rs.close();
            
            String sql =  " SELECT * FROM "
                    + " 		(SELECT * FROM "
                    + " 			(SELECT R.SEQ, R.ID, R.TITLE, R.CONTENT, R.FILENAMEBF, R.FILENAMEAF, R.MANAGEMENT, "
    				+ " 			R.READCOUNT, R.WDATE, R.TNAME, "
    				+ " 			M.NAME " 
    				+ " 			FROM REVIEW R, MEMBER M " 
    				+ " 			WHERE R.ID = M.ID AND R.ID= '" + id + "' " + str
    				+ " 			ORDER BY SEQ ASC) "
    				+ "			WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
    	            + " 		ORDER BY SEQ DESC) "   
    	            + " 	WHERE ROWNUM <=" + paging.getCountPerPage();   // 10개까지
            System.out.println("sql: " + sql);
            
            psmt = conn.prepareStatement(sql);
            System.out.println("4/6 getReviewList Suc");
            
            rs = psmt.executeQuery();
            System.out.println("5/6 getReviewList Suc");
            
			while(rs.next()) {
				ReviewDto dto = new ReviewDto();
						dto.setSeq(rs.getInt("SEQ"));			// seq,
						dto.setId(rs.getString("ID"));			// id,
						dto.setTitle(rs.getString("TITLE"));		// title,
						dto.setContent(rs.getString("CONTENT"));	// content,
						dto.setFileNameBf(rs.getString("FILENAMEBF"));	// fileName,
						dto.setFileNameAf(rs.getString("FILENAMEAF"));	// fileName,
						dto.setManagement(rs.getString("MANAGEMENT"));	// management,
						dto.setReadcount(rs.getInt("READCOUNT"));		// readcount,
						dto.setWdate(rs.getString("WDATE"));		// wdate,
						dto.setTname(rs.getString("TNAME"));		// tname,
						dto.setName(rs.getString("NAME"));		// name
				list.add(dto);
			}
			System.out.println("6/6 getReviewList Suc");
		} catch (Exception e) {
			System.out.println("getReviewList Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return list;
	}

	//내가쓴글 - 고객소리함 목록
	@Override
	public List<CustomDto> myCustomList(String id, PagingBean paging, String sWord, String sOption) {

		String str = "";
		String str2 = "";
		if( !(sWord==null || sWord.equals("")) ) { 
			str = " AND " + sOption + " LIKE '%" + sWord.trim() + "%'";
			str2 = " AND " + sOption + " LIKE '%" + sWord.trim() + "%'";
		}
			
		/*String sql = " SELECT * FROM "
				+ " (SELECT * FROM "
				+ "		(SELECT * FROM CUSTOM "
				+ "		ORDER BY REF ASC, STEP DESC) "		
				+ " WHERE ROWNUM <=" + paging.getStartNum() + ""	// 시작번호
				+ " ORDER BY REF DESC, STEP ASC) "	
				+ " WHERE ROWNUM <=" + paging.getCountPerPage();	// 10개까지
		 */			
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CustomDto> list = new ArrayList<>();
		
		try {	
			conn = DBConnection.getConnection();
			System.out.println("1/6 myCustomList Success");
			
			String totalSql = " SELECT COUNT(SEQ) "
					+ " FROM CUSTOM "
					+ " WHERE ID= '" + id + "' "
					+ str;
			System.out.println("totalSql: " + totalSql);
			
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 myCustomList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 myCustomList Success");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //실행결과의 총 글갯수를 받는듯
		    paging.setTotalCount(totalCount); //pagingbean에 총 글갯수 세팅
            paging = PagingUtil.setPagingInfo(paging); //하단 페이지링크가 몇개 생길지 계산
            System.out.println("totalCount:" + totalCount );
            
            psmt.close();
            rs.close();
            System.out.println("paging.getStartNum():"+paging.getStartNum());
            System.out.println("paging.getCountPerPage():" + paging.getCountPerPage());
            /*
            SELECT * FROM (
            	    SELECT ROWNUM, AA.* 
            	    FROM (
            	        SELECT C.SEQ SEQ,
            	                C.ID ID,
            	                C.TITLE TITLE,
            	                C.CONTENT CONTENT,
            	                C.FILENAME FILENAME,
            	                C.WDATE WDATE,
            	                C.TNAME TNAME,
            	                C.REF REF,
            	                C.STEP STEP,
            	                C.DEPTH DEPTH,
            	                M.NAME NAME,
            	                M.PWD PWD,
            	                M.BIRTH BIRTH,
            	                M.GENDER GENDER,
            	                M.EMAIL EMAIL,
            	                M.PHONE PHONE,
            	                M.ADDRESS ADDRESS,
            	                M.AUTH AUTH 
            	        FROM CUSTOM C, MEMBER M 
            	        WHERE C.ID = M.ID 
            	        ORDER BY SEQ ASC) AA
            	    WHERE ROWNUM <=36 
            	    ORDER BY SEQ DESC, STEP ASC)  
            	WHERE ROWNUM <=10;
            */
            String sql =  " SELECT * FROM "
                    + " 		(SELECT * FROM "
                    + "      		(SELECT C.SEQ SEQ," + 
                    "            	                C.ID ID," + 
                    "            	                C.TITLE TITLE," + 
                    "            	                C.CONTENT CONTENT," + 
                    "            	                C.FILENAMEAF FILENAMEAF," +
                    "            	                C.FILENAMEBF FILENAMEBF," +
                    "            	                C.WDATE WDATE," + 
                    "            	                C.TNAME TNAME," +
                    "	 							C.PROGRESS PROGRESS, " 	+ 
                    "            	                M.NAME NAME," + 
                    "            	                M.PWD PWD," + 
                    "            	                M.BIRTH BIRTH," + 
                    "            	                M.GENDER GENDER," + 
                    "            	                M.EMAIL EMAIL," + 
                    "            	                M.PHONE PHONE," + 
                    "            	                M.ADDRESS ADDRESS," + 
                    "            	                M.AUTH AUTH "
                    + " 			FROM CUSTOM C, MEMBER M "  //+ str
                    + " 			WHERE C.ID = M.ID AND C.ID= '" + id + "' " + str2
                    + "      		ORDER BY SEQ ASC) "
                    + "			 WHERE ROWNUM <=" + paging.getStartNum() + " "   // 시작번호
                    + " 		ORDER BY SEQ DESC) "   
                    + " WHERE ROWNUM <=" + paging.getCountPerPage();   // 10개까지
            System.out.println("sql: " + sql);

            psmt = conn.prepareStatement(sql);         
            System.out.println("4/6 myCustomList Success");      
            
            rs = psmt.executeQuery();
            System.out.println("5/6 myCustomList Success");
            
			while(rs.next()) {
				CustomDto dto = new CustomDto(
						rs.getInt("SEQ"), 
						rs.getString("ID"), 
						rs.getString("TITLE"), 
						rs.getString("CONTENT"), 
						rs.getString("FILENAMEBF"), 
						rs.getString("FILENAMEAF"), 
						rs.getString("WDATE"), 
						rs.getString("TNAME"),
						rs.getInt("PROGRESS"));
				dto.setName(rs.getString("NAME"));
				list.add(dto);				
			}
			System.out.println("6/6 myCustomList Success");
			
		} catch (Exception e) {
			System.out.println("myCustomList Success");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);		
		}
				
		return list;
	}
	
	//회원 전체목록
	@Override
	public List<MemberDto> memberAllPrint(PagingBean paging, String choice, String findWord) {
		String str = "";
		if( !(findWord==null || findWord.equals("")) ) { 
			str = " AND " + choice + " LIKE '%" + findWord.trim() + "%'";
		}	
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<MemberDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 memberAllPrint suc");
			
			String totalSql = " SELECT COUNT(ID) "
					+ " FROM MEMBER "
					+ " WHERE AUTH=0 " + str;
			
			psmt = conn.prepareStatement(totalSql);
			System.out.println("2/6 memberAllPrint suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 memberAllPrint suc");
			
			int totalCount = 0;
			rs.next();
			totalCount = rs.getInt(1); //실행결과의 총 글갯수를 받는듯
			
		    paging.setTotalCount(totalCount); //pagingbean에 총 글갯수 세팅
            paging = PagingUtil.setPagingInfo(paging); //하단 페이지링크가 몇개 생길지 계산
			
			psmt.close();
			rs.close();
			
			String sql = " SELECT * FROM "
					+ "			(SELECT * FROM "
					+ " 			(SELECT ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH "
					+ " 			FROM MEMBER "
					+ " 			WHERE AUTH=0 " + str
					+ "				AND LENGTH(ID) < 21 "			
					+ " 			ORDER BY ID ASC) "
					+ " 		WHERE ROWNUM <=" + paging.getStartNum() + " "
					+ " 		ORDER BY ID DESC) "
					+ " 	WHERE ROWNUM <=" + paging.getCountPerPage();
	        System.out.println("adminAllPrint() sql: " + sql);
			
			psmt = conn.prepareStatement(sql);
			System.out.println("4/6 memberAllPrint suc");
			
			rs = psmt.executeQuery();
			System.out.println("5/6 memberAllPrint suc");
			
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setId(rs.getString("ID"));
				dto.setPwd("PWD");
				dto.setName(rs.getString("NAME"));
				dto.setGender(rs.getString("GENDER"));
				dto.setEmail(rs.getString("EMAIL"));
				dto.setPhone(rs.getString("PHONE"));
				dto.setBirth(rs.getString("BIRTH"));
				dto.setAddress(rs.getString("ADDRESS"));
				dto.setAuth(rs.getInt("AUTH"));
				
				list.add(dto);
			}
			System.out.println("6/6 memberAllPrint suc");
		} catch (Exception e) {
			System.out.println("memberAllPrint fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	@Override
	public boolean myDelAllReply(String id) {
		String sql = " UPDATE SET REPLY "
				+ " DEL=1 WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 myDelAllReply suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/6 myDelAllReply suc");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 myDelAllReply suc");
			
			conn.commit();
		} catch (Exception e) {
			System.out.println("myDelAllReply fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {
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
		}
		
		return count>0? true:false;
	}

	//회원탈퇴
	@Override
	public boolean myDelete(String id) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		boolean isS = true;
		int count = 0;
		String cName = UtilClass.makeTrash();
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1 myDelete suc");
			
			//1. 가라멤버 입력
			String sqlInsert = " INSERT INTO MEMBER "
					+ " (ID,PWD,NAME,GENDER,EMAIL,PHONE,BIRTH,ADDRESS,AUTH) "
					+ " VALUES(?,'1111', 'trashUser', '남성', 'trashUser@trash.com', '000-0000-0000', '20000101', '[000-000] 탈퇴시 탈퇴동 탈퇴빌라 탈퇴호', 0) ";
			psmt = conn.prepareStatement(sqlInsert);
			psmt.setString(1, cName);
			psmt.executeUpdate();		
			psmt.clearBatch();
			psmt.close();
			System.out.println("1 myDelete suc");
			
			//2. 기존id의 댓글 모조리 del=1 작업 + id변경
			String sqlReplyDel = " UPDATE REPLY SET "
					+ " DEL=1, ID='"+cName+"' WHERE ID='"+id+"' ";
			psmt = conn.prepareStatement(sqlReplyDel);
			psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("2 myDelete suc");

			//3. 각종 게시판 글댓글들 삭제
			//3-1. 상담및예약 게시판 글댓글들 삭제
			String sqlDelReply = 
					" UPDATE REPLY "
					+ " SET DEL=1 "
					+ " WHERE SEQ IN ( "
					+ " 	SELECT SEQ " 
					+ " 	FROM REPLY "
					+ " 	WHERE PSEQ IN (SELECT SEQ FROM COMBINE WHERE ID='"+id+"')) ";
			psmt = conn.prepareStatement(sqlDelReply);
			count = psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("3-1 myDelete suc");

			//3-2. 고객소리함 게시판 글댓글들 삭제
			sqlDelReply = 
					" UPDATE REPLY "
					+ " SET DEL=1 "
					+ " WHERE SEQ IN ( "
					+ " 	SELECT SEQ " 
					+ " 	FROM REPLY "
					+ " 	WHERE PSEQ IN (SELECT SEQ FROM CUSTOM WHERE ID='"+id+"')) ";
			psmt = conn.prepareStatement(sqlDelReply);
			count = psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("3-2 myDelete suc");

			//3-3. 시술후기 게시판 글댓글들 삭제
			sqlDelReply = 
					" UPDATE REPLY "
					+ " SET DEL=1 "
					+ " WHERE SEQ IN ( "
					+ " 	SELECT SEQ " 
					+ " 	FROM REPLY "
					+ " 	WHERE PSEQ IN (SELECT SEQ FROM REVIEW WHERE ID='"+id+"')) ";
			psmt = conn.prepareStatement(sqlDelReply);
			psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("3-3 myDelete suc");

			
			//4. 본문글 댓글들 삭제했으니, 이제 본문글들 삭제
			//4-1. 상담게시판 글 삭제
			String sqlDel = " DELETE FROM COMBINE WHERE ID='"+id+"' ";
			psmt = conn.prepareStatement(sqlDel);
			psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("4-1 myDelete suc");

			//4-2. 상담게시판 글 삭제
			sqlDel = " DELETE FROM CUSTOM WHERE ID='"+id+"' ";
			psmt = conn.prepareStatement(sqlDel);
			psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("4-2 myDelete suc");

			//4-3. 상담게시판 글 삭제
			sqlDel = " DELETE FROM REVIEW WHERE ID='"+id+"' ";
			psmt = conn.prepareStatement(sqlDel);
			count = psmt.executeUpdate();
			psmt.clearBatch();
			psmt.close();
			System.out.println("4-3 myDelete suc");
			
			//5. 회원정보 삭제
			String sql2 = " DELETE FROM MEMBER WHERE ID='"+id+"' ";
			psmt = conn.prepareStatement(sql2);
			count = psmt.executeUpdate();
			System.out.println("5 myDelete suc");

			//6. commit
			conn.commit();
			System.out.println("6 myDelete suc");
			
		} catch (Exception e) {
			try {
				conn.rollback();
				isS = false;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
		}
		
		return isS;
	}
}






















