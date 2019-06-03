package combine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
import util.ReplyDto;
@WebServlet(urlPatterns="/CombineReplyAddInsert")
public class CombineReplyAddInsert extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CombineReplyAddInsert doGet()");
		
		int pseq = Integer.parseInt(req.getParameter("pseq"));
		String id = req.getParameter("id");
		String content = req.getParameter("content");
		
		int ref = Integer.parseInt(req.getParameter("ref"));
		int step = Integer.parseInt(req.getParameter("step"));
		int depth = Integer.parseInt(req.getParameter("depth"));
		int auth = Integer.parseInt(req.getParameter("auth"));
		System.out.println("pseq : " + pseq);
		System.out.println("Ref : " + ref);
		System.out.println("step : " + step);
		System.out.println("depth : " +depth);
		System.out.println("auth : " + auth);
		
//		System.out.println("pseq : " + pseq);
		System.out.println("id : " + id);
		iCombineDao dao = CombineDao.getInstance();
		ReplyDto dto = new ReplyDto(id,content,pseq,ref,step,depth);
		
		
		boolean isS = dao.insertCombineAddReply(dto,pseq,auth);
		
		if(isS) {
			System.out.println("대댓글 성공");
		}else {
			System.out.println("대댓글 실패");
		}
		
		resp.sendRedirect("CombineDetail?seq=" + pseq);
		
	}
}
