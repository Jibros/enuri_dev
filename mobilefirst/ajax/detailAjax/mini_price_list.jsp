<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ include file="/include/IncSearch.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@ page import="com.enuri.bean.main.Goods_BBS_Data"%>
<%@ page import="com.enuri.bean.main.Goods_BBS_Proc"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="com.enuri.bean.main.Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="com.enuri.bean.main.Goods_Search" scope="page" />
<jsp:useBean id="Goods_BBS_Data" class="com.enuri.bean.main.Goods_BBS_Data" scope="page" />
<jsp:useBean id="Goods_BBS_Proc" class="com.enuri.bean.main.Goods_BBS_Proc" scope="page" />
<%

//QDx5bIClmpDtc_5ib9uGwdp7hLbCuPACw79x583ga27t9oAOJuz8dGlAscvZrsxz3ziiAYCdJlIfbeXFfv962rBEY9OiHzAZLm9KeiY6iNq1zhmf40CtDtAhTxMxpqshKKDn_P9BnWK3KuL5mzE6lc1VhnUYdSDQGj90_6dkRM8
	String strT1 = ChkNull.chkStr(request.getParameter("t1"));

	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	String strPreview = ChkNull.chkStr(request.getParameter("preview"),"0");
	
	//if(strReferer != null && !strReferer.equals("")){	//불법 접근 차단

	String intPrdNo = ChkNull.chkStr(request.getParameter("prdno"),"");
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

	int intPage = ChkNull.chkInt(request.getParameter("page"),1);
	int intPagesize = ChkNull.chkInt(request.getParameter("pagesize"),50);

	//최저가 가지고 오기.. 초기에는 0
	long lngInstanceMinPrice = ChkNull.chkInt(request.getParameter("instanceminprice"),0);

	String strSort = "";

	int intModelno_group = 0;//goods_data_pop.getModelno_group();

	if(tab_dminsort.equals("Y"))	strSort = "Y";

	Goods_Data goods_data_pop = null;
	
	String strTmp_modelnos = ChkNull.chkStr(request.getParameter("modelnos"),"");	//체크 항목 리스트
	boolean blChk_group = false;
	
	if(strTmp_modelnos.indexOf(",") > -1){
		intModelno= Mobile_Goods_Proc.get_Minpricemodelno_group(strTmp_modelnos);	//그룹모델일때 기본정보들은 그 그룹에서 제일 최저가를 가진 모델이 대표가 됨.
		blChk_group = true;
	}

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

	int intTotal = 0;
	int intFstshop = 0;

	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";

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
	String strCondi = goods_data_pop.getCondiname();
	String strCdate = goods_data_pop.getC_date();
	String strFactory = goods_data_pop.getFactory();
	String strCategory = goods_data_pop.getCa_code();
	long mMinPrice = goods_data_pop.getMinprice();
	long mMinPrice_org = goods_data_pop.getMinprice();
	String strBrand = goods_data_pop.getBrand();
	
	//모델명 변경 2015.10.12.
	String[] strModelno_new = getModel_FBN(strCategory, strModelnm, strFactory, strBrand);
	String strView_modelnm = strModelno_new[1] + " "+ strModelno_new[2] + " "+ strModelno_new[0];
	
	strView_modelnm = strView_modelnm.replace("  "," ");

	strModelnm = strView_modelnm;
	
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
	
	strModelnm = removeTag(strModelnm);

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
			if(strCdate.substring(5,6).equals("0")){
				dateText = "'"+strCdate.substring(2,4)+"년 "+strCdate.substring(6,7)+"월 출시";
			}else{
				dateText = "'"+strCdate.substring(2,4)+"년 "+strCdate.substring(5,7)+"월 출시";
			}
		}
	}
	
	Pricelist_Data[] aszPlist = null;


	//pagesize 가 10 인것만 pagesize가 사용됨.
	if(strPreview.equals("1")){
		aszPlist = Mobile_Pricelist_Proc.get_list_first_all(intModelno, strCategory, intGroup, "", 1, 10);
	}else{
		if(blChk_group){
			aszPlist = Mobile_Pricelist_Proc.get_list_first_group(strTmp_modelnos, strCategory, intGroup, strSort, intPage, intPagesize);
		}else{
			aszPlist = Mobile_Pricelist_Proc.get_list_first_all(intModelno, strCategory, intGroup, strSort, intPage, intPagesize);
		}
	}
%>
{
<%
	String strZumFlag = "N";
	Cookie[] cookies = request.getCookies();
	if(cookies!=null && cookies.length>0) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("FROMZUM")) {
				strZumFlag = cookies[i].getValue();
			}
		}
	}
	if(strZumFlag.equals("N") || strZumFlag.equals("")){
		strZumFlag = cb.getCookie_One("FROMZUM");
	}
	
	//별점가지고 오기
	Goods_BBS_Proc goods_bbs_proc = new Goods_BBS_Proc();
	int intStarAvg = goods_bbs_proc.Goods_BBS_Star_Avg(intModelno+"");	//별 평균

//try {
	if(aszPlist != null && aszPlist.length > 0){
		out.println("	\"modelno\":  \"" + intModelno + "\",");
		out.println("	\"modelnm\":  \"" + chk_Webapp_tojs(request, strModelnm) + "\",");
		//out.println("	\"factory\":  \"" + chk_Webapp_tojs(request, strFactory) + "\",");
		out.println("	\"factory\":  \"\",");
		out.println("	\"date\":  \"" + dateText + "\",");
		out.println("	\"staravg\":  \"" + ((double)(intStarAvg) / 10 ) +"" + "\",");
		out.println("	\"prdNo\":  \"" + intPrdNo + "\",");
		out.println("	\"listContent\": [");

		intTotal = aszPlist[0].getAll_cnt();
		intFstshop = aszPlist[0].getShop_code();
		
		boolean blZumflag = false;

		for(int i=0; i<aszPlist.length; i++) {
			if(aszPlist[i] != null ){
				if(!strZumFlag.equals("Y") || (strZumFlag.equals("Y") && aszPlist[i].getShop_code() != 6378 && aszPlist[i].getShop_code() != 6368 )){
	
					String strShop_name = aszPlist[i].getShop_name();
					String strPlGoodsNmM = aszPlist[i].getGoodsnm();
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
					String iPlno = "" + aszPlist[i].getPl_no();
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
					String strDetail_url = aszPlist[i].getUrl1();
					
					strPlGoodsNmM = toJS2(strPlGoodsNmM);
	
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
	
					if(instance_price > 0){
						instance_price = instance_price;
					}else{
						instance_price = 0;
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
	
					if(DateUtil.RtnDateComment(CutStr.cutStr(strCdate,10),"2010_list","").equals("예정")){
					}else if(instance_price==0 && ( strCate4.equals("0304") || strCate4.equals("0305") || strCate4.equals("0353"))){
					}else{
						if(instance_price == mMinPrice ){
							strMinpriceflag = "Y";
						}
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
					if(i == 0){
						if(mMinPrice_org < mMinPrice){
							out.println("	{ ");
							out.println("		\"shopname\":\"PC 최저가\", ");
							out.println("		\"shopurl\":\"\", ");
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
							out.println("		\"detail_url\":\"\" ");
							out.println("	} ");
							out.println("	,");
						}
	
					}
	
					if(i>0) out.print("	,\r\n");
					out.println("	{ ");
					out.println("		\"shopname\":\""+ chk_Webapp_tojs(request, strShop_name) +"\", ");
					out.println("		\"shopurl\":\""+ chk_Webapp_tojs(request, strShop_url) +"\", ");
					out.println("		\"shopcode\":\""+ chk_Webapp_tojs(request, szVcode+"") +"\", ");
					out.println("		\"mobileurl\":\""+ chk_Webapp_tojs(request, strMobile_url) +"\", ");
					out.println("		\"price\":\""+ strInstance_Price +"\", ");
					out.println("		\"instanceprice\":\""+ chk_Webapp_tojs(request, instance_price+"") +"\", ");
					out.println("		\"goodscode\":\""+ chk_Webapp_tojs(request, strGoodscode) +"\", ");
					out.println("		\"minprice\":\""+ mMinPrice +"\", ");
					out.println("		\"plno\":\""+ chk_Webapp_tojs(request, iPlno+"") +"\", ");
					out.println("		\"ca_code\":\""+ chk_Webapp_tojs(request, strCa_code_l) +"\", ");
					out.println("		\"category\":\""+ chk_Webapp_tojs(request, strCategory) +"\", ");
					out.println("		\"plgoodsname\":\""+ chk_Webapp_tojs(request, strPlGoodsNmM) +"\", ");
	
					out.println("		\"deliveryinfo1\":\""+ chk_Webapp_tojs(request, deliveryInfo) +"\", ");
					out.println("		\"deliveryinfo2\":\""+ chk_Webapp_tojs(request, deliveryInfo2+"") +"\", ");
					out.println("		\"cardname\":\""+ chk_Webapp_tojs(request, cardName) +"\", ");
					out.println("		\"authflag\":\""+ chk_Webapp_tojs(request, strAuthflag) +"\", ");
					out.println("		\"cardflag\":\""+ chk_Webapp_tojs(request, strCardflag) +"\", ");
					out.println("		\"cardfreeflag\":\""+ chk_Webapp_tojs(request, strCardfreeflag) +"\", ");
					out.println("		\"freeinterestflag\":\""+ chk_Webapp_tojs(request, strFreeinterest_chk) +"\", ");
					out.println("		\"couponflag\":\""+ chk_Webapp_tojs(request, strCouponflag) +"\", ");
					out.println("		\"mpriceflag\":\""+ chk_Webapp_tojs(request, strMinpriceflag) +"\", ");
					out.println("		\"detail_url\":\""+  chk_Webapp_tojs(request, strDetail_url) +"\", ");
					if(deliveryInfo.equals("무료배송")){
						out.println("		\"displaydelivery\":\"무료배송\" ");
					}else{
						if(deliveryType2 == 0){
							if (deliveryInfo.equals("")){	//유무료
								out.println("		\"displaydelivery\":\"유무료\" ");
							}else{
								out.println("		\"displaydelivery\":\""+deliveryInfo+"\" ");
							}
						}else{
							if(deliveryType2 == 1 && deliveryInfo2 == 0){
								out.println("		\"displaydelivery\":\"무료배송\" ");
							}else{
								if(tab_dminsort.equals("Y")){
									out.println("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 포함\" ");
								}else{
									out.println("		\"displaydelivery\":\""+toNumFormat(Long.parseLong(deliveryInfo2+""))+"원 별도\" ");
								}
							}
						}
					}
					out.println("	}");
				}
			}
		}
		out.println("	],");

		out.println("	\"listCount\":\""+ aszPlist.length +"\",  ");
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
		out.println("	\"modelno\":  \"" + intModelno + "\",");
		out.println("	\"modelnm\":  \"" + chk_Webapp_tojs(request, strModelnm)  + "\",");
		out.println("	\"factory\":  \"" + chk_Webapp_tojs(request, strFactory) + "\",");
		out.println("	\"date\":  \"" + dateText + "\",");
		out.println("	\"staravg\":  \"" + ((double)(intStarAvg) / 10 ) +"" + "\",");
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
		out.println("		\"detail_url\":\"\" ");
		out.println("	} ");
		out.println("	],");
		out.println("	\"listCount\":\"0\",  ");
		out.println("	\"FstShop\":\"pc\",  ");
		out.println("	\"instanceMinPrice\":\"\",  ");
		out.println("	\"pcPriceyn\":\"Y\"  ");
	}
	if(!strTabinfoYnString.equals("")){
		out.println(strTabinfoYnString);
	}
//} catch(Exception e) {
//}
%>
}
<%!

public String removeTag(String html) throws Exception {
	return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
} 

public String chk_Webapp_tojs(HttpServletRequest request, String str) throws Exception{
	
	String userAgent = request.getHeader("user-agent");

	//System.out.println("userAgent>>"+userAgent);
	
	if(userAgent.indexOf("enuriApp")  > -1|| userAgent.indexOf("Android") > -1){
		str = str.replace("&nbsp;"," ");
		return toJS2(str);
	}else{
		return toJS2(str);
	}
}
%>