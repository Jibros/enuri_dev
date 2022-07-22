<%@ page contentType="text/json;charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.ParseException" %>
<%
/******************************************
	title : app용 LP 플러스링크 api
	auth : 2016-11-15 diana
	info : 손진욱팀장 요청 
******************************************/
String strEdReqUrl = "";																							//실제 넘겨줄 
String isAdult = ChkNull.chkStr(request.getParameter("adult"),"");									//성인여부 (app에서 파라메터처리
String strLp_Srp = ChkNull.chkStr(request.getParameter("lpsrp"),"list.jsp");						//list.jsp: LP, search.jsp : SRP
String strEdUserIp = ChkNull.chkStr(request.getParameter("adid"),"");							//웹 & PC 는 ip를 사용하나 , app에서는 adid 사용 (20자리 짤라서처리)
String strEdShopImg = ConfigManager.IMG_ENURI_COM;
String strCate = ChkNull.chkStr(request.getParameter("cate"),"");									//현재 카테고리
String strKeyword  = ChkNull.chkStr(request.getParameter("keyword"),"");						//검색어
String strCatekeyword  = ChkNull.chkStr(request.getParameter("catekeyword"),"");			//분류검색어로 검색페이지에서 넘어왔을때도 cpc 검색 로직을 태움
String strAppyn  = ChkNull.chkStr(request.getParameter("appyn"),"N");							//검색어

String strEdkeyword = "";																						//실제 넘길 키워드

if(strLp_Srp.equals("search.jsp") && strKeyword != null && !strKeyword.equals("") ){											//search/EnuriSearch.jsp 용 키워드 값  : 일반적인 검색일때
	strEdkeyword = strKeyword;
}else if(strLp_Srp.equals("list.jsp") && !strCatekeyword.equals("")){									//search/EnuriSearch.jsp 용 키워드 값  : 분류검색어로 검색페이지에서 넘어왔을때도 cpc 검색 로직을 태움
	strEdkeyword = strCatekeyword;
}

if(!strEdUserIp.equals("") && strEdUserIp.length() > 20){
	strEdUserIp = strEdUserIp.substring(0,20);
}

//운영서버 체크 위한 구문
String  strEdIsReal = ChkNull.chkStr(request.getParameter("isreal"),"false");							//실서버 : true, 테스트 : false;
boolean blEdIsReal = false;

if(strEdIsReal.equals("true")){
	blEdIsReal = true;
}


String strQuery = "";														// 광고요청 키워드 or 카테고리  (UTF-8 Encoding 필수)
String strChannelId = "";												// 광고노출 매체 및 광고노출 페이지를 구별하기 위한 ID 
int intStartRank = 1;														// 광고목록의 시작 순위 
int intMaxCount = 4;														// 필요한 광고 갯수. 광고슬롯갯수만큼만 호출	
String strServerUrl = "http://m.enuri.com/" +strLp_Srp;	// 광고노출 페이지의 URL (UTF-8 Encoding 필수) - 노출대비 클릭 수 확인 위해 필요
String strUserIp = strEdUserIp;										// 사용자 IP (Encoding 불필요)
String strReturnType = "json";										// 광고노출 작업을 위한 리턴 타입 (json)
String strAdType = "";													// 광고요청 분류 srp, lp (SRP일 경우 keyword, LP일 경우 category)
String strDeviceType = "MOBILE";									// 광고요청 디바이스 (pc/mobile)
String strIsRecevieAdultInfo = "N";									// 광고 요청 시 성인 상품을 포함해서 받을 것인지 제외시키고 받을 것인지를 구분 default=N (로그인 후 인증 받았을 경우만 Y)
	
/**********************************
	EDPlatform ChannelID Protocol 
		D001001001 : SRP - 키워드 검색을 통해 검색 함
		D001002001 : LP  - GNB 카테고리 분류를 클릭하여 검색 함.
**********************************/
//LP 또는 SRP에서 받아온 키워드 또는 카테고리 쿼리 값을 넣어 준다.
	
if (strEdkeyword != null && !strEdkeyword.equals("")) {
	strQuery = java.net.URLEncoder.encode(strEdkeyword);
	strAdType = "SRP"; 
} else { 
	strQuery = strCate;
	strAdType = "LP";
}
	
if(strAppyn.equals("Y")){				//앱일때
	if (strLp_Srp.equals("list.jsp")) {   
		if(strAdType == "LP"){
			strChannelId = "E001004001";
		}else if(strAdType == "SRP"){
			 strChannelId = "E001004002";
		}
	}else if(strLp_Srp.indexOf("search.jsp") > -1) {   
		strChannelId = "E001005001"; 
	} 
}else{									//웹일때
	if (strLp_Srp.indexOf("list.jsp") > -1) {   
		if(strAdType == "LP"){
			strChannelId = "E001004003";
		}else if(strAdType == "SRP"){ 
			strChannelId = "E001004004";
		}
	}else  if (strLp_Srp.indexOf("search.jsp") > -1) {   
		strChannelId = "E001005002"; 
	} 		  
} 
	 
//운영서버일 경우와 테스트 서버일 경우 분리
if (blEdIsReal) {    
	strEdReqUrl = strEdReqUrl + "http://display.cpcad.enuri.com/adReq?";		//운영
} else {  
	strEdReqUrl = strEdReqUrl + "http://display.cpcad.enuri.com/adReq?";
}    
	   
/********************************** 
	DeviceType이 MOBILE 인 경우 DeviceType 변경
	DeviceType의 Default 값은 PC 임.
 **********************************/
strDeviceType = "MOBILE"; 
	
/**********************************
	성인 상품 정보를 가져오기 위한 로그인 및 인증 검사
	Default 값은 N 이며, 에누리 로그인 및 본인인증 받는 
	사용자만 성인 상품 정보를 받을 수 있음.
 **********************************/
if(isAdult.equals("1")) { 
	strIsRecevieAdultInfo = "Y";
}
	
strEdReqUrl = strEdReqUrl + "query="+strQuery;
strEdReqUrl = strEdReqUrl + "&channelId="+strChannelId;
strEdReqUrl = strEdReqUrl + "&startRank="+intStartRank;
strEdReqUrl = strEdReqUrl + "&maxCount="+intMaxCount;
strEdReqUrl = strEdReqUrl + "&serverUrl="+java.net.URLEncoder.encode(strServerUrl);
strEdReqUrl = strEdReqUrl + "&userIp="+strUserIp;
strEdReqUrl = strEdReqUrl + "&returnType="+strReturnType;
strEdReqUrl = strEdReqUrl + "&adType="+strAdType;
strEdReqUrl = strEdReqUrl + "&deviceType="+strDeviceType;
strEdReqUrl = strEdReqUrl + "&isRecevieAdultInfo="+strIsRecevieAdultInfo;
	
//실행부분
int timeout = 5000;	//timeout 2초 설정 : 2초 이후 Connection 끊어버림.
 
URL u = new URL(strEdReqUrl);
HttpURLConnection c = (HttpURLConnection) u.openConnection();
c.setRequestMethod("GET");
c.setRequestProperty("Content-length", "0");
c.setUseCaches(false); 
c.setAllowUserInteraction(false);
c.setConnectTimeout(timeout);
c.setReadTimeout(timeout);
c.connect();
 
int status = c.getResponseCode();

BufferedReader br = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
StringBuilder sb = new StringBuilder();
String line;
 
while ((line = br.readLine()) != null) {
    sb.append(line);
}
br.close();
out.print(sb);
%>
