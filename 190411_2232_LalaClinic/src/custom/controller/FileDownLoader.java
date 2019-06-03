package custom.controller;

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

import custom.dao.CustomDao;
import custom.dao.iCustomDao;
import custom.dto.CustomDto;


@WebServlet(urlPatterns="/customfiledown")

public class FileDownLoader extends HttpServlet {
	
	private ServletConfig mConfig = null;
	private static final int BUFFER_SIZE = 8192; //8kb

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		mConfig = config; //업로드된 경로를 얻어오기 위한 준비
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CustomFileDown doget");
		
		String fileNameBf = req.getParameter("fileNameBf");
		String fileNameAf = req.getParameter("fileNameAf");
		int seq = Integer.parseInt(req.getParameter("seq"));
		
		//바이트단위로 날아온걸 준비?
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		String filePath = "";
		
		//1. 톰캣
		filePath = mConfig.getServletContext().getRealPath("/upload");
		
		//2. 폴더
		//filePath = "d:\\tmp";
		
		filePath = filePath + "\\" + fileNameAf;
		System.out.println("filePath: " + filePath);
		File f = new File(filePath); //찾았음
		
		//파일이 존재하며, 읽을수 있는가
		if(f.exists() && f.canRead()) {
			//window download 설정 (다운로드창)
			resp.setHeader("Content-Disposition", "attachment; fileName=\"" + fileNameBf + "\";"); //파일명칭 나옴. 헤드에?
			resp.setHeader("Content-Transfer-Encoding", "binary;"); //인코딩
			resp.setHeader("Content-Length", ""+f.length()); //파일 길이값 표현(얼마남았는지?)
			resp.setHeader("Pragma", "no-cache;"); //저장 안할거다 (취소되면 받은것들 무시)
			resp.setHeader("Expires", "-1;"); //기한?
			
			//파일생성, 기입
			BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
			byte[] buffer = new byte[BUFFER_SIZE];
			
			int read = 0;
			//끝까지 읽어라
			while( (read=fileInput.read(buffer)) != -1 ) {
				//읽으면서 read
				out.write(buffer, 0, read);
			}
			
			fileInput.close();
			out.flush(); //이게 진짜 중요하다고.
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("CustomDownLoader dopost");
	}

}






