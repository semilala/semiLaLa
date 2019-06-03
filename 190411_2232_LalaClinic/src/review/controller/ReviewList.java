package review.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paging.PagingBean;
import review.dao.ReviewDao;
import review.dao.iReviewDao;
import review.dto.ReviewDto;

@WebServlet(urlPatterns="/reviewList")

public class ReviewList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

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

		String choice = req.getParameter("choice");
		// 검색어
		String findWord = req.getParameter("findWord");
		if(choice == null || choice == "") {
			choice="title";
		}
		if(findWord == null) {
			findWord = "";
		}
		System.out.println("ReviewList doGet choice1: " + choice);
		System.out.println("ReviewList doGet searchWord1: " + findWord);
		
		//////////
		iReviewDao dao = ReviewDao.getInstance();

		List<ReviewDto> list = dao.getReviewPagingList(paging, findWord, choice);
		System.out.println(list.toString());
		System.out.println("list.size() : " + list.size());
		System.out.println("paging.getCountPerPage() : "+ paging.getCountPerPage());
		System.out.println("paging.getBlockCount():"+paging.getBlockCount());
		System.out.println("paging.getNowPage():"+paging.getNowPage());
		System.out.println("paging.getTotalCount():"+paging.getTotalCount());
		
		req.setAttribute("reviewlist", list);
		req.setAttribute("paging", paging);

		System.out.println("paging : " + paging.toString());
		System.out.println("list : " + list.toString());
		System.out.println("combineList Servlet choice : " + choice);
		System.out.println("combineList Servlet searchWord : " + findWord);
		
		req.getRequestDispatcher("./Review/reviewlist.jsp?choice=" + choice + "&searchWord=" + findWord).forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}


}
