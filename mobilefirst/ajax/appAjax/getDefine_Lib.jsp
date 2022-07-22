<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");
		String pack = request.getParameter("package");

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

	
	temp1.put("GO_CLOSE", "close://");
	
	temp1.put("SHARE_TEXT", "sharetext:");
	temp1.put("SHARE_TEXT_TITLE", "공유");
	temp1.put("SHARE_TYPE", "text/plain");
	
	temp1.put("ENURI_GETMOBILE", "enuri.com/mobilefirst/move.jsp");

	
	
	
	temp1.put("ICONURL","http://img.enuri.info/images/mobilefirst/browser/marketicon/");
	
	temp1.put("EB_USE", true);//에누리 브라우져 사용 여부 
	
	temp1.put("IOS_LOGIN_LIMITE", "10"); // ajax로만 동작하는 쇼핑몰에서는 로그아웃을 확인하기가 힘듬, 따라서 타임아웃으로 결정함
	temp1.put("IOS_LOGOUT_LOGIN_INFO_DEL", "Y"); // IOS에서 로그아웃 할때 쇼핑몰들의 로그인 정보를 삭제할지를 결정하는 플래그 Y:삭제
	
	temp1.put("COMFAIL","자동로그인&자동 로그인&아이디 찾기&비밀번호가 일치하지&아이디 저장&로그인 상태 유지&아이디 저장&자동로그인 설정&http%3A%2F%2Fmember.auction.co.kr%2FAuthenticate%2F%3Freturn_value%3D-1&loginResult('01'");//에누리 브라우져 사용 여부

	
	temp1.put("REVIEW_SIZE","100");

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
	sil.get("cjmall").put("l","https://mw.cjmall.com/m/login/login.jsp");//http%3A%2F%2Fm.wemakeprice.com%2F");
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
	sil.get("auction").put("redirect","[{\"t\":\"e\",\"url\":\"http://mobile.auction.co.kr/HomeMain\"}]");
	sil.get("interpark").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shop.interpark.com/#mwm1=common&mwm2=header&mwm3=bi\"}]");
	sil.get(".emart").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.emart.ssg.com/\"}]");
	sil.get("shinsegaemall").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shinsegaemall.ssg.com/mall/main.ssg\"}]");
	sil.get("ssg").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ssg.com/\"}]");
	sil.get("gsshop").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.gsshop.com/index.gs\"}]");
	sil.get("wemakeprice").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.wemakeprice.com/m/\"}]");
	sil.get("ticketmonster").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ticketmonster.co.kr/\"}]");
	sil.get("cjmall").put("redirect","[{\"t\":\"c\",\"url\":\"http://mw.cjmall.com/m/main.jsp\",\"pv\":[{\"p\":\"app_cd\",\"v\":\"ENURI\"}]}]");
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