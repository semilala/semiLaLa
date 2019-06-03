package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDao;
import member.dao.iMemberDao;
import member.dto.MemberDto;
import util.UtilClass;

@WebServlet(urlPatterns="/AdminUpdate")
public class AdminUpdate extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminUpdate get");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminUpdate post");
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String name = req.getParameter("name");
		String gender = req.getParameter("gender");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");
		int auth = Integer.parseInt(req.getParameter("auth"));
		
		String syear = req.getParameter("year");
		String smonth = UtilClass.two(req.getParameter("month"));
		String sday = UtilClass.two(req.getParameter("day"));
		String birth = syear + smonth + sday;
		
		MemberDto dto = new MemberDto(id, pwd, name, gender, email, phone, birth, address, auth);
		System.out.println(dto.toString());
		
		iMemberDao dao = MemberDao.getInstance();
		boolean isS = dao.adminUpdate(dto);
		
		String msg = "";
		PrintWriter out = resp.getWriter();
		if(isS) {
			msg = "관리자 수정에 성공했습니다";
		}
		else {
			msg = "관리자 수정에 실패했습니다";
		}
		
		msg = "<script>alert('" + msg + "'); location.href='/LalaClinic/AdminDetail?id="+id+"';</script>";
		out.println(msg);
		
		//resp.sendRedirect("index.jsp");
	}
}
