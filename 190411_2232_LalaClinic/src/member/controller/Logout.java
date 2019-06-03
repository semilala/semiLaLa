package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns="/Logout")
public class Logout extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Logout get");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8"); 
		
		HttpSession session = req.getSession(false);
		session.getAttribute("login");
		session.removeAttribute("login");
		session.invalidate();
		
		resp.setHeader("Pragma", "No-cache");
		resp.setDateHeader("Expires", 0);
		resp.setHeader("Cache-Control", "no-cache");
		
		String msg = "";
		PrintWriter out = resp.getWriter();
		
		/*msg = "로그아웃 했습니다";
		msg = "<script>alert('" + msg + "'); location.href='check.jsp';</script>";
		out.println(msg);*/
		/*req.getRequestDispatcher("check.jsp").forward(req, resp);*/
		
		resp.sendRedirect("check.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Logout post");
	}

}
