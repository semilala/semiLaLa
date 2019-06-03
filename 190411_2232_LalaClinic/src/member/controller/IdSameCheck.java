package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDao;
import member.dao.iMemberDao;

@WebServlet(urlPatterns="/IdSameCheck")
public class IdSameCheck extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("IdSameCheck get");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("IdSameCheck post");
		
		String id = req.getParameter("id");
		
		iMemberDao mdao = MemberDao.getInstance();
		boolean idsamecheck = mdao.idSameCheck(id);
		
		PrintWriter out = resp.getWriter();
		if(idsamecheck) {
			// 중복되면
			out.print("fail");
		}
		else {
			out.print("success");
		}
	}
}
