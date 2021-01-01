package util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileUtil {
	public static MultipartRequest upload(HttpServletRequest req, String saveDirectory) {

		MultipartRequest mr = null;
		/*
		 * 매개변수1 : 사용자의 요청 정보가 저장된 request내장객체 매개변수2 : 파일이 저장된 서버의 물리적 경로 그외 업로드할 파일의 최대
		 * 용량, 인코딩방식, 파일명 중복처리를 위한 클래스를 통해 MultipartRequest객체를 생성한다. 객체생성이 완료되면 파일
		 * 업로드된다.
		 */
		try {
			mr = new MultipartRequest(req, saveDirectory, 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mr;
	}

	public static void deleteFile(HttpServletRequest req, String directory, String filename) {
		String saveDirectory = req.getServletContext().getRealPath(directory);

		File f = new File(saveDirectory + File.separator + filename);

		if (f.exists()) {
			f.delete();
		}
	}

	// 파일 다운로드 로직1
	public static void download(HttpServletRequest request, HttpServletResponse response, String directory,
			String fileName) {

		/*
		 * 파일다운로드 원리 1.웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정해주면 웹브라우저는 자체 다운로드 창을 띄운다.
		 * 
		 * 2.서버에 저장된 파일을 출력스트림을 통해 웹브라우저에 출력한다.
		 */
		try {
			// 파일이 저장된 물리적인 경로를 가져온다.
			String saveDirectory = request.getServletContext().getRealPath(directory);

			// 3.파일 크기를 얻기 위한 파일객체 생성
			// - 다운로드시 프로그래스바를 표시하기 위함.
			File f = new File(saveDirectory + File.separator + fileName);
			long length = f.length();

			// 다운로드를 위한 응답헤더 설정
			// 4.다운로드창을 보여주기 위한 응답헤더 설정
			// 4-1.웹브라우저가 인식하지 못하는 컨텐츠타입(MIME)을 설정
			response.setContentType("binary/octect-stream");
			// 4-2.다운로드시 프로그래스바를 표시하기위한 컨텐츠길이 설정
			response.setContentLengthLong(length);

			/*
			 * 4-3. 응답헤더명 : Content-Disposition 응답헤더명에 따른 값 : attachment;filename=파일명
			 * setHeader(응답헤더명,헤더값)으로 추가함 브라우저 종류에 따라 한글파일명이 깨지는 경우가 있음으로 브라우저별 인코딩 방식을
			 * 달리하는것임(파일명을 인코딩)
			 */
			boolean isIE = request.getHeader("user-agent").toUpperCase().indexOf("MSIE") != -1
					|| request.getHeader("user-agent").toUpperCase().indexOf("11.0") != -1;

			if (isIE) {// 인터넷 익스플로러
				fileName = URLEncoder.encode(fileName, "UTF-8");
			} else {// 기타 웹브라우져
				/*
				 * new String(byte[] bytes, String charset)사용 1) 파일명을 byte형 배열로 변환 2) String클래스의
				 * 생성자에 변환한 배열과 charset는 8859_1을 지정함.
				 */
				fileName = new String(fileName.getBytes("UTF-8"), "8859_1");
			}

			response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

			/*
			 * IO작업을 통해서 서버에 있는 파일을 웹브라우저에 바로 출력
			 * 
			 * 데이터소스 : 파일 - 노드스트림 : FileInputStream 필터스트림 : BufferedInputStream 데이터목적지 :
			 * 웹브라우저 - 노드스트림 : response.getOutputStream(); 필터스트림 : BufferedOutputStream
			 */
			// 5.서버에 있는 파일에 연결할 입력스트림 생성
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
			// 6.웹브라우저에 연결할 출력스트림 생성
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			// 7.bis로 읽고 bos로 웹브라우저에 출력
			int data;
			while ((data = bis.read()) != -1) {
				bos.write(data);
				// bos.flush();
			}
			// 8.스트림 닫기
			bis.close();
			bos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	파일 다운로드 처리2 : 원본파일명과 저장된 파일명을 지정하여 파일 다운로드시
			파일명을 원본 파일명으로 변경한다.
			sfileName : 서버에 저장된 파일명 
			ofileName : 첨부파일의 원본 파일명
	*/
	public static void download(
				HttpServletRequest request, 
				HttpServletResponse response, 
				String directory,
				String sfileName, String ofileName) {

		/*
		 * 파일다운로드 원리 1.웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정해주면 웹브라우저는 자체 다운로드 창을 띄운다.
		 * 
		 * 2.서버에 저장된 파일을 출력스트림을 통해 웹브라우저에 출력한다.
		 */
		
		try {
			//파일명이 한글인 경우 깨집현상이 발생하므로 반드시 인코딩 해야한다.
			ofileName = URLEncoder.encode(ofileName, "UTF-8");
			// 파일이 저장된 물리적인 경로를 가져온다.
			String saveDirectory = request.getServletContext().getRealPath(directory);

			// 3.파일 크기를 얻기 위한 파일객체 생성
			// - 다운로드시 프로그래스바를 표시하기 위함.
			File f = new File(saveDirectory + File.separator + sfileName);
			long length = f.length();

			// 다운로드를 위한 응답헤더 설정
			// 4.다운로드창을 보여주기 위한 응답헤더 설정
			// 4-1.웹브라우저가 인식하지 못하는 컨텐츠타입(MIME)을 설정
			response.setContentType("binary/octect-stream");
			// 4-2.다운로드시 프로그래스바를 표시하기위한 컨텐츠길이 설정
			response.setContentLengthLong(length);

			/*
			 * 4-3. 응답헤더명 : Content-Disposition 응답헤더명에 따른 값 : attachment;filename=파일명
			 * setHeader(응답헤더명,헤더값)으로 추가함 브라우저 종류에 따라 한글파일명이 깨지는 경우가 있음으로 브라우저별 인코딩 방식을
			 * 달리하는것임(파일명을 인코딩)
			 */
			boolean isIE = request.getHeader("user-agent").toUpperCase().indexOf("MSIE") != -1
					|| request.getHeader("user-agent").toUpperCase().indexOf("11.0") != -1;

			if (isIE) {// 인터넷 익스플로러
				sfileName = URLEncoder.encode(sfileName, "UTF-8");
			} else {// 기타 웹브라우져
				/*
				 * new String(byte[] bytes, String charset)사용 1) 파일명을 byte형 배열로 변환 2) String클래스의
				 * 생성자에 변환한 배열과 charset는 8859_1을 지정함.
				 */
				sfileName = new String(sfileName.getBytes("UTF-8"), "8859_1");
			}
			/*
			서버에 저장된 파일명을 통해 파일객체를 생성한 후 파일을 다운로드
			받을때 아래 설정된 응답헤더를 통해 파일명이 원본 파일명으로 변경되어 
			로컬로 다운로드 된다.
			*/
			response.setHeader("Content-Disposition", "attachment;filename=" + ofileName);

			/*
			 * IO작업을 통해서 서버에 있는 파일을 웹브라우저에 바로 출력
			 * 
			 * 데이터소스 : 파일 - 노드스트림 : FileInputStream 필터스트림 : BufferedInputStream 데이터목적지 :
			 * 웹브라우저 - 노드스트림 : response.getOutputStream(); 필터스트림 : BufferedOutputStream
			 */
			// 5.서버에 있는 파일에 연결할 입력스트림 생성
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
			// 6.웹브라우저에 연결할 출력스트림 생성
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			// 7.bis로 읽고 bos로 웹브라우저에 출력
			int data;
			while ((data = bis.read()) != -1) {
				bos.write(data);
				// bos.flush();
			}
			// 8.스트림 닫기
			bis.close();
			bos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
