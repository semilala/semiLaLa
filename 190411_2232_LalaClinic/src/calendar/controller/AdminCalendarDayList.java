package calendar.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import calendar.dao.CalendarDao;
import calendar.dao.iCalendarDao;
import combine.dto.CombineDto;
import member.dto.MemberDto;
import util.UtilClass;

@WebServlet(urlPatterns="/AdminCalendarDayList")
public class AdminCalendarDayList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminCalendarDayList doget");
		
		String id = ((MemberDto)req.getSession(false).getAttribute("login")).getId();	
		String year = req.getParameter("year");
		String month = req.getParameter("month");
		String day = req.getParameter("day");
		String rdate = year + UtilClass.two(month) + UtilClass.two(day);
		
		iCalendarDao dao = CalendarDao.getInstance();
		List<CombineDto> list = dao.getDayList(rdate);
		
		req.setAttribute("list", list);
		req.getRequestDispatcher("/admin/adminDayList.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminCalendarDayList doget");
	}

}
