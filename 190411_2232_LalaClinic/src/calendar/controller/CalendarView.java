package calendar.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import calendar.dao.CalendarDao;
import calendar.dao.iCalendarDao;
import combine.dto.CombineDto;
import member.dto.MemberDto;
import util.UtilClass;


@WebServlet(urlPatterns="/CalendarView")
public class CalendarView extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CalendarView doget");
		
		Calendar cal = Calendar.getInstance(); //현재시간세팅
		cal.set(Calendar.DATE, 1); //1일로 설정
		
		String syear = req.getParameter("year");
		String smonth = req.getParameter("month");
		
		int year = cal.get(Calendar.YEAR); //현재연도
		if(UtilClass.nvl(syear)==false) {
			year = Integer.parseInt(syear);
		}
		int month = cal.get(Calendar.MONTH)+1; //0~11
		if(UtilClass.nvl(smonth)==false) {
			month = Integer.parseInt(smonth);
		}
		
		if(month<1) {
			month = 12;
			year--;
		}
		if(month>12) {
			month = 1;
			year++;
		}
		
		cal.set(year, month-1, 1); //년월일 세팅
		
		//요일
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		System.out.println("dayofweek: " + dayOfWeek);
		
		HttpSession session = req.getSession(false);
		//MemberDto mdto = (MemberDto)session.getAttribute("login");
		String id = ((MemberDto)session.getAttribute("login")).getId();
		
		//iCalendarDao dao = CalendarDao.getInstance();
		iCalendarDao dao = CalendarDao.getInstance();
		List<CombineDto> list = dao.getCalendarList(id, year+UtilClass.two(month+""));
	
		System.out.println("11111: " + id + ", " + year + ", " + month);
		System.out.println("size: " + list.size());
		
		req.setAttribute("list", list);
		req.getRequestDispatcher("/mypage/myCalendar.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CalendarView dopost");
	}
}
