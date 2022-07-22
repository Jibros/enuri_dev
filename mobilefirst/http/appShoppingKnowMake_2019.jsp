
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.json.simple.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="java.net.*"%>

<%
String os="";

request.setCharacterEncoding("UTF-8");
String ver = ChkNull.chkStr(request.getParameter("ver"), "");
String server = ChkNull.chkStr(request.getParameter("t"), "");
boolean isDev = request.getServerName().contains("dev.enuri.com");	
if(ver == "" || server == "" ){
	out.println("");
}else{
	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 )
	{
		os="aos";
	}else{
		os="ios";
	}

	JSONObject makeJson = new JSONObject();
	try {
		HashMap<String,String> connectlinks = new HashMap<String,String>();
		//if(isDev)
		//	connectlinks.put("getKnowcomTab.json", "http://localhost/m/api/getKnowcomTab.jsp"); //커뮤니티 인기글, 투데이 HOT CLIP, 에누리TV
		//else 
			connectlinks.put("getKnowcomTab.json", "http://localhost/m/api/main/knowcomTab.json"); //커뮤니티 인기글, 투데이 HOT CLIP, 에누리TV
		connectlinks.put("getTodayNews.json", "http://localhost/m/api/main/news.json");   //오늘의 뉴스
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dates = formatter.format(new Date());
		makeJson.put("time", dates);

		List<String> name = new ArrayList<String>(connectlinks.keySet());
		for(int i = 0; i < name.size(); i++){
			makeJson.put(  name.get(i),   getJSONObjectfromHttp(connectlinks.get(name.get(i))) == null ? "{}" : getJSONObjectfromHttp(connectlinks.get(name.get(i))) );
		}
		
		JSONArray categorymenu = new JSONArray();
		categorymenu.put(new JSONObject("{'title':'디지털/가전','link':'http://m.enuri.com/knowcom/news.jsp?cateno=1'}"));
		categorymenu.put(new JSONObject("{'title':'컴퓨터','link':'http://m.enuri.com/knowcom/news.jsp?cateno=2'}"));
		categorymenu.put(new JSONObject("{'title':'자동차/레저','link':'http://m.enuri.com/knowcom/news.jsp?cateno=3'}"));
		categorymenu.put(new JSONObject("{'title':'유아/라이프','link':'http://m.enuri.com/knowcom/news.jsp?cateno=4'}"));
		categorymenu.put(new JSONObject("{'title':'스포츠/연예','link':'http://m.enuri.com/knowcom/news.jsp?cateno=5'}"));
		categorymenu.put(new JSONObject("{'title':'게임갤러리','link':'http://m.enuri.com/knowcom/news.jsp?cateno=6'}"));
		makeJson.put("categorymenu",categorymenu);
		
		JSONArray boardmenu = new JSONArray();
		boardmenu.put(new JSONObject("{'title':'뉴스','link':' http://m.enuri.com/knowcom/news.jsp?temp=1'}"));
		boardmenu.put(new JSONObject("{'title':'구매가이드','link':'http://m.enuri.com/knowcom/guide.jsp?temp=1'}"));
		boardmenu.put(new JSONObject("{'title':'사용기','link':'http://m.enuri.com/knowcom/board.jsp?bbsname=review'}"));
		boardmenu.put(new JSONObject("{'title':'자유게시판','link':'http://m.enuri.com/knowcom/board.jsp?bbsname=nuri'}"));
		boardmenu.put(new JSONObject("{'title':'에누리TV','link':'http://m.enuri.com/knowcom/enuritv.jsp?bbsname=enuritv'}"));
		boardmenu.put(new JSONObject("{'title':'쇼핑Q&A','link':'http://m.enuri.com/knowcom/qna.jsp?temp=1'}"));
		makeJson.put("boardmenu",boardmenu);
		
	} catch (Exception e) {
		makeJson.put("exception2", e.toString());
	}
	if (makeJson != null)
		out.println(makeJson.toString());
}

%>
<%!
	public JSONObject getJSONObjectfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			//urlcon.setConnectTimeout(10000);
			InputStream inputStream = urlcon.getInputStream();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] arBytes = null;
			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();
			outputStream.close();
			inputStream.close();

			return new JSONObject(new String(arBytes,"UTF-8"));
			//return new String(arBytes,"UTF-8");
		} catch (Exception e) {
			//return e.getMessage();
		}
		return null;
	}

	public JSONArray getJSONArrayfromHttp(String strurl) {
		try {
			String recv;
			StringBuffer recvbuff = new StringBuffer();
			URL jsonpage = new URL(strurl);
			URLConnection urlcon = jsonpage.openConnection();
			urlcon.setConnectTimeout(10000);

			InputStream inputStream = urlcon.getInputStream();

			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			byte[] arBytes = null;
			byte[] readByte = new byte[1024];
			int readLen;
			while ((readLen = inputStream.read(readByte)) != -1) {
				outputStream.write(readByte, 0, readLen);
			}
			arBytes = outputStream.toByteArray();
			outputStream.close();
			inputStream.close();

			return new JSONArray(new String(arBytes, "utf-8"));
		} catch (Exception e) {

		}
		return null;
	}
%>