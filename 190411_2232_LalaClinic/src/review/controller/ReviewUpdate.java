package review.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import review.dao.ReviewDao;
import review.dao.iReviewDao;
import review.dto.ReviewDto;
import util.UtilClass;

@WebServlet(urlPatterns="/reviewUpdate")
public class ReviewUpdate extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewUpdate doGet");
		iReviewDao dao = ReviewDao.getInstance();
		int seq = Integer.parseInt(req.getParameter("seq"));
		ReviewDto rdto = dao.getReivew(seq);

		req.setAttribute("getReview", rdto);
		req.getRequestDispatcher("./Review/reviewUpdate.jsp").forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("ReviewUpdate doPost");

		// tomcat 배포
		// JSP -> application - 내장객체 - 경로 -> JAVA -> req.getSession().getServletContext()
		String fupload = req.getSession().getServletContext().getRealPath("/upload"); // WebContent에 폴더가 있어야 한다.	

		// 지정 폴더 저장
		//String fupload = "d:\\tmp"; 

		System.out.println("파일 업로드 폴더 : " + fupload);

		String yourTempDir = fupload;

		int yourMaxRequestSize = 100 * 1024 * 1024;		// 1M
		int yourMaxMemorySize = 100 * 1024;		// 1K

		// form field의 데이터(String)
		String id = "";
		String title = "";
		String content = "";
		String management = "";
		String filechk = "";
		int seq = 0;
		
		// file data
		String filename[] = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);

		if(isMultipart){

			// FileItem을 생성
			DiskFileItemFactory factory = new DiskFileItemFactory();

			// 사이즈 설정
			factory.setSizeThreshold(yourMaxMemorySize);
			// 디렉토리 설정
			factory.setRepository(new File(yourTempDir));

			// 업로드 설정
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(yourMaxRequestSize);

			// list저장 일단 다 담는다.file인지 문자열인지 모르기 때문에..
			List<FileItem> items;
			try {
				items = upload.parseRequest(req);
				Iterator<FileItem> it = items.iterator();

				while(it.hasNext()){	// 어떤게 넘어온지 모르지만 돌려줌

					// 파일을 꺼낸다.
					FileItem item =it.next();

					if(item.isFormField()){	// id, title, content
						if(item.getFieldName().equals("id")){
							id = item.getString("utf-8");	// utf-8
						}else if(item.getFieldName().equals("title")){
							title = item.getString("utf-8");
						}else if(item.getFieldName().equals("content")){
							content = item.getString("utf-8");
						}else if(item.getFieldName().equals("management")){
							management = item.getString("utf-8");
						}else if(item.getFieldName().equals("seq")){
							seq = Integer.parseInt(item.getString("utf-8"));
						}else if(item.getFieldName().equals("filechk")) {
							filechk = item.getString("UTF-8");
						}
					}else{	// file
						if(item.getFieldName().equals("fileload")){
							if(filechk.equals("ex") || filechk.equals("del")) {
								filename = null;
							}else {								
								filename = UtilClass.processUploadFile(item, fupload);
								System.out.println("fupload : " + fupload);					
							}
						}				
					}
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 실제로 날아온것을 담는 영역

		}else{
			System.out.print("multipart가 아님");
		}
		System.out.println("ReviewUpdate seq : " + seq);
		//System.out.println("ReviewUpdate id : " + id);
		
		// DB에 추가
		ReviewDto dto = null;
		if(filechk.equals("ex") || filechk.equals("del")) {
			dto = new ReviewDto(seq, id, title, content, null, null, management);
		}else {
			dto = new ReviewDto(seq, id, title, content, filename[0], filename[1], management);
		}
		System.out.println("seq : " + dto.getSeq());
		
		boolean isS = false;		
		iReviewDao dao = ReviewDao.getInstance();
		
		if(filechk.equals("ex")) {
			isS = dao.updateExReview(dto);
		}else if (filechk.equals("del") || filechk.equals("up")) {
			isS = dao.updateReview(dto);
		}
		
		System.out.println(isS);
		if(isS){
			System.out.println("리뷰 수정 성공!");		
			resp.sendRedirect("reviewList");

		}else{
			System.out.println("리뷰 수정 실패!");
			resp.sendRedirect("reviewList");		
		}

	}


}
