package custom.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import custom.dto.CustomDto;
import paging.PagingBean;
@WebServlet(urlPatterns="/customList")
public class customList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	System.out.println("customList doget()");
		req.setCharacterEncoding("utf-8");

	
		PagingBean paging = new PagingBean();
		if(req.getParameter("nowPage") == null){
	         paging.setNowPage(1);   
	         System.out.println("new PagingBean() 1");
	      }else{
	         paging.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
	         System.out.println("new PagingBean() old");
	      }
		String choice = req.getParameter("choice");
		System.out.println("앞에 초이스:" + choice);
		// 검색어
		String findWord = req.getParameter("findWord");
		System.out.println("choice1:" + choice);
		System.out.println("findWord1:" + findWord);
		if(choice == null || choice.equals("")){
			choice = "sel";	
		}
		if(choice.equals("sel")){
			findWord = "";
		}

		// 검색어를 지정하지 않았을 경우, 빈 문자열로
		if(findWord == null){
			findWord = "";
			
		}
		System.out.println(":" + choice);
		System.out.println("findWord:" + findWord);
		iCustomDao dao = CustomDao.getInstance();
		//String pageNum = req.getParameter("pageNum");
		List<CustomDto> list = dao.getCustomPagingList(paging,findWord,choice);
		System.out.println(list.size());
		System.out.println("paging.getCountPerPage() : "+ paging.getCountPerPage());
		System.out.println("paging.getBlockCount():"+paging.getBlockCount());
		System.out.println("paging.getNowPage():"+paging.getNowPage());
		System.out.println("paging.getTotalCount():"+paging.getTotalCount());
		
		System.out.println(paging.toString());
//		System.out.println(list.get(0).toString());
		req.setAttribute("findWord", findWord);
		req.setAttribute("choice", choice);
		req.setAttribute("customlist", list);
		req.setAttribute("paging", paging);
		req.getRequestDispatcher("/custom/custom_list.jsp?choice=" + choice + "&findWord=" + findWord).forward(req, resp);
		
	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
	}

	
}
