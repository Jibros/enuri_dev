<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.Writer"%>
<%@ page import="java.io.BufferedWriter"%>
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.io.FileOutputStream"%>
<%!
public void saveHttpFileLocation(String url, String filePath) {
	try {
		URL obj = new URL(url);
		HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
		conn.setReadTimeout(5000);
		conn.setRequestProperty("Accept-Charset", "UTF-8");
//		conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
//		conn.addRequestProperty("User-Agent", "Mozilla");
//		conn.addRequestProperty("Referer", "google.com");

		StringBuffer html = new StringBuffer();

		// 헤더 입력
		html.append("<%@");
		html.append(" page contentType=\"text/html; charset=utf-8\" ");
		html.append("%>r\n");

		// jsp 소스 입력
		html.append("<%\r\n");
		html.append("%>r\n");

		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		String inputLine;

		while ((inputLine = in.readLine()) != null) {
			html.append(inputLine+"\r\n");
		}
		in.close();


		Writer outFile = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "utf-8"));

		String htmlStr = "";
		htmlStr += html.toString();

		outFile.write(htmlStr);

		outFile.close();

	} catch (Exception e) {
		System.out.println("error = "+e.toString());
		e.printStackTrace();
	}
}
%>
<%
	String saveRootUrl = "/mobilefirst/http";
	String saveRootAjaxUrl = "/mobilefirst/http/ajax";
	String saveRootPath = request.getRealPath(saveRootUrl);

//	out.println("<br>rootAddr = "+request.getRequestURL());
//	out.println("<br>saveRootPath = "+saveRootPath);

	String nowUrl = request.getRequestURL().toString();
	String nowUri = request.getRequestURI();

	String webRoot = nowUrl.replace(nowUri, "");

	// 변환할 URL목록
	int urlCnt = 3;
	int urlSubCnt = 5; // 하위에 딸린 ajax를 모아서 저장할수 있도록함
	String[][] inputUrl = new String[urlCnt][urlSubCnt];

	inputUrl[0] = new String[urlSubCnt];
	inputUrl[0][0] = "/mobilefirst/trend_news.jsp";
	inputUrl[0][1] = "/mobilefirst/ajax/main/getNews_top.jsp";
	inputUrl[0][2] = "/mobilefirst/ajax/main/getNews_list.jsp";

	inputUrl[1] = new String[urlSubCnt];
	inputUrl[1][0] = "/mobilefirst/best_list.jsp";

	inputUrl[2] = new String[urlSubCnt];
	inputUrl[2][0] = "/mobilefirst/plan_event.jsp";

	out.println("saveRootUrl = "+saveRootUrl);

	for(int i=0; i<inputUrl.length; i++) {

		for(int j=0; j<inputUrl[i].length; j++) {

			if(inputUrl[i][j]!=null && inputUrl[i][j].length()>0 && inputUrl[i][j].indexOf("/")>-1) {
				String inUrl = webRoot + inputUrl[i][j];
				String fileName = inputUrl[i][j].substring(inputUrl[i][j].lastIndexOf("/"));
				String outUrl = "";

				if(j==0) {
					outUrl = saveRootUrl + fileName;
				} else {
					outUrl = saveRootAjaxUrl + fileName;
				}

				out.println("<br>inUrl = "+inUrl);
				out.println("<br>outUrl = "+outUrl);

				//String saveRootUrl = "/mobilefirst/http";
				//String saveRootAjaxUrl = "/mobilefirst/http/ajax";

				String filePath = request.getRealPath(outUrl);

//				out.println("<br>inUrl = "+inUrl);
//				out.println("<br>filePath = "+filePath);

				saveHttpFileLocation(inUrl, filePath);
			}
		}
	}
	
%>
