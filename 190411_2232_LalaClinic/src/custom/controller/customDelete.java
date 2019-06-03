package custom.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
@WebServlet(urlPatterns="/customDelete")
public class customDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		iCustomDao dao = CustomDao.getInstance();
		
		boolean isS = dao.deleteCustom(seq);
		if(isS) {
			System.out.println("고객소리함 게시글 삭제 성공");
			
			resp.sendRedirect("./MyWriteCustomList");
		}else {
			System.out.println("고객소리함 게시글 삭제 실패");
			
		}
		
		
	}

	
	
	
}
