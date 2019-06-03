package review.fd;

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

@WebServlet(urlPatterns="/filedown")

public class FileDownLoader extends HttpServlet {

	private ServletConfig mConfig = null;
	private static final int BUFFER_SIZE = 8192;	// 8KB
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		mConfig = config;	// 업로드된 경로를 취득하기 위해서		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//System.out.println("FileDownLoader doGet");
		
		String fileNameBf = req.getParameter("fileNameBf");
		String fileNameAf = req.getParameter("fileNameAf");
		String sseq = req.getParameter("seq");
		
		// download 증가(DB)		
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		String filePath = "";
		
		// tomcat에 올렸을 경우
		filePath = mConfig.getServletContext().getRealPath("/upload");
		
		// 폴더에 올렸을 경우
		//filePath = "d:\\tem";
		
		filePath = filePath + "\\" + fileNameAf;;
		System.out.println("filePath = " + filePath);
		
		File f = new File(filePath);	// 올린부분의 경로와 파일이름을 가져온다.
		
		if(f.exists() && f.canRead()) {	// 파일이 있고 읽을수 있으면 true

			// window download 설정(다운로드 창) 
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameBf + "\";"); // 파일명칭을 헤더에 보여줌
			resp.setHeader("Content-Transfer-Encoding", "binary;");	//2진코딩
			resp.setHeader("Content-Length", "" + f.length());		// 파일의 길이값
			resp.setHeader("Pragma", "no-cache;"); 	// 저장을 하지 않겠다.(버퍼같은 공간에)
			resp.setHeader("Expires", "-1;");
			
			// 파일생성, 기입
			BufferedInputStream fileInput 
						= new BufferedInputStream(new FileInputStream(f));
			byte buffer[] = new byte[BUFFER_SIZE];
			
			int read = 0;
			
			while((read = fileInput.read(buffer)) != -1) {	// 끝까지 읽어라
				out.write(buffer, 0, read);		// 버퍼공간에 쓰면서 읽는다.
			}
			
			fileInput.close();	// 닫기
			out.flush();	// 비우기
			
		}
	}	
}
