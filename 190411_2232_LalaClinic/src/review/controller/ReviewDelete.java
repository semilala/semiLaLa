package review.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import review.dao.ReviewDao;
import review.dao.iReviewDao;

@WebServlet(urlPatterns="/reviewDelete")

public class ReviewDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewDelete doGet");
		
		resp.setContentType("text/html; charset=UTF-8");

		
		iReviewDao dao = ReviewDao.getInstance();
		
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		boolean isS = dao.deleteReview(seq);
		System.out.println(isS);
		
		if(isS){
			System.out.println("리뷰 삭제 성공!");	
			
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('삭제되었습니다.'); location.href='reviewList';</script>");
			out.flush();

		}else{
			System.out.println("리뷰 수정 실패!");
			resp.sendRedirect("reviewList");		
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

	
}
