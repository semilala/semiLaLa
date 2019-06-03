package custom.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import custom.dto.CustomDto;
@WebServlet(urlPatterns="/customUpdate")
public class customUpdate extends HttpServlet {

	/*public String processUploadFile(FileItem fileItem, String dir) throws IOException {
		String fileName = fileItem.getName(); //경로+파일명
		long sizeInBytes = fileItem.getSize();

		//파일이 정상일 때
		if(sizeInBytes > 0) {
			int idx = fileName.lastIndexOf("\\");
			if(idx==-1) { // \\가 없으면
				idx = fileName.lastIndexOf("/");
			}
			fileName = fileName.substring(idx+1); //abc.txt

			//파일명 바꾸고 싶으면 여기서 바꾼다.
			//
			//

			//올릴경로, 잘라낸 파일명로 파일포인터 생성
			File uploadFile = new File(dir, fileName);
			try {
				//실제 파일을 올리는 부분 - 생성되면서 기입된다
				fileItem.write(uploadFile);
			} catch(Exception e) {}
		}
		//그냥 확인용
		return fileName;
	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("CustomInsert doPost()");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		//1. 톰캣배포
		String saveFile = req.getSession().getServletContext().getRealPath("/upload");

		//2. 지정폴더에 저장
		//String savePath = "d:\\tmp";

		System.out.println("파일업로드 폴더: " + saveFile);
		String saveDir = saveFile;

		int fileMaxSize = 100*1024*1024; //100메가?
		int fileMemorySize = 100*1024; //1키로?

		String id = "";
		String title = "";
		String content = "";
		String wdate = "";
		int seq = 0;
		// file data
		String fileName = "";

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		if(isMultipart) {
			DiskFileItemFactory factory = new DiskFileItemFactory();

			factory.setSizeThreshold(fileMaxSize);
			factory.setRepository(new File(saveDir));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(fileMaxSize);
			//세팅 완료

			List<FileItem> items;

			try {
				items = upload.parseRequest(req);


				Iterator<FileItem> it = items.iterator();
				while(it.hasNext()) {
					FileItem item = it.next();

					if(item.isFormField()) {

						if(item.getFieldName().equals("id")){
							id = item.getString("utf-8");

						}else if(item.getFieldName().equals("title")){
							title = item.getString("utf-8");

						}else if(item.getFieldName().equals("content")){
							content = item.getString("utf-8");

						}
					else if(item.getFieldName().equals("seq")){
						seq = Integer.parseInt(item.getString("utf-8"));

					}else if(item.getFieldName().equals("wdate")){
						wdate = item.getString("utf-8");

					}


					}else {
						if(item.getFieldName().equals("fileName")) {
							fileName = processUploadFile(item, saveFile);
							System.out.println("saveFile: " + saveFile);
						}
					}
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


		}



		CustomDto dto = new CustomDto(seq,id,title,content,fileName,wdate);

		//System.out.println(seq+ " " + id + " " + title + " " + content + " " + fileName + " " + wdate);

		iCustomDao dao = CustomDao.getInstance();
		boolean isS = dao.update(dto);

		if(isS) {
			//req.getRequestDispatcher("custom_write.jsp").forward(req, resp);
			resp.sendRedirect("custom_write.jsp");

		}else {

			System.out.println("fail");
		}
		}*/


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("CombineUpdate doGet()");

		String command = req.getParameter("command");
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		CustomDto dto = new CustomDto();
		dto.setSeq(seq);
		
		iCustomDao dao = CustomDao.getInstance();
		boolean isS = dao.update(dto);

		if(isS) {
			resp.sendRedirect("custom_detail.jsp");
		}else {
			System.out.println("fail");
		}
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

		String id = "";
		String title = "";
		String content = "";
		String wdate = "";
		int seq = 0;
		String filechk = "";
		// file data
		String fileName[] = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		System.out.println("-------------------1");
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
							id = item.getString("utf-8");

						}else if(item.getFieldName().equals("title")){
							title = item.getString("utf-8");

						}else if(item.getFieldName().equals("content")){
							content = item.getString("utf-8");

						}
						else if(item.getFieldName().equals("seq")){
							seq = Integer.parseInt(item.getString("utf-8"));

						}else if(item.getFieldName().equals("wdate")){
							wdate = item.getString("utf-8");

						}
						else if(item.getFieldName().equals("filechk")) {
							filechk = item.getString("UTF-8");
						}
					}else{		//file
						if(item.getFieldName().equals("fileload")){
							System.out.println("멀파일티파트 들어옴?");
							if(filechk.equals("ex") || filechk.equals("del")) {
								fileName = null;
							}else {
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
		
		// DB에 추가
		CustomDto dto =null;
		if(filechk.equals("ex") || filechk.equals("del")) {
			//seq,null,null,null,null,null,null,null,0,0,0
			dto = new CustomDto(seq, id,  title, content, null,null, null, "CUSTOM", 0);
		}else {
			dto = new CustomDto(seq, id,  title, content, fileName[0],fileName[1], null, "CUSTOM", 0);
		}
		System.out.println("-------------------3");
		boolean isS =false;
		iCustomDao dao = CustomDao.getInstance();
		if(filechk.equals("ex")) {
			System.out.println("-------------------4");
			isS = dao.updateExCustom(dto);
		}else if (filechk.equals("del") || filechk.equals("up")) {
			System.out.println("-------------------4-1");
			isS = dao.update(dto);
		}
		System.out.println("-------------------5");
		if(isS) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}


		resp.sendRedirect("customdetail?seq=" + seq);

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





