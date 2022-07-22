<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ver = request.getParameter("ver");
	String appid = request.getParameter("appid");

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
	JSONObject temp1 = new JSONObject();
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
temp1.put("EB_USE", "true");
temp1.put("REVIEW_SIZE", "100");
	
	temp1.put("ICONURL","http://img.enuri.info/images/mobilefirst/browser/marketicon/");
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	JSONArray arrMallData = new JSONArray();
	arrMallData.put("/http/json/coupang.json");
	arrMallData.put("/http/json/dealTimon.json");
	arrMallData.put("/http/json/wemeke.json");

	arrMallData.put("/http/json/shocking.json");
	arrMallData.put("/http/json/superDeal.json");
	arrMallData.put("/http/json/allKill.json");
	
	temp1.put("MALLDATA",arrMallData);
	
	JSONArray arrMallIcon = new JSONArray();
	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_coupang");
	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_tmon");
	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_wemake");

	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_shoking");
	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_superdill");
	arrMallIcon.put("/images/mobilefirst/module/tabs/tab_allkill");
	

	
	// arrMallIcon.put("/images/mobilefirst/module/tabs/tab_shoking");
	temp1.put("MALLICON",arrMallIcon);

	
	
	
            
            
	
	
	
	HashMap<String, JSONObject> sil = new HashMap<String, JSONObject>();
	String[] siteNameList = {  "auction","gmarket","11st",  "coupang", "wemakeprice" ,"ticketmonster", "interpark" , "shinsegaemall", ".lotte.com", "hyundaihmall", "akmall", "gsshop", "cjmall", "lotteimall", "hnsmall", ".emart", "ellotte","galleria", ".nsmall.com", "ssg", "e-himart", "g9",
						 "okmall", "homeplus", "lottemart" };

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
	sil.get("gsshop").put("ic","app_icon_gsshop");
	sil.get("wemakeprice").put("ic","app_icon_wemakeprice1015");
	sil.get("ticketmonster").put("ic","app_icon_ticketmonster");
	sil.get("cjmall").put("ic","app_icon_cjmall");
	sil.get("hyundaihmall").put("ic","");
	sil.get("akmall").put("ic","app_icon_akmall");
	sil.get("e-himart").put("ic","");
	sil.get("galleria").put("ic","app_icon_galleria");
	sil.get("okmall").put("ic","");
	sil.get(".nsmall.com").put("ic","app_icon_nsshopping");
	sil.get("homeplus").put("ic","");
	sil.get("lottemart").put("ic","app_icon_lottemart");
	sil.get(".lotte.com").put("ic","app_icon_lottecom_new");
	sil.get("lotteimall").put("ic","app_icon_lotteimall_new");//app_icon_lotteimall_new
	sil.get("ellotte").put("ic","app_icon_ellotte_new");
	sil.get("hnsmall").put("ic","app_icon_homenshopping");
	sil.get("coupang").put("ic","app_icon_coupang");
	
	
	sil.get("11st").put("id", 1);
	sil.get("gmarket").put("id", 2);
	sil.get("g9").put("id", 3);
	sil.get("auction").put("id", 4);
	sil.get("interpark").put("id", 5);
	sil.get(".emart").put("id", 6);
	sil.get("shinsegaemall").put("id", 7);
	sil.get("ssg").put("id", 8);
	sil.get("gsshop").put("id", 9);
	sil.get("wemakeprice").put("id", 10);
	sil.get("ticketmonster").put("id", 11);
	sil.get("cjmall").put("id", 12);
	sil.get("hyundaihmall").put("id", 13);
	sil.get("akmall").put("id", 14);
	sil.get("e-himart").put("id", 15);
	sil.get("galleria").put("id", 16);
	sil.get("okmall").put("id", 17);
	sil.get(".nsmall.com").put("id", 18);
	sil.get("homeplus").put("id", 19);
	sil.get("lottemart").put("id", 20);
	sil.get(".lotte.com").put("id", 21);
	sil.get("lotteimall").put("id", 22);
	sil.get("ellotte").put("id", 23);
	sil.get("hnsmall").put("id", 24);
	sil.get("coupang").put("id", 25);
	
	

	// 이름 입력 : [t]
	sil.get("11st").put("t", "11번가");
	sil.get("gmarket").put("t", "G마켓");
	sil.get("g9").put("t", "G9");
	sil.get("auction").put("t", "옥션");
	sil.get("interpark").put("t", "인터파크");
	sil.get(".emart").put("t", "이마트");
	sil.get("shinsegaemall").put("t", "신세계몰");
	sil.get("ssg").put("t", "SSG.COM");
	sil.get("gsshop").put("t", "GS Shop");
	sil.get("wemakeprice").put("t", "위메프");
	sil.get("ticketmonster").put("t", "티몬");
	sil.get("cjmall").put("t", "CJ mall");
	sil.get("hyundaihmall").put("t", "현대아이몰");
	sil.get("akmall").put("t", "AK몰");
	sil.get("e-himart").put("t", "하이마트");
	sil.get("galleria").put("t", "갤러리아");
	sil.get("okmall").put("t", "OKMALL");
	sil.get(".nsmall.com").put("t", "ns홈쇼핑");
	sil.get("homeplus").put("t", "홈플러스");
	sil.get("lottemart").put("t", "롯데마트");
	sil.get(".lotte.com").put("t", "롯데닷컴");
	sil.get("lotteimall").put("t", "롯데홈쇼핑");
	sil.get("ellotte").put("t", "엘롯데");
	sil.get("hnsmall").put("t", "홈앤쇼핑");
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
	sil.get("cjmall").put("m","http://mw.cjmall.com/");
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
	// sil.get("11st").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.11st.co.kr/MW\",\"h\":[{\"hurl\":\"http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1000997249\"},{\"hurl\":\"http://m.11st.co.kr/\"},{\"hurl\":\"http://m.11st.co.kr/MW\"},{\"hurl\":\"http://m.11st.co.kr/MW/\"},{\"hurl\":\"http://m.11st.co.kr/MW/index.html\"}]}]");//X
	// sil.get("gmarket").put("redirect","[{\"t\":\"c\",\"url\":\"http://mobile.gmarket.co.kr/?pCache=\"},{\"t\":\"e\",\"url\":\"http://sna.gmarket.co.kr/?cc=CHD0B001&url=http://www.gmarket.co.kr/\"}]");
	// sil.get("g9").put("redirect","");
	// // sil.get("auction").put("redirect","[{\"t\":\"e\",\"url\":\"http://mobile.auction.co.kr/HomeMain\"}]");
	// sil.get("interpark").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shop.interpark.com/#mwm1=common&mwm2=header&mwm3=bi\"}]");
	// sil.get(".emart").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.emart.ssg.com/\"}]");
	// sil.get("shinsegaemall").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.shinsegaemall.ssg.com/mall/main.ssg\"}]");
	// sil.get("ssg").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ssg.com/\"}]");
	// sil.get("gsshop").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.gsshop.com/index.gs\"}]");
	// sil.get("wemakeprice").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.wemakeprice.com/m/\"}]");
	// sil.get("ticketmonster").put("redirect","[{\"t\":\"e\",\"url\":\"http://m.ticketmonster.co.kr/\"}]");
	// sil.get("cjmall").put("redirect","[{\"t\":\"c\",\"url\":\"http://mw.cjmall.com/m/main.jsp\",\"pv\":[{\"p\":\"app_cd\",\"v\":\"ENURI\"}]}]");
	// sil.get("hyundaihmall").put("redirect","");
	// sil.get("akmall").put("redirect","");
	// sil.get("e-himart").put("redirect","");
	// sil.get("galleria").put("redirect","");
	// sil.get("okmall").put("redirect","");
	// sil.get(".nsmall.com").put("redirect","");
	// sil.get("homeplus").put("redirect","[{\"t\":\"c\",\"url\":\"http://mdirect.homeplus.co.kr/front.app.exhibition.main.Main.ghs\",\"pv\":[{\"p\":\"extends_id\",\"v\":\"enuri\"}]}]");
	// sil.get("lottemart").put("redirect","");
	// sil.get(".lotte.com").put("redirect","[{\"t\":\"c\",\"url\":\"http://m.lotte.com/main_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"112346\"},{\"p\":\"cdn\",\"v\":\"783491\"}]}]");
	// sil.get("lotteimall").put("redirect","");
	// sil.get("ellotte").put("redirect","[{\"t\":\"c\",\"url\":\"http://m.ellotte.com/main_ellotte_phone.do?\",\"pv\":[{\"p\":\"cn\",\"v\":\"153348\"},{\"p\":\"cdn\",\"v\":\"2942692\"}]}]");
	// sil.get("hnsmall").put("redirect","");
	// sil.get("coupang").put("redirect","");
	
	
	// 쇼핑몰 상품창 구분자 : [p]
	sil.get("11st").put("p","prdno=;productbasicinfo.tmall");
	sil.get("gmarket").put("p","goodscode=;item");
	sil.get("g9").put("p","display/vip");
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
	sil.get("coupang").put("p","/nm/products/");

	// 쇼핑몰 상품창 구분자 : [p]
	sil.get("auction").put("p2","ego.aspx;p=");
	sil.get("gsshop").put("p2","/deal/deal.gs;dealno=");
	sil.get("wemakeprice").put("p2","mobile_app/direct_to_app");
	sil.get("coupang").put("p2","/vm/products/");
	sil.get("cjmall").put("p2","/m/mocode;app_cd=");

	//("p","/deal/deal.gs;dealno=");
	///sil.get("auction").put("p2","/ego.aspx;p=");//("p","/deal/deal.gs;dealno=");








	
	sil.get("11st").put("info","(function(){return 	$('.dtl_tit').text().trim()+\"EnuRi\"+$('link[rel=\"image_src\"]').attr('href')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.dtl_total .prc b').text();})()");//http://m.11st.co.kr/MW/Product/productBasicInfo.tmall?trTypeCd=MW001&prdNo=1243511989	
	sil.get("gmarket").put("info","(function(){return $('title').text()+\"EnuRi\"+$('meta[property=\"og:image\"]').attr('content')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pri1').text();})()");//http://mitem.gmarket.co.kr/Item?goodsCode=156928441
	sil.get("g9").put("info","(function(){return $('.info_area .prod_cont .info_box .tit2').text()+\"EnuRi\"+$('.item_bnr .thmb img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.info_area .price').text();})()");//http://m.g9.co.kr/VIP.htm#/Display/VIP/785543628
	sil.get("auction").put("info","(function(){return $('.title span').text()+\"EnuRi\"+ $('.content-slider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.elements_info .price .ng-scope strong').text();})()");//http://mmya.auction.co.kr/item/vip#/A540826340
	sil.get("interpark").put("info","(function(){return $('#sub_title').text()+\"EnuRi\"+$('.slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+ $('.discountedPrice .numeric').text()+'원';})()");//http://m.shop.interpark.com/product/1153214449/0000100000?pay_disp_no=008016002003002
	sil.get(".emart").put("info","(function(){return $('.article-title h3').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.article-title .sale').text().trim();})()");//http://m.emart.ssg.com/item/itemView.ssg?itemId=1000016842242&siteNo=6001&salestrNo=2039
	sil.get("shinsegaemall").put("info","(function(){return $('.txt01 em').text()+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr_area .price').text();})()");//http://m.emart.ssg.com/item/itemView.ssg?itemId=1000016842242&siteNo=6001&salestrNo=2039
	sil.get("ssg").put("info","(function(){return $('.mallprd_info h3').text().trim().replace('\n','').replaceAll('\t','')+\"EnuRi\"+$('.flick-ct').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.prd_sel .price').text().trim();})()");//http://m.ssg.com/item/itemView.ssg?itemId=0000007024783&siteNo=6001&salestrNo=2449
	sil.get("gsshop").put("info","(function(){return $('.prdNames').text()+\"EnuRi\"+$('.swiper-slide-active’).find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.infoPrice strong ').text()+'원';})()");//http://m.gsshop.com/prd/prd.gs?prdid=16820974&pgmID=179126
	sil.get("wemakeprice").put("info","(function(){return $('.info-area #main_name').text()+\"EnuRi\"+$('#img_app_onecut').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price_area .sale').text();})()");//http://m.wemakeprice.com/m/deal/adeal/1027498/100200/?source=m_bestdeal&no=1
	sil.get("ticketmonster").put("info","(function(){return $('.info h2').text()+\"EnuRi\"+$('.deal_summary').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pr .dc').text();})()");//http://m.ticketmonster.co.kr/deal/detailDaily/176807793?cat=
	sil.get("cjmall").put("info","(function(){  var a =$('.flick-container').find('img:eq(0)').attr('src'); if(a.indexOf('?')!=-1) a= a.substring(0,a.indexOf('?')); if(a.indexOf('http')==-1) a= 'http:'+a;return $('.prd_info h1').text().trim()+\"EnuRi\"+a+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.prd_price .price strong').text()+'원';})()");//http://fdrive.cjmall.com/m/mocode/M1001445?app_cd=WTM2&pic=dealgoods_M1001445_1
	sil.get("hyundaihmall").put("info","(function(){return $('.title1 h2').text()+\"EnuRi\"+$('#detailPageImgSlide .selected img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.group .price1').text();})()");//http://m.g9.co.kr/VIP.htm#/Display/VIP/785543628
	
	sil.get("akmall").put("info","(function(){return $('.info_top h2').text().trim().replace('\n','')+\"EnuRi\"+'http:'+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.discount').text();})()");//http://m.g9.co.kr/VIP.htm#/Display/VIP/785543628
		
		
	sil.get("galleria").put("info","(function(){return $('.dt_pr .dt_pr_tx strong').text()+' '+$('.dt_pr .dt_pr_tx .min').text()+\"EnuRi\"+$('#dtSwipeList .pinch-zoom_no img').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.pri').eq(1).text();})()");//http://mobile.galleria.co.kr/item/showItemDtl.do?item_id=2214734
	sil.get(".nsmall.com").put("info","(function(){return $('.test #productName').text()+\"EnuRi\"+$('.swipe_bannerArea.goods_thumbnailArea').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#txtOfferPriceIns').text();})()");//http://m.nsmall.com/#M_G2600000M&pageNewUrlNum=2
	sil.get("homeplus").put("info","(function(){return $('.discount').text() +' '+$('.heading h2').text()+\"EnuRi\"+$('.flex-active-slide').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.value1').text();})()");//http://m.homeplus.co.kr/product/info.do?good_id=125945270&MT.ac=Main_keyword_1items&wiselogDummy=
	sil.get("lottemart").put("info","(function(){return $('.goodstitle').text()+\"EnuRi\"+$('.swiper-wrapper').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('#ItemCurrSalePrc').text()+'원';})()");//http://m.lottemart.com/mobile/cate/PMWMCAT0004_New.do?ProductCD=2485250000006&CategoryID=C006008000770001&SITELOC=OH005
	sil.get(".lotte.com").put("info","(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");//http://m.lotte.com/product/m/product_view.do?c=mlotte&udid=&v=&cn=&cdn=&schema=&goods_no=236532008&curDispNoSctCd=20&tclick=m_DC_Planshop_Clk_Prd_idx1
	sil.get("lotteimall").put("info","(function(){return $('#goodsNm').text()+\"EnuRi\"+$('.prodCont.clfix').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.price.dc_price .big').text();})()");//http://m.lotteimall.com/goods/viewGoodsDetail.lotte?goods_no=1135145814&grbyEndDtime=20160405095900&clog=4001_1
	sil.get("ellotte").put("info","(function(){return $('.titText').text()+\"EnuRi\"+$('.dSwipeImg').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.titPrice').text().trim();})()");//http://m.ellotte.com/product/m/product_view.do?c=mlotte&udid=&v=&cn=&cdn=&schema=&goods_no=210987356&curDispNoSctCd=20&tclick=m_EL_Planshop_Clk_Prd_idx1
	sil.get("hnsmall").put("info","(function(){return $('h2.tit').text()+\"EnuRi\"+$('.pd_img.bxslider').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('strong.priceRed').text()+'원';})()");;//http://m.hnsmall.com/goods/view/12179070?planclass_code=00000047&plan_code=2013031252
	sil.get("coupang").put("info","(function(){return $('.clearfix dt').text()+\"EnuRi\"+$('.detail-main').find('img:eq(0)').attr('src')+\"EnuRi\"+$(location).attr('href')+\"EnuRi\"+$('.detail-main-info  .clearfix .sale-price').text();})()");//http://m.coupang.com/nm/products/3000045664


 

	


	// 팝업 url
	// IOS에서 팝업을 실행하도록 해줌
	sil.get("interpark").put("popupUrl","/order/shop/pay_addr_zip.html=-=/product/content.html");
	sil.get("hyundaihmall").put("popupUrl","/front/smItemDetailImg.do");

	// IOS에서 무시해야할 URL return YES
	sil.get("11st").put("noUrl","/a.st?url");

	// 사이트 아이디 입력 : [n]
	for(int i=0; i<siteNameList.length; i++) {
		sil.get(siteNameList[i]).put("n", siteNameList[i]);
	}

	// 사이트정보 json에 입력
	JSONArray arrSiteData = new JSONArray();
	for(int i=0; i<siteNameList.length; i++) {
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