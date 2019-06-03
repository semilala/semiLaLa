package reply.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reply.dao.ReplyDao;
import reply.dao.iReplyDao;

@WebServlet(urlPatterns="/replyDelete")
public class ReplyDelete extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReplyDelete doGet");
		resp.setContentType("text/html; charset=UTF-8");
		iReplyDao dao = ReplyDao.getInstance();
		
		int seq = Integer.parseInt(req.getParameter("seq"));
		int pseq = Integer.parseInt(req.getParameter("pseq"));
		
		boolean isS = dao.deleteReply(seq);
		System.out.println(isS);
		
		if(isS){
			System.out.println("댓글 삭제 성공!");	
			
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('삭제되었습니다.'); location.href='reviewDetail?seq=" + pseq + "';</script>");
			out.flush();

		}else{
			System.out.println("댓글 삭제 실패!");
			resp.sendRedirect("reviewDetail?seq=" + pseq);		
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReplyDelete doPost");
	}

	
}
