<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.ShopUrl_Proc"%>
<%@ page import="com.enuri.bean.mobile.ShopUrl_Data"%>
<%
	String shopUrl = ConfigManager.RequestStr(request, "shopUrl", "");
	int shop_code = 0;

	if(shop_code==0) {
		if(shopUrl.indexOf(".gmarket.")>=0) {
			shop_code = 536;
		} else if(shopUrl.indexOf(".auction.")>=0) {
			shop_code = 4027;
		} else if(shopUrl.indexOf("books.11st.")>=0) {
			shop_code = 6378;
		} else if(shopUrl.indexOf(".11st.")>=0) {
			shop_code = 5910;
		} else if(shopUrl.indexOf(".interpark.")>=0) {
			shop_code = 55;
		} else if(shopUrl.indexOf(".gseshop.")>=0 || shopUrl.indexOf(".gsshop.")>=0) {
			shop_code = 75;
		} else if(shopUrl.indexOf(".lotteimall.")>=0) {
			shop_code = 663;
		} else if(shopUrl.indexOf(".hmall.")>=0 || shopUrl.indexOf(".hyundaihmall.")>=0) {
			shop_code = 57;
		} else if(shopUrl.indexOf(".cjmall.")>=0) {
			shop_code = 806;
		} else if(shopUrl.indexOf(".oclock.")>=0) {
			shop_code = 6688;
		} else if(shopUrl.indexOf(".nsmall.")>=0) {
			shop_code = 974;
		} else if(shopUrl.indexOf(".hnsmall.")>=0) {
			shop_code = 6588;
		} else if(shopUrl.indexOf("shinsegaemall.")>=0) {
			shop_code = 47;
		} else if(shopUrl.indexOf(".lotte.")>=0) {
			shop_code = 49;
		} else if(shopUrl.indexOf(".dnshop.")>=0) {
			shop_code = 1878;
		} else if(shopUrl.indexOf(".akmall.")>=0) {
			shop_code = 90;
		} else if(shopUrl.indexOf(".ellotte.")>=0) {
			shop_code = 6547;
		} else if(shopUrl.indexOf(".e-himart.")>=0) {
			shop_code = 6252;
		} else if(shopUrl.indexOf(".compuzone.")>=0) {
			shop_code = 1634;
		} else if(shopUrl.indexOf(".icoda.")>=0) {
			shop_code = 273;
		} else if(shopUrl.indexOf(".lotsshop.")>=0) {
			shop_code = 6300;
		} else if(shopUrl.indexOf(".wemakeprice.")>=0) {
			shop_code = 6508;
		} else if(shopUrl.indexOf(".etland.")>=0) {
			shop_code = 58;
		} else if(shopUrl.indexOf("ssg.")>=0 || shopUrl.indexOf(".emartmall.")>=0) {
			shop_code = 374;
		} else if(shopUrl.indexOf(".homeplus.")>=0) {
			shop_code = 6361;
		} else if(shopUrl.indexOf(".epost.")>=0) {
			shop_code = 5438;
		} else if(shopUrl.indexOf(".gsisuper.")>=0) {
			shop_code = 6622;
		} else if(shopUrl.indexOf(".dongwonmall.")>=0) {
			shop_code = 6193;
		} else if(shopUrl.indexOf(".0to7.")>=0) {
			shop_code = 6095;
		} else if(shopUrl.indexOf(".yes24.")>=0) {
			shop_code = 3367;
		} else if(shopUrl.indexOf(".aladin.")>=0) {
			shop_code = 4861;
		} else if(shopUrl.indexOf(".bandinlunis.")>=0) {
			shop_code = 4858;
		} else if(shopUrl.indexOf(".linkprice.")>=0) {
			shop_code = 6367;
		} else if(shopUrl.indexOf(".boribori.")>=0) {
			shop_code = 6603;       
		} else if(shopUrl.indexOf(".galleria.")>=0) {
			shop_code = 6620;   
		} else if(shopUrl.indexOf(".halfclub.")>=0) {
			shop_code = 6644;       
		} else if(shopUrl.indexOf(".lgfashionshop.")>=0 || shopUrl.indexOf(".lfmall.")>=0) {
			shop_code = 6634;
		} else if(shopUrl.indexOf(".ticketmonster.")>=0) {
			shop_code = 6641;
		} else if(shopUrl.indexOf("shop2.olleh.")>=0) {
			shop_code = 6346;
		} else if(shopUrl.indexOf(".cjonmart.")>=0) {
			shop_code = 6165;
		} else if(shopUrl.indexOf(".mrkoon.")>=0) {
			shop_code = 6667;
		} else if(shopUrl.indexOf(".1200m.")>=0) {
			shop_code = 5962;
		} else if(shopUrl.indexOf(".babosarang.")>=0) {
			shop_code = 5978;
		} else if(shopUrl.indexOf(".fashionplus.")>=0) {
			shop_code = 6389;
		} else if(shopUrl.indexOf("shop.adidas.")>=0) {
			shop_code = 6657;
		} else if(shopUrl.indexOf(".nikestore.")>=0) {
			shop_code = 6414;
		} else if(shopUrl.indexOf("store.musinsa.")>=0) {
			shop_code = 6666;
		} else if(shopUrl.indexOf(".hanssem.")>=0) {
			shop_code = 6044;
		} else if(shopUrl.indexOf("toysrus.")>=0) {
			shop_code = 7695;
		} else if(shopUrl.indexOf(".lottemart.")>=0) {
			shop_code = 7455;
		}
	}

	shopUrl = URLDecoder.decode(shopUrl);

	Pattern pattern  = null;
	Matcher match = null;

	// url ??? ?????? ????????? ?????? ????????????  ??????   
	String prdNo = "";		//  ????????????
	String splitChar = "";

	if(shop_code==4027) { // ?????? http://www.auction.co.kr
		pattern = Pattern.compile("(?i)itemNo=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==536) { // ????????? http://www.gmarket.co.kr
		pattern = Pattern.compile("(?i)goodscode=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if((shop_code==6378 || shop_code==5910) || shop_code==55) {
		if(shopUrl.indexOf("product/")>-1) {
			pattern = Pattern.compile("(?i)product/([0-9a-zA-Z]*)");
			splitChar = "/";
		} else {
			pattern = Pattern.compile("(?i)prdNo=([0-9a-zA-Z]*)");
			splitChar = "=";
		}
	} else if(shop_code==663) {
		pattern = Pattern.compile("(?i)goods_no=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6508) {
		pattern = Pattern.compile("(?i)adeal/([0-9a-zA-Z]*)");
		splitChar = "/";
	} else if(shop_code==90) {
		pattern = Pattern.compile("(?i)goods_id=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==374) {
		pattern = Pattern.compile("(?i)itemId=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==806) {
		pattern = Pattern.compile("(?i)item_cd=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6252 || shop_code==75) {
		pattern = Pattern.compile("(?i)prdid=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==7455) {
		pattern = Pattern.compile("(?i)ProductCD=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==57) {
		pattern = Pattern.compile("(?i)ItemCode=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6620) {
		pattern = Pattern.compile("(?i)item_id=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6588) {
		pattern = Pattern.compile("(?i)goods_code=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6588) {
		pattern = Pattern.compile("(?i)no=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==974) {
		pattern = Pattern.compile("(?i)partNumber=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6361) {
		pattern = Pattern.compile("(?i)i_style=([0-9a-zA-Z]*)");
		splitChar = "=";
	} else if(shop_code==6641) {
		pattern = Pattern.compile("(?i)detailDaily/([0-9a-zA-Z]*)");
		splitChar = "=";
	} else {
	}

	// ???????????? ????????? ????????? ????????? ?????? 
	if(pattern != null) {
		match = pattern.matcher(shopUrl);
	}

	if(match != null && match.find()) { // ??????????????? ????????? ??????
		prdNo = match.group(0); 
	}

	String goodsCode = "";
	if(prdNo.length()>0 && splitChar.length()>0) {
		if(prdNo.indexOf(splitChar)>-1) {
			String[] goodsCodeAry = prdNo.split(splitChar);
			goodsCode = goodsCodeAry[1];
		} else {
			goodsCode = prdNo;
		}
	}

	ShopUrl_Data shopurl_data = null;
	ShopUrl_Proc shopurl_proc = new ShopUrl_Proc();

	shopurl_data = shopurl_proc.getGoodsCodeToUrl(shop_code, goodsCode);

	// PC ????????? ??????????????? ?????? URL
	String shopLocUrl = "";
	if(shopurl_data!=null && shopurl_data.getUrl().length()>0) {
	//	shopLocUrl = shopurl_data.getUrl();
	}
	//out.println("shopurl_data.getUrl()="+shopurl_data.getUrl());

	// ?????? PC??????????????? ???????????? ?????? URL??? ???????????? ????????? ???????????? ?????? ????????? ???????????? ???????????????
	if(shopLocUrl.length()==0) {
		if(shop_code==4027) { // ?????? http://www.auction.co.kr
			shopLocUrl = "http://pd.auction.co.kr/pd_redirect.asp?itemno="+goodsCode+"&pc=589";
		} else if(shop_code==536) { // ????????? http://www.gmarket.co.kr
			shopLocUrl = "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode="+goodsCode+"&GoodsSale=Y&jaehuid=200002673";
		} else if(shop_code==6378) { // ?????? 11??????
			shopLocUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&prdNo="+goodsCode+"&tid=1000000125 ";
		} else if(shop_code==5910) { // 11??????
			shopLocUrl = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&prdNo="+goodsCode+"&tid=1000000125";
		} else if(shop_code==55) { // ????????????
			shopLocUrl = "http://www.interpark.com/gate/ippgw.jsp?goods_no="+goodsCode+"&biz_cd=P00335&aa=om";
		} else if(shop_code==663) { // ??????i???
			shopLocUrl = "http://www.lotteimall.com/coop/affilGate.lotte?chl_no=20&chl_dtl_no=&returnUrl=/goods/viewGoodsDetail.lotte?goods_no="+goodsCode;
		} else if(shop_code==6508) { // ?????????
			shopLocUrl = "http://www.wemakeprice.com/widget/aff_bridge_public/enuri/"+goodsCode+"/Y/PRICE_af/"+goodsCode+"/0240A7/enuri";
		} else if(shop_code==90) { // AKmall
			shopLocUrl = "http://www.akmall.com/assc/associate.do?assc_comp_id=12189&goods_id="+goodsCode;
		} else if(shop_code==374) { // ????????????
			shopLocUrl = "http://emart.ssg.com/item/itemDtl.ssg?itemId="+goodsCode+"&siteNo=6001&ckwhere=enuri&pid=enuri&sid=en001";
		} else if(shop_code==806) { // CJmall
			shopLocUrl = "http://www.cjmall.com/joinmall/gate.jsp?gate_code=0011&wacode=000200110482&url=http://www.cjmall.com/prd/detail_cate.jsp?item_cd="+goodsCode;
		} else if(shop_code==6252) { // ????????????
			shopLocUrl = "http://www.e-himart.co.kr/store/prditm.jsp?prdid=1135&prditmid="+goodsCode+"&fromShop=enuri";
		} else if(shop_code==75) { // GS SHOP
			shopLocUrl = "http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?media=Pg&ecpid="+goodsCode+"&utm_source=price&utm_medium=affiliate&utm_campaign=enuri";
		} else if(shop_code==7455) { // ???????????????
			// CategoryID ?????? ?????? ?????????
			// CategoryID????????? ????????? ???
			//shopLocUrl = "http://www.lottemart.com/product/ProductDetail.do?CategoryID=C001001600040005&ProductCD="+goodsCode+"&AFFILIATE_ID=01030001&CHANNEL_CD=00056";
			shopLocUrl = "http://www.lottemart.com/product/ProductDetail.do?ProductCD="+goodsCode+"&AFFILIATE_ID=01030001&CHANNEL_CD=00056";
		} else if(shop_code==57) { // ?????? hmall
			shopLocUrl = "http://www.hyundaihmall.com/front/pda/itemPtc.do?ReferCode=022&slitmCd="+goodsCode;
		} else if(shop_code==6620) { // ???????????????
			shopLocUrl = "http://www.galleria.co.kr/common.do?method=join&link_id=0010&channel_id=2763&params="+goodsCode;
		} else if(shop_code==6588) { // ????????????
			shopLocUrl = "http://www.hnsmall.com/channel/channel.do?channel_code=20008&goods_code="+goodsCode;
		} else if(shop_code==974) { // nsmall
			shopLocUrl = "http://www.nsmall.com/jsp/site/gate.jsp?co_cd=190&good_id="+goodsCode+"&target=/ProductDisplay";
		} else if(shop_code==6361) { // ????????????
			shopLocUrl = "http://www.homeplus.co.kr/app.exhibition.main.PartnerMall.ghs?extends_id=enuri&service_cd=56010&nextUrl=/app.product.GoodDetail.ghs%3Fcomm%3Dusr.detail%26good_id%3D"+goodsCode+"%26extends_id%3Denuri%26service_cd%3D56010";
		} else if(shop_code==6641) { // ??????
			shopLocUrl = "http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no="+goodsCode;
		} else {
		}
	}

	// PC?????? ????????? ?????? URL??? ????????? ??????????????? ??????
	if(shopLocUrl.length()>0) {
		shopLocUrl = toUrlCode(shopLocUrl);
	}

	// ?????? ????????? ????????? URL??? ???????????? ????????? ????????? ?????? URL??? ?????????
	if(shopLocUrl.length()==0) shopLocUrl = shopUrl;

	// ???????????? url??? ??????????????? ???
	response.sendRedirect(shopUrl);
/*
	out.println("<br>shopUrl="+shopUrl);
	out.println("<br>shop_code="+shop_code);
	out.println("<br>prdNo="+prdNo);
	out.println("<br>goodsCode="+goodsCode);
	out.println("<br>shopLocUrl="+shopLocUrl);
*/
%>
