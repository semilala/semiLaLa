package reply.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import oracle.net.aso.r;
import reply.dao.ReplyDao;
import reply.dao.iReplyDao;
import reply.dto.ReplyDto;

@WebServlet(urlPatterns="/replyAnswer")
public class ReplyAnswer extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReplyAnswer doGet");
		
		int seq = Integer.parseInt(req.getParameter("seq"));
		String id = req.getParameter("id");
		String content =req.getParameter("content");
		String tname = req.getParameter("tname");
		int pseq = Integer.parseInt(req.getParameter("pseq"));
		
		System.out.println("seq = " + seq);
		System.out.println("id = " + id);
		System.out.println("content = " + content);
		System.out.println("tname = " + tname);
		System.out.println("pseq = " + pseq);
		
		iReplyDao dao = ReplyDao.getInstance();
		ReplyDto dto = new ReplyDto(id, content, tname, pseq);
		
		boolean isS = dao.replyAnswer(seq, dto);
		
		if(isS) {
			System.out.println("답변입력 성공!");
			resp.sendRedirect("reviewDetail?seq=" + pseq);
		}else {
			System.out.println("답변입력 실패.....!");
			resp.sendRedirect("reviewDetail?seq=" + pseq);
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReplyAnswer doPost");
	}
	
	

}
