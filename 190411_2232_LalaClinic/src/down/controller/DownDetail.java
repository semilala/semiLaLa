package down.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
import combine.dto.CombineDto;
import down.dao.DownDao;
import down.dao.iDownDao;
import down.dto.DownDto;
import paging.PagingBean;
import util.ReplyDto;
@WebServlet(urlPatterns="/DownDetail")
public class DownDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownDetail doGet()");
		req.setCharacterEncoding("UTF-8");
		
		PagingBean paging = new PagingBean();
		if(req.getParameter("nowPage") == null){
	         paging.setNowPage(1); //넘어온 현재페이지가 없으면 1로 세팅
		}
		else{
	         paging.setNowPage(Integer.parseInt(req.getParameter("nowPage"))); //있으면 현재페이지로 세팅
	    }
		
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		iDownDao dao = DownDao.getInstance();
		DownDto dto = dao.detailDown(seq);
		List<ReplyDto> list = dao.getReplyList(seq, paging);
		
		req.setAttribute("dto", dto);
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		req.getRequestDispatcher("down/downDetail.jsp").forward(req, resp);
	}

}
