package down.controller;

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

import down.dao.DownDao;
import down.dao.iDownDao;
import down.dto.DownDto;

@WebServlet(urlPatterns="/DownWrite")
public class DownWrite extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownWrite doGet()");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DownWrite dopost()");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		//tomcat 배포
		String fupload = req.getSession().getServletContext().getRealPath("/upload");
		System.out.println("파일업로드 폴더 : " + fupload );

		String yourTempDir = fupload;
		File file = new File(fupload);
		if(file.exists()==false) {
			file.mkdirs();
		}

		int yourMaxRequestSize = 100 * 1024 * 1024; //1M
		int yourMaxMemorySize = 100 * 1024; //1kByte

		//form field의 데이터(String)
		String id ="";
		String title ="";
		String content = "";
		String name = "";

		// file data
		String fileName[] = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);

		if(isMultipart){
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
						if(item.getFieldName().equals("id")){
							id = item.getString("UTF-8");
						}else if(item.getFieldName().equals("title")){
							title = item.getString("UTF-8");
						}else if(item.getFieldName().equals("content")){
							content = item.getString("UTF-8");
						}
					}
					else { //file
						if(item.getFieldName().equals("fileload")){
							fileName = processUploadFile(item, fupload);
							System.out.println("파일명 확인용 : " + fupload);
						}
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		}
		else{
			System.out.println("multipart가 아님");
		}
		
		/*
		System.out.println("fileupload // id : " + id);
		System.out.println("fileupload // name : " + name);
		System.out.println("fileupload // title : " + title);
		System.out.println("fileupload // content : " + content);
		System.out.println("fileupload // fileNameBf : " + fileName[0]);
		System.out.println("fileupload // fileNameAf : " + fileName[1]);
		 */

		// DB에 추가
		DownDto dto = new DownDto(0, id, title, content, fileName[0], fileName[1], 0, null, "DOWN");
		
		iDownDao dao = DownDao.getInstance();

		boolean isS = dao.insertDown(dto);
		String msg = "";
		
		if(isS) {
			msg = "등록에 성공했습니다";
		}else {
			msg = "등록에 실패했습니다";
		}
		
		PrintWriter out = resp.getWriter();
		out.println("<script>alert('" + msg + "'); location.href='/LalaClinic/DownList';</script>");
	}
	
	public String[] processUploadFile(FileItem fileItem, String dir) throws IOException{
		
		String fileNameBf = fileItem.getName(); //경로 + 파일명 (원본)
		String fileNameAf = ""; //변경후 파일명
		
		long sizeInBytes = fileItem.getSize(); //파일 크기
		String extension = "";
		
		SimpleDateFormat format1 = new SimpleDateFormat( "yyyyMMddHHmmssSSS");
		Date time = new Date();
		String time1 = format1.format(time); //수정후 파일명
		
		// 파일이 정상일 때
		if(sizeInBytes > 0){	// d:\\temp\\abc.txt  d:/temp/abc.txt
			int idx = fileNameBf.lastIndexOf("\\");
			if(idx == -1) {
				idx = fileNameBf.lastIndexOf("/");
			} //경로제거 (파일명만 남음)
			
			fileNameBf = fileNameBf.substring(idx+1); //원본파일명 취득
			
			int exIndex = fileNameBf.lastIndexOf(".");
			extension = fileNameBf.substring(exIndex); //원본파일 확장자 취득
			
			fileNameAf = time1 + extension;	//임시파일명 + 확장자
			
			File uploadFile = new File(dir,fileNameAf); //임시이름으로 서버에 파일저장
			try{
				fileItem.write(uploadFile);	//실제 파일을 올리는 부분
			} catch(Exception e){}
		}
		
		String fileName[] = {fileNameBf,fileNameAf};
		System.out.println("fileName[0] " + fileName[0]);
		System.out.println("fileName[1]" + fileName[1]);
		return fileName; 
	}
}



