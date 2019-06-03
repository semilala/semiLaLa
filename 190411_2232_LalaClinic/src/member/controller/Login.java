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

@WebServlet(urlPatterns="/Login")
public class Login extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Login get");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Login post");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		
		HttpSession session = req.getSession(false);
		iMemberDao mdao = MemberDao.getInstance();
		MemberDto mdto = mdao.loginCheck(id, pwd);
		

		
		String msg = "";
		PrintWriter out = resp.getWriter();
		if(mdto!=null) {
			session.setAttribute("login", mdto);
			session.setMaxInactiveInterval(30*60);
			//req.setAttribute("mdto", mdto);
			//req.getRequestDispatcher("index.jsp").forward(req, resp);
			msg = "<script>alert('로그인에 성공했습니다'); location.href='index.jsp';</script>";
		}
		else {
			msg = "로그인에 실패했습니다";
			msg = "<script>alert('" + msg + "'); location.href='member/login.jsp';</script>";
		}
		out.println(msg);
	}
}
