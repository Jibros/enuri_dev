<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data"%>
<%@ page import="com.enuri.bean.global.Global_Shop_Json"%>
<%@page import="com.enuri.bean.main.Reward_Cate_Rate" %>
<jsp:useBean id="Reward_Cate_Rate" class="com.enuri.bean.main.Reward_Cate_Rate" scope="page" />
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Proc" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Data" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Goods_Info_Data" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data" scope="page" />
<jsp:useBean id="Global_Shop_Json" class="com.enuri.bean.global.Global_Shop_Json" scope="page" />
<%
	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	String strPreview = ChkNull.chkStr(request.getParameter("preview"),"0");

	//if(strReferer != null && !strReferer.equals("")){	//불법 접근 차단

	int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
	int intGroup = ChkNull.chkInt(request.getParameter("group"),0);
	String strCate = ChkNull.chkStr(request.getParameter("ca_code"),"0201");
	String strTabinfoYn = ChkNull.chkStr(request.getParameter("tabinfoyn"),"N"); //정렬기준 항목정보 리턴 여부
	String strTabinfoYnString = "";
	String tab_open = ChkNull.chkStr(request.getParameter("tabyn_open"),""); //오픈마켓
	String tab_dlv0 = ChkNull.chkStr(request.getParameter("tabyn_dlv0"),""); //무료배송
	String tab_junggo = ChkNull.chkStr(request.getParameter("tabyn_junggo"),""); //전시/중고
	String tab_return = ChkNull.chkStr(request.getParameter("tabyn_return"),""); //반품
	String tab_tariffree = ChkNull.chkStr(request.getParameter("tabyn_tariffree"),""); //세금/배송비무료(해외쇼핑)
	String tab_auth = ChkNull.chkStr(request.getParameter("tabyn_auth"),""); //제조사 공식인증판매자
	String tab_realprice = ChkNull.chkStr(request.getParameter("tabyn_realprice"),""); //판매가쇼핑몰
	String tab_aircon_1 = ChkNull.chkStr(request.getParameter("tabyn_aircon_1"),""); //기본설치비(스탠드+벽걸이) 포함
	String tab_aircon_2 = ChkNull.chkStr(request.getParameter("tabyn_aircon_2"),""); //기본설치비(스탠드+벽걸이+진공비) 포함
	String tab_aircon_4 = ChkNull.chkStr(request.getParameter("tabyn_aircon_4"),""); //기본설치비+진공비 포함
	String tab_tirefree = ChkNull.chkStr(request.getParameter("tabyn_tirefree"),""); //전국무료장착(타이어)
	String tab_depart = ChkNull.chkStr(request.getParameter("tabyn_depart"),""); //백화점몰
	String tab_card = ChkNull.chkStr(request.getParameter("tabyn_card"),""); //카드할인
	String tab_cardfree = ChkNull.chkStr(request.getParameter("tabyn_cardfree"),""); //무이자
	String tab_etcmall = ChkNull.chkStr(request.getParameter("tabyn_etcmall"),""); //무이자
	String tab_minsort = ChkNull.chkStr(request.getParameter("tabyn_minsort"),""); //배송비미포함
	String tab_dminsort = ChkNull.chkStr(request.getParameter("tabyn_dminsort"),""); //배송비포함
	String strCardsort = ChkNull.chkStr(request.getParameter("card_sort"),""); //카드할인가 적용 정렬

	int intPage = ChkNull.chkInt(request.getParameter("page"),1);
	int intPagesize = ChkNull.chkInt(request.getParameter("pagesize"),50);

	//최저가 가지고 오기.. 초기에는 0
	long lngInstanceMinPrice = ChkNull.chkInt(request.getParameter("instanceminprice"),0);

	String strSort = "";

	int intModelno_group = 0;//goods_data_pop.getModelno_group();

	if(tab_dminsort.equals("Y"))	strSort = "Y";		//배송비 포함가
	if(tab_card.equals("Y"))			strSort = "C";		//카드할인가

	Goods_Data goods_data_pop = null;

	String strTmp_modelnos = ChkNull.chkStr(request.getParameter("modelnos"),"");	//체크 항목 리스트
	boolean blChk_group = false;

	if(strTmp_modelnos.indexOf(",") > -1){
		intModelno= Mobile_Goods_Proc.get_Minpricemodelno_group(strTmp_modelnos);	//그룹모델일때 기본정보들은 그 그룹에서 제일 최저가를 가진 모델이 대표가 됨.
		blChk_group = true;
	}

	// 프로모션 자동화 시작
	Goods_Lsv_11St_Proc goodsLsv11StProcAjax = new Goods_Lsv_11St_Proc();
	HashMap<String, Goods_Lsv_11St_Data> goodsLsv11StMap = goodsLsv11StProcAjax.getPromotionGoodsList(intModelno);
	// 프로모션 자동화 끝

	if(intModelno != 0) {

		if(blChk_group){
			goods_data_pop = Mobile_Goods_Proc.Goods_One_Group(intModelno, strTmp_modelnos);
		}else{
			goods_data_pop = Mobile_Goods_Proc.Goods_One_noGroup(intModelno);
		}

		if(goods_data_pop == null) {
			out.println("Goods_Data Error !!");
			return;
		}
	}else{
		out.println("Goods_Data Error !!!");
		return;
	}

	//G마켓 G9 리다이렉트 상품
	long lngG9_plno = Mobile_Pricelist_Proc.getG9_plno( intModelno );

	//System.out.println("lngG9_plno>>>>"+lngG9_plno);

	int intTotal = 0;
	int intFstshop = 0;

	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";

	//쇼핑몰 상위입찰용 개별로그번호
	String strLogno_view = "12628";  		//view 개별로그
	String strLogno_click = "12629";  		//click out 개별로그
	String strLogno_view_1 = "";
	String strLogno_click_1 = "";
	String strLogno_view_2 = "";
	String strLogno_click_2 = "";

	String strModelnm = goods_data_pop.getModelnm();

	if(strModelnm.indexOf("[") > 0){
		strModelnm = strModelnm.replace("[","<span class=\"strModelnm\">");
		strModelnm = strModelnm.replace("]","</span>");
	}

	strModelnm = strModelnm.replaceAll("'","`");		//따옴표처리
	strModelnm = strModelnm.replaceAll("`]","]");		//특정문자삭제
	strModelnm = strModelnm.replaceAll("!]","]");		//특정문자삭제
	if(strModelnm.indexOf("*]")>-1) {
		try {
			strModelnm = strModelnm.substring(0, strModelnm.indexOf("*]")) + strModelnm.substring(strModelnm.indexOf("*]")+1);
		} catch(Exception e) {}
	}
	strModelnm = strModelnm.replaceAll("#]","]");		//특정문자삭제

	// [일반] 제거
	if(strModelnm.indexOf("[일반]")>-1) {
		try {
			strModelnm = CutStr.cutStr(strModelnm, strModelnm.indexOf("[일반]")) + strModelnm.substring(strModelnm.indexOf("[일반]")+4);
		} catch(Exception e) {}
	}
	//특수문자 제거
	strModelnm = strModelnm.replace("!","");
	strModelnm = strModelnm.replace("`","");
	strModelnm = strModelnm.replace("'","");
	strModelnm = strModelnm.replace("#","");
	strModelnm = strModelnm.replace("*","");


	String strCondi = goods_data_pop.getCondiname();
	String strCdate = goods_data_pop.getC_date();
	String strFactory = goods_data_pop.getFactory();
	String strCategory = goods_data_pop.getCa_code();
	long mMinPrice = goods_data_pop.getMinprice();
	long mMinPrice_org = goods_data_pop.getMinprice();
	long mTlcMinPrice = goods_data_pop.getTlc_min_prc();
	if(strCategory.length() > 0){
		strCate2 = strCategory.substring(0,2);
	}
	if(strCategory.length() > 2){
		strCate4 = strCategory.substring(0,4);
	}
	if(strCategory.length() > 4){
		strCate6 = strCategory.substring(0,6);
	}
	if(strCategory.length() > 7){
		strCate8 = strCategory.substring(0,8);
	}


	//최저가 초기화
	//mMinPrice = lngInstanceMinPrice;

	if (strCate.trim().length() == 0 ){
		strCate = strCategory;
	}
	// 카드 코드와 이름을 저장함
	java.util.HashMap cardNameHash = new java.util.HashMap();

	//쇼핑몰 카드할인 이벤트기간 체크 : 기간이 아닐때 할인문구 삭제하기 위해 필요
	String[][] cardInfoAry = Pricelist_Proc.getPriceList_CardEvent();
	String cardShopCodes = "|"; //카드할인중인 쇼핑몰 목록
	String cardName = "";
	if(cardInfoAry!=null) {
		for(int i=0; i<cardInfoAry.length; i++) {
			cardName = "";
			cardShopCodes += cardInfoAry[i][0]+"|";
			%>
			<%@ include file="/common/jsp/IncCardName.jsp"%>
			<%
			cardName += "|"+cardInfoAry[i][4]; //카드 제한 문구

			//System.out.println("cardName1>>>>"+cardName);

			if(cardNameHash.containsKey(cardInfoAry[i][0])){
				cardName = (String)cardNameHash.get(cardInfoAry[i][0]) + ":" + cardName;
			}

			//System.out.println("cardName2>>>>"+cardName);

			cardNameHash.put(cardInfoAry[i][0], cardName);
		}
	}


	//쇼핑몰 카드 무이자 할부 정보
	String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();

	// 현재 날짜
	Calendar calendar = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
	String cur_date = format.format(calendar.getTime());

	String strViewCdate = DateUtil.RtnDateComment(strCdate,"2010_list","");
	String dateText = "";
	if(!CutStr.cutStr(strCate4,2).equals("15")){
		if (strViewCdate.equals("예정")){
			dateText = "출시예정";
		}else{
			if(strCdate.substring(4,5).equals("0")){
				dateText = "'"+strCdate.substring(2,4)+"년 "+strCdate.substring(5,6)+"월 출시";
			}else{
				dateText = "'"+strCdate.substring(2,4)+"년 "+strCdate.substring(4,6)+"월 출시";
			}
		}
	}

	String strZumFlag = "N";
	String strShopBidFlag = "";
	boolean blZumFlag = false;

	Cookie[] cookies = request.getCookies();
	if(cookies!=null && cookies.length>0) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("FROMZUM")) {
				strZumFlag = cookies[i].getValue();
				break;
			}
		}

		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("FROM")) {
				if(cookies[i].getValue().equals("zum")){
					blZumFlag = true;
				}
				break;
			}
		}
	}
	if(strZumFlag.equals("N") || strZumFlag.equals("")){
		strZumFlag = cb.getCookie_One("FROMZUM");
	}

	Pricelist_Data[] aszPlist = null;


	//pagesize 가 10 인것만 pagesize가 사용됨.
	if(strPreview.equals("1")){
		aszPlist = Mobile_Pricelist_Proc.get_list_first_all(intModelno, strCategory, intGroup, "", 1, 50);
	}else{
		if(blChk_group){
			//2017-11-02 현재 사용안하는것으로 파악됨. 추후 재 검사해야함.
			aszPlist = Mobile_Pricelist_Proc.get_list_first_group(strTmp_modelnos, strCategory, intGroup, strSort, intPage, intPagesize);
		}else{
			if(strCardsort.equals("Y")){
				aszPlist = Mobile_Pricelist_Proc.get_list_first_all_card(intModelno, strCategory, intGroup, strSort, intPage, intPagesize);
			}else{
				aszPlist = Mobile_Pricelist_Proc.get_list_first_all(intModelno, strCategory, intGroup, strSort, intPage, intPagesize);
			}
		}

		if(aszPlist!=null) {
%>
<%@ include file="/mobilefirst/include/inc_detail_proc.jsp"%>
<%
		}
	}

	//쇼핑몰 상위입찰
	if(aszPlist!=null) {
%>
<%@ include file="/mobilefirst/include/inc_shop_bid.jsp"%>
<%
	}

//zum으로 들어왔을때 쿠팡 예외처리 2016-05-18 shwoo
if(blZumFlag && aszPlist != null){
	Pricelist_Data[] aszDelPlist = (Pricelist_Data[])aszPlist.clone();
	int newPricelistCnt = 0;
	boolean[] isMatch = new boolean[aszPlist.length];

	if(aszPlist!=null) {
		for(int deli=0; deli<aszDelPlist.length; deli++) {
			isMatch[deli] = true;
/*
			if(aszDelPlist[deli].getShop_code() == 7861){
				isMatch[deli] = false;
			}
	 */
			if(isMatch[deli]) {
				newPricelistCnt++;
			}
		}
	}
	if(newPricelistCnt>0) {
		aszPlist = new Pricelist_Data[newPricelistCnt];
		int aszCnt = 0;
		for(int deli=0; deli<aszDelPlist.length; deli++) {
			if(isMatch[deli]) {
				aszPlist[aszCnt] = aszDelPlist[deli].cloneMe();
				aszCnt++;
			}
		}
	} else {
		aszPlist = null;
	}
}

//카테고리 적립율
float flRewardRate =  Reward_Cate_Rate.getRewardCateRate(strCate4);
%>
{
<%
//try {
	if(aszPlist != null && aszPlist.length > 0){
		out.println("	\"listContent\": [");

		intTotal = aszPlist[0].getAll_cnt();
		intFstshop = aszPlist[0].getShop_code();

		boolean blZumflag = false;

		Global_Shop_Json shopJson = new Global_Shop_Json();
        Map<Integer, Object> shopMap = shopJson.parseGlobalShopListJson();

		for(int i=0; i<aszPlist.length; i++) {
			if(strPreview.equals("1") && i == 10){
				break;
			}
			if(aszPlist[i] != null ){
				if(!strZumFlag.equals("Y") || (strZumFlag.equals("Y") && aszPlist[i].getShop_code() != 6378 && aszPlist[i].getShop_code() != 6368 )){

					String strShop_name = aszPlist[i].getShop_name();
					String strShop_type = aszPlist[i].getShop_type();
					String strPlGoodsNmM = StringReplace(aszPlist[i].getGoodsnm());
					long mPrice = aszPlist[i].getPrice();
					long instance_price = aszPlist[i].getInstance_price();
					String strGoodscode = aszPlist[i].getGoodscode();
					int deliveryType2 = aszPlist[i].getDeliverytype2();
					int deliveryInfo2 = aszPlist[i].getDeliveryinfo2();
					String strShop_url = aszPlist[i].getUrl();
					String strMobile_url = "";
					String deliveryInfo = aszPlist[i].getDeliveryinfo();
					String strPrice_flog = aszPlist[i].getDelivery();
					int Intmodelno = aszPlist[i].getModelno();
					int szVcode = aszPlist[i].getShop_code();
					int intPrice_card = aszPlist[i].getPrice_card();
					String strCa_code_l = aszPlist[i].getCa_code();
					long iPlno = aszPlist[i].getPl_no();
					String strGoodsfactory = aszPlist[i].getGoodsfactory();
					String strFreeinterest = aszPlist[i].getFreeinterest();
					String szSbName = strShop_name;
					String strAuthflag = aszPlist[i].getAuthflag().replace("0","").replace("N","");
					String strCardflag = "";
					String strCardfreeflag = "";
					String strFreeinterest_chk = "";
					String strCoupon = "";
					String strCouponflag = "";
					String strMinpriceflag = "";
					int intCoupon = aszPlist[i].getCoupon();
					String strDetail_url = aszPlist[i].getUrl1();
					//11번가 쿠폰 영역
					String eventCouponCheck = "";
					String eventCouponText = "";
					String eventCouponCss = "";
					//인터파크 쿠폰 영역
					String interParkCouponCss = "";
					String interParkCouponPer = "";
					//다른 이벤트영역
					String eventCouponCheck_etc = "";
					String eventCouponText_etc = "";
					String eventCouponCss_etc = "";
					String eventCouponCss_link = "";

					//G마켓 G9 리다이텍트 상품
					String strG9_model = "";
					if(lngG9_plno == iPlno){
						strG9_model =  "Y";
					}

					//쇼핑몰 상위입찰
					int intShop_bid = aszPlist[i].getShop_bid();
					String strShop_bid = "";

					if(intShop_bid > 0){
						strShop_bid = intShop_bid + "";

						strShopBidFlag = "Y";
					}
					//상위입찰 클릭번호 입력
					if(intShop_bid == 1){
						strLogno_view = strLogno_view_1;
						strLogno_click = strLogno_click_1;
					}else if(intShop_bid == 2){
						strLogno_view = strLogno_view_2;
						strLogno_click = strLogno_click_2;
					}else{
						strLogno_view = "";
						strLogno_click = "";
					}

					String strType = "";

					if(!strFreeinterest.equals("")){
						strFreeinterest_chk = "Y";	//할부내용은 필요없으며 할부여부만 필요.
					}

					if(aszPlist[i].getPrice_card()>0 && cardShopCodes.indexOf("|"+aszPlist[i].getShop_code())>-1 && checkEventCard(cardNameHash, aszPlist[i].getShop_code()+"", aszPlist[i].getGoodsnm(), aszPlist[i].getPrice(), strCategory)) {
						strCardflag = "Y";
					}
					if(!getForceFreeInterest2(aszPlist[i].getShop_code(), strCategory, aszPlist[i].getFreeinterest(), aszPlist[i].getPrice(), cardFreeAry).equals("")){
						strCardfreeflag = "Y";
					}

					String strPrice = "";
					String strInstance_Price = "";
					String strPrice_Card = "";

					if(instance_price > 0){
						instance_price = instance_price;
					}else{
						instance_price = 0;
					}

					// 신용카드 정보를 보여줘야 할 경우 제목에 신용카드 정보를 입력함
					String tempCardName = "";

					//if(szVcode == 75){
					//	System.out.println("szVcode>>>"+szVcode);
					//	System.out.println("strPlGoodsNmM>>>"+strPlGoodsNmM);
					//	System.out.println("mPrice>>>"+mPrice);
					//	System.out.println("strCa_code_l>>>"+strCa_code_l);
					//}


					tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNmM, mPrice, strCa_code_l);

					//if(szVcode == 75){
					//	System.out.println("tempCardName>>>"+tempCardName);
					//	System.out.println("strGoodsfactory>>>"+strGoodsfactory);
					//}


					//if(szVcode==75 && !strGoodsfactory.equals("쇼핑지원금")) {
					//	tempCardName = tempCardName.replaceAll("쇼핑지원금:", "");
					//	tempCardName = tempCardName.replaceAll("쇼핑지원금", "");
					//}

					if(cardNameHash.containsKey(szVcode+"")) {
						// GS 쇼핑지원금
						if(szVcode==75 && tempCardName.indexOf(":")>-1 && (intPrice_card==mPrice || mPrice<50000)) {
							String[] aryCardName = tempCardName.split(":");
							if(aryCardName!=null && aryCardName.length>1) {
								tempCardName = aryCardName[0];
							}
						}
						szSbName += "-";
						szSbName += tempCardName;
					}

					if(szSbName.indexOf("-")>-1) {
						String[] szSbNameInfos = szSbName.split("-");
						if(szSbNameInfos!=null && szSbNameInfos.length>0){
							szSbName = szSbNameInfos[0];
							if(szSbNameInfos.length>1 && !tempCardName.equals("")){ //할인카드명이 있고 상품명에 카드명이 있을때만
								cardName = szSbNameInfos[1];
							}
						}
					}else{
						cardName = tempCardName;
					}

					if(szVcode==57 && cardName.length()>0) { //hmall
						if(strPlGoodsNmM.indexOf("[삼성카드")>-1) cardName = "삼성카드";
						if(strPlGoodsNmM.indexOf("[현대카드")>-1) cardName = "현대카드";
					}
					// 하이마트 예외처리
					if(szVcode==6252) {
						szSbName = szSbName.replace("하이마트쇼핑몰", "하이마트");
					}
					if(ControlUtil.compareValOR(new int[]{szVcode,806,6165}) && intPrice_card>0 && tempCardName.equals("CJ카드")){
						cardName = "CJ카드";
					}

					if(cardName.length()>0) {
						if(cardName.indexOf("CJ(씨티제외)")>-1) {
						} else {
							if(cardName.indexOf("쇼핑지원금")>-1) {
								if(cardName.indexOf(":")>-1) {
									String[] aryCardName = cardName.split(":");
									if(aryCardName!=null && aryCardName.length>1) {
										szSbName = aryCardName[1];
									}
								}
							}
						}
					}

					//상품명 강제변경
					strPlGoodsNmM = getGoodsNmReplace2(szVcode, strPlGoodsNmM, mPrice, strCa_code_l, true, strFreeinterest, cardFreeAry);

					String[] arrTempCardName = null;
					if(tempCardName.indexOf(",")>0){
						arrTempCardName = tempCardName.split(",");
					}

					//카드할인 문구 삭제
					strPlGoodsNmM = getGoodsNmCardReplace(szVcode, strPlGoodsNmM, tempCardName, arrTempCardName, mPrice, strCa_code_l, true);

					if(lngInstanceMinPrice == 0 && i == 0){
						mMinPrice = instance_price;
					}

					//쇼핑몰에 따른 모바일 url & 수입코드 변경
					strMobile_url = toUrlCode(strShop_url);

					// deliveryType2==0 : 배송비 정보가 불명확함
					// deliveryType2==1 : 배송비 정보가 정확학
					// 배송비 정보는 deliveryInfo2에 들어 있으며
					// deliveryInfo2==0 이면 무료배송
					// deliveryInfo의 정보는 배송비가 정해지는 규칙이 들어 있음(업체에서 입력)
					String tmpbbbbb = "";
					int ibbbbb_1 = 0;
					int ibbbbb_2 = 0;

					if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
					}else if(instance_price==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
					}else{
						if(instance_price == mMinPrice){
							strMinpriceflag = "Y";

							if(szVcode == 6641){	//티몬
								strDetail_url = "http://m.ticketmonster.co.kr/deal/detailDaily/bbbbb?page=review";
								//티몬은 strShop_url 에 p_no= 값
								//strShop_url : http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=175768289&o_no=175773197
								ibbbbb_1 = strShop_url.indexOf("&p_no=") + 6;
								if(strShop_url.indexOf("&o_no=") > ibbbbb_1){
									ibbbbb_2 = strShop_url.indexOf("&o_no=");
								}else{
									ibbbbb_2 = strShop_url.length();
								}

								if(ibbbbb_1 < ibbbbb_2){
									tmpbbbbb = strShop_url.substring(ibbbbb_1, ibbbbb_2);
									strDetail_url = strDetail_url.replace("bbbbb", tmpbbbbb);
								}else{
									strDetail_url = strShop_url;
								}
							}else if(szVcode == 6508){	//위메프
								strDetail_url = "http://m.wemakeprice.com/m/deal/detail_expand/bbbbb";
								//위메프는 strShop_url 에 /enuri/982425/Y 사이값
								//strShop_url : http://www.wemakeprice.com/widget/aff_bridge_public/enuri/931477/Y/PRICE_af/931477/0240A7/enuri
								ibbbbb_1 = strShop_url.indexOf("/enuri/") + 7;
								ibbbbb_2 = strShop_url.indexOf("/Y/");
								if(ibbbbb_1 < ibbbbb_2){
									tmpbbbbb = strShop_url.substring(ibbbbb_1, ibbbbb_2);
									strDetail_url = strDetail_url.replace("bbbbb", tmpbbbbb);
								}else{
									strDetail_url = strShop_url;
								}
							}
						}
					}

					if(strShopBidFlag.equals("Y") && intShop_bid < 1 && strMinpriceflag.equals("Y")){
						strMinpriceflag = "";
					}

					if(!deliveryInfo.equals("무료배송")){
						if(deliveryType2 != 0){
							if(deliveryType2 == 1 && deliveryInfo2 == 0){
							}else{
								if(tab_dminsort.equals("Y")){
									instance_price = instance_price + Long.parseLong(deliveryInfo2+"");
								}
							}
						}
					}

					/* 2015.01.13. 모바일가격으로 변경
					if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
						strPrice = "미정";
					}else if(mPrice==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
						//strPrice = "클릭";
						strPrice = toNumFormat(mPrice) + " 원";
					}else{
						strPrice = toNumFormat(mPrice) + " 원";
					}
					*/

					if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
						strInstance_Price = "미정";
					}else if(instance_price==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
						strInstance_Price = toNumFormat(instance_price)+"";
					}else{
						strInstance_Price = toNumFormat(instance_price)+"";
					}


					//쿠폰여부
					if(szVcode==4027 || szVcode==536 || szVcode==663){
						strType = "2";				//case2. 모바일 제휴& 할인 자동 적용
					}else if(szVcode==75  ){
						strType = "6";
					}else if(szVcode==57){
						strType = "6";
					}else if(szVcode==55 || szVcode==806 || szVcode==90  || szVcode==1878){
						strType = "6";				//case6. 모바일 제휴 & 쿠폰 유무를 모를 때
					}else if(szVcode==5910 || szVcode==49 || szVcode==47 || szVcode==6547 || szVcode==6588  || szVcode==6603 ){
						strType = "7";				//case7. 모바일 제휴 & CTU 적용 불가
					}else if(szVcode==6620){		// 특이. 갤러리아몰은 쿠폰필드 1이면 case6, 쿠폰필드0이면 case2
						if(intCoupon == 1){
							strType = "6";
						}else{
							strType = "2";
						}
					}else if(szVcode==663){		// 특이. 롯데아이몰은 쿠폰필드 1이면 case5, 쿠폰필드0이면 case2
						if(intCoupon == 1){
							strType = "5";
						}else{
							strType = "2";
						}
					}else if(szVcode==6665){
						if(intCoupon == 1){
							strType = "6";
						}else{
							strType = "2";
						}
					}else{
						strType = "7";				//case7. 모바일 비제휴 ---> 일단 case2로...
					}

					if(strCate4.equals("0304") && (szVcode==806 || szVcode==663 || szVcode==55 || szVcode==57) ){
						strType = "7";
					}

					//11번가 쿠폰 프로모션 2017-09-14
					//15010801 추가 2017-09-21
					//프로모션 중단 2017-10-27

					boolean onCoupon = false;

					if(com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2017.03.12. 09:00")>0 && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.04.30. 23:59")<0){
						onCoupon = true;
					}

					//2017-11-28 특정모델만 쿠폰 보임
					boolean onCoupon_model = false;
					// 5% 쿠폰  종료 : 2018-03-19
					/* if(szVcode == 5910 && (",1946064027,1946009265,1951751368,1955732347,1831313988,1630749186,635915910,1164120442,1803242133,".indexOf(","+ strGoodscode +",") > -1
							|| ",1031877940,1910523313,1911345036,1952762376,1955957679,1707991733,1745896589,1888163982,1709317274,".indexOf(","+ strGoodscode +",") > -1
							|| ",1888182680,1849873051,1732642717,1827644584,1037128143,1711771553,1947139440,1957734146,".indexOf(","+ strGoodscode +",") > -1)
							){
						onCoupon_model = true;
						intCoupon = 2;
						eventCouponCss_link = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001234868";	//없으면 클릭없음.
					// 10% 쿠폰
					} else  */
				/* 	if(szVcode == 5910 && (",1188105074,1674993203,1791262782,1955710686,1785592886,1524586827,1782497951,1493366502,1954858672,".indexOf(","+ strGoodscode +",") > -1
							|| ",1536156897,1141080834,1914838515,1904577714,1958578514,1968019062,1927107648,1218421244,1398315984,".indexOf(","+ strGoodscode +",") > -1
							|| ",1882634053,875185226,1450677146,1481315601,1570342818,1871761674,1582593921,1658410660,1658415351,".indexOf(","+ strGoodscode +",") > -1
							|| ",1077221535,1943835221,1848787144,1460088032,1578320490,1940500674,1917924003,1877983386,1769154167,".indexOf(","+ strGoodscode +",") > -1
							|| ",33388504,1103015861,1319858523,1214077104,1441147063,742793978,1253091463,1151552508,1967074371,".indexOf(","+ strGoodscode +",") > -1
							|| ",1983626039,1974342785,1807031075,1179618269,1736078383,3932207,1762927285,1905928235,1875158955,".indexOf(","+ strGoodscode +",") > -1
							|| ",1957360597,1940444112,1833185119,1682072167,1670511536,1880096621,1944358430,1947124055,1921440543,1259978629,".indexOf(","+ strGoodscode +",") > -1
							|| ",1602262462,1707571702,1536156969,1475151242,1964298748,1964332912,1964341228,1782667509,1891580822,".indexOf(","+ strGoodscode +",") > -1
							|| ",1755054944,1781647983,1937846286,1708914862,1113060386,1937846063,1732688005,1937845932,1849806652,".indexOf(","+ strGoodscode +",") > -1
							|| ",1717126194,1714001890,1849806788,1878303880,1988570974,1673212327,1919353088,".indexOf(","+ strGoodscode +",") > -1) ){
						onCoupon_model = true;
						intCoupon = 3;
						eventCouponCss_link = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001235767";	//없으면 클릭없음.
					// 5만원 쿠폰
					} else */ if(szVcode == 5910 && (",1986121032,1986127484,1983978177,1983111893,1983980544,1983982146,1983986354,1983988981,1986135211,".indexOf(","+ strGoodscode +",") > -1
							|| ",1986144635,1983991938,1983993077,1983995191,1983999933,1984001257,1983116238,".indexOf(","+ strGoodscode +",") > -1) ){
						onCoupon_model = true;
						intCoupon = 4;
						eventCouponCss_link = "http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&tid=1001235769";	//없으면 클릭없음.
					}



					if(onCoupon && onCoupon_model){

						/*
						if(
								(strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0609"))
								|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0404"))
								|| (strCa_code_l.length() > 6 && strCa_code_l.substring(0,6).equals("150105"))
								|| (strCa_code_l.length() > 6 && strCa_code_l.substring(0,8).equals("15010801"))
						){

							if(intCoupon==2){
								eventCouponCheck = "1";
								if(strCa_code_l.substring(0,4).equals("0609")){
									eventCouponText = "50,000원 중복할인쿠폰 적용상품";
									eventCouponCss = "i_ll _50";
								}else if(strCa_code_l.substring(0,6).equals("150105") || strCa_code_l.substring(0,8).equals("15010801")){
									eventCouponText = "5,000원 중복할인쿠폰 적용상품";
									eventCouponCss = "i_ll _5";
								}else if(strCa_code_l.substring(0,4).equals("0404")){
									eventCouponText = "10% 중복할인쿠폰 적용상품";
									eventCouponCss = "i_ll _10";
								}
							}
						}
						*/

						//System.out.println("mPrice>>>>>"+mPrice);
						/*
						if(intCoupon==2 && mPrice >= 100000 &&
							(
									(strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0405"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0908"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0913"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0930"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("2406"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("2404"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("2407"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0930"))
							)
						){
							eventCouponCheck = "1";
							eventCouponText = "10%(최대2만원) 중복할인쿠폰 적용상품";
							eventCouponCss = "i_ll _10m2";
						}else if(intCoupon==2 && mPrice >= 30000 &&
							(
									(strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0903"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0923"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("1007"))
									|| (strCa_code_l.length() > 4 && strCa_code_l.substring(0,4).equals("0713"))
							)
						){
							eventCouponCheck = "1";
							eventCouponText = "10%(최대2만원) 중복할인쿠폰 적용상품";
							eventCouponCss = "i_ll _10m2";
						}
						*/

						/*
						if(intCoupon==2){
							eventCouponCheck = "1";
							if(strGoodscode.equals("1856212993") || strGoodscode.equals("1872398184") || strGoodscode.equals("1332666236") || strGoodscode.equals("1881101974") || strGoodscode.equals("1504254009") || strGoodscode.equals("1891515207") ){
								eventCouponText = "30,000원 중복할인쿠폰 적용상품";
								eventCouponCss = "i_ll _30";
							}else if(strGoodscode.equals("1886800893") || strGoodscode.equals("1904337157")){
								eventCouponText = "5,000원 중복할인쿠폰 적용상품";
								eventCouponCss = "i_ll _5";
							}else{
								eventCouponText = "3,000원 중복할인쿠폰 적용상품";
								eventCouponCss = "i_ll _3";
							}
						}
						*/

						// 5%
						if(intCoupon==2){
							eventCouponCheck = "1";
							eventCouponText = "5% 중복할인 쿠폰 적용상품";
							eventCouponCss = "i_ll _5p";
						}
						// 10%
						if(intCoupon==3){
							eventCouponCheck = "1";
							eventCouponText = "10% 중복할인 쿠폰 적용상품";
							eventCouponCss = "i_ll _10p";
						}
						// 50,000 원 쿠폰
						if(intCoupon==4){
							eventCouponCheck = "1";
							eventCouponText = "50,000원 중복할인쿠폰 적용상품";
							eventCouponCss = "i_ll _50";
						}


						//System.out.println("eventCouponText>>>>>"+eventCouponText);
						//System.out.println("eventCouponCss>>>>>"+eventCouponCss);
					}
					//2017-11-28 특정모델만 쿠폰 보임
					boolean onCoupon_cate = false;
					if(szVcode == 5910 && (strCate6.equals("150105") || strCate8.equals("15010801")) && com.enuri.util.date.DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.02.12. 18:00")<0){
						onCoupon_cate = true;
						//intCoupon = 2;
					}

					if(szVcode == 5910 && onCoupon_cate){
						if(mPrice >= 100000){
							eventCouponCheck = "1";
							eventCouponText = "10,000원 중복할인쿠폰 적용상품";
							eventCouponCss = "i_ll _100";
						}else if(mPrice >= 50000){
							eventCouponCheck = "1";
							eventCouponText = "5,000원 중복할인쿠폰 적용상품";
							eventCouponCss = "i_ll _5";
						}
					}

		 		   /********************************************
				   		카카오페이 광고 문구 Start
				   		 - 노출 기간
				   		    * 인터파크(55): 9/1 ~ 9/30
				   		    * CJ오쇼핑(806) : 9/5 ~ 9/23
				   		    * 위메프(6508) : 9/1 ~ 9/16
			 	  **********************************************/
	        		// 11월 카카오페이 광고 문구 노출
	        		if(szVcode == 55 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.30. 23:59")<=0) {
						eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 3만원이상 1천원 쿠폰";
						eventCouponCss_etc = "addtxt";
						eventCouponCss_link = "";	//없으면 클릭없음.
	        		}
	        		if(szVcode == 806 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 &&  DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.30. 23:59")<=0) {
	        			eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 7% 카드 청구할인";
						eventCouponCss_etc = "addtxt";
						//eventCouponCss_link = "";	//없으면 클릭없음.
	        		}
	        		if(szVcode == 6508 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.01. 00:00") > 0 &&  DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.11.15. 23:59")<=0) {
	        			eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 5만원이상 5% 할인";
						eventCouponCss_etc = "addtxt";
						//eventCouponCss_link = "";	//없으면 클릭없음.
	        		}

	        		// 12월 카카오페이 광고 문구 노출
	        		// CJ 오쇼핑 날짜 지정
					String nowDate = DateStr.nowStr("yyyy.MM.dd.");
					boolean isCjView = false;
					if (nowDate.indexOf("2018.12.12.") > -1 || nowDate.indexOf("2018.12.13.") > -1 || nowDate.indexOf("2018.12.19.") > -1 || nowDate.indexOf("2018.12.20.") > -1
							 || nowDate.indexOf("2018.12.24.") > -1 || nowDate.indexOf("2018.12.25.") > -1 || nowDate.indexOf("2018.12.30.") > -1 || nowDate.indexOf("2018.12.31.") > -1){
						isCjView = true;
					}

	        		if(szVcode == 55 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.01. 00:00") > 0  && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.31. 23:59")<=0) {
						eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 3만원이상 1천원 쿠폰";
						eventCouponCss_etc = "addtxt";
						eventCouponCss_link = "";	//없으면 클릭없음.
	        		}
	        		if(szVcode == 806 && isCjView) {
	        			eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 7% 카드 청구할인";
						eventCouponCss_etc = "addtxt";
						//eventCouponCss_link = "";	//없으면 클릭없음.
	        		}
	        		if(szVcode == 6508 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.01. 00:00") > 0  && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.12.31. 23:59")<=0) {
	        			eventCouponCheck_etc = "1";
						eventCouponText_etc = "카카오페이 4~6% 쿠폰 할인";
						eventCouponCss_etc = "addtxt";
						//eventCouponCss_link = "";	//없으면 클릭없음.
	        		}
				   /********************************************
			   			카카오페이 광고 문구 End
			   		**********************************************/

		        	/*2018-04-03 인터파크 할인 */
		        	/*2018-04-12 인터파크 삭제(5569002956,5569205632)*/
		        	/*2018-04-12 인터파크 추가(5617378921,5617346487)*/
					if(szVcode == 55 && (",5617378921,5569045855,5569144721,5617346487,".indexOf(","+ strGoodscode +",") > -1) ){
						interParkCouponCss = "couponbadge";
						interParkCouponPer = "5,000";
						eventCouponCheck_etc = "";
						eventCouponCheck = "1";
						eventCouponText = "5,000원 추가할인 행사상품";
						eventCouponCss_link = "http://m.interpark.com/mobileGW.html?svc=Shop&bizCode=P14661&url=http://m.shop.interpark.com/display/plandisplay.html?disp_no=021750035";	//없으면 클릭없음.
					}

					if(strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("추가할인") > -1){
						strCoupon = strPlGoodsNmM.substring(0, strPlGoodsNmM.indexOf("추가할인")+4);
						if( strCoupon.indexOf("추가할인") > strCoupon.indexOf("에누리")){
							strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("추가할인"));
						}
					}

					//SSG(6665) 쿠폰 관련 (모델명에 할인문구 있을경우 케이스 추가)
					if(szVcode == 6665 && strType.equals("6") && strPlGoodsNmM.indexOf("에누리") > -1 && strPlGoodsNmM.indexOf("더블할인쿠폰") > -1 ){
						strCoupon = strPlGoodsNmM;
						strCoupon = strCoupon.substring(strCoupon.indexOf("에누리")+3, strCoupon.indexOf("더블할인쿠폰")+1).replace(" ","");
						strType = "4";
					}

					if(!strCoupon.equals("") || strType.equals("4") || strType.equals("5") || strType.equals("6") ){
						strCouponflag = "Y";
					}

					//if(szVcode==4027 || szVcode==55 || szVcode==536){
					//	strShop_name = "PC 최저가";

					//}

					//카드할인가 천단위콤마추가
					strPrice_Card = toNumFormat(intPrice_card)+"";

					// 프로모션 자동화
					String moblVipCpnViewDcd = "";			// VIP 쿠폰 노출 구분 코드 : 문구노출 M, 쿠폰 할인가노출 C, 비노출, N
					String moblVipCpnViewDcd_M = "";
					String moblVipCpnViewDcd_C = "";
					String moblVipCpnViewStr = "";				// VIP 쿠폰 노출 문자열 : 문구 또는 할인가 문구
					String moblVipCpnIcnViewYn = "";			// VIP 쿠폰 아이콘 노출 여부
					String moblVipCpnDcViewYn = "";			// VIP 쿠폰 할인 노출 여부
					String moblPromtnUrl = "";					// 프로모션 랜딩 URL
					String vipCpnDcCndCd = "";					// 정액 인지 정률 구분값
					int vipDcPrice = 0;								// VIP 상품 할인가
					String moblCouponTxt = "";
					String pcMiniVipIcnViewDcd = "";	//미니VIP 아이콘 노출 구분 코드 : 쿠폰 받기 노출 C, 이벤트 아이콘 노출: M
					String pcMiniVipIcnStr = "";			// 미니 VIP 아이콘 문자열

					if (goodsLsv11StMap.containsKey(strGoodscode)) {
						Goods_Lsv_11St_Data goodsLsv11StData = goodsLsv11StMap.get(strGoodscode);

						if (goodsLsv11StData != null) {
							vipCpnDcCndCd = goodsLsv11StData.getCpn_dc_cnd_cd();
							moblVipCpnViewDcd = goodsLsv11StData.getMobl_vip_cpn_view_dcd();
							moblVipCpnViewStr = goodsLsv11StData.getMobl_vip_cpn_view_str();
							moblVipCpnIcnViewYn = goodsLsv11StData.getMobl_vip_cpn_icn_view_yn();
							moblVipCpnDcViewYn = goodsLsv11StData.getMobl_vip_cpn_dc_view_yn();
							vipDcPrice = goodsLsv11StProcAjax.accDiscountPrice(goodsLsv11StData, (int)mPrice);
							moblPromtnUrl = goodsLsv11StData.getMobl_promtn_url();

							if (!moblVipCpnIcnViewYn.equals("Y")) {moblVipCpnIcnViewYn = "";}

							if (moblVipCpnViewDcd.equals("M")) {
								moblVipCpnViewDcd_M = "Y";
							} else if (moblVipCpnViewDcd.equals("C")) {
								moblVipCpnViewStr = "(" + strShop_name + " " + moblVipCpnViewStr + " " + toNumFormat(vipDcPrice) + "원)";
								moblVipCpnViewDcd_C = "Y";
							}

							if (vipCpnDcCndCd.equals("R")) {					// 정률
								moblCouponTxt = Integer.toString(goodsLsv11StData.getCpn_dc_rt())+"%";
							} else if (vipCpnDcCndCd.equals("P")) {			// 정액
								if (goodsLsv11StData.getCpn_dc_amt() > 0) {
									moblCouponTxt = toNumFormat(goodsLsv11StData.getCpn_dc_amt())+"원";
								} else {
									moblCouponTxt = "";
								}
							}
						}
					}

					if(i == 0){
						if((mMinPrice_org < mMinPrice) && mTlcMinPrice == 0 ){
							out.println("	{ ");
							out.println("		\"shopname\":\"PC 최저가\", ");
							out.println("		\"shopurl\":\"\", ");
							out.println("		\"shoptype\":\"\",  ");
							out.println("		\"shopcode\":\"\",  ");
							out.println("		\"mobileurl\":\"\",  ");
							out.println("		\"price\":\""+ toNumFormat(mMinPrice_org) +" 원\", ");
							out.println("		\"instanceprice\":\"0\", ");
							out.println("		\"goodscode\":\"\", ");
							out.println("		\"minprice\":\"\", ");
							out.println("		\"plno\":\"\", ");
							out.println("		\"ca_code\":\"\", ");
							out.println("		\"category\":\"\", ");
							out.println("		\"plgoodsname\":\"\", ");
							out.println("		\"deliveryinfo1\":\"\", ");
							out.println("		\"deliveryinfo2\":\"\", ");
							out.println("		\"cardname\":\"\", ");
							out.println("		\"authflag\":\"\",  ");
							out.println("		\"cardflag\":\"\", ");
							out.println("		\"cardfreeflag\":\"\", ");
							out.println("		\"freeinterestflag\":\"\", ");
							out.println("		\"couponflag\":\"\", ");
							out.println("		\"mpriceflag\":\"\", ");
							out.println("		\"displaydelivery\":\"\", ");
							out.println("		\"detail_url\":\"\", ");
							out.println("		\"shop_bid\":\"\", ");
							out.println("		\"eventCoupon\":\"\",  ");
							out.println("		\"eventCouponText\":\"\", ");
							out.println("		\"eventCouponCss\":\"\",  ");
							out.println("		\"eventCouponCheck_etc\":\"\",  ");
							out.println("		\"eventCouponText_etc\":\"\",  ");
							out.println("		\"eventCouponCss_etc\":\"\",  ");
							out.println("		\"eventCouponCss_link\":\"\",  ");
							out.println("		\"interParkCouponPer\":\"\",  ");
							out.println("		\"interParkCouponCss\":\"\",  ");
							out.println("		\"price11stPromotion\":\"\",  ");
							out.println("		\"srvflag\":\"\",  "); // 샵 구분
							out.println("		\"ovsflag\":\"\"  "); // 해외직구 구분
							out.println("	} ");
							out.println("	,");
						}

					}

					if(i>0) out.print("	,\r\n");
					out.println("	{ ");
					out.println("		\"shopname\":\""+ toJS2(strShop_name) +"\", ");
					out.println("		\"shoptype\":\""+ toJS2(strShop_type) +"\", ");
					out.println("		\"shopurl\":\""+ toJS2(strShop_url) +"\", ");
					out.println("		\"shopcode\":\""+ toJS2(szVcode+"") +"\", ");
					out.println("		\"mobileurl\":\""+ toJS2(strMobile_url) +"\", ");
					out.println("		\"price\":\""+ strInstance_Price +"\", ");
					out.println("		\"instanceprice\":\""+ toJS2(instance_price+"") +"\", ");
					out.println("		\"goodscode\":\""+ toJS2(strGoodscode) +"\", ");
					out.println("		\"minprice\":\""+ mMinPrice +"\", ");
					out.println("		\"plno\":\""+ toJS2(iPlno+"") +"\", ");
					out.println("		\"ca_code\":\""+ toJS2(strCa_code_l) +"\", ");
					out.println("		\"category\":\""+ toJS2(strCategory) +"\", ");

					// 제휴 마케팅 요청으로 VIP title 강제 적용 : G마켓, 옥션 경우만	20180619
					if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2018.08.31. 23:59")<=0 && (536 == szVcode || 4027 == szVcode) ) {
						strPlGoodsNmM = "[스마일카드,2% 캐시백] "+strPlGoodsNmM;
					}

					// 제휴 마케팅 요청으로 VIP title 강제 적용 : 11번가 [신한카드 청구할인 2%] 20180725
					// 노출 제외 카테고리 정보 추가 : 1647 (모바일쿠폰, 상품권), 93 (도서), 145210 (패션 >쥬얼리,헤어액세서리 >순금/돌반지)
					boolean isNoCateCd = true;
					if (CutStr.cutStr(strCategory,4).equals("1647") || CutStr.cutStr(strCategory,2).equals("93") || CutStr.cutStr(strCategory,6).equals("145210") ) {
						isNoCateCd = false;
					}

					// VIP > 11번가 상품명 앞 카드 할인 문구 노출
					/*
					if (DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2019.05.20. 00:00") > 0 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2019.05.28. 23:59")<=0 && 5910 == szVcode && isNoCateCd ) {
						strPlGoodsNmM = " [신한카드 1% 청구할인] "+strPlGoodsNmM;
					}
				 */
					// 쿠팡이면서 상품코드에I가 있을 경우 로켓배송 추가
					//ep에서 로켓배송문구 추가되서 들어옴. 로직삭제(2019-04-05)
					//if (7861 == szVcode && strGoodscode.indexOf("I") > -1 ) {
					//	 strPlGoodsNmM = " [로켓배송] "+strPlGoodsNmM;
					//}

					out.println("		\"plgoodsname\":\""+ toJS2(strPlGoodsNmM) +"\", ");

					out.println("		\"deliveryinfo1\":\""+ toJS2(deliveryInfo) +"\", ");
					out.println("		\"deliveryinfo2\":\""+ toJS2(deliveryInfo2+"") +"\", ");
					out.println("		\"cardname\":\""+ toJS2(cardName) +"\", ");
					out.println("		\"authflag\":\""+ toJS2(strAuthflag) +"\", ");
					out.println("		\"cardflag\":\""+ toJS2(strCardflag) +"\", ");
					out.println("		\"cardfreeflag\":\""+ toJS2(strCardfreeflag) +"\", ");
					out.println("		\"freeinterest\":\""+ toJS2(strFreeinterest) +"\", ");
					out.println("		\"freeinterestflag\":\""+ toJS2(strFreeinterest_chk) +"\", ");
					out.println("		\"couponflag\":\""+ toJS2(strCouponflag) +"\", ");
					out.println("		\"mpriceflag\":\""+ toJS2(strMinpriceflag) +"\", ");
					out.println("		\"pricecard\":\""+ toJS2(strPrice_Card) +"\", ");
					out.println("		\"detail_url\":\""+  toJS2(strDetail_url) +"\", ");

					//해외몰일 경우 배송정보 고정 20191122 jinwook
					if( shopMap.containsKey(szVcode) ) {
						out.println("		\"displaydelivery\":\"해외배송(별도)\", ");
					} else {
						if(deliveryInfo.equals("무료배송")){
							out.println("		\"displaydelivery\":\"무료배송\", ");
						}else{
							if(deliveryType2 == 0){
								if (deliveryInfo.equals("")){	//유무료
									out.println("		\"displaydelivery\":\"유무료\", ");
								}else{
									out.println("		\"displaydelivery\":\""+deliveryInfo+"\", ");
								}
							}else{
								if(deliveryType2 == 1 && deliveryInfo2 == 0){
									out.println("		\"displaydelivery\":\"무료배송\", ");
								}else{
									if(tab_dminsort.equals("Y")){
										out.println("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 포함\", ");
									}else{
										out.println("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 별도\", ");
									}
								}
							}
						}
					}

					out.println("		\"shop_bid\":\""+  strShop_bid +"\", ");
					if(intShop_bid > 0){
						out.println("	\"shopbidflag\":\"Y\",  ");
						out.println("	\"shopbidlogno_view\":\""+ strLogno_view +"\",  ");
						out.println("	\"shopbidlogno_click\":\""+ strLogno_click +"\",  ");
					}else{
						out.println("	\"shopbidflag\":\"\",  ");
						out.println("	\"shopbidlogno_view\":\"\",  ");
						out.println("	\"shopbidlogno_click\":\"\",  ");
					}
					//G마켓 G9 예외
					out.println("	\"gmarket_g9\":\""+ strG9_model +"\",  ");
					//11번가 쿠폰프로모션 2017-09-14
					out.println("	\"eventCoupon\":\""+ eventCouponCheck +"\",  ");
					out.println("	\"eventCouponText\":\""+ eventCouponText +"\", ");
					out.println("	\"eventCouponCss\":\""+ eventCouponCss +"\",  ");
					//인터파크 쿠폰 프로모션 2018-04-03
					out.println("	\"interParkCouponPer\":\""+interParkCouponPer+"\",  ");
					out.println("	\"interParkCouponCss\":\""+interParkCouponCss+"\",  ");
					//다른 쿠폰프로모션 2017-12-04
					out.println("	\"eventCouponCheck_etc\":\""+ eventCouponCheck_etc +"\",  ");
					out.println("	\"eventCouponText_etc\":\""+ eventCouponText_etc +"\",  ");
					out.println("	\"eventCouponCss_etc\":\""+ eventCouponCss_etc +"\",  ");
					out.println("	\"eventCouponCss_link\":\""+ eventCouponCss_link +"\",  ");

					//11번가 쿠폰프로모션 2017-09-14 --- 여기 신규 파일명으로 다시 만들어서 내려 주도록 한다.
					out.println("	\"mobl_vip_cpn_view_dcd\":\""+ moblVipCpnViewDcd +"\", ");
					out.println("	\"mobl_vip_cpn_view_dcd_M\":\""+ moblVipCpnViewDcd_M +"\", ");
					out.println("	\"mobl_vip_cpn_view_dcd_C\":\""+ moblVipCpnViewDcd_C +"\", ");
					out.println("	\"mobl_vip_cpn_view_str\":\""+ moblVipCpnViewStr +"\",  ");
					out.println("	\"mobl_vip_cpn_icn_view_yn\":\""+ moblVipCpnIcnViewYn +"\",  ");
					out.println("	\"mobl_vip_cpn_dc_view_yn\":\""+ moblVipCpnDcViewYn +"\", ");
					out.println("	\"mobl_promtn_url\":\""+ moblPromtnUrl +"\",  ");
					out.println("	\"mobl_coupon_txt\":\""+ moblCouponTxt +"\",  ");
					//4027(옥션), 536(G마켓), 5910(11번가), 55(인터파크) ,806(CJ몰), 75(GS SHOP),7861(쿠팡), 6508(위메프), 6641(티몬),47(신세계몰), 374(이마트몰), 6665(SSG.COM), 114(신세계백화점),8270(마이크로소프트 전문관),9011(SK스토아),19051(SSG새벽배송),6361(홈플러스)
					String emoneyshopList ="4027,536,5910,55,806,75,6641,47,374,6665,6508,7861,9011,19051,6361";
					//e머니 적립가능 쇼핑몰 유무 20200113 choiseojin(#37797)
					String emoneyshop = "";
					String emoneyshopAry[] = emoneyshopList.split(",");
					for(int x=0; x<emoneyshopAry.length;x++){
						if(Integer.parseInt(emoneyshopAry[x])==szVcode) emoneyshop = "Y";
					}
					//특정 분류(1647) 내 e머니 적립표시 제거
					if(strCate4.equals("1647")) emoneyshop = "";

					out.println("			\"emoneyshop\" : \""+emoneyshop+"\", ");

					//해외직구 & 현금몰 2019-11-12 jinwook
					String strCashFlag = "N";
					if(aszPlist[i].getSrvflag().equals("C")){
						strCashFlag = "Y";
					}
					out.println("	\"cashflag\":\""+ strCashFlag +"\", "); // 샵 구분
					int[] ovsArr = new int[] {8446,8447,8448,8826,8827,8828,8829};
					// 해외직구 몰인지 체크 Arrays.sort() 를 해야하지만 순서대로 나열되어있기때문에 생략.
					int ovsBoolCheckNum = Arrays.binarySearch(ovsArr, aszPlist[i].getShop_code());
					String strOvsFlag = ovsBoolCheckNum>0 ? "Y" : "N";
					out.println("	\"ovsflag\":\""+ strOvsFlag +"\", "); // 해외직구 구분
					out.println("	\"tlcMinPrice\":\""+ mTlcMinPrice +"\", "); // TLC 구분
					//리워드 적립율
					if(szVcode==8270 && DateStr.nowStr("yyyy.MM.dd. HH:mm").compareTo("2020.04.01. 00:00")<=0){
						out.println("	\"rewardRate\" : \"1.0\" " );
					}else{
						out.println("	\"rewardRate\" : \""+flRewardRate+"\" " );
					}
					out.println("	}");
				}
			}
		}
		out.println("	],");

		out.println("	\"listCount\":\""+ aszPlist.length +"\",  ");
		out.println("	\"FstShop\":\""+ intFstshop +"\",  ");
		out.println("	\"instanceMinPrice\":\""+ mMinPrice +"\",  ");

		if((mMinPrice_org < mMinPrice) && mTlcMinPrice == 0 ){
			out.println("	\"pcPriceyn\":\"Y\"  ");
		}else{
			out.println("	\"pcPriceyn\":\"N\"  ");
		}

		if(!strTabinfoYnString.equals("")){
			out.println(",");
		}
	}else{
		out.println("	\"listContent\": [");
		out.println("	{ ");
		out.println("		\"shopname\":\"PC 최저가\", ");
		out.println("		\"shopurl\":\"\", ");
		out.println("		\"shopcode\":\"\",  ");
		out.println("		\"mobileurl\":\"\",  ");
		if(mMinPrice_org > 0){
			out.println("		\"price\":\""+ toNumFormat(mMinPrice_org) +" 원\", ");
		}else{
			out.println("		\"price\":\"미정\", ");
		}
		out.println("		\"instanceprice\":\"0\", ");
		out.println("		\"goodscode\":\"\", ");
		out.println("		\"minprice\":\"\", ");
		out.println("		\"plno\":\"\", ");
		out.println("		\"ca_code\":\"\", ");
		out.println("		\"category\":\"\", ");
		out.println("		\"plgoodsname\":\"\", ");
		out.println("		\"deliveryinfo1\":\"\", ");
		out.println("		\"deliveryinfo2\":\"\", ");
		out.println("		\"cardname\":\"\", ");
		out.println("		\"authflag\":\"\",  ");
		out.println("		\"cardflag\":\"\", ");
		out.println("		\"cardfreeflag\":\"\", ");
		out.println("		\"freeinterestflag\":\"\", ");
		out.println("		\"couponflag\":\"\", ");
		out.println("		\"mpriceflag\":\"\", ");
		out.println("		\"displaydelivery\":\"\", ");
		out.println("		\"detail_url\":\"\", ");
		out.println("		\"shop_bid\":\"\", ");
		out.println("		\"srvflag\":\"\", "); // 샵 구분
		out.println("		\"ovsflag\":\"\" "); // 해외직구 구분
		out.println("	} ");
		out.println("	],");
		out.println("	\"listCount\":\"0\",  ");
		out.println("	\"FstShop\":\"pc\",  ");
		out.println("	\"instanceMinPrice\":\"\",  ");
		out.println("	\"shopbidflag\":\"\",  ");
		out.println("	\"shopbidlogno_view\":\"\",  ");
		out.println("	\"shopbidlogno_click\":\"\",  ");
		out.println("	\"pcPriceyn\":\"Y\"  ");
		if(!strTabinfoYnString.equals("")){
			out.println(",");
		}
	}
	if(!strTabinfoYnString.equals("")){
		out.println(strTabinfoYnString);
	}
//} catch(Exception e) {
//}
%>
}
<% //} %>