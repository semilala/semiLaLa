package custom.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import custom.dto.CustomDto;
import util.ReplyDto;
@WebServlet(urlPatterns="/customdetail")
public class customDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		iCustomDao dao = CustomDao.getInstance();
		String sseq = req.getParameter("seq");
		int seq = Integer.parseInt(sseq);
		
		CustomDto dto = dao.detail(new CustomDto(seq,null,null,null,null,null,null,null,0));
		System.out.println(dto.toString());
		
		List<ReplyDto> reply = dao.replyDetail(seq);
	      req.setAttribute("reply", reply);
		req.setAttribute("customdetail", dto);
		//System.out.println(list.size());
		req.getRequestDispatcher("custom/custom_detail.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

	
}
