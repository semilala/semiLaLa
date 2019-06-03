package combine.controller;

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
import paging.PagingBean;
import util.ReplyDto;
@WebServlet(urlPatterns="/CombineDetail")
public class CombineDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		PagingBean paging = new PagingBean();
		//현재 페이지가 정해져있지않으면 1로셋팅
		if(req.getParameter("nowPage") == null){
	         paging.setNowPage(1);   
	         System.out.println("new PagingBean() 1");
	    }else{
	    	 //넘어온값이있다면 현재페이지설정
	         paging.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
	         System.out.println("new PagingBean() old");
	    }
		
		System.out.println("CombineDetail doGet()");
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		System.out.println("seq : " + seq);
		
		iCombineDao dao = CombineDao.getInstance();
		
		CombineDto com = dao.detailCombine(seq);
		System.out.println("paging TotalCount : " + paging.getTotalCount());
		List<ReplyDto> reply = dao.getReplyList(seq, paging);
		req.setAttribute("paging", paging);
		req.setAttribute("reply", reply);
		req.setAttribute("com", com);
		req.getRequestDispatcher("/combine/combine_detail.jsp").forward(req, resp);
		
	}

}
