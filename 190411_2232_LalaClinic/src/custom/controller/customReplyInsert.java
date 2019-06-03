package custom.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import util.ReplyDto;

@WebServlet(urlPatterns="/customReplyInsert")
public class customReplyInsert extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	System.out.println("customReplyInsert doGet");
	
	int pseq = Integer.parseInt(req.getParameter("pseq"));
	String id = req.getParameter("id");
	String content = req.getParameter("content");
	int auth = Integer.parseInt(req.getParameter("auth"));
	System.out.println(pseq + " " + id + " " + content);
	ReplyDto rdto = new ReplyDto(pseq,id,content,0);
	iCustomDao dao = CustomDao.getInstance();
	
	boolean isS =  dao.insertCustomRelpy(rdto, auth);
	
	if(isS) {
		System.out.println("댓글입력성공");
		resp.sendRedirect("./customdetail?seq="+pseq);
		
	}else {
		System.out.println("댓글입력실패");
	}
}

	
	
	
}
