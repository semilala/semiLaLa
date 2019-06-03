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

@WebServlet(urlPatterns="/DownList")
public class DownList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownList doget()");
		req.setCharacterEncoding("UTF-8");
	
		PagingBean paging = new PagingBean();
		if(req.getParameter("nowPage") == null){
	         paging.setNowPage(1); //넘어온 현재페이지가 없으면 1로 세팅
		}
		else{
	         paging.setNowPage(Integer.parseInt(req.getParameter("nowPage"))); //있으면 현재페이지로 세팅
	    }
	     
		String choice = req.getParameter("choice");
		String findWord = req.getParameter("findWord");
		if(findWord==null) findWord = "";
		
		iDownDao dao = DownDao.getInstance();
		List<DownDto> list = dao.getDownPagingList(paging, choice, findWord);
		
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		
		req.getRequestDispatcher("down/downList.jsp?choice="+choice+"&findWord="+findWord).forward(req, resp);	
	}
}
