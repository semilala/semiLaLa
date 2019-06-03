package calendar.dao;

import java.util.List;

import combine.dto.CombineDto;

public interface iCalendarDao {
	public List<CombineDto> getCalendarList(String id, String yyyyMM);
	public List<CombineDto> getDayList(String id, String yyyyMMDD);
	
	public List<CombineDto> getCalendarListAll(String yyyyMM); //관리자용 예약 전체 모든리스트
	public List<CombineDto> getDayList(String yyyyMMDD); //관리자용 해당일 모든리스트
}
