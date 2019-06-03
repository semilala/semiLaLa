package down.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import down.dao.DownDao;
import down.dao.iDownDao;

@WebServlet(urlPatterns="/DownDelete")
public class DownDelete extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownDelete doget");
		
		int seq = Integer.parseInt(req.getParameter("pseq"));
		
		iDownDao dao = DownDao.getInstance();
	}
}
