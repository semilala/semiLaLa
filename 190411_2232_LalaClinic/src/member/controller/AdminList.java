package member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDao;
import member.dao.iMemberDao;
import member.dto.MemberDto;
import paging.PagingBean;

@WebServlet(urlPatterns="/AdminList")
public class AdminList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("adminList doget");
		
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
		
		iMemberDao dao = MemberDao.getInstance();
		List<MemberDto> list = dao.adminAllPrint(paging, choice, findWord);
		
		req.setAttribute("list", list);
		req.setAttribute("paging", paging);
		req.getRequestDispatcher("admin/adminList.jsp?choice="+choice+"&findWord="+findWord).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("adminList dopost");
	}
}
