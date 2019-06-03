package down.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
import down.dao.DownDao;
import down.dao.iDownDao;
import util.ReplyDto;
@WebServlet(urlPatterns="/DownReplyInsert")
public class DownReplyInsert extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownReplyInsert doGet");
		
	   int pseq = Integer.parseInt(req.getParameter("pseq")); //원본글번호
	   String id = req.getParameter("id"); //글쓴사람id
	   int auth = Integer.parseInt(req.getParameter("auth")); //글쓴사람권한
	   String content = req.getParameter("content");
	   
	   ReplyDto dto = new ReplyDto();
	   dto.setPseq(pseq);
	   dto.setId(id);
	   dto.setContent(content);
	   
	   iDownDao dao = DownDao.getInstance();
	   boolean isS = dao.insertDownReply(dto, pseq, auth);
	   
	   if(isS) {
	      System.out.println("댓글입력성공");
	   }else {
	      System.out.println("댓글입력실패");
	   }
	   resp.sendRedirect("DownDetail?seq=" + pseq);
	}
}
