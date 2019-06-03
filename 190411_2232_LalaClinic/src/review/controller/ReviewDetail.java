package review.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reply.dao.ReplyDao;
import reply.dao.iReplyDao;
import reply.dto.ReplyDto;
import review.dao.ReviewDao;
import review.dao.iReviewDao;
import review.dto.ReviewDto;

@WebServlet(urlPatterns="/reviewDetail")
public class ReviewDetail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewDetail doGet");
		int seq = Integer.parseInt(req.getParameter("seq"));
		System.out.println("seq = " + seq);
		iReviewDao dao = ReviewDao.getInstance();
		//String id = req.getParameter("id");
		dao.updateReadcount(seq);	// 조횟수 증가
		ReviewDto rdto = dao.getReivew(seq);	
		
		req.setAttribute("rdto", rdto);	// 리뷰 디테일가져감
		//req.setAttribute("id", id);
		
		// 댓글 리스트 출력
		iReplyDao rdao = ReplyDao.getInstance();
		//System.out.println("rdto.getTname : " + rdto.getTname());
		List<ReplyDto> plist = rdao.getReplyList(seq, rdto.getTname());
		req.setAttribute("plist", plist);	// 댓글 리스트 가져감
		
		req.getRequestDispatcher("./Review/reviewDetail.jsp").forward(req, resp);		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewDetail doPost");
	}

	
}
