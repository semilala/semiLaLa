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

@WebServlet(urlPatterns="/CombineList")
public class CombineList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		System.out.println("Combine doget()");
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
		if(choice == null || choice.equals("")) {
			choice="title";
		}
		if(findWord == null) {
			findWord = "";
		}
		System.out.println("choice1:" + choice);
		System.out.println("findWord:" + findWord);
		
		
		iCombineDao dao = CombineDao.getInstance();
		//String pageNum = req.getParameter("pageNum");
		List<CombineDto> list = dao.getCustomPagingList(paging,findWord,choice);
		
		System.out.println(list.size());
		System.out.println("paging.getCountPerPage() : "+ paging.getCountPerPage());
		System.out.println("paging.getBlockCount():"+paging.getBlockCount());
		System.out.println("paging.getNowPage():"+paging.getNowPage());
		System.out.println("paging.getTotalCount():"+paging.getTotalCount());
		
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		System.out.println("paging : " + paging.toString());
		System.out.println("listServlet list : " + list.toString());
		System.out.println("combineList Servlet choice : " + choice);
		System.out.println("combineList Servlet findWord : " + findWord);
		System.out.println();
		req.getRequestDispatcher("/combine/combine_list.jsp?choice=" + choice + "&findWord=" + findWord).forward(req, resp);
		
	}
}
