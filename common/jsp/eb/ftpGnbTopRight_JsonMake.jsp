<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.net.*,java.io.*"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ page import="com.enuri.bean.main.GetLoadExternalPage"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%
//ad Server 링크 array List에 미리 담아 놓음.
List<String> adServerLinkList = new ArrayList<String>();
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Digital_Electronics");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Computer");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Sports_Leisure_Car");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Baby_Grocery");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Furniture_Home_Health");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Fashion_Beauty");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Book_Travel_Hobby");
adServerLinkList.add("http://ad.enuri.com/NetInsight/bundle/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right");

//ftp 전송
System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp START");

for (int i=0; i<adServerLinkList.size(); i++ ) {
	//1. url 별로 데이터 가져 옴.
	//return data가 전혀 없는 경우도 있으니, 예외 처리 필요
	JSONParser jsonParser = new JSONParser();
	JSONObject jsonData =  new JSONObject();
	JSONArray jsonArray =  new JSONArray();
	boolean isJson = false;

	String strData = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(ChkNull.chkStr(adServerLinkList.get(i)),"utf-8")).toString();
	//System.out.println("strData : "+strData);
	
	if (!strData.isEmpty()) {
		if (strData.indexOf("[") > -1) {
			jsonArray = (JSONArray) jsonParser.parse(strData);
			
			if (jsonArray.size() > 0) {
				isJson = true;
			}
			
		} else {
			jsonData = (JSONObject) jsonParser.parse(strData);
			System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp] jsonData : "+jsonData);
			
			//json Data의 유효성 검사 : URL 및 IMG URL 존재 여부만 검사 함.
			if (jsonData.containsKey("JURL1") && !jsonData.get("JURL1").toString().isEmpty() && jsonData.containsKey("IMG1") && !jsonData.get("IMG1").toString().isEmpty()) {
				isJson = true;
			}
			//System.out.println("jsonData.containsKey(\"JURL1\") : "+jsonData.containsKey("JURL1"));
			//System.out.println("jsonData.containsKey(\"JURL1\") : "+ jsonData.get("JURL1").toString());
			//	jsonData.get("JURL1").toString();
		}
	} else {
		System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp] strData3 : "+strData);
	}

	// 2. 새로 생성한 json Data의 유효성 검사 (alt가 없거나, img1이 없거나, Target이 없을 경우)
	// 데이터가 비정상적일 경우 업로드 하지 않는다.
	
		//파일 업로드 시 사용 할 text 명 추출 함. 
		String adUrl = adServerLinkList.get(i);
		adUrl = adUrl.substring((adUrl.indexOf("@") + 1), adUrl.length());
	
		StringBuilder sb = new StringBuilder();
		
		HttpURLConnection yc = null;
		BufferedReader in = null;
		
		try {
			URL topMenuUrl = new URL(adServerLinkList.get(i));
			yc = (HttpURLConnection)topMenuUrl.openConnection();
			
			yc.connect();
			
			in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8"));
	
			String inputLine;
			String strTotCont = "";
	
			if (isJson) {
				//GNB 우측 윙 배너의 경우 array로 담아줘야 하는데, 안 주는 경우가 있어서 강제로 만들어 줌
			//	System.out.println("jsonData.toJSONString() : "+ jsonData.toJSONString());
			//	System.out.println("adUrl : "+adUrl + " indexOf[ : ] " + strData.indexOf("["));

				if ("GNB_Upper_right".equals(adUrl) && strData.indexOf("[") < 0 ) {
					sb.append("[");
				}
				
				while ((inputLine = in.readLine()) != null){
					sb.append(inputLine);
				  //  strTotCont += inputLine+"\r\n";
				}
	
				if ("GNB_Upper_right".equals(adUrl) && strData.indexOf("[") < 0 ) {
					sb.append("]");
				}
			} else {
				sb.append("");
			}
			in.close();

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch(NullPointerException e) {
		} finally {
		    if(yc != null)
		    	yc.disconnect();
		    if(in != null)
		    	in.close();
        }
		
		String strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/jca/main/json/" + adUrl + ".json";

		OutputStream topMenuStream = new FileOutputStream(strTopMenuFileName, false);
		
		topMenuStream.write(sb.toString().getBytes("UTF-8"));
		topMenuStream.flush();
		topMenuStream.close();

		uploadFile(adUrl + ".json","/was/lena/1.3/depot/lena-application/ROOT/jca/main/json/", "real");

		//out.println("<script>alert('[real] 정상반영되었습니다.');self.close();</script>");
	}
	System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp END");

%>
<%!
static boolean uploadFile(String strFileName, String uploadDir, String serverType){
	ArrayList<String> ipList = new ArrayList<String>();

	if ("stage".equals(serverType)) {
	    //ipList.add("100.100.100.230");	// 구서버
	    ipList.add("200.200.100.234");		// 신서버. 2017-08-17 부터.
	}

	if ("real".equals(serverType)) {
		ipList.add("100.100.100.151");
		ipList.add("100.100.100.170");
		ipList.add("100.100.110.171");
		ipList.add("100.100.100.172");
		ipList.add("100.100.110.173");
		ipList.add("100.100.100.174");
		ipList.add("100.100.110.175");
		ipList.add("100.100.100.176");
		ipList.add("100.100.110.177");
		ipList.add("100.100.100.178");
		ipList.add("100.100.110.179");
		ipList.add("100.100.110.191");
		ipList.add("100.100.100.192");
	}

    int port = 21;
    String ftpId = "lena";
    String ftpPw = "#cloud2021";
		
    //System.out.println("[ftpGnbTopRight_JsonMake.jsp] 170 ~ 179 전송 시작");
    for(int i = 0; i<ipList.size() ;i++){
        try{
	        CommonFtp commonFtp = new CommonFtp((String)ipList.get(i),port,ftpId,ftpPw);
	        commonFtp.login();

	        if(!uploadDir.equals(""))
	            commonFtp.cd(uploadDir);
		        commonFtp.put(strFileName,strFileName,uploadDir);
		        commonFtp.disconnect();
        } catch(Exception e){
            System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp] " + (String)ipList.get(i) + " 전송 실패");
        }finally{

        }
    }
    System.out.println(getCurrentTime() + " ftpGnbTopRight_JsonMake.jsp] 170 ~ 179 전송 완료");
    return true;
}

static boolean uploadFile(String strFileName){
    return uploadFile(strFileName,"", "");
}

protected static String getCurrentTime() {
	long time = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
	String str = dayTime.format(new Date(time));
	
	return str;
}
%>