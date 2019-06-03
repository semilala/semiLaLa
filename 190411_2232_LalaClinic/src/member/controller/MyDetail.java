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

@WebServlet(urlPatterns="/MyDetail")
public class MyDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyDetail doget");
		
		String id = ((MemberDto)req.getSession(false).getAttribute("login")).getId();
		iMemberDao dao = MemberDao.getInstance();
		MemberDto dto = dao.myDetail(id);
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("mypage/mypage.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyDetail doget");
	}
}
