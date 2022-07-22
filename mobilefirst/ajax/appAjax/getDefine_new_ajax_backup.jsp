<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");

	String os;
	//System.out.println("start");
	if (ver==null) ver = "0.0.0";
	//System.out.println("ver "+ver);

	int version = 0;
	if(ver.length()>=5) {
		try {
			version = Integer.parseInt(ver.substring(0, 1)) * 100 + Integer.parseInt(ver.substring(2, 3)) * 10 + Integer.parseInt(ver.substring(4, 5));
		} catch(Exception e) {}
	}


	if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") > -1 )
	{ 
		os="aos";
	}else{
		os="ios";
	}

	JSONObject jsonObject = new JSONObject();

	String ifdomain = "enuri.com/mobilefirst";

	JSONObject temp1 = new JSONObject();

	temp1.put("OUTLINKURL",	"enuri.com/mobilefirst;http://enuri.sweettracker.net;enuri.com/deal/mobile/;/mobiledepart;enuri.com/mobilenew");
	temp1.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
	temp1.put("IF_DOMAIN", ifdomain);
	temp1.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
	temp1.put("IF_MAIN_URL2", "enuri.com/mobilefirst/Index.jsp");
	temp1.put("IF_BIG_IMAGE_URL", "enuri.com/mobilefirst/detailBigImage.jsp");

	temp1.put("IF_LOGIN_URL", ifdomain + "/login/");
	temp1.put("IF_LOGIN_URL2", "enuri.com/mobilenew/login/");
	temp1.put("IF_SOCIAL_URL", "enuri.com/deal/mobile/main.deal");
	temp1.put("IF_SOCIAL_DETAIL_URL",	"enuri.com/deal/mobile/goods.deal"); 
	temp1.put("IF_DEPARTMENT_LINK", "enuri.com/mobiledepart/Index.jsp");
	temp1.put("IF_DEPARTMENT_DETAILPAGE",	"enuri.com/mobiledepart/detail.jsp");
	temp1.put("IF_DETAIL_URL", "enuri.com/mobilefirst/detail.jsp?modelno=");
	temp1.put("IF_ETC_URL", "enuri.com/mobilefirst/event/eventWonList.jsp;enuri.com/mobilefirst/event/eventWonView.jsp");
	temp1.put("IF_LIST_URL", "enuri.com/mobilefirst/list.jsp");
	temp1.put("IF_SEARCH_URL", "enuri.com/mobilefirst/search.jsp");
	temp1.put("IF_NICE", "https://nice.checkplus.co.kr");
	temp1.put("IF_NEWS_DETAIL", "enuri.com/mobilefirst/news_detail.jsp");
	temp1.put("IF_EVENT_GO", "enurievent=Y");

	temp1.put("GO_INTENT", "androidgo");
	temp1.put("GO_CLOSE", "close://");
	temp1.put("GO_SHARE", "shareintent://");
	temp1.put("GO_EVENTDETAIL_KEYWORD", "eventdetailurl://");
	temp1.put("INTENT_PROTOCOL_START", "intent:");
	temp1.put("INTENT_PROTOCOL_INTENT", "#Intent;");
	temp1.put("INTENT_PROTOCOL_EN", ";end;");
	temp1.put("GOOGLE_PLAY_STORE_PREFIX", "market://details?id=");
	temp1.put("SHARE_TEXT", "sharetext:");
	temp1.put("SHARE_TEXT_TITLE", "공유");
	temp1.put("SHARE_TYPE", "text/plain");
	
	temp1.put("SWEETTRACKER_PACKAGE", "com.sweettracker.smartparcel");
	temp1.put("SWEETTRACKER_MARKET", "market://details?id=com.sweettracker.smartparcel");
	temp1.put("ZZIM_LIST_SPLIT", "ENURI");
	temp1.put("DETAIL_VIEWPORT", "");
	temp1.put("CATEGORY_MISE_ICON", "@");
	temp1.put("ENURI_GATE", "freetoken");
	temp1.put("ENURI_GETMOBILE", "enuri.com/mobilefirst/move.jsp");

	temp1.put("VIP_BACK", "N");
	temp1.put("LP_BACK", "Y");
	temp1.put("BROWSER_OUT", "http&https&intent&enuri&eventdetailurl&shareintent");
	temp1.put("REWARDMSG", "전송에 실패 했습니다.\n재전송 하시겠습니까?");
	temp1.put("REWARDCODEFAIL", "결제 번호 가져오기 실패");
	
	// IOS에서 쿠키를 찾기 위해 사용하는 문자열
	// 쿠키를 원데이터로 읽으면 name, value가 서로 분리되어있는데 합쳐서 검색이 편하도록 하기 위해
	temp1.put("IOS_COOKIE_FIND_STR1", "\" value:\"");
	temp1.put("IOS_COOKIE_FIND_STR2", " value:\"=-=\" "); // 쿠키의 value값을 찾는 정규식
	temp1.put("ICONURL","http://img.enuri.info/images/mobilefirst/browser/marketicon/");
	
	temp1.put("EB_USE", true);//에누리 브라우져 사용 여부 
	temp1.put("ISP_SCHEME", "ispmobile://?TID="); // 에누리 브라우저에서 ISP결제시 URL체크
	temp1.put("IOS_LOGIN_LIMITE", "10"); // ajax로만 동작하는 쇼핑몰에서는 로그아웃을 확인하기가 힘듬, 따라서 타임아웃으로 결정함
	temp1.put("IOS_LOGOUT_LOGIN_INFO_DEL", "Y"); // IOS에서 로그아웃 할때 쇼핑몰들의 로그인 정보를 삭제할지를 결정하는 플래그 Y:삭제
	temp1.put("LOGOUT_ALERT", "아이디"); // 
	temp1.put("COMFAIL","자동로그인&자동 로그인&아이디 찾기&비밀번호가 일치하지&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정&http%3A%2F%2Fmember.auction.co.kr%2FAuthenticate%2F%3Freturn_value%3D-1&loginResult('01'");//에누리 브라우져 사용 여부
	temp1.put("COMFAIL_IOS","document.getElementById('divMessageForInvalidPWD').textContent&document.getElementById('layerPopup').getElementsByClassName('login_layer')[0].textContent&다시 입력해주세요.&document.getElementById('webkit-xml-viewer-source-xml').textContent");//쇼핑몰 로그인 체크 ios

	// 마이페이지 리워드 관련 옵션
	temp1.put("REWARD_SHOW_AND_FLAG", "Y"); // AND 마이페이지에서 리워드정보를 보여줄지  
	temp1.put("REWARD_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지  
	temp1.put("REWARD_GUIDE_FLAG", "Y"); // 리워드 가이드를 보여줄지
	temp1.put("REWARD_BANNER_URL", "http://img.enuri.info/images/mobilefirst/reward/mobile/reward_off_banner");
	temp1.put("REWARD_BANNER_LINK_URL","/mobilefirst/event/benefit.jsp");//ios 마이메뉴 , 누파리 자세히보기 3.0.1까지 이렇게 되고 이후로는 and와 맞춤 // and 마이메뉴 링크
	temp1.put("REWARD_DETAIL_INFO_LINK", "http://m.enuri.com/mobilefirst/event/benefit.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크
	temp1.put("REWARD_INFO_TEXT1", "라면쿠폰\n교환권"); 
	temp1.put("REWARD_INFO_TEXT2", "지급예정\n교환권"); 
	temp1.put("REWARD_INSERT_AND_FLAG", "Y"); // 리워드 저장을 할 것인지를 확인함
	temp1.put("REWARD_INSERT_IOS_FLAG", "Y"); // 리워드 저장을 할 것인지를 확인함

	// 리워드인 상품은 누파리에서 문구 보여주기"
	temp1.put("REWARD_DETAIL_INFO_SHOW", "Y"); // 누파리의 상품창에서 리워드 관련 문구 보여줄지
	temp1.put("REWARD_DETAIL_INFO_HIGHLIGHT", "e머니"); // 적립대상 url이 아닐 경우
	temp1.put("REWARD_DETAIL_INFO_TEXT1", "구매 후 생활혜택 e머니 적립받는 방법"); // 1. 비로그인 상태 / 적립 가능 쇼핑몰
	temp1.put("REWARD_DETAIL_INFO_TEXT2", "생활혜택 e머니를 받을 수 있습니다."); // 3. 로그인 상태 /적립 가능 쇼핑몰 /적립군X
	temp1.put("REWARD_DETAIL_INFO_TEXT3", "생활혜택 e머니를 받을 수 있습니다."); // 4. 로그인 상태 /적립 가능 쇼핑몰 /적립군O
	// 2. 비로그인 상태 / 적립 불가 쇼핑몰
	// 5. 로그인 상태 / 적립 불가 쇼핑몰 / 적립군X
	// 6. 로그인 상태 / 적립 불가 쇼핑몰 / 적립군O
	temp1.put("REWARD_DETAIL_INFO_TEXT4", "라면 적립 쇼핑몰이 아닙니다.");
	
	
	// 로그인 url
	temp1.put("SERVER_LOGINURL", "/mobilefirst/login/login.jsp?app=Y&backUrl=");

	temp1.put("NUFARI_LOGIN_OK_INFO","에누리 로그인 중입니다.");
	temp1.put("NUFARI_LOGIN_SUGGESTION_INFO","에누리 로그인을 하신 후 '쇼핑몰 연결' 서비스를 사용해 보세요.");
	temp1.put("NUFARI_OUTLINK_INFO","ISP, 결제오류 시 다른브라우저를 이용해보세요");
	temp1.put("NUFARI_INFO_DELAY","10");//값 * 하루 .... 0보다 작으면 안띄움
	
	
	temp1.put("REVIEW_SIZE","100");

//안드로이드 아이폰 3.0.4 버젼 부터 이머니 적용됨
	temp1.put("EMONEY_GUIDE","Y");
	temp1.put("EMONEY_SHOW_AND_FLAG", "Y"); // AND 마이페이지에서 리워드정보를 보여줄지  
	temp1.put("EMONEY_SHOW_IOS_FLAG", "Y"); // IOS 마이페이지에서 리워드정보를 보여줄지  
	temp1.put("EMONEY_INSERT_AND_FLAG","Y");
	temp1.put("EMONEY_STORE","/mobilefirst/emoney/emoney_store.jsp");
	temp1.put("EMONEY_HISTORY","/mobilefirst/emoney/emoney.jsp");
	temp1.put("EMONEY_DETAIL_INFO_SHOW", "Y");
	temp1.put("EMONEY_DETAIL_INFO_HIGHLIGHT", "e머니"); // 하이라이트 
	temp1.put("EMONEY_DETAIL_INFO_POINT_OK", "생활혜택 e머니를 받을 수 있습니다.;혜택받기 >"); // 로그인 > 적립가능 쇼핑몰
	temp1.put("EMONEY_DETAIL_INFO_POINT_NO", "생활혜택 e머니 적립 쇼핑몰이 아닙니다.;적립받기 >"); // 로그인 > 적립불가 쇼핑몰 
	temp1.put("EMONEY_DETAIL_INFO_LOGIN", "구매 후 생활혜택 e머니 적립받는 방법;자세히보기 >"); // 로그인 없이 쇼핑몰 접속 
	temp1.put("EMONEY_DETAIL_INFO_LINK", "http://m.enuri.com/mobilefirst/event/benefit.jsp?freetoken=event&app=Y"); // and 자세히 보기 링크
	/*
	http://img.enuri.info
	 
	/images/mobilefirst/extra_tab/adtab/adtab1_on_ios6p.png
	/images/mobilefirst/extra_tab/adtab/adtab1_on_ios6.png
	/images/mobilefirst/extra_tab/adtab/adtab1_off_ios6p.png
	/images/mobilefirst/extra_tab/adtab/adtab1_off_ios6.png
	/images/mobilefirst/extra_tab/adtab/adtab1_on_aos_xhdpi.png
	/images/mobilefirst/extra_tab/adtab/adtab1_of_aos_xxhdpi.png
	*/

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 안드로이드 신용카드 결제 처리 시작
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	HashMap<String, JSONObject> cdh = new HashMap<String, JSONObject>();
	String[] cardDataList = { "hdcard", "mpocket", "lotte", "smshin", "kb-acp", "hanaansim", "shinhan-sr", "ispmobile" };

	for(int i=0; i<cardDataList.length; i++) {
		JSONObject cardData = new JSONObject();

		cdh.put(cardDataList[i], cardData);
	}

	// 패키지명 : i  입력
	cdh.get("hdcard").put("i", "hdcardappcardansimclick");
	cdh.get("mpocket").put("i", "mpocket.online.ansimclic");
	cdh.get("lotte").put("i", "lottesmartpay");
	cdh.get("smshin").put("i", "smshinhanansimclick");
	cdh.get("kb-acp").put("i", "kb-acp");
	cdh.get("hanaansim").put("i", "hanaansim");
	cdh.get("shinhan-sr").put("i", "shinhan-sr-ansimclick");
	cdh.get("ispmobile").put("i", "ispmobile");
	// 마켓스킴URL : m 입력
	cdh.get("hdcard").put("m", "market://details?id=com.hyundaicard.appcard");
	cdh.get("mpocket").put("m", "market://details?id=kr.co.samsungcard.mpocket");
	cdh.get("lotte").put("m", "market://details?id=com.lotte.lottesmartpay");
	cdh.get("smshin").put("m", "market://details?id=com.shcard.smartpay");
	cdh.get("kb-acp").put("m", "market://details?id=com.kbcard.cxh.appcard");
	cdh.get("hanaansim").put("m", "market://details?id=com.ilk.visa3d");
	cdh.get("shinhan-sr").put("m", "market://details?id=com.shcard.smartpay");//여기 수정 필요!!2014.04.01
	cdh.get("ispmobile").put("m", "http://mobile.vpay.co.kr/jsp/MISP/andown.jsp");//여기 수정 필요!!2014.04.01

	// 카드 json에 입력
	JSONArray arrCardData = new JSONArray();
	for(int i=0; i<cardDataList.length; i++) {
		arrCardData.put(cdh.get(cardDataList[i]));
	}
	temp1.put("CARDDATAS", arrCardData);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 안드로이드 신용카드 결제 처리 끝
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 


	////////////////////////////////////////////////////////
	int Hex_IDINPUT 	= 0X00000000;
	int Hex_EMAILINPUT 	= 0X00010000;
	
	int Hex_LOGINDELAY_1 	= 0X0000003C;
	int Hex_LOGINDELAY_3 	= 0X000000B4;
	int Hex_LOGINDELAY_2 	= 0X00000078;
	int Hex_LOGINDELAY_6 	= 0X00000168;
	int Hex_LOGINDELAY_12 	= 0X000002D0;

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 사이트 관련 정보 넣기 시작
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	HashMap<String, JSONObject> sil = new HashMap<String, JSONObject>();
	String[] siteNameList = { "11st", "gmarket", "g9", "auction", "interpark", ".emart", "shinsegaemall", "ssg", "gsshop", "wemakeprice", "ticketmonster", "cjmall", "hyundaihmall", "akmall", "e-himart", 
						"galleria", "okmall", ".nsmall.com", "homeplus", "lottemart", ".lotte.com", "lotteimall", "ellotte", "hnsmall", "coupang" };

	for(int i=0; i<siteNameList.length; i++) {
		JSONObject cardData = new JSONObject();

		sil.put(siteNameList[i], cardData);
	}

	// 사이트 아이디 입력 : [n]
	for(int i=0; i<siteNameList.length; i++) {
		sil.get(siteNameList[i]).put("n", siteNameList[i]);
	}

	// 아이콘 입력 : [ic]
	
	sil.get("11st").put("ic","app_icon_11st");
	sil.get("gmarket").put("ic","app_icon_gmarket");
	sil.get("g9").put("ic","");
	sil.get("auction").put("ic","app_icon_auction_new");
	sil.get("interpark").put("ic","app_icon_interpark");
	sil.get(".emart").put("ic","app_icon_emart");
	sil.get("shinsegaemall").put("ic","app_icon_shinsegaemall");
	sil.get("ssg").put("ic","app_icon_ssg");
	sil.get("gsshop").put("ic","");
	sil.get("wemakeprice").put("ic","app_icon_wemakeprice1015");
	sil.get("ticketmonster").put("ic","app_icon_ticketmonster");
	
	//ios 3.0.4 에서는 빠져야 된다 이전 버젼에서는 자동 로그인이 안되는데 리워드 때문에 넣어 둔것 
	//
	//
	// if( ChkNull.chkStr(os).indexOf("ios") > -1 )
	// {
	// 	if(version>=304)	
	// 		sil.get("cjmall").put("ic","");
	// 	else 
	// 		sil.get("cjmall").put("ic","app_icon_cjmall");
	// }
	// else 
	sil.get("cjmall").put("ic","app_icon_cjmall");
	
	sil.get("hyundaihmall").put("ic","");
	sil.get("akmall").put("ic","");
	sil.get("e-himart").put("ic","");
	sil.get("galleria").put("ic","");
	sil.get("okmall").put("ic","");
	sil.get(".nsmall.com").put("ic","");
	sil.get("homeplus").put("ic","");
	sil.get("lottemart").put("ic","");
	sil.get(".lotte.com").put("ic","app_icon_lottecom_new");
	sil.get("lotteimall").put("ic","");//app_icon_lotteimall_new
	sil.get("ellotte").put("ic","app_icon_ellotte_new");
	sil.get("hnsmall").put("ic","");
	sil.get("coupang").put("ic","");

	// 이름 입력 : [t]
	sil.get("11st").put("t", "11번가");
	sil.get("gmarket").put("t", "G마켓");
	sil.get("g9").put("t", "G9");
	sil.get("auction").put("t", "옥션");
	sil.get("interpark").put("t", "인터파크");
	sil.get(".emart").put("t", "이마트");
	sil.get("shinsegaemall").put("t", "신세계몰");
	sil.get("ssg").put("t", "SSG.COM");
	sil.get("gsshop").put("t", "GS쇼핑");
	sil.get("wemakeprice").put("t", "위메프");
	sil.get("ticketmonster").put("t", "티켓몬스터");
	sil.get("cjmall").put("t", "CJ몰");
	sil.get("hyundaihmall").put("t", "현대아이몰");
	sil.get("akmall").put("t", "AK몰");
	sil.get("e-himart").put("t", "하이마트");
	sil.get("galleria").put("t", "겔러리아");
	sil.get("okmall").put("t", "OKMALL");
	sil.get(".nsmall.com").put("t", "ns홈쇼핑");
	sil.get("homeplus").put("t", "홈플러스");
	sil.get("lottemart").put("t", "롯데마트");
	sil.get(".lotte.com").put("t", "롯데닷컴");
	sil.get("lotteimall").put("t", "롯데아이몰");
	sil.get("ellotte").put("t", "엘롯데");
	sil.get("hnsmall").put("t", "홈엔쇼핑");
	sil.get("coupang").put("t", "쿠팡");
	
	// URL입력 : [m]
	sil.get("11st").put("m", "http://m.11st.co.kr/MW/html/main.html");
	sil.get("gmarket").put("m", "http://mobile.gmarket.co.kr/");
	sil.get("g9").put("m", "http://m.g9.co.kr/");
	sil.get("auction").put("m", "http://mobile.auction.co.kr/");
	sil.get("interpark").put("m", "http://m.interpark.com/");
	sil.get(".emart").put("m","http://m.emart.ssg.com/");
	sil.get("shinsegaemall").put("m","http://m.shinsegaemall.ssg.com/mall/main.ssg");
	sil.get("ssg").put("m", "http://m.ssg.com/");
	sil.get("gsshop").put("m","http://m.gsshop.com/");
	sil.get("wemakeprice").put("m","http://m.wemakeprice.com/");
	sil.get("ticketmonster").put("m","http://m.ticketmonster.co.kr/");
	sil.get("cjmall").put("m","https://mw.cjmall.com/m/main.jsp");
	sil.get("hyundaihmall").put("m","http://m.hyundaihmall.com/");
	sil.get("akmall").put("m","http://m.akmall.com/");
	sil.get("e-himart").put("m","http://m.e-himart.co.kr/");
	sil.get("galleria").put("m","http://mobile.galleria.co.kr");
	sil.get(".nsmall.com").put("m", "http://m.nsmall.com");
	sil.get("homeplus").put("m","http://m.homeplus.co.kr/");
	sil.get("lottemart").put("m","http://m.lottemart.com");
	sil.get(".lotte.com").put("m","http://m.lotte.com");
	sil.get("lotteimall").put("m","http://m.lotteimall.com/main/viewMain.lotte");
	sil.get("ellotte").put("m","http://m.ellotte.com/");
	sil.get("hnsmall").put("m","http://m.hnsmall.com");
	sil.get("coupang").put("m","http://m.coupang.com/nm/");

	// 로그인 페이지 입력 : [l]
	sil.get("11st").put("l", "https://m.11st.co.kr/MW/Login/login.tmall?returnURL=&method=Xsite&tid=1000997249");
	sil.get("gmarket").put("l", "http://mobile.gmarket.co.kr/Login/Login?URL=");
	sil.get("g9").put("l", "https://mssl.g9.co.kr/Member.htm#/Member/Login");
	sil.get("auction").put("l","http://member.auction.co.kr/Authenticate/m/?url=");
	sil.get("interpark").put("l", "https://m.interpark.com/auth/login.html");
	sil.get(".emart").put("l","https://member.ssg.com/m/member/login.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com%2Fmain.ssg&t=login");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("shinsegaemall").put("l","https://member.ssg.com/m/member/login.ssg?shinsegaemall=");//http%3A%2F%2Fm.shinsegaemall.ssg.com%2Fmall%2Fmain.ssg&t=login");
	sil.get("ssg").put("l",	"https://member.ssg.com/m/member/login.ssg?retURL=");//http%3A%2F%2Fm.ssg.com%2F&t=login");
	sil.get("gsshop").put("l","http://m.gsshop.com/member/logIn.gs");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("wemakeprice").put("l","https://member.wemakeprice.com/m/member/login/");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("ticketmonster").put("l","https://m.ticketmonster.co.kr/user/loginForm");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("cjmall").put("l","https://mw.cjmall.com/m/member/loginView.jsp");
	sil.get("hyundaihmall").put("l","https://m.hyundaihmall.com/front/smLoginF.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("akmall").put("l","https://m.akmall.com/login/Login.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("e-himart").put("l","https://m.e-himart.co.kr/login.hmt?page=myHimart");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("galleria").put("l","");
	sil.get("okmall").put("l","");
	sil.get(".nsmall.com").put("l", "http://m.nsmall.com/MemberLogin");
	sil.get("homeplus").put("l","http://m.homeplus.co.kr/identity/login.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("lottemart").put("l","");
	sil.get(".lotte.com").put("l","https://m.lotte.com/login/m/loginForm.do?c=mlotte&udid=&v=&cn=&cdn=&tclick=m_footer_log&targetUrl=");//http%3A%2F%2Fm.lotte.com%2Fmain_phone.do");
	sil.get("lotteimall").put("l","https://securem.lotteimall.com/member/login/forward.LCLoginMem.lotte");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("ellotte").put("l","https://m.ellotte.com/login/m/loginForm.do");
	sil.get("hnsmall").put("l","https://m.hnsmall.com/customer/login");//http%3A%2F%2Fm.wemakeprice.com%2F");
	sil.get("coupang").put("l","https://login.coupang.com/login/m/login.pang?rtnUrl=");//http%3A%2F%2Fm.coupang.com%2Fm%2Fmy.pang");

	// 로그인페이지에서 로그인 하는 스크립트 : [i]
	sil.get("11st").put("i", "$('#userId').val('[[id]]');$('#userPw').val('[[pwd]]');$('#alg').prop('checked',true);$('#loginButton').click();");	
	sil.get("gmarket").put("i", "$('#id').val('[[id]]');$('#pwd').val('[[pwd]]');$('.lgs').click();");	
	sil.get("g9").put("i", "$('#LoginID').val('[[id]]');$('#Password').val('[[pwd]]');$('.lgs').click();");	
	sil.get("auction").put("i", "$('#id').val('[[id]]');$('#password').val('[[pwd]]');$('#Form4').submit();");
	sil.get("interpark").put("i", "$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$('.btn_login').click();");
	sil.get(".emart").put("i","$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('#login_form').submit();");
	sil.get("shinsegaemall").put("i","$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();"); 
	sil.get("ssg").put("i", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
	sil.get("gsshop").put("i","$('#id').val('[[id]]');$('#passwd').val('[[pwd]]');$('#btnLogin').click();");
	sil.get("wemakeprice").put("i","$('#login_uid').val('[[id]]');$('#login_upw').val('[[pwd]]');$('#login_confirm_btn').click();");				   
	sil.get("ticketmonster").put("i","$('#user_id').val('[[id]]');$('#user_pw').val('[[pwd]]');$('form').submit();");
	sil.get("cjmall").put("i","$('#member_id').val('[[id]]');$('#pwd').val('[[pwd]]');loginSubmit();"); 
	sil.get("hyundaihmall").put("i","$(\"input[name='userid']\").val('[[id]]');$(\"input[name='password']\").val('[[pwd]]');$('#loginCheck').click();");
	sil.get("akmall").put("i","$('#cust_id').val('[[id]]');$('#upw').val('[[pwd]]');$(\"form[name='memberFrm']\").submit();");
	sil.get("e-himart").put("i","");
	sil.get("galleria").put("i","");
	sil.get("okmall").put("i","");
	sil.get(".nsmall.com").put("i", "$('#txtUserId').val('[[id]]');$('#txtPassword').val('[[pwd]]');$('#btnLogin').click();");	
	sil.get("homeplus").put("i","$('#login_id').val('[[id]]');$('#user_passwd').val('[[pwd]]');identity.login();");
	sil.get("lottemart").put("i","");
	sil.get(".lotte.com").put("i","$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
	sil.get("lotteimall").put("i","$('#login_id').val('[[id]]');$('#password').val('[[pwd]]');$('.btn_login').click();");
	// sil.get("ellotte").put("i","$('#userId').val('[[id]]');$('#password').val('[[pwd]]');checkLogin('N');");
	// 
	// 
	// $('#userIdEasy').val('[[id]]');$('#userPwEasy').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');
	// 
	// 
	sil.get("ellotte").put("i","$('#userId').val('[[id]]');$('#lPointPw').val('[[pwd]]');angular.element('[ng-click]').scope().checkLogin('N');");
	sil.get("hnsmall").put("i","$(\"input[name='mem_id']\").val('[[id]]');$(\"input[name='mem_pw']\").val('[[pwd]]');login(document.loginForm);");
	sil.get("coupang").put("i","$('#login-tf-email').val('[[id]]');$('#login-tf-password').val('[[pwd]]');$('#loginForm').submit();");

	// 쇼핑몰 홈(수익코드 붙음) :	[h]
	sil.get("11st").put("h","http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249");
	sil.get("gmarket").put("h","http://www.gmarket.co.kr/index.asp?jaehuid=200006254");
	sil.get("g9").put("h","http://m.g9.co.kr/");
	sil.get("auction").put("h","http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187");
	sil.get("interpark").put("h","http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com");
	sil.get(".emart").put("h","http://m.emart.ssg.com/planshop/planShopBest.ssg?ckwhere=m_enuri");
	sil.get("shinsegaemall").put("h","http://m.shinsegaemall.ssg.com/mall/main.ssg?ckwhere=s_enuri");
	sil.get("ssg").put("h","http://m.ssg.com/?ckwhere=s_enuri");
	sil.get("gsshop").put("h","http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?media=Pg&gourl=http://m.gsshop.com");
	sil.get("wemakeprice").put("h","http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af" );
	sil.get("ticketmonster").put("h","http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285");
	sil.get("cjmall").put("h","http://mw.cjmall.com/m/main.jsp?app_cd=ENURI");
	sil.get("hyundaihmall").put("h","http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html");
	sil.get("akmall").put("h","http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392");
	sil.get("e-himart").put("h","");
	sil.get("galleria").put("h","");
	sil.get("okmall").put("h","");
	sil.get(".nsmall.com").put("h","");
	sil.get("homeplus").put("h","http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56080&nextUrl=http://www.homeplus.co.kr");
	sil.get("lottemart").put("h","");
	sil.get(".lotte.com").put("h","http://m.lotte.com/main_phone.do?udid=&cn=112346&cdn=783491");
	sil.get("lotteimall").put("h","http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476");
	sil.get("ellotte").put("h","http://m.ellotte.com/main.do?&cn=153348&cdn=2942692");
	sil.get("hnsmall").put("h","http://m.hnsmall.com/channel/gate?channel_code=20200");
	sil.get("coupang").put("h","http://m.coupang.com/nm/");
	
	
	//////////////////////////////////////////
	



	//sil.get("11st").put("redirect","[{\"type\":\"e\",\"url\":\"http://m.11st.co.kr/MW\"}]");//X
	sil.get("11st").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.11st.co.kr/MW\",\"h\":[{\"hurl\":\"http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249\"},{\"hurl\":\"http://m.11st.co.kr/\"},{\"hurl\":\"http://m.11st.co.kr/MW\"},{\"hurl\":\"http://m.11st.co.kr/MW/\"},{\"hurl\":\"http://m.11st.co.kr/MW/index.html\"}]}]");//X
	sil.get("gmarket").put("redirect","[{\"t\":\"c\",\"url\":\"http://mobile.gmarket.co.kr/?pCache=\"},{\"t\":\"e\",\"url\":\"http://sna.gmarket.co.kr/?cc=CHD0B001&url=http://www.gmarket.co.kr/\"}]");
	sil.get("g9").put("redirect","");
	//sil.get("auction").put("redirect","[{\"t\":\"e\",\"url\":\"http://mobile.auction.co.kr/HomeMain\"}]");
	sil.get("auction").put("redirect","[{\"t\":\"e\",\"url\":\"\"}]");
	sil.get("interpark").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shop.interpark.com/#mwm1=common&mwm2=header&mwm3=bi\"}]");
	sil.get(".emart").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.emart.ssg.com/\"}]");
	sil.get("shinsegaemall").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shinsegaemall.ssg.com/mall/main.ssg\"}]");
	sil.get("ssg").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ssg.com/\"}]");
	// sil.get("gsshop").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.gsshop.com/index.gs\"}]");
	sil.get("gsshop").put("redirect","");
	sil.get("wemakeprice").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.wemakeprice.com/m/\"}]");
	sil.get("ticketmonster").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ticketmonster.co.kr/\"}]");
	// sil.get("cjmall").put("redirect","[{\"t\":\"c\",\"url\":\"http://mw.cjmall.com/m/main.jsp\",\"pv\":[{\"p\":\"app_cd\",\"v\":\"ENURI\"}]}]");
	sil.get("cjmall").put("redirect","");
	sil.get("hyundaihmall").put("redirect","");
	sil.get("akmall").put("redirect","");
	sil.get("e-himart").put("redirect","");
	sil.get("galleria").put("redirect","");
	sil.get("okmall").put("redirect","");
	sil.get(".nsmall.com").put("redirect","");
	sil.get("homeplus").put("redirect","[{\"t\":\"c\",\"url\":\"http://mdirect.homeplus.co.kr/front.app.exhibition.main.Main.ghs\",\"pv\":[{\"p\":\"extends_id\",\"v\":\"enuri\"}]}]");
	sil.get("lottemart").put("redirect","");
	sil.get(".lotte.com").put("redirect","[{\"t\":\"c\",\"url\":\"http://m.lotte.com/main_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"112346\"},{\"p\":\"cdn\",\"v\":\"783491\"}]}]");
	sil.get("lotteimall").put("redirect","");
	sil.get("ellotte").put("redirect","[{\"t\":\"c\",\"url\":\"http://m.ellotte.com/main_ellotte_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"153348\"},{\"p\":\"cdn\",\"v\":\"2942692\"}]}]");
	sil.get("hnsmall").put("redirect","");
	sil.get("coupang").put("redirect","");
	
	

	/////////////////////////////////////////////
	

	// 마이페이지 : [my]
	sil.get("11st").put("my", "http://m.11st.co.kr/MW/MyPage/mypageMain.tmall");
	sil.get("gmarket").put("my", "http://mmyg.gmarket.co.kr/home");
	sil.get("g9").put("my", "http://m.g9.co.kr/MyPage.htm#/MyPage/PurchaseInfo");
	sil.get("auction").put("my", "http://mmya.auction.co.kr/MyAuction/");
	sil.get("interpark").put("my", "https://m.interpark.com/my/shop/index.html?b=1");
	sil.get(".emart").put("my", "http://m.ssg.com/myssg/main.ssg?emart=");
	sil.get("shinsegaemall").put("my", "http://m.ssg.com/myssg/main.ssg?shinsegaemall=");
	sil.get("ssg").put("my", "http://m.ssg.com/myssg/main.ssg");
	sil.get("gsshop").put("my", "http://m.gsshop.com/mygsshop/myOrderList.gs");
	sil.get("wemakeprice").put("my", "http://m.wemakeprice.com/m/mypage/order_list/ship");
	sil.get("ticketmonster").put("my", "http://m.ticketmonster.co.kr/mytmon/list");
	sil.get("cjmall").put("my", "https://mw.cjmall.com/m/mycj/index.jsp?pic=MYZONE&app_cd=ENURI");
	sil.get("hyundaihmall").put("my", "http://m.hyundaihmall.com/front/smOrderPeriodL.do");
	sil.get("akmall").put("my", "https://m.akmall.com/mypage/OrderDeliInquiry.do");
	sil.get("e-himart").put("my", "");
	sil.get("galleria").put("my", "");
	sil.get("okmall").put("my", "");
	sil.get(".nsmall.com").put("my", "http://m.nsmall.com");
	sil.get("homeplus").put("my","http://m.homeplus.co.kr/mypage/main.do");
	sil.get("lottemart").put("my", "");
	sil.get(".lotte.com").put("my", "http://m.lotte.com/mylotte/m/mylotte.do");
	sil.get("lotteimall").put("my", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
	sil.get("ellotte").put("my", "https://m.ellotte.com/mylotte/purchase/m/purchase_list.do");
	sil.get("hnsmall").put("my", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
	sil.get("coupang").put("my", "http://m.coupang.com/m/my.pang");

	// 쇼핑몰 바로 로그인 스크립트 : [j]
	sil.get("11st").put("j","");
	sil.get("gmarket").put("j","<form style=\"visibility:hidden\" name=lf method=post " +
			 "action=\"https://mobile.gmarket.co.kr/Login/Login\">"+
			// "<input name=\"url\" value=\"\">"+
			  "<input name=\"url\" value=\"\">"+
			 "<input name=\"id\" id=\"id\" value=\"[[id]]\">"+
			 "<input name=\"pwd\" id=\"pwd\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("g9").put("j","");
	sil.get("auction").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
	 "action=\"https://signin.auction.co.kr/Authenticate/login.aspx\">"+
	 "<input name=\"seller\" type=\"hidden\" value=\"\">"+
	 "<input name=\"seqno\" type=\"hidden\" value=\"\">"+
	 "<input name=\"url\" value=\"\">"+
	 "<input name=\"id\" value=\"[[id]]\">"+
	 "<input name=\"password\" value=\"[[pwd]]\">"+
	 "</form>"+
	 "<script>lf.submit();" +
	 "</script>");
	sil.get("interpark").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
			 + "action=\"https://m.interpark.com/auth/login.html\">" +
			 "<input name=\"url\" value=\"\">"
			 + "<input name=\"userId\" id=\"userId\" value=\"[[id]]\">"
			 + "<input name=\"userPwd\" id=\"userPwd\" value=\"[[pwd]]\">" 
		 	 + "<input name=\"saveSess\" value=\"Y\">"+ 
			 "</form>" + "<script>lf.submit();"
			 + "</script>");
	sil.get(".emart").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://member.ssg.com/m/member/login.ssg\">" 
					+ "<input name=\"mbrLoginId\" value=\"[[id]]\">"
					+ "<input name=\"password\" value=\"[[pwd]]\">" 
					+ "<input name=\"keepLogin\" value=\"Y\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>");
	sil.get("shinsegaemall").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://member.ssg.com/m/member/login.ssg\">"+
			 "<input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\">"+
			 "<input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\">"+
			 "<input name=\"keepLogin\" value=\"Y\">"+ 
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("ssg").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://member.ssg.com/m/member/login.ssg\">"+
			 "<input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\">"+
			 "<input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\">"+
					 "<input name=\"keepLogin\" value=\"Y\">"+ 
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("gsshop").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "			 +
			 "action=\"https://m.gsshop.com/member/j_spring_security_check\">"+
			 "<input name=\"id\" value=\"[[id]]\">"+
			 "<input name=\"passwd\" value=\"[[pwd]]\">"+
			 "<input name=\"chkAutoid\" value=\"on\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("ticketmonster").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://m.ticketmonster.co.kr/user/login\">" 
					+ "<input name=\"id\" value=\"[[id]]\">"
					+ "<input name=\"pw\" value=\"[[pwd]]\">"
					+ "<input name=\"au\" value=\"1\">"
					+ "</form>" + "<script>lf.submit();" + "</script>");

	// sil.get("cjmall").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "	+
// 			 "action=\"https://mw.cjmall.com/m/login/login_act.jsp?app_cd=ENURI\">"+
// 			 "<input name=\"member_id\" value=\"[[id]]\">"+
// 			 "<input name=\"pwd\" value=\"[[pwd]]\">"+
// 			 "<input name=\"autolog\" value=\"1\">"+
// 			 "</form>"+
// 			 "<script>lf.submit();" + "</script>");

	sil.get("hyundaihmall").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "			 +
			 "action=\"https://m.hyundaihmall.com/front/smLoginP.do\">"+
			 "<input name=\"userid\" value=\"[[id]]\">"+
			 "<input name=\"password\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("akmall").put("j", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://m.akmall.com/login/LoginProc.do\">"+
			 "<input name=\"cust_id\" value=\"[[id]]\">"+
			 "<input name=\"passwd\" value=\"[[pwd]]\">"+
			 "<input name=\"checkedNoSSL\" value=\"Y\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");
	sil.get("e-himart").put("j", "");
	sil.get("galleria").put("j", "");
	sil.get("okmall").put("j", "");
	sil.get(".nsmall.com").put("j","");
	sil.get("homeplus").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://m.homeplus.co.kr:448/identity/loginProc.do\">" 
					+ "<input name=\"login_id\" value=\"[[id]]\">"
					+ "<input name=\"user_passwd\" value=\"[[pwd]]\">"
					+ "<input name=\"chkautologin\" value=\"Y\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>");
	sil.get("lottemart").put("j", "");
	sil.get(".lotte.com").put("j","");
	// sil.get(".lotte.com").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
	// 		 "action=\"https://m.lotte.com/login/login.do\">"+
	// 		 "<input name=\"userId\" value=\"[[id]]\">"+
	// 		 "<input name=\"password\" value=\"[[pwd]]\">"+
	// 		 "<input name=\"autoEasy\" value=\"1\">"+
	// 		 "<input name=\"saveEasy\" value=\"1\">"+ 
	// 		 "<input name=\"auto\" value=\"1\">"+ 
	// 		 "<input name=\"save\" value=\"1\">"+
	// 		 "<input name=\"grockle_yn\" value=\"N\">"+
	// 		 "<input name=\"app_login_form\" value=\"N\">"+
	// 		 "<input name=\"mach_knd_cd\" value=\"android\">"+
	// 		 "<input name=\"fromPg\" value=\"0\">"+
	// 		 "<input name=\"simpleSignMember\" value=\"N\">"+
	// 		 "<input name=\"adultChkDrmc\" value=\"N\">"+
	// 		 "</form>"+
	// 		 "<script>lf.submit();" +
	// 		 "</script>");
	// sil.get("lotteimall").put("j", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
// 			 "action=\"https://securem.lotteimall.com/member/goLogin.lotte\">"+
// 			 "<input name=\"login_id\" value=\"[[id]]\">"+
// 			 "<input name=\"password\" value=\"[[pwd]]\">"+
// 			 "<input name=\"memberGubun\" value=\"1\">"+
// 			 "<input name=\"aloginSave\" value=\"Y\">"+ 
// 			 "<input name=\"chkAloginSave\" value=\"Y\">"+
// 			 "<input name=\"memSave\" value=\"on\">"+
// 			 "</form>"+
// 			 "<script>lf.submit();" +"</script>");
	sil.get("ellotte").put("j","");
	sil.get("hnsmall").put("j", "<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://m.hnsmall.com/customer/loginproc\">" 
					+ "<input name=\"mem_id\" value=\"[[id]]\">"
					+ "<input name=\"mem_pw\" value=\"[[pwd]]\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>");
	sil.get("coupang").put("j","<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" " +
			 "action=\"https://login.coupang.com/login/loginProcess.pang\">"+
			 "<input name=\"email\" id=\"login-tf-email\" value=\"[[id]]\">"+
			 "<input name=\"password\" id=\"login-tf-password\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>");

	// 로그인 마지막 페이지에서 떨어지는결과 : [f]
	sil.get("11st").put("f","");
	sil.get("gmarket").put("f","");
	sil.get("g9").put("f","");
	sil.get("auction").put("f","");
	sil.get("interpark").put("f","");
	sil.get(".emart").put("f","");
	sil.get("shinsegaemall").put("f","");
	sil.get("ssg").put("f","");
	sil.get("gsshop").put("f","");
	sil.get("wemakeprice").put("f","");
	sil.get("ticketmonster").put("f","");
	sil.get("cjmall").put("f","");
	sil.get("hyundaihmall").put("f","");
	sil.get("akmall").put("f","");	
	sil.get("e-himart").put("f","");	
	sil.get("galleria").put("f","");	
	sil.get("okmall").put("f","");	
	sil.get(".nsmall.com").put("f","");
	sil.get("homeplus").put("f","");
	sil.get("lottemart").put("f","");	
	sil.get(".lotte.com").put("f","");
	sil.get("lotteimall").put("f","");
//	sil.get(".lotte.com").put("f","loginResult('01',");
//	sil.get("lotteimall").put("f","loginResult('01'");
	sil.get("ellotte").put("f","");
	sil.get("hnsmall").put("f","");
	sil.get("coupang").put("f","");

	// 로그아웃 URL : [o]
	sil.get("11st").put("o","http://m.11st.co.kr/MW/Login/logout.tmall?type=");
	sil.get("gmarket").put("o","http://m.gmarket.co.kr/Login/logout.asp");
	sil.get("g9").put("o","https://apissl.g9.co.kr/api/Authentication/Logout?");
	sil.get("auction").put("o","http://member.auction.co.kr/Authenticate/Logout.aspx");
	sil.get("interpark").put("o","http://m.interpark.com/auth/logout.html");
	sil.get(".emart").put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com%2F");
	sil.get("shinsegaemall").put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.shinsegaemall.ssg.com%2F");
	sil.get("ssg").put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.ssg.com%2F");
	sil.get("gsshop").put("o","http://m.gsshop.com/member/logOut.gs");
	sil.get("wemakeprice").put("o","call_ajax('GET','/m/member/logout',false,function(data){if(data['result']==1){window.location ='https://member.wemakeprice.com/m/member/login/'}else {alert(data['msg']);}});");
	sil.get("ticketmonster").put("o","http://m.ticketmonster.co.kr/user/logout");
	sil.get("cjmall").put("o","https://mw.cjmall.com/m/login/logout.jsp");
	sil.get(".nsmall.com").put("o","");
	sil.get("homeplus").put("o","http://m.homeplus.co.kr/identity/logout.do");
	sil.get(".lotte.com").put("o","http://m.lotte.com/login/logout.do");
	sil.get("lotteimall").put("o","https://securem.lotteimall.com/member/goLogout.lotte");
	sil.get("ellotte").put("o","http://m.ellotte.com/login/logout.do");

	// 쇼핑몰 상품창 구분자 : [p]
	sil.get("11st").put("p","prdno=;productbasicinfo.tmall");
	sil.get("gmarket").put("p","goodscode=;item");
	sil.get("g9").put("p","vip");
	sil.get("auction").put("p","/item/vip#/");
	sil.get("interpark").put("p","/product/");//;pay_disp_no=");
	sil.get(".emart").put("p","/item/itemview.ssg;itemid=");
	sil.get("shinsegaemall").put("p","/item/itemview.ssg;itemid=");
	sil.get("ssg").put("p","/item/itemview.ssg;itemid=");
	sil.get("gsshop").put("p","/prd/prd.gs;prdid=");//("p","/deal/deal.gs;dealno=");
	sil.get("wemakeprice").put("p","/m/deal/adeal/");
	// sil.get("ticketmonster").put("p","/deal/detaildaily/");	
	sil.get("ticketmonster").put("p","/deal/");	
	sil.get("cjmall").put("p","/m/item/;app_cd=");
	sil.get("hyundaihmall").put("p","/front/smitemdetailr.do;itemcode=");	
	sil.get("akmall").put("p","/goods/goodsdetail.do;goods_id=");
	sil.get("e-himart").put("p","/productdetail.hmt;prditmid=");
	sil.get("galleria").put("p","/item/showitemdtl.do;item_id=");	
	sil.get("okmall").put("p","/product/view.html;pid=");	
	sil.get(".nsmall.com").put("p","m_g2600000m");
	sil.get("homeplus").put("p","/product/info.do;good_id=");
	sil.get("lottemart").put("p","/mobile/cate/pmwmcat0004_new.do;productcd=");	
	sil.get(".lotte.com").put("p","/product/m/product_view.do;goods_no=");	
	sil.get("lotteimall").put("p","/goods/viewgoodsdetail.lotte;goods_no=");
	sil.get("ellotte").put("p","/product/m/product_view.do;goods_no=");
	sil.get("hnsmall").put("p","/goods/view/");

	// 쇼핑몰 상품창 구분자 : [p]
	sil.get("auction").put("p2","ego.aspx;p=");
	sil.get("gsshop").put("p2","/deal/deal.gs;dealno=");
	sil.get("wemakeprice").put("p2","mobile_app/direct_to_app");
	//("p","/deal/deal.gs;dealno=");
	///sil.get("auction").put("p2","/ego.aspx;p=");//("p","/deal/deal.gs;dealno=");

	// 안드로이드 시간 으로 로그인 확인 : [etc]
	sil.get("11st").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_12);
	sil.get("gmarket").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_6);
	sil.get("auction").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_2);
	sil.get("interpark").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_2);
	sil.get(".emart").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_3);
	sil.get("shinsegaemall").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_3);
	sil.get("ssg").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_3);
	sil.get("gsshop").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_6);
	sil.get("wemakeprice").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_6);
	sil.get("ticketmonster").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_6);
	sil.get("cjmall").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_6);
	sil.get("homeplus").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_12);
	sil.get(".lotte.com").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_12);
	sil.get("lotteimall").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_12);
	sil.get("ellotte").put("etc",Hex_IDINPUT|Hex_LOGINDELAY_12);

	// 리워드 
	sil.get("11st").put("re","SCRIPT=-=Order/viewOrderPayInfo.tmall=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('ordNo=')+6, document.documentURI.indexOf('&prdNo='));})()");
	sil.get("11st").put("reExt","");
	sil.get("gmarket").put("re","SCRIPT=-=ordercomplete?packNo=-=(function() {var doc11=(document.documentURI);var packNo=doc11.substring(doc11.indexOf('?packNo=')+8);var outText=packNo+',';for(var i=0; i<nova.data.OrderInformation.length; i++) {outText += nova.data.OrderInformation[i].OrderNo+',';}return outText;})()");
	sil.get("gmarket").put("reExt","");
	//sil.get("auction").put("re","SCRIPT=-=common/OrderConfirmMobile.aspx=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?PayNo=')+7, document.documentURI.indexOf('&type='));})()");
	if(version>=304)
	{
		sil.get("auction").put("re","SCRIPT=-=/OrderConfirmMobile.aspx=-=(function(){var doc11=(document.documentURI);var index = doc11.indexOf('?PayNo=')+7;var packNo=doc11.substring(index,index+9)+','; var track =$('#form1 script');for(var i=0;i< track.length;i++){var a = track[i].text;if(a.indexOf('OrderTracking(')>-1){var b =a.substring(a.indexOf('OrderTracking(')+ 'OrderTracking('.length, a.length);packNo += b.substring(0,b.indexOf(');')).split(',')[1]+',';}}return packNo;})()");
		sil.get("auction").put("reExt","");
	}else 
	{
		sil.get("auction").put("re","");
		sil.get("auction").put("reExt","");
	}
	sil.get("interpark").put("re","SCRIPT=-=order/shop/pay_done=-=(function() {return $('#orderNumber strong').text();})()");
	sil.get("interpark").put("reExt","");
	//sil.get(".emart").put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() { var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	sil.get(".emart").put("re","");
	sil.get(".emart").put("reExt","");
	//sil.get("shinsegaemall").put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() { var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	sil.get("shinsegaemall").put("re","");
	sil.get("shinsegaemall").put("reExt","");
	//sil.get("ssg").put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() { var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	sil.get("ssg").put("re","");
	sil.get("ssg").put("reExt","");
	sil.get("gsshop").put("re","SCRIPT=-=order/main/confirmOrder.gs=-=(function() {return $('.order-number em').text().split(' : ')[1];})()");
	sil.get("gsshop").put("reExt","");
	//sil.get("wemakeprice").put("re","SCRIPT=-=order/confirm_cart_order=-=(function() {return DaumConversionDctSv.substring(DaumConversionDctSv.indexOf('orderID=')+8, DaumConversionDctSv.indexOf(',amount'));})()");
	sil.get("wemakeprice").put("re","");
	sil.get("wemakeprice").put("reExt","");
	sil.get("ticketmonster").put("re","SCRIPT=-=ticketmonster.co.kr/m/buy/result=-=(function() {return $('.cmpl .order .num').text();})()");
	sil.get("ticketmonster").put("reExt","");
	sil.get("cjmall").put("re","SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {var a = $('.paynum').text();return a.substring('주문번호 '.length,a.length);})()");
	sil.get("cjmall").put("reExt","");
	//sil.get("hyundaihmall").put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return $('.complete .order span').text().split(' : ')[1];})()");
	sil.get("hyundaihmall").put("re","");
	sil.get("hyundaihmall").put("reExt","");
	//sil.get("akmall").put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?ord_id=')+8);})()");
	sil.get("akmall").put("re","");
	sil.get("akmall").put("reExt","");
	//sil.get("homeplus").put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?ord_id=')+8);})()");
	sil.get("homeplus").put("re","");
	sil.get("homeplus").put("reExt","");
	//sil.get(".lotte.com").put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return document.frm_purchase.orderNo.value;})()");
	sil.get(".lotte.com").put("re","");
	sil.get(".lotte.com").put("reExt","/dacom/xansim/");
	//sil.get("lotteimall").put("re","SCRIPT=-=/order/getOrderComplete.lotte=-=(function() {return TRS_ORDER_ID})()");
	sil.get("lotteimall").put("re","");
	sil.get("lotteimall").put("reExt","dis.as.criteo.com");
	//sil.get("ellotte").put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return document.frm_purchase.orderNo.value;})()");
	sil.get("ellotte").put("re","");
	sil.get("ellotte").put("reExt","dis.as.criteo.com");
	//sil.get("hnsmall").put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return document.okcashback_from.order_no.value;})()");
	sil.get("hnsmall").put("re","");
	sil.get("hnsmall").put("reExt","");

	// 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함 [lc]
	sil.get("11st").put("lc","TMALL_AUTH="); // 로그인을 확인하는 쿠키
	sil.get("gmarket").put("lc","isMember=MEM"); // 로그인을 확인하는 쿠키
	// sil.get("auction").put("lc","RPM="); // 로그인을 확인하는 쿠키
	sil.get("auction").put("lc","AGP="); // 로그인을 확인하는 쿠키
	sil.get("interpark").put("lc","TMem%5FNO="); // 로그인을 확인하는 쿠키
	sil.get(".emart").put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	sil.get("shinsegaemall").put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	sil.get("ssg").put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	sil.get("gsshop").put("lc","login=true"); // 로그인을 확인하는 쿠키
	sil.get("wemakeprice").put("lc","setGM="); // 로그인을 확인하는 쿠키
	sil.get("ticketmonster").put("lc","tmon_login="); // 로그인을 확인하는 쿠키
	// sil.get("cjmall").put("lc","HE_MEMBERID="); // 로그인을 확인하는 쿠키
	sil.get("cjmall").put("lc","M_CERT_DATA="); // 로그인을 확인하는 쿠키
	sil.get("hyundaihmall").put("lc","_gali=loginCheck"); // 로그인을 확인하는 쿠키
	sil.get("akmall").put("lc","loginToken=-=BLANK"); // 로그인을 확인하는 쿠키
	sil.get("homeplus").put("lc","cAAutoID=-=BLANK"); // 로그인을 확인하는 쿠키
	sil.get(".lotte.com").put("lc","LOGINCHK=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	sil.get("lotteimall").put("lc","MC_ALOGIN_SEQ=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	sil.get("ellotte").put("lc","LOGINCHK=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	sil.get("hnsmall").put("lc","savePw=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함

	// 로그인 하기위한 관련 url [lurl]
	sil.get("lotteimall").put("lurl",""); // 로그인을 확인하는 URL 이 URL이 있을 경우 로그인 체크를 함
	sil.get("ellotte").put("lurl",""); // 로그인을 확인하는 URL 이 URL이 있을 경우 로그인 체크를 함

	// 로그인 하기위한 관련 url [lpurl]
	sil.get("11st").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("gmarket").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("auction").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("interpark").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get(".emart").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("shinsegaemall").put("lpurl","http://m.shinsegaemall.ssg.com/mall/main.ssg"); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("ssg").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("gsshop").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("wemakeprice").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("ticketmonster").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("cjmall").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("hyundaihmall").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("akmall").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("homeplus").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get(".lotte.com").put("lpurl","http://m.lotte.com/login/logout.do"); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("lotteimall").put("lpurl","https://securem.lotteimall.com/member/goLogout.lotte"); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("ellotte").put("lpurl","http://m.ellotte.com/login/logout.do"); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	sil.get("hnsmall").put("lpurl",""); // j가 있을 경우 로그인 하기전에 미리 한번 실행해야하는 url, 이게 있으면 J를 바로 실행하지 않음
	
	// 로그인 쿠키를 찾는 도메인
	sil.get("11st").put("ld","http://m.11st.co.kr"); // 로그인 쿠키를 찾는 도메인 
	sil.get("gmarket").put("ld","http://m.gmarket.co.kr"); // 로그인 쿠키를 찾는 도메인 
	sil.get("auction").put("ld","http://mobile.auction.co.kr"); // 로그인 쿠키를 찾는 도메인 
	sil.get("interpark").put("ld","http://m.interpark.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get(".emart").put("ld","https://m.emart.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("shinsegaemall").put("ld","https://m.shinsegaemall.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("ssg").put("ld","http://m.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("gsshop").put("ld","http://m.gsshop.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("wemakeprice").put("ld","https://wemakeprice.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("ticketmonster").put("ld","http://m.ticketmonster.co.kr"); // 로그인 쿠키를 찾는 도메인 
	sil.get("cjmall").put("ld","http://mw.cjmall.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("hyundaihmall").put("ld","http://m.hyundaihmall.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("akmall").put("ld","http://m.hyundaihmall.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("homeplus").put("ld","https://m.homeplus.co.kr:448"); // 로그인 쿠키를 찾는 도메인 
	sil.get(".lotte.com").put("ld","http://m.lotte.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("lotteimall").put("ld","http://m.lotteimall.com"); // 로그인 쿠키를 찾는 도메인 
	sil.get("ellotte").put("ld","http://m.ellotte.com"); // 로그인 쿠키를 찾는 도메인
	sil.get("hnsmall").put("ld","http://m.hnsmall.com"); // 로그인 쿠키를 찾는 도메인 

	// ** IOS 전용 ** 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨) [cno]
	sil.get("11st").put("cno","login.tmall=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("gmarket").put("cno","blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	// sil.get("auction").put("cno","https://=-=blank=-=http://member==-=http://www"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("auction").put("cno","https://=-=blank=-=http://member=-=http://www"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("interpark").put("cno","blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get(".emart").put("cno","blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("shinsegaemall").put("cno","/mall/main.ssg=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("ssg").put("cno","blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("gsshop").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("wemakeprice").put("cno","https"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("ticketmonster").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("cjmall").put("cno","blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("hyundaihmall").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("akmall").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("homeplus").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get(".lotte.com").put("cno","/login/logout.do=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("lotteimall").put("cno","/member/goLogout.lotte=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("ellotte").put("cno","/login/logout.do=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	sil.get("hnsmall").put("cno","https://=-=blank"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	
	// 로그인이 지연될 경우 20초? 선언된 시간까지 기다려도 실패하면 실패메세지를 줌
	sil.get("wemakeprice").put("aLogin","Y");
	sil.get("cjmall").put("aLogin","Y");

	// 로그인 메세지 타입 1이면 첫번째만 보여주고 2이면 두번째만 보여줌 [ellotte]
	sil.get("ellotte").put("lmtype","1-1-0-0"); // 로그인 메세지 타입 1이면 첫번째만 보여주고 2이면 두번째만 보여줌

	// 빅 아이콘 이미지 [icb]
	sil.get("11st").put("icb","app_icon_166_11st"); // 빅 아이콘 이미지
	sil.get("gmarket").put("icb","app_icon_166_gmarket"); // 빅 아이콘 이미지
	sil.get("auction").put("icb","app_icon_166_auction"); // 빅 아이콘 이미지
	sil.get("interpark").put("icb","app_icon_166_interpark"); // 빅 아이콘 이미지
	sil.get(".emart").put("icb","app_icon_166_emart"); // 빅 아이콘 이미지
	sil.get("shinsegaemall").put("icb","app_icon_166_shinsegaemall"); // 빅 아이콘 이미지
	sil.get("ssg").put("icb","app_icon_166_ssg"); // 빅 아이콘 이미지
	//sil.get("gsshop").put("icb","app_icon_166_gsshop"); // 빅 아이콘 이미지
	sil.get("wemakeprice").put("icb","app_icon_166_wemakeprice"); // 빅 아이콘 이미지
	sil.get("ticketmonster").put("icb","app_icon_166_ticketmonster"); // 빅 아이콘 이미지
	sil.get("cjmall").put("icb","app_icon_166_cjmall"); // 빅 아이콘 이미지
	sil.get("hyundaihmall").put("icb",""); // 빅 아이콘 이미지
	sil.get("akmall").put("icb",""); // 빅 아이콘 이미지
	sil.get("homeplus").put("icb",""); // 빅 아이콘 이미지
	sil.get(".lotte.com").put("icb","app_icon_166_lottecom"); // 빅 아이콘 이미지
	//sil.get("lotteimall").put("icb","app_icon_166_lotteimall"); // 빅 아이콘 이미지
	sil.get("ellotte").put("icb","app_icon_166_ellotte"); // 빅 아이콘 이미지
	sil.get("hnsmall").put("icb",""); // 빅 아이콘 이미지

	// 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함 [op]
	sil.get("11st").put("op","mw/order/orderbasicfirststep.tmall"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("gmarket").put("op","ko/order?orderidx"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("auction").put("op","common/ordermobile.aspx"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("interpark").put("op","order/shop/payment.html"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get(".emart").put("op","m/order/ordpage.ssg"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("shinsegaemall").put("op","m/order/ordpage.ssg"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("ssg").put("op","m/order/ordpage.ssg"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("gsshop").put("op","mobile/ordsht/ordsht.gs"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("wemakeprice").put("op","m/order/pay"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("ticketmonster").put("op","m/buy?selected_id"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("cjmall").put("op","m/order/order.jsp?app_cd"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("hyundaihmall").put("op","front/order.do"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("akmall").put("op","order/delipaymentinpt.do"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("homeplus").put("op","orderfulfilment/order/info.do"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get(".lotte.com").put("op","order/m/order_form.do"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("lotteimall").put("op","order/searchordersheetlist.lotte"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("ellotte").put("op","order/m/order_form.do"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함
	sil.get("hnsmall").put("op","order/input#init"); // 주문페이지 URL -> IOS에서 ISP가 안된다는 메세지를 보여줘야 함

	// 완료 메세지 : [em]
	sil.get("11st").put("em",""); // 완료 메세지
	sil.get("gmarket").put("em",""); // 완료 메세지
	sil.get("auction").put("em",""); // 완료 메세지	
	sil.get("interpark").put("em",""); // 완료 메세지
	sil.get(".emart").put("em","SUCCESS"); // 완료 메세지	
	sil.get("shinsegaemall").put("em","SUCCESS"); // 완료 메세지
	sil.get("ssg").put("em","SUCCESS"); // 완료 메세지
	sil.get("gsshop").put("em",""); // 완료 메세지
	sil.get("wemakeprice").put("em",""); // 완료 메세지
	sil.get("ticketmonster").put("em",""); // 완료 메세지
	sil.get("cjmall").put("em",""); // 완료 메세지
	sil.get("hyundaihmall").put("em",""); // 완료 메세지
	sil.get("akmall").put("em",""); // 완료 메세지
	sil.get("homeplus").put("em",""); // 완료 메세지
	sil.get(".lotte.com").put("em",""); // 완료 메세지
	sil.get("lotteimall").put("em",""); // 완료 메세지
	sil.get("ellotte").put("em",""); // 완료 메세지
	sil.get("hnsmall").put("em",""); // 완료 메세지

	// 팝업 url
	// IOS에서 팝업을 실행하도록 해줌
	sil.get("interpark").put("popupUrl","/order/shop/pay_addr_zip.html=-=/product/content.html");
	sil.get("hyundaihmall").put("popupUrl","/front/smItemDetailImg.do");

	// IOS에서 무시해야할 URL return YES
	sil.get("11st").put("noUrl","/a.st?url");

	// 적립 대상인지 확인하는 url
	// =-=을 넣으면 여러개의주소가능
	// ios3.0.2 이하 버젼에서 값이 무조건 있어야지 라면 적립 여부가 확인 된다 그래서 빈값 넣어준 쇼핑몰이 있다
	sil.get("11st").put("reCoDomain","http://m.11st.co.kr/");
	sil.get("gmarket").put("reCoDomain","http://mitem.gmarket.co.kr/");
	if(version>=304)
		sil.get("auction").put("reCoDomain","http://mobile.auction.co.kr=-=http://mmya.auction.co.kr"); 
	else
		sil.get("auction").put("reCoDomain"," "); 
	sil.get("interpark").put("reCoDomain","http://m.shop.interpark.com/");
	sil.get(".emart").put("reCoDomain"," ");
	sil.get("shinsegaemall").put("reCoDomain"," ");
	sil.get("ssg").put("reCoDomain"," ");
	sil.get("gsshop").put("reCoDomain","http://m.gsshop.com/");
	sil.get("wemakeprice").put("reCoDomain"," "); 
	sil.get("ticketmonster").put("reCoDomain","http://m.ticketmonster.co.kr/");
	sil.get("cjmall").put("reCoDomain","http://fdrive.cjmall.com/m=-=http://mw.cjmall.com/m/item");
	sil.get("hyundaihmall").put("reCoDomain"," "); 
	sil.get("akmall").put("reCoDomain"," "); 
	sil.get("homeplus").put("reCoDomain"," "); 
	sil.get(".lotte.com").put("reCoDomain"," ");
	sil.get("lotteimall").put("reCoDomain"," "); 
	sil.get("ellotte").put("reCoDomain"," ");
	sil.get("hnsmall").put("reCoDomain"," ");

	// IOS에서 버려야할 URL return NO
	//sil.get("11st").put("yesUrl","/a.st?url");

	//android에서 innerHtml을 실행 하지 않는 경우 
	// sil.get("cjmall").put("andInnerX","https://mw.cjmall.com/m/login/login_act.jsp");

	// 사이트정보 json에 입력
	JSONArray arrSiteData = new JSONArray();
	for(int i=0; i<siteNameList.length; i++) {
		
		// 일반 주석
		if(siteNameList[i].equals("g9") || siteNameList[i].equals("coupang")) {
			continue;
		}

		// 3.0.0버전 이하에서 안되는 것들
		if(version<300) {
			if(siteNameList[i].equals(".lotte.com") || siteNameList[i].equals("lotteimall") || siteNameList[i].equals("ellotte") || siteNameList[i].equals("cjmall")) {
				continue;
			}
		}


		if( ChkNull.chkStr(os).indexOf("ios") > -1  && version<304)
		{
			if(siteNameList[i].equals(".lotte.com")||siteNameList[i].equals("ellotte"))
				continue;
		}


		arrSiteData.put(sil.get(siteNameList[i]));
	}
	temp1.put("SITES", arrSiteData);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 사이트 관련 정보 넣기 끝
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	jsonObject.put("andDefineList", temp1);

	out.print(jsonObject);
	out.flush();
%>