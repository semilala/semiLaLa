package combine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
@WebServlet(urlPatterns="/CombineReplyDelete")
public class CombineReplyDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CombineReplyDelete doGet()");
		
		int seq = Integer.parseInt(req.getParameter("seq"));
		int pseq = Integer.parseInt(req.getParameter("pseq"));
		System.out.println("Seq : " + seq);
		
		iCombineDao dao = CombineDao.getInstance();
		
		boolean isS = dao.deleteCombineReply(seq);
		
		if(isS) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
		resp.sendRedirect("CombineDetail?seq=" + pseq);
	}

}
