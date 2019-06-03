package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dao.MemberDao;
import member.dao.iMemberDao;
import member.dto.MemberDto;
import util.UtilClass;

@WebServlet(urlPatterns="/MyDelete")
public class MyDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyDelete doget");
		resp.setContentType("text/html; charset=UTF-8;");
		
		String id = req.getParameter("id");
		
		iMemberDao dao = MemberDao.getInstance();
		
		boolean isS = dao.myDelete(id);
		
		String msg = "";
		if(isS) {
			msg = "탈퇴에 성공햇습니다";
			HttpSession session = req.getSession(false);
			session.removeAttribute("login");
		}
		else {
			msg = "탈퇴에 실패햇습니다";
		}
		
		PrintWriter out = resp.getWriter();
		out.print("<script>alert('"+msg+"'); location.href='index.jsp';</script>");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyDelete dopost");
	}
}
