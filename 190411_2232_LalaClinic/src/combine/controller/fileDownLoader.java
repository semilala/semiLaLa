package combine.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns="/combinefiledown")
public class fileDownLoader extends HttpServlet {

	private ServletConfig mConfig = null;
	private static final int BUFFER_SIZE = 8192; //8kb
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		mConfig = config; 	//업로드된 경로를 취득하기 위해서
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("fileDownLoader");
		String fileNameBf = req.getParameter("fileNameBf");
		String fileNameAf = req.getParameter("fileNameAf");
		String sseq = req.getParameter("seq");
		
		// download 증가(DB)
		
		//byte단위로 들어온것을 내보내기위해 준비햐놓는것
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		String filePath ="";
		
		//tomcat
		filePath = mConfig.getServletContext().getRealPath("/upload");
		
		//폴더
//		filePath = "d:\\tmp";
		
		filePath = filePath + "\\" + fileNameAf;
		
		File f = new File(filePath);
		if(f.exists() && f.canRead()) {
			//파일명을 헤더에 올려줌
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameBf + "\";");
			//인코딩방식을 binary로
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			//파일의 길이 (남은 파일용량)
			resp.setHeader("Content-Length", "" + f.length());
			//임시공간에 저장하지않겠다
			resp.setHeader("Pragma", "no-cache;"); 
			//기한없음
			resp.setHeader("Expires", "-1;");
			
		}
		
		//파일 생성, 기립
		BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
		
		byte buffer[] = new byte[BUFFER_SIZE]; 
		
		int read = 0;
		
		while((read = fileInput.read(buffer)) != -1) {
			out.write(buffer, 0, read);
		}
		fileInput.close();
		out.flush();
		
		
	}

}
