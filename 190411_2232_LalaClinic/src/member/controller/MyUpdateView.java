package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDao;
import member.dao.iMemberDao;
import member.dto.MemberDto;

@WebServlet(urlPatterns="/MyUpdateView")
public class MyUpdateView extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminUpdateView doget");
		
		String id = req.getParameter("id");
		iMemberDao dao = MemberDao.getInstance();
		MemberDto dto = dao.adminDetail(id);
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("mypage/myUpdateView.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("AdminUpdateView dopost");
	}
}
