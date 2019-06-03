package review.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns="/reviewAnswer")
public class ReviewAnswer extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewAnswer doGet");
		String id = req.getParameter("id");
		String content = req.getParameter("content");
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		System.out.println("seq = " + seq);
		System.out.println("id = " + id);
		System.out.println("content = " + content);
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewAnswer doPost");
		
		
	}
	
	
}
