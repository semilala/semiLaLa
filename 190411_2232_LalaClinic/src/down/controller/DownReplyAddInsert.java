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
@WebServlet(urlPatterns="/DownReplyAddInsert")
public class DownReplyAddInsert extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownReplyAddInsert doGet");
		   
	   int pseq = Integer.parseInt(req.getParameter("pseq")); //원본글번호
	   String id = req.getParameter("id"); //글쓴사람id
	   String content = req.getParameter("content");
	   int ref = Integer.parseInt(req.getParameter("ref"));
	   int step = Integer.parseInt(req.getParameter("step"));
	   int depth = Integer.parseInt(req.getParameter("depth"));
	   
	   ReplyDto dto = new ReplyDto();
	   dto.setPseq(pseq);
	   dto.setId(id);
	   dto.setContent(content);
	   dto.setRef(ref);
	   dto.setStep(step);
	   dto.setDepth(depth);
	   System.out.println("servlet: " + dto.toString());
	   
	   iDownDao dao = DownDao.getInstance();
	   boolean isS = dao.insertDownAddReply(dto, pseq);
	   
	   if(isS) {
	      System.out.println("댓글입력성공");
	   }else {
	      System.out.println("댓글입력실패");
	   }
	   resp.sendRedirect("DownDetail?seq=" + pseq);
	}
}
