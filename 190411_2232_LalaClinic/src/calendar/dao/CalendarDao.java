package calendar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import combine.dto.CombineDto;
import db.DBClose;
import db.DBConnection;
import util.UtilClass;

public class CalendarDao implements iCalendarDao {

	private static CalendarDao dao = new CalendarDao();
	
	public CalendarDao() {
		DBConnection.initConnect();
	}
	
	public static CalendarDao getInstance() {
		return dao;
	}

	@Override
	public List<CombineDto> getCalendarList(String id, String yyyyMM) {
		String sql = " SELECT C.SEQ, C.ID, C.INQUIRE, C.MEDICAL, "
				+ " C.RDATE, C.TITLE, C.CONTENT, C.FILENAMEBF, C.FILENAMEAF, C.PROGRESS, C.WDATE, "
				+ " C.TNAME, "
				+ " M.NAME, M.BIRTH, M.GENDER, M.EMAIL, M.PHONE, M.ADDRESS "
				+ " FROM COMBINE C, MEMBER M "
				+ " WHERE C.ID = M.ID "
				+ " AND C.ID=? AND INQUIRE='예약' AND SUBSTR(RDATE,1,6)=? "
				+ " ORDER BY RDATE ASC ";
		
		/*
		SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE,1,8) ORDER BY RDATE ASC) RN,
SEQ,ID,TITLE,CONTENT,RDATE,WDATE
FROM COMBINE
WHERE ID='ojh' AND SUBSTR(RDATE,1,6)='201903' AND INQUIRE='예약'
		 */
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CombineDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getcalendarlist suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM);
			System.out.println("2/6 getcalendarlist suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getcalendarlist suc");
			
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
			System.out.println("4/6 getcalendarlist suc");
			
		} catch (Exception e) {
			System.out.println("getcalendarlist fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//일별일정
	@Override
	public List<CombineDto> getDayList(String id, String yyyyMMDD) {
		String sql = " SELECT C.SEQ, C.ID, C.INQUIRE, C.MEDICAL, "
				+ " C.RDATE, C.TITLE, C.CONTENT, C.FILENAMEBF, C.FILENAMEAF, C.PROGRESS, C.WDATE, "
				+ " C.TNAME, "
				+ " M.NAME, M.BIRTH, M.GENDER, M.EMAIL, M.PHONE, M.ADDRESS "
				+ " FROM COMBINE C, MEMBER M "
				+ " WHERE C.ID = M.ID "
				+ " AND C.ID=? AND INQUIRE='예약' AND SUBSTR(RDATE,1,8)=? "
				+ " ORDER BY RDATE ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CombineDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getcalendarlist suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMMDD);
			System.out.println("2/6 getcalendarlist suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getcalendarlist suc");
			
			while(rs.next()) {
				CombineDto dto = new CombineDto();
				
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setInquire(rs.getString("INQUIRE"));
				dto.setMedical(rs.getString("MEDICAL"));
				//dto.setRdate(rs.getString("RDATE"));
				dto.setRdate(UtilClass.getRdateString(rs.getString("RDATE")));
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
			System.out.println("4/6 getcalendarlist suc");
			
		} catch (Exception e) {
			System.out.println("getcalendarlist fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//관리자용 예약 모든리스트
	@Override
	public List<CombineDto> getCalendarListAll(String yyyyMM) {
		String sql = " SELECT C.SEQ, C.ID, C.INQUIRE, C.MEDICAL, "
				+ " C.RDATE, C.TITLE, C.CONTENT, C.FILENAMEBF, C.FILENAMEAF, C.PROGRESS, C.WDATE, C.TNAME, "
				+ " M.NAME, M.BIRTH, M.GENDER, M.EMAIL, M.PHONE, M.ADDRESS "
				+ " FROM COMBINE C, MEMBER M "
				+ " WHERE C.ID = M.ID "
				+ " AND C.INQUIRE='예약' AND SUBSTR(RDATE,1,6)=? "
				+ " ORDER BY RDATE ASC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CombineDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getcalendarlistAll suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, yyyyMM);
			System.out.println("2/6 getcalendarlistAll suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getcalendarlistAll suc");
			
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
				
				System.out.println("찍어봅시다: " + dto.toString());
				list.add(dto);
			}
			System.out.println("4/6 getcalendarlistAll suc");
			
		} catch (Exception e) {
			System.out.println("getcalendarlistAll fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}

	//관리자용 - 해당일 전체리스트
	@Override
	public List<CombineDto> getDayList(String yyyyMMDD) {
		String sql = " SELECT C.SEQ, C.ID, C.INQUIRE, C.MEDICAL, "
				+ " C.RDATE, C.TITLE, C.CONTENT, C.FILENAMEBF, C.FILENAMEAF, C.PROGRESS, C.WDATE, "
				+ " C.TNAME, "
				+ " M.NAME, M.BIRTH, M.GENDER, M.EMAIL, M.PHONE, M.ADDRESS "
				+ " FROM COMBINE C, MEMBER M "
				+ " WHERE C.ID = M.ID "
				+ " AND INQUIRE='예약' AND SUBSTR(RDATE,1,8)=? "
				+ " ORDER BY RDATE ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CombineDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getDayList suc");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, yyyyMMDD);
			System.out.println("2/6 getDayList suc");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getDayList suc");
			
			while(rs.next()) {
				CombineDto dto = new CombineDto();
				
				dto.setSeq(rs.getInt("SEQ"));
				dto.setId(rs.getString("ID"));
				dto.setInquire(rs.getString("INQUIRE"));
				dto.setMedical(rs.getString("MEDICAL"));
				dto.setRdate(UtilClass.getRdateString(rs.getString("RDATE")));
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
			System.out.println("4/6 getDayList suc");
			
		} catch (Exception e) {
			System.out.println("getDayList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}	
}
