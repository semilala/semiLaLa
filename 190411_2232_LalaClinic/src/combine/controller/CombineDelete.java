package combine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
@WebServlet(urlPatterns="/CombineDelete")
public class CombineDelete extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		
		iCombineDao dao = CombineDao.getInstance();
		
		boolean isS = dao.deleteCombine(seq);
		
		if(isS) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
		resp.sendRedirect("CombineList");
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
