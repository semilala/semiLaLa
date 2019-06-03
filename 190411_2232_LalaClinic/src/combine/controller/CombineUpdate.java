package combine.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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

import combine.dao.CombineDao;
import combine.dao.iCombineDao;
import combine.dto.CombineDto;
import util.UtilClass;

@WebServlet(urlPatterns="/CombineUpdate")
public class CombineUpdate extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("CombineUpdate doGet()");

		String command = req.getParameter("command");
		int seq = Integer.parseInt(req.getParameter("seq"));
		iCombineDao dao = CombineDao.getInstance();
		CombineDto dto = dao.detailCombine(seq);

		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/combine/combine_update.jsp").forward(req, resp);



	}




	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println("combineUpdate doPost()");
		String sseq = "";
		//tomcat 배포
		String fupload = req.getSession().getServletContext().getRealPath("/upload");

		// 지정폴더 저장
		//		 	String fupload = "d:\\tmp";

		System.out.println("파일업로드 폴더 : " + fupload );

		String yourTempDir = fupload;

		int yourMaxRequestSize = 100 * 1024 * 1024; //1M
		int yourMaxMemorySize = 100 * 1024; //1kByte

		//form field의 데이터(String)
		String id ="";
		String title ="";
		String content = "";
		String name = "";
		String phone = "";
		String email = "";
		String inquire = "";
		String gender = "";
		String medical = "";
		String rdate = "";
		String year = "";
		String month = "";
		String day = "";
		String hour = "";
		String filechk = "";
		// file data
		String fileName[] = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		if(isMultipart){
			// FileItem 을 생성
			DiskFileItemFactory factory =  new DiskFileItemFactory();

			factory.setSizeThreshold(yourMaxMemorySize);
			factory.setRepository(new File(yourTempDir));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(yourMaxRequestSize);

			// list 저장
			List<FileItem> items = null;
			try {
				items = upload.parseRequest(req);

				Iterator<FileItem> it = items.iterator();
				while(it.hasNext()){
					FileItem item = it.next();

					if(item.isFormField()){	//id, title, content
						System.out.println("멀티파트 들어옴?");
						if(item.getFieldName().equals("id")){
							id = item.getString("UTF-8");
						}else if(item.getFieldName().equals("seq")){
							sseq = item.getString("UTF-8");
							System.out.println("sseq :  " + sseq);
						}else if(item.getFieldName().equals("name")){
							name = item.getString("UTF-8");
						}else if(item.getFieldName().equals("phone")){
							phone = item.getString("UTF-8");
						}else if(item.getFieldName().equals("email")){
							email = item.getString("UTF-8");
						}else if(item.getFieldName().equals("inquire")){
							inquire = item.getString("UTF-8");
						}else if(item.getFieldName().equals("gender")){
							gender = item.getString("UTF-8");
						}else if(item.getFieldName().equals("medical")){
							medical = item.getString("UTF-8");
						}else if(item.getFieldName().equals("title")){
							title = item.getString("UTF-8");
						}else if(item.getFieldName().equals("content")){
							content = item.getString("UTF-8");
						}else if(item.getFieldName().equals("year")){
							year = item.getString("UTF-8");
						}else if(item.getFieldName().equals("month")){
							month = item.getString("UTF-8");
						}else if(item.getFieldName().equals("day")){
							day = item.getString("UTF-8");
						}else if(item.getFieldName().equals("hour")){
							hour = item.getString("UTF-8");
						}else if(item.getFieldName().equals("filechk")) {
							filechk = item.getString("UTF-8");
						}
					}else{		//file
						if(item.getFieldName().equals("fileload")){
							System.out.println("멀파일티파트 들어옴?");
							if(filechk.equals("ex") || filechk.equals("del")) {
								fileName = null;
							}else {
								System.out.println("Up으로 들어옴? multipart");
								fileName = processUploadFile(item, fupload);
								System.out.println("파일명 확인용 : " + fupload);
							}
						}
					}

				}
			} catch (FileUploadException e) {
					e.printStackTrace();
			}
		}else{
			System.out.println("multipart가 아님");
		}
		
		System.out.println("-------------------2");
		System.out.println("filechk : "  + filechk);
		rdate = year + UtilClass.two(month) + UtilClass.two(day) + UtilClass.two(hour);
		System.out.println("year :"  + year );
		System.out.println("month : " + month);
		System.out.println("day : " + day);
		System.out.println("hour : " + hour);
		System.out.println("combineUpdate doPost() rdate :  " + rdate);
		/*
		System.out.println("fileupload // id : " + id);
		System.out.println("fileupload // name : " + name);
		System.out.println("fileupload // phone : " + phone);
		System.out.println("fileupload // email : " + email);
		System.out.println("fileupload // inquire : " + inquire);
		System.out.println("fileupload // gender : " + gender);
		System.out.println("fileupload // medical : " + medical);
		System.out.println("fileupload // title : " + title);
		System.out.println("fileupload // content : " + content);
		System.out.println("fileupload // rdate : " + rdate);
		System.out.println("fileupload // fileNameBf : " + fileName[0]);
		System.out.println("fileupload // fileNameAf : " + fileName[1]);
		 */
		int seq = Integer.parseInt(sseq);
		// DB에 추가
		CombineDto dto =null;
		if(filechk.equals("ex") || filechk.equals("del")) {
			dto = new CombineDto(seq, id, inquire, medical, 
					rdate, title, content, null,null, 0, null, "COMBINE");
		}else {
			System.out.println("fileName[0] : " + fileName[0]);
			System.out.println("fileName[1] : " + fileName[1]);
			dto = new CombineDto(seq, id, inquire, medical, 
					rdate, title, content, fileName[0],fileName[1], 0, null, "COMBINE");
		}
		boolean isS =false;
		iCombineDao dao = CombineDao.getInstance();
		if(filechk.equals("ex")) {
			isS = dao.updateExCombine(dto);
		}else if (filechk.equals("del") || filechk.equals("up")) {
			isS = dao.updateCombine(dto);
		}
		if(isS) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		
		
		resp.sendRedirect("CombineDetail?seq=" + seq);

	}


	public String[] processUploadFile(FileItem fileItem, String dir) throws IOException{

		String fileNameBf = fileItem.getName(); // 경로 + 파일명 (원본)
		String fileNameAf = "";		// 변경후 파일명
		long sizeInBytes = fileItem.getSize(); // 파일 크기
		String extension = "";
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyyMMddHHmmssSSS");
		Date time = new Date();
		String time1 = format1.format(time);	//수정후 파일명

		// 파일이 정상일 때
		if(sizeInBytes > 0){	// d:\\temp\\abc.txt  d:/temp/abc.txt

			int idx = fileNameBf.lastIndexOf("\\");
			if(idx == -1){
				idx = fileNameBf.lastIndexOf("/");
			}
			fileNameBf = fileNameBf.substring(idx+1);	//파일명취득

			int exIndex = fileNameBf.lastIndexOf(".");	//확장자취득

			extension = fileNameBf.substring(exIndex);

			fileNameAf = time1 + extension; 	//임시파일명 + 확장자

			File uploadFile = new File(dir,fileNameAf);
			try{
				fileItem.write(uploadFile);	//실제 파일을 올리는 부분
			}catch(Exception e){}
		}

		String fileName[] = {fileNameBf,fileNameAf};
		System.out.println("fileName[0] " + fileName[0]);
		System.out.println("fileName[1]" + fileName[1]);
		return fileName; 

	}
}
