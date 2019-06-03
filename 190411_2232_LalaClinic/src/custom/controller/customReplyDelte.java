package custom.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import util.ReplyDto;
@WebServlet(urlPatterns="/customReplyDelte")
public class customReplyDelte extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	int seq = Integer.parseInt(req.getParameter("seq"));
	int pseq = Integer.parseInt(req.getParameter("pseq"));
	System.out.println("seq:" + seq);
	System.out.println("pseq:" + pseq);
	
//	ReplyDto rdto = new ReplyDto(seq, pseq);
	iCustomDao dao = CustomDao.getInstance();
	
	boolean isS =  dao.replyDelte(seq, pseq);
	
	if(isS) {
		System.out.println("댓글삭제성공");
		resp.sendRedirect("./customdetail?seq="+pseq);
		
	}else {
		System.out.println("댓글삭제실패");
	}
	}
	
	
	
	

}
