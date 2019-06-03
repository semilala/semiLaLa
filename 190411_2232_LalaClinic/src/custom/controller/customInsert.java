package custom.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(urlPatterns="/customInsert")
public class customInsert extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CustomWrite doGet()");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		System.out.println("CustomWrite doPost()");
		//tomcat 배포
		String fupload = req.getSession().getServletContext().getRealPath("/upload");

		// 지정폴더 저장
		//          String fupload = "d:\\tmp";

		System.out.println("파일업로드 폴더 : " + fupload );

		String yourTempDir = fupload;

		int yourMaxRequestSize = 100 * 1024 * 1024; //1M
		int yourMaxMemorySize = 100 * 1024; //1kByte

		//form field의 데이터(String)
		String id = "";
		String title = "";
		String content = "";
		
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

					if(item.isFormField()){   //id, title, content
						
							System.out.println("formfiled 들어옴?");
							if(item.getFieldName().equals("id")){
								id = item.getString("utf-8");

							}else if(item.getFieldName().equals("title")){
								title = item.getString("utf-8");

							}else if(item.getFieldName().equals("content")){
								content = item.getString("utf-8");

							}
							

						}else{      //file
							if(item.getFieldName().equals("fileName")){
								System.out.println("processUploadFile 들어옴?");
								fileName = processUploadFile(item, fupload);
								System.out.println("파일명 확인용 : " + fupload);
							}
						}

					}
				}
				 catch (FileUploadException e) {
					e.printStackTrace();
				}

			}else{
				System.out.println("multipart가 아님");
			}

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
			System.out.println(id + " " + title + " " + content + " "
				+ fileName[0] + fileName[1]);
			// DB에 추가
			CustomDto dto = new CustomDto(0,id,title,content,fileName[0],fileName[1],null,null,0);

			iCustomDao dao = CustomDao.getInstance();

			String msg = "";
			boolean isS = dao.insertCustom(dto);
			

			//resp.sendRedirect("custom/custom_write.jsp");
			
			PrintWriter out = resp.getWriter();
			msg = "<script> location.href='/LalaClinic/MyWriteCustomList';</script>";
			out.println(msg);
		}
	
	public String[] processUploadFile(FileItem fileItem, String dir) throws IOException{

		String fileNameBf = fileItem.getName(); // 경로 + 파일명 (원본)
		String fileNameAf = "";      // 변경후 파일명
		long sizeInBytes = fileItem.getSize(); // 파일 크기
		String extension = "";
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyyMMddHHmmssSSS");
		Date time = new Date();
		String time1 = format1.format(time);   //수정후 파일명

		// 파일이 정상일 때
		if(sizeInBytes > 0){   // d:\\temp\\abc.txt  d:/temp/abc.txt

			int idx = fileNameBf.lastIndexOf("\\");
			if(idx == -1){
				idx = fileNameBf.lastIndexOf("/");
			}
			fileNameBf = fileNameBf.substring(idx+1);   //파일명취득

			int exIndex = fileNameBf.lastIndexOf(".");   //확장자취득

			extension = fileNameBf.substring(exIndex);

			fileNameAf = time1 + extension;    //임시파일명 + 확장자

			File uploadFile = new File(dir,fileNameAf);
			try{
				fileItem.write(uploadFile);   //실제 파일을 올리는 부분
			}catch(Exception e){}
		}

		String fileName[] = {fileNameBf,fileNameAf};
		System.out.println("fileName[0] " + fileName[0]);
		System.out.println("fileName[1]" + fileName[1]);
		return fileName; 

	}
}