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
@WebServlet(urlPatterns="/CombineReplyInsert")
public class CombineReplyInsert extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("customReplyInsert doGet");
		   
		   int pseq = Integer.parseInt(req.getParameter("pseq"));
		   String id = req.getParameter("id");
		   int auth = Integer.parseInt(req.getParameter("auth"));
		   
		   String content = req.getParameter("content");
		   System.out.println(pseq + " " + id + " " + content);
		   ReplyDto rdto = new ReplyDto(pseq,id,content);
		   iCombineDao dao = CombineDao.getInstance();
		   
		   boolean isS =  dao.insertCombineReply(rdto,pseq,auth);
		   
		   if(isS) {
		      System.out.println("댓글입력성공");
		   }else {
		      System.out.println("댓글입력실패");
		   }
		   resp.sendRedirect("CombineDetail?seq=" + pseq);
	}
}
