<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");

	JSONObject jsonObject = new JSONObject();

	String ifdomain = "enuri.com/mobilefirst";

	JSONObject temp1 = new JSONObject();

	temp1.put("OUTLINKURL", "enuri.com/mobilefirst;http://enuri.sweettracker.net;enuri.com/deal/mobile/;/mobiledepart;enuri.com/mobilenew");
	temp1.put("OUTLINKURL_IOS", "dev.enuri.com;m.enuri.com;dis.as.criteo.com;widerplanet.com");
	temp1.put("IF_DOMAIN", ifdomain);
	temp1.put("IF_ALL_MENU", ifdomain + "/layerMenu_ajax.jsp");
	temp1.put("IF_MAIN_URL2", "enuri.com/mobilefirst/Index.jsp");
	temp1.put("IF_BIG_IMAGE_URL", "enuri.com/mobilefirst/detailBigImage.jsp");

	temp1.put("IF_LOGIN_URL", ifdomain + "/login/");
	temp1.put("IF_LOGIN_URL2", "enuri.com/mobilenew/login/");
	temp1.put("IF_SOCIAL_URL", "enuri.com/deal/mobile/main.deal");
	temp1.put("IF_SOCIAL_DETAIL_URL", "enuri.com/deal/mobile/goods.deal"); 
	temp1.put("IF_DEPARTMENT_LINK", "enuri.com/mobiledepart/Index.jsp");
	temp1.put("IF_DEPARTMENT_DETAILPAGE", "enuri.com/mobiledepart/detail.jsp");
	temp1.put("IF_DETAIL_URL", "enuri.com/mobilefirst/detail.jsp?modelno=");
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
	
	// IOS에서 쿠키를 찾기 위해 사용하는 문자열
	// 쿠키를 원데이터로 읽으면 name, value가 서로 분리되어있는데 합쳐서 검색이 편하도록 하기 위해
	temp1.put("IOS_COOKIE_FIND_STR1", "\" value:\"");
	temp1.put("IOS_COOKIE_FIND_STR2", " value:\"=-=\" "); // 쿠키의 value값을 찾는 정규식
	////////////////////////////////////////////////////////

	JSONArray arrCardData = new JSONArray();

	JSONObject cardData1 = new JSONObject();
	cardData1.put("i", "hdcardappcardansimclick");
	cardData1.put("m", "market://details?id=com.hyundaicard.appcard");
	arrCardData.put(cardData1);

	JSONObject cardData2 = new JSONObject();
	cardData2.put("i", "mpocket.online.ansimclic");
	cardData2.put("m", "market://details?id=kr.co.samsungcard.mpocket");
	arrCardData.put(cardData2);

	JSONObject cardData3 = new JSONObject();
	cardData3.put("i", "mpocket.online.ansimclic");
	cardData3.put("m", "market://details?id=kr.co.samsungcard.mpocket");
	arrCardData.put(cardData3);

	JSONObject cardData4 = new JSONObject();
	cardData4.put("i", "lottesmartpay");
	cardData4.put("m", "market://details?id=com.lotte.lottesmartpay");
	arrCardData.put(cardData4);

	JSONObject cardData5 = new JSONObject();
	cardData5.put("i", "smshinhanansimclick");
	cardData5.put("m", "market://details?id=com.shcard.smartpay");
	arrCardData.put(cardData5);

	JSONObject cardData6 = new JSONObject();
	cardData6.put("i", "kb-acp");
	cardData6.put("m", "market://details?id=com.kbcard.cxh.appcard");
	arrCardData.put(cardData6);

	JSONObject cardData7 = new JSONObject();
	cardData7.put("i", "hanaansim");
	cardData7.put("m", "market://details?id=com.ilk.visa3d");
	arrCardData.put(cardData7);

	JSONObject cardData8 = new JSONObject();
	cardData8.put("i", "shinhan-sr-ansimclick");
	cardData8.put("m", "market://details?id=com.shcard.smartpay");//여기 수정 필요!!2014.04.01
	arrCardData.put(cardData8);

	JSONObject cardData9 = new JSONObject();
	cardData9.put("i", "ispmobile");
	cardData9.put("m", "http://mobile.vpay.co.kr/jsp/MISP/andown.jsp");//여기 수정 필요!!2014.04.01
	arrCardData.put(cardData9);

	temp1.put("CARDDATAS", arrCardData);

	////////////////////////////////////////////////////////
	int Hex_IDINPUT 	= 0X00000000;
	int Hex_EMAILINPUT 	= 0X00010000;

	JSONArray arrSiteData = new JSONArray();

	JSONObject siteData1 = new JSONObject();
	siteData1.put("n", "11st");
	siteData1.put("ic","app_icon_11st");
	siteData1.put("t", "11번가");
	siteData1.put("m", "http://m.11st.co.kr/MW/html/main.html");
	siteData1.put("l", "https://m.11st.co.kr/MW/Login/login.tmall?returnURL=&method=Xsite&tid=1000997249");
	siteData1.put("i", "$('#userId').val('[[id]]');$('#userPw').val('[[pwd]]');$('#loginButton').click();");	
	siteData1.put("h","http://m.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249");
	siteData1.put("my", "http://m.11st.co.kr/MW/MyPage/mypageMain.tmall");
	siteData1.put("j","");
	siteData1.put("f","");
	siteData1.put("o","http://m.11st.co.kr/MW/Login/logout.tmall?type=");
	siteData1.put("p","prdno");
	siteData1.put("c","TMALL_AUTH;TMALL_KEY_VALUE;TMALL_STATIC");
	siteData1.put("ec","XSITE;1000997249");
	siteData1.put("etc",Hex_IDINPUT);
	siteData1.put("re","SCRIPT=-=Order/viewOrderPayInfo.tmall=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?ordNo=')+7, document.documentURI.indexOf('&prdNo='));})()");
	siteData1.put("ld","http://m.11st.co.kr"); // 로그인 쿠키를 찾는 도메인 
	siteData1.put("lc","TMALL_AUTH="); // 로그인을 확인하는 쿠키
	siteData1.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData1.put("icb","app_icon_166_11st"); // 빅 아이콘 이미지
	siteData1.put("em",""); // 완료 메세지
	arrSiteData.put(siteData1);

	JSONObject siteData2 = new JSONObject();
	siteData2.put("n", "gmarket");
	siteData2.put("ic","app_icon_gmarket");
	siteData2.put("t", "G마켓");
	siteData2.put("m", "http://mobile.gmarket.co.kr/");
	siteData2.put("l", "http://mobile.gmarket.co.kr/Login/Login?URL=");
	siteData2.put("i", "$('#id').val('[[id]]');$('#pwd').val('[[pwd]]');$('.lgs').click();");	
	siteData2.put("h","http://www.gmarket.co.kr/index.asp?jaehuid=200006254");
	siteData2.put("my", "http://mmyg.gmarket.co.kr/home");
	siteData2.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post " +
			 "action=\"https://mobile.gmarket.co.kr/Login/Login\">"+
			  "<input name=\"url\" value=\"\">"+
			 "<input name=\"id\" id=\"id\" value=\"[[id]]\">"+
			 "<input name=\"pwd\" id=\"pwd\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData2.put("f","");
	siteData2.put("o","http://m.gmarket.co.kr/Login/logout.asp");
	siteData2.put("p","goodscode");
	siteData2.put("c","PCIDJCN");
	siteData2.put("ec","jaehuid;200006254");
	siteData2.put("etc",Hex_IDINPUT);
	// 마이페이지 형태로 찾음
	// 키워드;주소;주문번호찾는스크립트;주문리스트HTML의 시작 키워드;주문번호시작키워드;주문번호끝키워드
	// 마이페이지를 http로 열어서 주문번호를 검색한 뒤 가장 마지막에 나오는 키워드를 찾아서 번호를 찾아냄 
	siteData2.put("re","SCRIPT=-=ordercomplete?packNo=-=(function() {var doc11=(document.documentURI);var packNo=doc11.substring(doc11.indexOf('?packNo=')+8);var outText=packNo+',';for(var i=0; i<nova.data.OrderInformation.length; i++) {outText += nova.data.OrderInformation[i].OrderNo+',';}return outText;})()");
	siteData2.put("lc","isMember=MEM"); // 로그인을 확인하는 쿠키
	siteData2.put("ld","http://m.gmarket.co.kr"); // 로그인 쿠키를 찾는 도메인 
	siteData2.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData2.put("icb","app_icon_166_gmarket"); // 빅 아이콘 이미지
	siteData2.put("em",""); // 완료 메세지
	arrSiteData.put(siteData2);

	JSONObject siteData3 = new JSONObject();
	siteData3.put("n", "interpark");
	siteData3.put("ic","app_icon_interpark");
	siteData3.put("t", "인터파크");
	siteData3.put("m", "http://m.interpark.com/");
	siteData3.put("l", "https://m.interpark.com/auth/login.html");
	siteData3.put("i", "$('#userId').val('[[id]]');$('#userPwd').val('[[pwd]]');$('.btn_login').click();");
	siteData3.put("h","http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14126&url=http://m.shop.interpark.com");
	siteData3.put("my", "https://m.interpark.com/my/shop/index.html?b=1");
	siteData3.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "
			 + "action=\"https://m.interpark.com/auth/login.html\">" +
			 "<input name=\"url\" value=\"\">"
			 + "<input name=\"userId\" id=\"userId\" value=\"[[id]]\">"
			 + "<input name=\"userPwd\" id=\"userPwd\" value=\"[[pwd]]\">" +
			 "</form>" + "<script>lf.submit();"
			 + "</script>');");
	siteData3.put("f","");
	siteData3.put("o","http://m.interpark.com/auth/logout.html");
	siteData3.put("p","product");
	siteData3.put("c","");//interparkID");
	siteData3.put("ec","alliance;P14126;allianceSvc");
	siteData3.put("etc",Hex_IDINPUT);
	//이놈은 pay_done_카드 뱅크 가 다 다른다 
	siteData3.put("re","SCRIPT=-=order/shop/pay_done=-=(function() {return $('#orderNumber strong').text();})()");
	siteData3.put("lc","TMem%5FNO="); // 로그인을 확인하는 쿠키
	siteData3.put("ld","http://m.interpark.com"); // 로그인 쿠키를 찾는 도메인 
	siteData3.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData3.put("icb","app_icon_166_interpark"); // 빅 아이콘 이미지
	siteData3.put("em",""); // 완료 메세지
	arrSiteData.put(siteData3);

	// 옥션은 주문번호로 구매 정보를 확인하기 힘들기 때문에 안함
	JSONObject siteData4 = new JSONObject();
	siteData4.put("n", "auction");
	siteData4.put("ic","app_icon_auction");
	siteData4.put("t", "옥션");
	siteData4.put("m", "http://mobile.auction.co.kr/");
	siteData4.put("l","http://member.auction.co.kr/Authenticate/m/?url=");
	siteData4.put("i", "$('#id').val('[[id]]');$('#password').val('[[pwd]]');$('#Form4').submit();");
	siteData4.put("h","http://banner.auction.co.kr/bn_redirect.asp?ID=BN00181187");
	siteData4.put("my", "http://mmya.auction.co.kr/MyAuction/");
	siteData4.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "+
	 "action=\"https://signin.auction.co.kr/Authenticate/login.aspx\">"+
	 "<input name=\"seller\" type=\"hidden\" value=\"\">"+
	 "<input name=\"seqno\" type=\"hidden\" value=\"\">"+
	 "<input name=\"url\" value=\"\">"+
	 "<input name=\"id\" value=\"[[id]]\">"+
	 "<input name=\"password\" value=\"[[pwd]]\">"+
	 "</form>"+
	 "<script>lf.submit();" +
	 "</script>');");
	siteData4.put("f","아이디 또는 비밀번호를 잘못 입력하셨습니다");
	siteData4.put("o","http://memeber.auction.co.kr/Authenticate/Logout.aspx");
	siteData4.put("p","itemno");
	siteData4.put("c","");//auction;auctionGrade;auctioncommon");
	siteData4.put("ec","BN00181187");
	siteData4.put("etc",Hex_IDINPUT);
	siteData4.put("re","SCRIPT=-=common/OrderConfirmMobile.aspx=-=(function() {return $('#FreeChargeMessage .order-num strong').text();})()");
	siteData4.put("lc","auctioncommon="); // 로그인을 확인하는 쿠키
	siteData4.put("ld","http://mobile.auction.co.kr"); // 로그인 쿠키를 찾는 도메인 
	siteData4.put("cno","https://=-=member.auction.co.kr"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData4.put("icb","app_icon_166_auction"); // 빅 아이콘 이미지
	siteData4.put("em",""); // 완료 메세지
	arrSiteData.put(siteData4);

	
	JSONObject siteData17 = new JSONObject();
	siteData17.put("n", "emart");
	siteData17.put("ic","app_icon_emart");
	siteData17.put("t", "이마트");
	siteData17.put("m","http://m.emart.ssg.com/");
	siteData17.put("l","https://member.ssg.com/m/member/login.ssg?emart=");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData17.put("i","$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('#login_form').submit();");
	siteData17.put("h","http://m.emart.ssg.com/?ckwhere=m_enuri");
	siteData17.put("my", "http://m.ssg.com/myssg/main.ssg?emart=");
	siteData17.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "
					+ "action=\"https://member.ssg.com/m/member/login.ssg\">" 
					+ "<input name=\"mbrLoginId\"  value=\"[[id]]\">"
					+ "<input name=\"password\"  value=\"[[pwd]]\">" 
					+ "<input name=\"keepLogin\"  value=\"Y\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>');");
	siteData17.put("f","아이디/비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
	siteData17.put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.emart.ssg.com%2F");
	siteData17.put("p","itemid");
	siteData17.put("c","MBR_ID");
	siteData17.put("ec","CKWHERE;m_enuri");
	siteData17.put("etc",Hex_IDINPUT);
	siteData17.put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() {var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	siteData17.put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	siteData17.put("ld","http://m.emart.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	siteData17.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData17.put("icb","app_icon_166_emart"); // 빅 아이콘 이미지
	siteData17.put("em","SUCCESS"); // 완료 메세지
	arrSiteData.put(siteData17);



	JSONObject siteData6 = new JSONObject();
	
	siteData6.put("n","shinsegaemall");
	siteData6.put("ic","app_icon_sinsegaemall");
	siteData6.put("t", "신세계몰");
	siteData6.put("m","http://m.shinsegaemall.ssg.com/mall/main.ssg");
	siteData6.put("l","https://member.ssg.com/m/member/login.ssg?shinsegaemall=");//http%3A%2F%2Fm.shinsegaemall.ssg.com%2Fmall%2Fmain.ssg&t=login");
	siteData6.put("i","$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();"); 
	siteData6.put("h","http://m.shinsegaemall.ssg.com/?ckwhere=s_enuri");
	siteData6.put("my", "http://m.ssg.com/myssg/main.ssg?shinsegaemall=");
	siteData6.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "+
			 "action=\"https://member.ssg.com/m/member/login.ssg\">"+
			 "<input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\">"+
			 "<input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData6.put("f","아이디/비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
	siteData6.put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.shinsegaemall.ssg.com%2F");
	siteData6.put("p","itemid");
	siteData6.put("c","MBR_ID");
	siteData6.put("ec","CKWHERE;m_enuri");
	siteData6.put("etc",Hex_IDINPUT);
	//siteData6.put("re","HTML;order/ordComplete.ssg;div#m_content div.odr_top_tx p.desc strong span.tx_point");
	siteData6.put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() {var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	siteData6.put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	siteData6.put("ld","http://m.shinsegaemall.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	siteData6.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData6.put("icb","app_icon_166_shinsegaemall"); // 빅 아이콘 이미지
	siteData6.put("em","SUCCESS"); // 완료 메세지
	arrSiteData.put(siteData6);

	JSONObject siteData5 = new JSONObject();
	siteData5.put("n", "ssg");
	siteData5.put("ic","app_icon_ssg");
	siteData5.put("t", "SSG.COM");
	siteData5.put("m", "http://m.ssg.com/");
	siteData5.put("l",	"https://member.ssg.com/m/member/login.ssg?retURL=");//http%3A%2F%2Fm.ssg.com%2F&t=login");
	siteData5.put("i", "$('#inp_id').val('[[id]]');$('#inp_pw').val('[[pwd]]');$('.bn_pnk').click();");
	siteData5.put("h","http://m.ssg.com/?ckwhere=s_enuri");
	siteData5.put("my", "http://m.ssg.com/myssg/main.ssg");
	siteData5.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "+
			 "action=\"https://member.ssg.com/m/member/login.ssg\">"+
			 "<input name=\"mbrLoginId\" id=\"inp_id\" value=\"[[id]]\">"+
			 "<input name=\"password\" id=\"inp_pw\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData5.put("f","아이디/비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
	siteData5.put("o","https://member.ssg.com/m/member/logout.ssg?retURL=http%3A%2F%2Fm.ssg.com%2F");
	siteData5.put("p","itemid");
	siteData5.put("c","MBR_ID");
	siteData5.put("ec","CKWHERE;m_enuri");
	siteData5.put("etc",Hex_IDINPUT);
	//siteData5.put("re","HTML;order/ordComplete.ssg;div#m_content div.odr_top_tx p.desc strong span.tx_point");
	siteData5.put("re","SCRIPT=-=order/ordComplete.ssg=-=(function() {var doc11=(document.documentURI);return doc11.substring(doc11.indexOf('?ordNo=')+7);})()");
	siteData5.put("lc","MEMBER_ID="); // 로그인을 확인하는 쿠키
	siteData5.put("ld","http://m.ssg.com"); // 로그인 쿠키를 찾는 도메인 
	siteData5.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData5.put("icb","app_icon_166_ssg"); // 빅 아이콘 이미지
	siteData5.put("em","SUCCESS"); // 완료 메세지
	arrSiteData.put(siteData5);
	

	JSONObject siteData11 = new JSONObject();
	siteData11.put("n", "gsshop");
	siteData11.put("ic","app_icon_gsshop");
	siteData11.put("t", "GS쇼핑");
	siteData11.put("m","http://m.gsshop.com/");
	siteData11.put("l","http://m.gsshop.com/member/logIn.gs");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData11.put("i","$('#id').val('[[id]]');$('#passwd').val('[[pwd]]');$('#btnLogin').click();");
	siteData11.put("h","http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?media=Pg&gourl=http://m.gsshop.com");
	siteData11.put("my", "http://m.gsshop.com/mygsshop/myOrderList.gs");
	siteData11.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "			 +
			 "action=\"https://m.gsshop.com/member/j_spring_security_check\">"+
			 "<input name=\"id\"  value=\"[[id]]\">"+
			 "<input name=\"passwd\"  value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData11.put("f","아이디 혹은 비밀번호가 일치하지 않습니다.");
	siteData11.put("o","http://m.gsshop.com/member/logOut.gs");
	siteData11.put("p","dealno");
	siteData11.put("c","accmAmtInfo;couponcnt;login");
	siteData11.put("ec","gsshopmobile_CTNASESSION");
	siteData11.put("etc",Hex_EMAILINPUT);
	// "주문번호 : " 뒤에 html태그가 있을 경우 제거 해야함
	siteData11.put("re","SCRIPT=-=order/main/confirmOrder.gs=-=(function() {return $('.order-number em').text().split(' : ')[1];})()");
	siteData11.put("lc","login=true"); // 로그인을 확인하는 쿠키
	siteData11.put("ld","http://m.gsshop.com"); // 로그인 쿠키를 찾는 도메인 
	siteData11.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData11.put("icb","app_icon_166_gsshop"); // 빅 아이콘 이미지
	siteData11.put("em",""); // 완료 메세지
	arrSiteData.put(siteData11);
	

	// 결제 정보 확인 안함
	JSONObject siteData15 = new JSONObject();
	siteData15.put("n","wemakeprice");
	siteData15.put("ic","app_icon_wemakeprice");
	siteData15.put("t", "위메이크프라이스");
	siteData15.put("m","http://m.wemakeprice.com/");
	siteData15.put("l","https://member.wemakeprice.com/m/member/login/");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData15.put("i","$('#login_uid').val('[[id]]');$('#login_upw').val('[[pwd]]');$('#login_confirm_btn').click();");
	
	siteData15.put("h","http://www.wemakeprice.com/widget/aff_bridge_public/enuri_m/0/Y/PRICE_af" );
	siteData15.put("my", "http://m.wemakeprice.com/m/mypage/order_list/ship");
	siteData15.put("j","");
	siteData15.put("f","");
	siteData15.put("o","call_ajax('GET','/m/member/logout',false,function(data){if(data['result']==1){window.location ='https://member.wemakeprice.com/m/member/login/'}else {alert(data['msg']);}});");
	siteData15.put("p","adeal");
	siteData15.put("c","setGM");
	siteData15.put("ec","utm_source;enuri_m");
	siteData15.put("etc",Hex_IDINPUT);
	siteData15.put("re","SCRIPT=-=order/confirm_cart_order=-=(function() {return DaumConversionDctSv.substring(DaumConversionDctSv.indexOf('orderID=')+8, DaumConversionDctSv.indexOf(',amount'));})()");
	siteData15.put("lc","setGM="); // 로그인을 확인하는 쿠키
	siteData15.put("ld","http://m.wemakeprice.com"); // 로그인 쿠키를 찾는 도메인 
	siteData15.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData15.put("icb","app_icon_166_wemakeprice"); // 빅 아이콘 이미지
	siteData15.put("em",""); // 완료 메세지
	arrSiteData.put(siteData15);
	

	JSONObject siteData16 = new JSONObject();
	siteData16.put("n","ticketmonster");
	siteData16.put("ic","app_icon_tiketmonster");
	siteData16.put("t", "티켓몬스터");
	siteData16.put("m","http://m.ticketmonster.co.kr/");
	siteData16.put("l","https://m.ticketmonster.co.kr/user/loginForm");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData16.put("i","$('#user_id').val('[[id]]');$('#user_pw').val('[[pwd]]');$('form').submit();");
	siteData16.put("h","http://m.ticketmonster.co.kr/entry/?jp=80025&ln=214285");
	siteData16.put("my", "http://m.ticketmonster.co.kr/mytmon/list");
	siteData16.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "
					+ "action=\"https://m.ticketmonster.co.kr/user/login\">" 
					+ "<input name=\"id\"  value=\"[[id]]\">"
					+ "<input name=\"pw\"  value=\"[[pwd]]\">"
					+ "</form>" + "<script>lf.submit();" + "</script>');");
	siteData16.put("f","");
	siteData16.put("o","http://m.ticketmonster.co.kr/user/logout");
	siteData16.put("p","detaildaily");
	siteData16.put("c","");
	siteData16.put("ec","jp;ln;80025;214285");
	siteData16.put("etc",Hex_IDINPUT);
	siteData16.put("re","SCRIPT=-=ticketmonster.co.kr/m/buy/result=-=(function() {return $('.cmpl .order .num').text();})()");
	siteData16.put("lc","tmon_login="); // 로그인을 확인하는 쿠키
	siteData16.put("ld","http://m.ticketmonster.co.kr"); // 로그인 쿠키를 찾는 도메인 
	siteData16.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData16.put("icb","app_icon_166_ticketmonster"); // 빅 아이콘 이미지
	siteData16.put("em",""); // 완료 메세지
	arrSiteData.put(siteData16);
	
	
	JSONObject siteData12 = new JSONObject();
	siteData12.put("n", "cjmall");
	siteData12.put("ic","app_icon_cjmall");
	siteData12.put("t", "CJ몰");
	siteData12.put("m","http://mw.cjmall.com/");
	siteData12.put("l","https://mw.cjmall.com/m/login/login.jsp");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData12.put("i","$('#member_id').val('[[id]]');$('#pwd').val('[[pwd]]');login_submit();"); 
	siteData12.put("h","http://mw.cjmall.com/m/main.jsp?app_cd=ENURI");
	siteData12.put("my", "https://mw.cjmall.com/m/mycj/index.jsp?pic=MYZONE&app_cd=ENURI");
	siteData12.put("j","document.write('<form style=\"visibility:hidden\" name=lf method=post "	+
			 "action=\"https://mw.cjmall.com/m/login/login_act.jsp?app_cd=ENURI\">"+
			 "<input name=\"member_id\"  value=\"[[id]]\">"+
			 "<input name=\"pwd\"  value=\"[[pwd]]\">"+
			 "<input name=\"autolog\"  value=\"1\">"+
			 "</form>"+
			 "<script>lf.submit();" + "</script>');");

	siteData12.put("f","");
	siteData12.put("o","https://mw.cjmall.com/m/login/logout.jsp");
	siteData12.put("p","item_cd");
	siteData12.put("c","");
	siteData12.put("ec","jp;ln;80025;214285");
	siteData12.put("etc",Hex_IDINPUT);
	siteData12.put("re","SCRIPT=-=mw.cjmall.com/m/order/order_end.jsp=-=(function() {return $('.order_number span').text();})()");
	siteData12.put("lc","HE_MEMBERID="); // 로그인을 확인하는 쿠키
	siteData12.put("ld","http://mw.cjmall.com"); // 로그인 쿠키를 찾는 도메인 
	siteData12.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData12.put("icb",""); // 빅 아이콘 이미지
	siteData12.put("em",""); // 완료 메세지

	arrSiteData.put(siteData12);

	

	JSONObject siteData9 = new JSONObject();
	siteData9.put("n","hyundaihmall");
	siteData9.put("ic","");
	siteData9.put("t", "현대아이몰");
	siteData9.put("m","http://m.hyundaihmall.com/");
	siteData9.put("l","https://m.hyundaihmall.com/front/smLoginF.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData9.put("i","$(\"input[name='userid']\").val('[[id]]');$(\"input[name='password']\").val('[[pwd]]');$('#loginCheck').click();");
	siteData9.put("h","http://www.hyundaihmall.com/front/shNetworkShop.do?NetworkShop=Html&ReferCode=022&Url=http://www.hyundaihmall.com/Home.html");
	siteData9.put("my", "http://m.hyundaihmall.com/front/smOrderPeriodL.do");
	siteData9.put("j","document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "			 +
			 "action=\"https://m.hyundaihmall.com/front/smLoginP.do\">"+
			 "<input name=\"userid\" value=\"[[id]]\">"+
			 "<input name=\"password\" value=\"[[pwd]]\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData9.put("f","비밀번호가 맞지 않습니다. 다시 확인하여 입력해 주세요");
	siteData9.put("p","itemcode");	
	siteData9.put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return $('.complete .order span').text().split(' : ')[1];})()");
	siteData9.put("lc","_gali=loginCheck"); // 로그인을 확인하는 쿠키
	siteData9.put("ld","http://m.hyundaihmall.com"); // 로그인 쿠키를 찾는 도메인 
	siteData9.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData9.put("icb",""); // 빅 아이콘 이미지
	siteData9.put("em",""); // 완료 메세지
	arrSiteData.put(siteData9);

	JSONObject siteData10 = new JSONObject();
	siteData10.put("n", "akmall");
	siteData10.put("ic","");
	siteData10.put("t", "AK몰");
	siteData10.put("m","http://m.akmall.com/");
	siteData10.put("l","https://m.akmall.com/login/Login.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData10.put("i","$('#cust_id').val('[[id]]');$('#upw').val('[[pwd]]');$(\"form[name='memberFrm']\").submit();");
	siteData10.put("h","http://www.akmall.com/assc/associate.jsp?assc_comp_id=26392");
	siteData10.put("my", "https://m.akmall.com/mypage/OrderDeliInquiry.do");
	siteData10.put("j", "document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://m.akmall.com/login/LoginProc.do\">"+
			 "<input name=\"cust_id\" value=\"[[id]]\">"+
			 "<input name=\"passwd\" value=\"[[pwd]]\">"+
			 "<input name=\"checkedNoSSL\" value=\"Y\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData10.put("f","");	
	siteData10.put("p","goods_id");
	siteData10.put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?ord_id=')+8);})()");
	siteData10.put("lc","loginToken=-=BLANK"); // 로그인을 확인하는 쿠키
	siteData10.put("ld","http://m.akmall.com"); // 로그인 쿠키를 찾는 도메인 
	siteData10.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData10.put("icb",""); // 빅 아이콘 이미지
	siteData10.put("em",""); // 완료 메세지
	arrSiteData.put(siteData10);
	
	
	JSONObject siteData30 = new JSONObject();
	siteData30.put("n", "e-himart");
	siteData30.put("ic","");
	siteData30.put("t", "하이마트");
	siteData30.put("m","http://m.e-himart.co.kr/");
	siteData30.put("l","https://m.e-himart.co.kr/login.hmt?page=myHimart");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData30.put("i","");
	siteData30.put("h","");
	siteData30.put("my", "");
	siteData30.put("j", "");
	siteData30.put("f","");	
	siteData30.put("p","prditmid");
	arrSiteData.put(siteData30);
	
	
	
	
	
	
	
	
	JSONObject siteData33 = new JSONObject();
	siteData33.put("n", "galleria");
	siteData33.put("ic","");
	siteData33.put("t", "겔러리아");
	siteData33.put("m","http://mobile.galleria.co.kr");
	siteData33.put("l","");
	siteData33.put("i","");
	siteData33.put("h","");
	siteData33.put("my", "");
	siteData33.put("j", "");
	siteData33.put("f","");	
	siteData33.put("p","item_id");	
	arrSiteData.put(siteData33);
	
	JSONObject siteData34 = new JSONObject();
	siteData34.put("n", "okmall");
	siteData34.put("ic","");
	siteData34.put("t", "OKMALL");
	siteData34.put("m","http://mobile.galleria.co.kr");
	siteData34.put("l","");
	siteData34.put("i","");
	siteData34.put("h","");
	siteData34.put("my", "");
	siteData34.put("j", "");
	siteData34.put("f","");	
	siteData34.put("p","pid");	
	arrSiteData.put(siteData34);
	

	JSONObject siteData35 = new JSONObject();
	siteData35.put("n", ".nsmall.com");
	siteData35.put("ic","");
	siteData35.put("t", "ns홈쇼핑");
	siteData35.put("m", "http://m.nsmall.com");
	siteData35.put("l", "http://m.nsmall.com/MemberLogin");
	siteData35.put("i", "$('#txtUserId').val('[[id]]');$('#txtPassword').val('[[pwd]]');$('#btnLogin').click();");	
	siteData35.put("h","");
	siteData35.put("my", "http://m.nsmall.com");
	siteData35.put("j","");
	siteData35.put("f","");
	siteData35.put("o","");
	siteData35.put("p","m_g2600000m");
	arrSiteData.put(siteData35);
	
	
	
	
	
	JSONObject siteData18 = new JSONObject();
	siteData18.put("n","homeplus");
	siteData18.put("ic","app_icon_wemakeprice");
	siteData18.put("t", "홈플러스");
	siteData18.put("m","http://m.homeplus.co.kr/");
	siteData18.put("l","http://m.homeplus.co.kr/identity/login.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData18.put("i","$('#login_id').val('[[id]]');$('#user_passwd').val('[[pwd]]');identity.login();");
	siteData18.put("h","http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56080&nextUrl=http://www.homeplus.co.kr");
	siteData18.put("my","http://m.homeplus.co.kr/mypage/main.do");
	siteData18.put("j","document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://m.homeplus.co.kr:448/identity/loginProc.do\">" 
					+ "<input name=\"login_id\" value=\"[[id]]\">"
					+ "<input name=\"user_passwd\" value=\"[[pwd]]\">"
					+ "<input name=\"chkautologin\" value=\"Y\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>');");
	siteData18.put("f","");
	siteData18.put("o","http://m.homeplus.co.kr/identity/logout.do");
	siteData18.put("p","i_style");
	siteData18.put("re","SCRIPT=-=/front/orderComplete.do=-=(function() {return document.documentURI.substring(document.documentURI.indexOf('?ord_id=')+8);})()");
	siteData18.put("lc","cAAutoID=-=BLANK"); // 로그인을 확인하는 쿠키
	siteData18.put("cno",""); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData18.put("ld","https://m.homeplus.co.kr:448"); // 로그인 쿠키를 찾는 도메인 
	siteData18.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData18.put("icb",""); // 빅 아이콘 이미지
	siteData18.put("em",""); // 완료 메세지
	arrSiteData.put(siteData18);
	
	
	
	
	JSONObject siteData31 = new JSONObject();
	siteData31.put("n", "lottemart");
	siteData31.put("ic","");
	siteData31.put("t", "롯데마트");
	siteData31.put("m","http://m.lottemart.com");
	siteData31.put("l","");
	siteData31.put("i","");
	siteData31.put("h","");
	siteData31.put("my", "");
	siteData31.put("j", "");
	siteData31.put("f","");	
	siteData31.put("p","productcd");	
	arrSiteData.put(siteData31);
	
	
	JSONObject siteData7 = new JSONObject();
	siteData7.put("n",".lotte.com");
	siteData7.put("ic","app_icon_wemakeprice");
	siteData7.put("t", "롯데닷컴");
	siteData7.put("m","http://m.lotte.com");
	siteData7.put("l","https://m.lotte.com/login/m/loginForm.do?c=mlotte&udid=&v=&cn=&cdn=&tclick=m_footer_log&targetUrl=");//http%3A%2F%2Fm.lotte.com%2Fmain_phone.do");
	siteData7.put("i","$('#userId').val('[[id]]');$('#password').val('[[pwd]]');checkLogin('N');"); 
	siteData7.put("h","http://m.lotte.com/main.do?&cn=112346&cdn=783491");
	siteData7.put("my", "http://m.lotte.com/mylotte/m/mylotte.do");
	siteData7.put("j","document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://m.lotte.com/login/login.do\">"+
			 "<input name=\"userId\" value=\"[[id]]\">"+
			 "<input name=\"password\" value=\"[[pwd]]\">"+
			 "<input name=\"autoEasy\" value=\"1\">"+
			 "<input name=\"saveEasy\" value=\"1\">"+ 
			 "<input name=\"auto\" value=\"1\">"+ 
			 "<input name=\"save\" value=\"1\">"+
			 "<input name=\"grockle_yn\" value=\"N\">"+
			 "<input name=\"app_login_form\" value=\"N\">"+
			 "<input name=\"mach_knd_cd\" value=\"android\">"+
			 "<input name=\"fromPg\" value=\"0\">"+
			 "<input name=\"simpleSignMember\" value=\"N\">"+
			 "<input name=\"adultChkDrmc\" value=\"N\">"+
			 "</form>"+
			 "<script>lf.submit();" +
			 "</script>');");
	siteData7.put("f","loginResult('01',");
	siteData7.put("o","http://m.lotte.com/login/logout.do");
	siteData7.put("p","goods_no");	
	siteData7.put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return document.frm_purchase.orderNo.value;})()");
	siteData7.put("lc","LOGINCHK=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	siteData7.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData7.put("ld","http://m.lotte.com"); // 로그인 쿠키를 찾는 도메인 
	siteData7.put("icb",""); // 빅 아이콘 이미지
	siteData7.put("em",""); // 완료 메세지
	arrSiteData.put(siteData7); 
	
	
	JSONObject siteData13 = new JSONObject();
	siteData13.put("n","lotteimall");
	siteData13.put("ic","app_icon_wemakeprice");
	siteData13.put("t", "롯데아이몰");
	siteData13.put("m","http://m.lotteimall.com/main/viewMain.lotte");
	siteData13.put("l","https://securem.lotteimall.com/member/login/forward.LCLoginMem.lotte");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData13.put("i","$('#login_id').val('[[id]]');$('#password').val('[[pwd]]');$('.btn_login').click();");
	siteData13.put("h","http://www.lotteimall.com/coop/affilGate.lotte?chl_no=140769&chl_dtl_no=2540476");
	siteData13.put("my", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
	siteData13.put("j", "document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "+
			 "action=\"https://securem.lotteimall.com/member/goLogin.lotte\">"+
			 "<input name=\"login_id\" value=\"[[id]]\">"+
			 "<input name=\"password\" value=\"[[pwd]]\">"+
			 "<input name=\"memberGubun\" value=\"1\">"+
			 "<input name=\"aloginSave\" value=\"Y\">"+ 
			 "<input name=\"chkAloginSave\" value=\"Y\">"+
			 "<input name=\"memSave\" value=\"on\">"+
			 "</form>"+
			 "<script>lf.submit();" +"</script>');");
	siteData13.put("f","");
	siteData13.put("o","https://securem.lotteimall.com/member/goLogout.lotte");
	siteData13.put("p","goods_no");
	siteData13.put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return TRS_ORDER_ID})()");
	siteData13.put("lc","MC_ALOGIN_SEQ=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	siteData13.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData13.put("icb",""); // 빅 아이콘 이미지
	siteData13.put("ld","http://m.lotteimall.com"); // 로그인 쿠키를 찾는 도메인 
	siteData13.put("em",""); // 완료 메세지
	arrSiteData.put(siteData13);
	
	JSONObject siteData19 = new JSONObject();
	siteData19.put("n","ellotte");
	siteData19.put("ic","app_icon_wemakeprice");
	siteData19.put("t", "엘롯데");
	siteData19.put("m","http://m.ellotte.com/");
	siteData19.put("l","https://m.ellotte.com/login/m/loginForm.do");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData19.put("i","$('#userId').val('[[id]]');$('#password').val('[[pwd]]');checkLogin('N');");
	siteData19.put("h","http://m.ellotte.com/main.do?&cn=153348&cdn=2942692");
	siteData19.put("my", "https://m.ellotte.com/mylotte/purchase/m/purchase_list.do");
	siteData19.put("j","");
	siteData19.put("f","이메일 또는 비밀번호를 다시 확인하세요.");
	siteData19.put("o","http://m.ellotte.com/login/logout.do");
	siteData19.put("p","goods_no");
	siteData19.put("re","SCRIPT=-=/order/m/order_complete.do=-=(function() {return document.frm_purchase.orderNo.value;})()");
	siteData19.put("lc","LOGINCHK=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	siteData19.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData19.put("icb",""); // 빅 아이콘 이미지
	siteData19.put("ld","http://m.ellotte.com"); // 로그인 쿠키를 찾는 도메인 
	siteData19.put("em",""); // 완료 메세지

	arrSiteData.put(siteData19);

	JSONObject siteData14 = new JSONObject();
	siteData14.put("n","hnsmall");
	siteData14.put("ic","");
	siteData14.put("t", "홈엔쇼핑");
	siteData14.put("m","http://m.hnsmall.com");
	siteData14.put("l","https://m.hnsmall.com/customer/login");//http%3A%2F%2Fm.wemakeprice.com%2F");
	siteData14.put("i","$(\"input[name='mem_id']\").val('[[id]]');$(\"input[name='mem_pw']\").val('[[pwd]]');login(document.loginForm);");
	siteData14.put("h","http://m.hnsmall.com/channel/gate?channel_code=20200");
	siteData14.put("my", "https://securem.lotteimall.com/mypage/searchOrderListFrame.lotte");
	siteData14.put("j", "document.write('<form style=\"visibility:hidden\" name=\"lf\" method=\"post\" "
					+ "action=\"https://m.hnsmall.com/customer/loginproc\">" 
					+ "<input name=\"mem_id\" value=\"[[id]]\">"
					+ "<input name=\"mem_pw\" value=\"[[pwd]]\">" 
					+ "</form>" + "<script>lf.submit();" + "</script>');");
	siteData14.put("f","");
	siteData14.put("p","goods");
	siteData14.put("re","SCRIPT=-=/order/finish=-=(function() {return document.okcashback_from.order_no.value;})()");
	siteData14.put("lc","savePw=-=BLANK"); // 로그인을 확인하는 쿠키, =-=BLANK가 있으면 내용이 있는지 확인해야함
	siteData14.put("cno","https://"); // 로그인이 완료 됨을 확인하는 문자열(저 문자열의 URL이 지나야 로그인이 완료됨)
	siteData14.put("icb",""); // 빅 아이콘 이미지
	siteData14.put("ld","http://m.hnsmall.com"); // 로그인 쿠키를 찾는 도메인 
	siteData14.put("em",""); // 완료 메세지
	arrSiteData.put(siteData14);


	temp1.put("SITES",arrSiteData);
	temp1.put("ICONURL","http://img.enuri.info/images/mobilefirst/browser/marketicon/");
	
	temp1.put("EB_USE",true);//에누리 브라우져 사용 여부 
	temp1.put("COMFAIL","자동로그인&자동 로그인&아이디 찾기&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정");//에누리 브라우져 사용 여부
	
	jsonObject.put("iosDefineList", temp1);

	out.print(jsonObject);
	out.flush();
%>
