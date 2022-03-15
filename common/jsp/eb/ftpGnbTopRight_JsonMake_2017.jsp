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
/* 
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Digital_Electronics");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Computer");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Sports_Leisure_Car");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Baby_Grocery");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Furniture_Home_Health");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Fashion_Beauty");
adServerLinkList.add("http://ad.enuri.com/NetInsight/text/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Category_banner_Book_Travel_Hobby");
adServerLinkList.add("http://ad.enuri.com/NetInsight/bundle/PC_Enuri_Site/GNB_Enuri/GNB@GNB_Upper_right");
 */

 //String strAdServerUrl = "http://adsvc.enuri.mcrony.com/enuri_PC/pc_main";
 //String strAdServerUrl = "http://adsvc.enuri.mcrony.com/enuri_PC/pc_home";
 String strAdServerUrl = "http://ad-api.enuri.info/enuri_PC/pc_home";
  
adServerLinkList.add(strAdServerUrl + "/B1/bundle?bundlenum=6");
adServerLinkList.add(strAdServerUrl + "/B21/req");	// GNB1 (B21)
adServerLinkList.add(strAdServerUrl + "/B22/req");	// GNB2 (B22)
adServerLinkList.add(strAdServerUrl + "/B23/req");	// GNB3 (B23)
adServerLinkList.add(strAdServerUrl + "/B24/req");	// GNB4 (B24)
adServerLinkList.add(strAdServerUrl + "/B25/req");	// GNB5 (B25)
adServerLinkList.add(strAdServerUrl + "/B26/req");	// GNB6 (B26)
adServerLinkList.add(strAdServerUrl + "/B27/req");	// GNB7 (B27)
adServerLinkList.add(strAdServerUrl + "/B28/req");	// GNB7 (B28)

//adServerLinkList.add(strAdServerUrl + "/A4/req");	// A4 (홈메인 오른쪽 윙)


//ftp 전송
//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> START");

for (int i=0; i<adServerLinkList.size(); i++ ) {
	//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> START URL : " + adServerLinkList.get(i));
	//1. url 별로 데이터 가져 옴.
	//return data가 전혀 없는 경우도 있으니, 예외 처리 필요
	JSONParser jsonParser = new JSONParser();
	JSONObject jsonData =  new JSONObject();
	JSONArray jsonArray =  new JSONArray();
	boolean isJson = false;

	String strData = new GetLoadExternalPage().getUrlPage(URLDecoder.decode(ChkNull.chkStr(adServerLinkList.get(i)),"utf-8")).toString();

	//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> strData : " + strData + "  strData.trim().isEmpty() : " + strData.trim().isEmpty());
	
	if (!strData.trim().isEmpty()) {
		if (strData.indexOf("[") > -1) {
			jsonArray = (JSONArray) jsonParser.parse(strData);
			
			if (jsonArray.size() > 0) {
				isJson = true;
			}
			
		} else {
			jsonData = (JSONObject) jsonParser.parse(strData);
			//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> jsonData : " + jsonData);
			
			//json Data의 유효성 검사 : URL 및 IMG URL 존재 여부만 검사 함.
			if (adServerLinkList.get(i).indexOf("/req") > 0 && jsonData.containsKey("JURL1")  && jsonData.containsKey("IMG1")) {
				isJson = true;
			}			
		}
	} else {
		//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> JSON Data is Empty ==  strData3 : " + strData + " URL : " + adServerLinkList.get(i));	// json Data가 없는 경우 시스템 로그 출력
	}

	// 2. 새로 생성한 json Data의 유효성 검사 (alt가 없거나, img1이 없거나, Target이 없을 경우)
	// 데이터가 비정상적일 경우 업로드 하지 않는다.
	
	//파일 업로드 시 사용 할 text 명 추출 함. 
	String adUrl = adServerLinkList.get(i);
	adUrl = adUrl.replace(strAdServerUrl, "");
	
	//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> /indexOf : " + (adUrl.indexOf("/") + 1));
	
	if (adUrl.indexOf("/bundle") > 0) {
		adUrl = adUrl.substring((adUrl.indexOf("/") + 1), adUrl.indexOf("/bundle"));
	} else {
		adUrl = adUrl.substring((adUrl.indexOf("/") + 1), adUrl.indexOf("/req"));
	}
	
	//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> adUrl : " + adUrl);
	
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
			while ((inputLine = in.readLine()) != null){
				sb.append(inputLine);
			  //  strTotCont += inputLine+"\r\n";
			}
		} else {
			sb.append("");
		}
		in.close();

	} catch (MalformedURLException e) {
		e.printStackTrace();
	} catch (NullPointerException e) {
		e.printStackTrace();
	} finally {
	    if(yc != null) {
	    	yc.disconnect();
	    }
	    if(in != null) {
	    	in.close();
		}
	}
	
	/*******************************************************************************
		response 받은 JSON 값이 유효할 경우에만 FTP Upload 함.
	********************************************************************************/
	if (isJson) {
		//String strTopMenuFileName = "/was/lena/1.3/depot/lena-application/ROOT/jca/main/json/" + adUrl + ".json";
		String strTopMenuFileName = "C:\\www/json/" + adUrl + ".json";
	
		//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> strTopMenuFileName : " + strTopMenuFileName);
		
		OutputStream topMenuStream = new FileOutputStream(strTopMenuFileName, false);
		
		topMenuStream.write(sb.toString().getBytes("UTF-8"));
		topMenuStream.flush();
		topMenuStream.close();
	
		//올리기 전 Test
		uploadFile(adUrl + ".json","/was/lena/1.3/depot/lena-application/ROOT/jca/main/json/", "real");
		//uploadFile(adUrl + ".json","/was/lena/1.3/depot/lena-application/ROOT/jca/main/json/", "stage");

	}
}	// for문 End

JSONObject result = new JSONObject();

result.put("msg", "gnb ad banner ftp upload 성공");
result.put("result", true);

out.println(result.toString());

//System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake.jsp =====> END");

%>
<%!
static boolean uploadFile(String strFileName, String uploadDir, String serverType){
	ArrayList<String> ipList = new ArrayList<String>();

	if ("stage".equals(serverType)) {
	    //ipList.add("100.100.100.230");	// 구서버
	    //ipList.add("192.168.213.214");		// 신서버. 2017-08-17 부터.
	    //ipList.add("200.200.100.234");		// 신신서버. 2021-03-28 부터.
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
	
    String strTopMenuFileName = "C:\\www/json/";
    
    //System.out.println("[ftpGnbTopRight_JsonMake.jsp] 170 ~ 179 전송 시작");
    for(int i = 0; i<ipList.size() ;i++){
        try{
	        CommonFtp commonFtp = new CommonFtp((String)ipList.get(i),port,ftpId,ftpPw);
	        commonFtp.login();

	        if(!uploadDir.equals(""))
	            commonFtp.cd(uploadDir);
		        commonFtp.put(strFileName,strFileName,strTopMenuFileName);
		        commonFtp.disconnect();
		        
		        //System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> "+uploadDir+strFileName);
		        
        } catch(Exception e){
            System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> " + (String)ipList.get(i) + " : " + strFileName+ ":" + uploadDir +" 전송 실패"+e);
        }finally{

        }
    }
    //System.out.println(getCurrentTime() + "ftpGnbTopRight_JsonMake_2017.jsp =====> 170 ~ 179 전송 완료");
    return true;
}

static boolean uploadFile(String strFileName){
    return uploadFile(strFileName,"", "");
}

protected static String getCurrentTime() {
	long time = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
	String str = "[" + dayTime.format(new Date(time)) + "] ";
	
	return str;
}
%>