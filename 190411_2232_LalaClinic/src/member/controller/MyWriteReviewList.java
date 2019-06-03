package member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import combine.dto.CombineDto;
import custom.dto.CustomDto;
import member.dao.MemberDao;
import member.dao.iMemberDao;
import member.dto.MemberDto;
import paging.PagingBean;
import review.dto.ReviewDto;

@WebServlet(urlPatterns="/MyWriteReviewList")
public class MyWriteReviewList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyWriteReviewList doget");
		
		String id = ((MemberDto)req.getSession(false).getAttribute("login")).getId();
		
		PagingBean paging = new PagingBean();
		if(req.getParameter("nowPage") == null){
	         paging.setNowPage(1); //넘어온 현재페이지가 없으면 1로 세팅
		}
		else{
	         paging.setNowPage(Integer.parseInt(req.getParameter("nowPage"))); //있으면 현재페이지로 세팅
	    }
		
		String sOption = req.getParameter("sOption");
		String sWord = req.getParameter("sWord");
		if(sWord==null) sWord = "";
		
		iMemberDao dao = MemberDao.getInstance();
		List<ReviewDto> rlist = dao.myReviewList(id, paging, sWord, sOption);
		
		req.setAttribute("rlist", rlist);
		req.setAttribute("paging", paging);
		req.getRequestDispatcher("mypage/myWriteReviewList.jsp?sOption="+sOption+"&sWord="+sWord).forward(req, resp);		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MyWriteReviewList");
	}
}
