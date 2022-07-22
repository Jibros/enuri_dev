<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data"%>
<%@page import="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Goods_Proc" class="com.enuri.bean.main.Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Proc" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Proc" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Data" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Data" scope="page" />
<jsp:useBean id="Goods_Lsv_11St_Goods_Info_Data" class="com.enuri.bean.lsv2016.Goods_Lsv_11St_Goods_Info_Data" scope="page" />
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

	// 프로모션 자동화 시작
	Goods_Lsv_11St_Proc goodsLsv11StProcAjax = new Goods_Lsv_11St_Proc();
	HashMap<String, Goods_Lsv_11St_Data> goodsLsv11StMap = goodsLsv11StProcAjax.getPromotionGoodsList(intModelno);
	// 프로모션 자동화 끝

	int intPage = ChkNull.chkInt(request.getParameter("page"),1);
	int intPagesize = ChkNull.chkInt(request.getParameter("pagesize"),50);
	
	String strSort = "";

	int intModelno_group = 0;//goods_data_pop.getModelno_group();

	if(tab_dminsort.equals("Y"))	strSort = "Y";

	Goods_Data goods_data_pop = null;

	String strTmp_modelnos = ChkNull.chkStr(request.getParameter("modelnos"),"");	//체크 항목 리스트
	boolean blChk_group = false;

	if(intModelno != 0) {
		goods_data_pop = Goods_Proc.Goods_Detailmulti_One(intModelno, "Detailmulti");
		
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

	if(strCate.length() > 0){
		strCate2 = strCate.substring(0,2);
	}
	if(strCate.length() > 2){
		strCate4 = strCate.substring(0,4);
	}
	if(strCate.length() > 4){
		strCate6 = strCate.substring(0,6);
	}
	if(strCate.length() > 7){
		strCate8 = strCate.substring(0,8);
	}

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
			if(cardNameHash.containsKey(cardInfoAry[i][0])){
				cardName = (String)cardNameHash.get(cardInfoAry[i][0]) + ":" + cardName;
			}
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
	
	boolean deliverOrderFlag = false;
	
	boolean eventModelCouponCheck = false;
	
	if(tab_dminsort.equals("Y")){
		deliverOrderFlag = true;
	}
	
	//pagesize 가 10 인것만 pagesize가 사용됨.
	if(strPreview.equals("1")){
		aszPlist = Pricelist_Proc.Pricelist_DetailMulti_List3("", intModelno, "", "", "", false, 0, deliverOrderFlag);
	}else{
		aszPlist = Pricelist_Proc.Pricelist_DetailMulti_List3("", intModelno, "", "", "", false, 0, deliverOrderFlag);

		if(aszPlist!=null) {
%>
<%@ include file="/mobilefirst/include/inc_detail_proc.jsp"%>
<%
		}
	}

	//쇼핑몰 상위입찰
	if(aszPlist!=null) {
%>
<%@ include file="/lsv2016/include/detail/inc_mini_shop_bid.jsp"%>
<%
	}
	
//zum으로 들어왔을때 쿠팡 예외처리 2016-05-18 shwoo
if(blZumFlag){
	Pricelist_Data[] aszDelPlist = (Pricelist_Data[])aszPlist.clone();
	int newPricelistCnt = 0;
	boolean[] isMatch = new boolean[aszPlist.length];
	
	if(aszPlist!=null) {
		for(int deli=0; deli<aszDelPlist.length; deli++) {
			isMatch[deli] = true;
	
			if(aszDelPlist[deli].getShop_code() == 7861){
				isMatch[deli] = false;
			}
	
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

%>
{
<%
//try {
	if(aszPlist != null && aszPlist.length > 0){
		if(tab_card.equals("Y")){
			//신용카드 가격 재정렬 해쉬
			TreeMap cardShopList = new TreeMap();
			for(int i=0; i<aszPlist.length; i++) {
				String tempIStr = ""+i;
				if(tempIStr.length()==1) tempIStr = "0000" + tempIStr;
				if(tempIStr.length()==2) tempIStr = "000" + tempIStr;
				if(tempIStr.length()==3) tempIStr = "00" + tempIStr;
				if(tempIStr.length()==4) tempIStr = "0" + tempIStr;
			
				if((aszPlist[i].getShop_code()==75 && aszPlist[i].getGoodsfactory().equals("쇼핑지원금")) || checkEventCard(cardNameHash, aszPlist[i].getShop_code()+"", aszPlist[i].getGoodsnm(), aszPlist[i].getPrice(), strCategory)){
					tempIStr = (aszPlist[i].getPrice_card()) + tempIStr;
					cardShopList.put(Long.parseLong(tempIStr), aszPlist[i]);
				}
			}

			Iterator cardKey = cardShopList.keySet().iterator();
			ArrayList tmpaszPlist = new ArrayList();
			for(int i=0; cardKey.hasNext(); i++) {
				tmpaszPlist.add((Pricelist_Data)cardShopList.get(cardKey.next()));
			}
			aszPlist = (Pricelist_Data[])tmpaszPlist.toArray(new Pricelist_Data[0]);;
		}

		out.println("	\"listContent\": [");
		
		intTotal = aszPlist[0].getAll_cnt();
		intFstshop = aszPlist[0].getShop_code();

		boolean blZumflag = false;
		int totalGoodsCnt = aszPlist.length;
		int listGoodscnt = 0;
		for(int i=0; i<aszPlist.length; i++) {
			
			if(strPreview.equals("1") && i == 10){
				break;
			}
			//if(blPcmini && i >= 30){
			//	break;
			//}
			if(aszPlist[i] != null ){
				//옵션필수구분
				boolean optionEssentialFlag = false;
				if(!optionEssentialFlag && aszPlist[i].getOption_flag2().equals("1") && aszPlist[i].getPrice()<=mMinPrice) {
					totalGoodsCnt = totalGoodsCnt-1;
					optionEssentialFlag = true;
				}
				if(!(aszPlist[i].getOption_flag2().equals("1") && aszPlist[i].getPrice()<=mMinPrice)){
					if(!strZumFlag.equals("Y") || (strZumFlag.equals("Y") && aszPlist[i].getShop_code() != 6378 && aszPlist[i].getShop_code() != 6368 )){
						listGoodscnt++; 
						String strShop_name = aszPlist[i].getShop_name();
						String strPlGoodsNmM = aszPlist[i].getGoodsnm();
						long mPrice = aszPlist[i].getPrice();
						long mPrice_card = aszPlist[i].getPrice_card();
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
						String strAuthflag = aszPlist[i].getAuthflag().replace("0","");
						String strCardflag = "";
						String strCardfreeflag = "";
						String strFreeinterest_chk = "";
						String strCoupon = "";
						String strCouponflag = "";
						String strMinpriceflag = "";
						int intCoupon = aszPlist[i].getCoupon();
						
						String vipRanUrl = "";					// 프로모션 랜딩 URL
						String pcMiniVipIcnViewDcd = "";	//미니VIP 아이콘 노출 구분 코드 : 쿠폰 받기 노출 C, 이벤트 아이콘 노출: M
						String pcMiniVipIcnStr = "";			// 미니 VIP 아이콘 문자열
						
						if (goodsLsv11StMap.containsKey(strGoodscode)) {
							Goods_Lsv_11St_Data goodsLsv11StData = goodsLsv11StMap.get(strGoodscode);

							if (goodsLsv11StData != null) {
								 vipRanUrl = goodsLsv11StData.getPc_promtn_url();
								 pcMiniVipIcnViewDcd = goodsLsv11StData.getPc_minivip_icn_view_dcd();
								 pcMiniVipIcnStr = goodsLsv11StData.getPc_minivip_icn_str();
							}
						}
						
						 
						String strDetail_url = aszPlist[i].getUrl1();
						
						//G마켓 G9 리다이텍트 상품
						String strG9_model = "";
						if(lngG9_plno == iPlno){
							strG9_model =  "Y";
						}
	
						//쇼핑몰 상위입찰
						String strShop_bid = aszPlist[i].getBid_flag();
						//System.out.println("intShop_bid : " + intShop_bid + "pl_no :" + iPlno);
						if(!(strShop_bid.equals("") || strShop_bid.equals("9"))){
							strShopBidFlag = "Y";
						}
						//상위입찰 클릭번호 입력
						if(strShop_bid.equals("1")){
							strLogno_view = strLogno_view_1;
							strLogno_click = strLogno_click_1;
						}else if(strShop_bid.equals("2")){
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
	
						if(mPrice > 0){
							mPrice = mPrice;
						}else{
							mPrice = 0;
						}
	
						// 신용카드 정보를 보여줘야 할 경우 제목에 신용카드 정보를 입력함
						String tempCardName = "";
	
						tempCardName = getCardNmEvent(cardNameHash, szVcode+"", strPlGoodsNmM, mPrice, strCa_code_l);
						if(szVcode==75 && !strGoodsfactory.equals("쇼핑지원금")) {
							tempCardName = tempCardName.replaceAll("쇼핑지원금:", "");
							tempCardName = tempCardName.replaceAll("쇼핑지원금", "");
						}
	
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
	
						if(i == 0){
							mMinPrice = mPrice;
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
						}else if(mPrice==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
						}else{
							if(mPrice == mMinPrice){
								strMinpriceflag = "Y";
								
								if(szVcode == 6641){	//티몬
									strDetail_url = "http://m.ticketmonster.co.kr/deal/detailDaily/bbbbb?page=review";
									//티몬은 strShop_url 에 p_no= 값 
									//strShop_url : http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=175768289&o_no=175773197
									ibbbbb_1 = strShop_url.indexOf("&p_no=") + 6;
									ibbbbb_2 = strShop_url.indexOf("&o_no=");
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
	
						if(strShopBidFlag.equals("Y") && (strShop_bid.equals("")|| strShop_bid.equals("9")) && strMinpriceflag.equals("Y")){
							strMinpriceflag = "";
						}
	
						if(!deliveryInfo.equals("무료배송")){
							if(deliveryType2 != 0){
								if(deliveryType2 == 1 && deliveryInfo2 == 0){
								}else{
									if(tab_dminsort.equals("Y")){
										mPrice = mPrice + Long.parseLong(deliveryInfo2+"");
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
							strPrice = "미정";
						}else if(mPrice==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
							strPrice = toNumFormat(mPrice)+"";
						}else{
							strPrice = toNumFormat(mPrice)+"";
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
	
						//out.println("mMinPrice_org>>>>"+mMinPrice_org);
						//out.println("mMinPrice>>>>"+mMinPrice);
						if(listGoodscnt>1) out.print("	,\r\n");
						out.println("	{ ");
						out.println("		\"shopname\":\""+ toJS2(strShop_name) +"\", ");
						out.println("		\"shopurl\":\""+ toJS2(strShop_url) +"\", ");
						out.println("		\"shopcode\":\""+ toJS2(szVcode+"") +"\", ");
						out.println("		\"mobileurl\":\""+ toJS2(strMobile_url) +"\", ");
						out.println("		\"price\":\""+ strPrice +"\", ");
						out.println("		\"instanceprice\":\""+ toJS2(instance_price+"") +"\", ");
						out.println("		\"goodscode\":\""+ toJS2(strGoodscode) +"\", ");
						out.println("		\"minprice\":\""+ mMinPrice +"\", ");
						out.println("		\"mPrice_card\":\""+ mPrice_card +"\", ");
						out.println("		\"plno\":\""+ toJS2(iPlno+"") +"\", ");
						out.println("		\"ca_code\":\""+ toJS2(strCa_code_l) +"\", ");
						out.println("		\"category\":\""+ toJS2(strCategory) +"\", ");
						out.println("		\"plgoodsname\":\""+ toJS2(strPlGoodsNmM) +"\", ");
						out.println("		\"deliveryinfo1\":\""+ toJS2(deliveryInfo) +"\", ");
						out.println("		\"deliveryinfo2\":\""+ toJS2(deliveryInfo2+"") +"\", ");
						out.println("		\"cardname\":\""+ toJS2(tempCardName) +"\", ");						//pc vip와 규칙 맞춤 20201102 (scboys)  cardName ==> tempCardName 으로 변경 
						out.println("		\"authflag\":\""+ toJS2(strAuthflag) +"\", ");
						out.println("		\"cardflag\":\""+ toJS2(strCardflag) +"\", ");
						out.println("		\"cardfreeflag\":\""+ toJS2(strCardfreeflag) +"\", ");
						out.println("		\"freeinterestflag\":\""+ toJS2(strFreeinterest_chk) +"\", ");
						out.println("		\"couponflag\":\""+ toJS2(strCouponflag) +"\", ");
						out.println("		\"mpriceflag\":\""+ toJS2(strMinpriceflag) +"\", ");
						out.println("		\"pricecard\":\""+ intPrice_card +"\", ");
						out.println("		\"detail_url\":\""+  toJS2(strDetail_url) +"\", ");
						out.println("		\"deliveryType2\":\""+  deliveryType2 +"\", ");
						if(szVcode==8446||szVcode==8447||szVcode==8448 ||szVcode==8826||szVcode==8827||szVcode==8828||szVcode==8829){
							out.println("		\"displaydelivery\":\"해외배송(별도)\", ");
						 }else if(deliveryInfo.equals("무료배송")){
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
									if(!deliveryInfo.isEmpty() && !"0".equals(deliveryInfo)) {
										out.println("		\"displaydelivery\":\""+deliveryInfo+"\", ");
									} else { 
										out.println("		\"displaydelivery\":\"무료배송\", ");
									}
								}else{
									if(tab_dminsort.equals("Y")){
										out.println("		\"displaydelivery\":\" 배송비 "+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 포함\", ");
									}else{
										out.println("		\"displaydelivery\":\" 배송비 "+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원\", ");
									}
								}
							}
						}
						out.println("		\"shop_bid\":\""+  strShop_bid +"\", ");
						if(!(strShop_bid.equals("") || strShop_bid.equals("9"))){
							out.println("	\"shopbidflag\":\"Y\",  ");
							out.println("	\"shopbidlogno_view\":\""+ strLogno_view +"\",  ");
							out.println("	\"shopbidlogno_click\":\""+ strLogno_click +"\",  ");
						}else{
							out.println("	\"shopbidflag\":\"\",  ");
							out.println("	\"shopbidlogno_view\":\"\",  ");
							out.println("	\"shopbidlogno_click\":\"\",  ");
						}
						out.println("	\"pc_mini_vip_icn_view_dcd\":\""+ pcMiniVipIcnViewDcd +"\",  ");
						out.println("	\"pc_mini_vip_icn_str\" : \""+pcMiniVipIcnStr+"\", ");
						out.println("	\"pc_promtn_url\" : \""+vipRanUrl+"\", ");
						//홈플러스 더클럽 모바일전용상품 플래그
						String strMobileOnly = "N";
						if(szVcode==8365){
							strMobileOnly = "Y";
						}
						out.println("			\"mobileOnly\" : \""+toJS2(strMobileOnly)+"\", ");
						//G마켓 G9 예외
						out.println("	\"gmarket_g9\":\""+ strG9_model +"\"  ");
						out.println("	}");
					}
				}	
			}
		}
		out.println("	],");
		out.println("	\"eventModelCouponCheck\":\""+ eventModelCouponCheck +"\",  ");
		out.println("	\"listCount\":\""+ totalGoodsCnt +"\",  ");
		out.println("	\"FstShop\":\""+ intFstshop +"\",  ");
		out.println("	\"instanceMinPrice\":\""+ mMinPrice +"\",  ");

		if(mMinPrice_org < mMinPrice){
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
		out.println("		\"shop_bid\":\"\" ");
		out.println("	} ");
		out.println("	],");
		out.println("	\"eventModelCouponCheck\":\""+ eventModelCouponCheck +"\",  ");
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