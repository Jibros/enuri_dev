<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Goods_Search"%>
<%@ page import="com.enuri.include.RandomMain"%>
<jsp:useBean id="Goods_Data" class="com.enuri.bean.main.Goods_Data" scope="page" />
<jsp:useBean id="Mobile_Goods_Proc" class="com.enuri.bean.mobile.Mobile_Goods_Proc" scope="page" />
<jsp:useBean id="Pricelist_Data" class="Pricelist_Data" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="Pricelist_Proc" scope="page" />
<jsp:useBean id="Mobile_Pricelist_Proc" class="com.enuri.bean.mobile.Mobile_Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search" class="Goods_Search" scope="page" />
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ include file="/include/IncDetailCommon_2010.jsp"%>
<%@ include file="/mobilefirst/include/incselectplist_dual.jsp"%>
<%
String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
String strPreview = ChkNull.chkStr(request.getParameter("preview"),"0");

int intModelno = ChkNull.chkInt(request.getParameter("modelno"),0);
int intGroup = ChkNull.chkInt(request.getParameter("group"),0);
String strCate = ChkNull.chkStr(request.getParameter("ca_code"),"0201");
String strTabinfoYn = ChkNull.chkStr(request.getParameter("tabinfoyn"),"N"); //정렬기준 항목정보 리턴 여부
String strTabinfoYnString = "";

int intPage = ChkNull.chkInt(request.getParameter("page"),1);
int intPagesize = ChkNull.chkInt(request.getParameter("pagesize"),50);

String szCallDataOpt = ConfigManager.RequestStr(request, "szCallDataOpt", "");
/*
 * szCallDataOpt 값으로 나올수 있는 헤더값.
 *
opt_card
무료배송/옵션필수

opt_term
배송비 포함 쇼핑몰/무료배송/배송비 유무료 쇼핑몰/배송비 유무료 쇼핑몰

opt_scale
대형몰/전문쇼핑몰/오픈마켓/일반쇼핑몰

opt_home
일반쇼핑몰/홈쇼핑

opt_shocking2
보상(2G→3G)/보상(3G→3G)

opt_card
일반 결제조건 가격/특정카드 할인가

opt_tariff
세금, 배송비 무료 /  세금, 배송비 유무료

opt_nboption
배송비 포함 쇼핑몰 / 필수옵션 없음 (추천!) / 배송비 유무료 쇼핑몰 / 필수옵션 확인요망

opt_freeset
전국 무료장착 / 일부지역 무료장착 / 좌측쇼핑몰 / 우측쇼핑몰
 */

//String tab_minsort = ChkNull.chkStr(request.getParameter("tabyn_minsort"),""); //배송비미포함
//String tab_dminsort = ChkNull.chkStr(request.getParameter("tabyn_dminsort"),""); //배송비포함

//최저가 가지고 오기.. 초기에는 0
long lngInstanceMinPrice = ChkNull.chkInt(request.getParameter("instanceminprice"),0);

String strSort = "";

int intModelno_group = 0;//goods_data_pop.getModelno_group();

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

String strCondi = goods_data_pop.getCondiname();
String strCdate = goods_data_pop.getC_date();
String strFactory = goods_data_pop.getFactory();
String strCategory = goods_data_pop.getCa_code();
long mMinPrice = goods_data_pop.getMinprice();
String szModelNm = goods_data_pop.getModelnm();
szModelNm = replaceModelNmSpecialChar(strCategory, szModelNm);
String szSpec = goods_data_pop.getSpec();

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

//카드 코드와 이름을 저장함
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
Pricelist_Data[] aszPlist = null;
Pricelist_Data[] aszTmpPlist = null;

long intMinPrice = 0;
//상위입찰
boolean blBid = true;

if(blChk_group){
	aszPlist = Mobile_Pricelist_Proc.get_list_first_group(strTmp_modelnos, strCategory, intGroup, strSort, intPage, intPagesize);
}else{
	aszPlist = Mobile_Pricelist_Proc.get_list_first_bid(intModelno, strCategory, intGroup, strSort, intPage, intPagesize, blBid);
}

boolean opt_termSumFlag = false;

//해외쇼핑 관세상품여부
boolean tariffFlag = false;
//제조사 인증 공식판매자 여부 확인
boolean authShowFlag = false;
//에어컨
String airconFlag = "";
String priceCardFlag = "";

java.util.HashMap phonePriceAllHash = new java.util.HashMap();

// 전시,중고,반품 구분 airconfeetype필드를 이용해서 구분, left만 있을 경우는 1, right만 있을 경우는 2, 둘다 있을 경우는 3
int junggoShowType = 0;

// 옵션 필수 상품 보여주기 플래그
boolean optionEssentialFlag = false;
// 옵션 필수는 안보이도록 하는 플래그
String optionEssentialDel = ConfigManager.RequestStr(request, "optionEssentialDel", "Y");

// 옵션비교 분류임을 확인하는 플래그
boolean optionCompCateFlag = IsOptionCompCate(strCategory);

// 옵션비교가 1개라도 있는지 확인하는 플래그
boolean optionCompFlag = false;
// 옵션비교의 총 개수를 구함
int optionContCnt = 0;

int buycnt = 1;

String strListViewType = ConfigManager.RequestStr(request, "strListViewType", "");;

int dj = 0;

int nModelNo = intModelno;

if(nModelNo==0) {
	return;
}

//배송비 관련 수량별 선택
// 0:디폴트, 1:배송비 별도가 상단 표시, 2:XX set 복수구매계산 적용, 3:기본표시가
String priceListShowType = "0"; //ConfigManager.RequestStr(request, "priceListShowType", "0");

boolean phonePriceAllFlag = false;
phonePriceAllFlag = checkPhonePriceAllFlag(strCategory, szModelNm);
String phonePriceTab = ChkNull.chkStr(request.getParameter("phonePriceTab"),""); //Y:휴대폰 판매가몰만 보임
String phoneNetworkType = ChkNull.chkStr(request.getParameter("phoneNetworkType"),"");
String phoneCompany = ChkNull.chkStr(request.getParameter("phoneCompany"),"");
String phonePlan = "";// ChkNull.chkStr(request.getParameter("phonePlan"),"");
String phonePlanNm = "";
boolean phonePriceExists = Pricelist_Proc.isPhoneSaleShop(nModelNo); //판매가몰 존재여부
//GS쇼핑지원금의 존재 여부
boolean gsEventFlag = false;
//현재의 파워셀러를 저장하는 변수
String powerUsersAry = "";
//판매자 광고문구
String[][] arrSellerAd = null;
//현재 모든 쇼핑몰이 무료인지 확인하는 플래그
boolean allFreeFlag = true;
// 현재 리스트에 나오는 상품들 중에 배송비가 있는 것이 확실한 상품의 개수를 구함
int deliveryType1Num2 = 0;


if(aszPlist!=null && 1 == 2) {	//사용안함.
%>
<%@ include file="/mobilefirst/include/inc_detail_dual_proc.jsp"%>
<%
}

//옵션 필수,비교 상품이 있는지 확인
if(aszPlist!=null) {
	for(int deli=0; deli<aszPlist.length; deli++) {
		//if(nModelNo==8596838){
		//	System.out.println(">>> " + aszPlist[deli].getPl_no() + "," + aszPlist[deli].getOption_flag2() + "," + aszPlist[deli].getAuthflag());
		//}
		// 옵션필수 상품 확인
		if(!optionEssentialFlag && aszPlist[deli].getOption_flag2().equals("1") && aszPlist[deli].getPrice()<=mMinPrice) {
			optionEssentialFlag = true;
		}
		// 제조사 인증 공식판매자 여부 확인
		if(!authShowFlag && !aszPlist[deli].getOption_flag2().equals("1") && aszPlist[deli].getAuthflag().equals("Y")) {
			if(!getAuthLogoCheck(strCategory, strFactory).equals("")){
				authShowFlag = true;
			}
		}
		//노트북 분류 필수옵션 좌우구분 (7:필수옵션확인요망-우측)
		if(!(priceListShowType.equals("1") || priceListShowType.equals("2")) && !szCallDataOpt.equals("opt_nboption") && (CutStr.cutStr(strCategory,4).equals("0404") || (!phonePriceAllFlag && CutStr.cutStr(strCategory,4).equals("0305"))) && aszPlist[deli].getAirconfeetype().equals("7")){
			szCallDataOpt = "opt_nboption";
		}
		//타이어 분류 무료장착 좌우구분 (2:전국무료장착-좌측)
		if(!(priceListShowType.equals("1") || priceListShowType.equals("2")) && !szCallDataOpt.equals("opt_freeset") && CutStr.cutStr(strCategory,4).equals("2115") && szModelNm.indexOf("무료장착")>0){
			szCallDataOpt = "opt_freeset";
		}
		// 옥션과 지마켓은 옵션 비교 안함
//				if(!ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0234", "0233", "1005"}) &&
//					(aszPlist[deli].getShop_code()==4027 || aszPlist[deli].getShop_code()==536)) {
//					aszPlist[deli].setOption_flag("");
//				}
		// 인터파크는 옵션비교 안함 2011-05-13
//				if(aszPlist[deli].getShop_code()==55) {
//					aszPlist[deli].setOption_flag("0");
//				}

		// 옵션비교 상품 확인
		//if(szSelectedShop.length()==0 && !optionCompFlag && aszPlist[deli].getOption_flag().equals("1")) {
		//if(!optionCompFlag && aszPlist[deli].getOption_flag().equals("1")) {
		optionCompFlag = true;

		if(aszPlist[deli].getOption_flag().equals("1")) {
			optionContCnt++;
		}

		// GS 쇼핑지원금의 유무 확인
		if(aszPlist[deli].getShop_code()==75 && aszPlist[deli].getGoodsfactory().equals("쇼핑지원금")) {
			if(aszPlist[deli].getPrice_card()==0) aszPlist[deli].setPrice_card(aszPlist[deli].getPrice());
			gsEventFlag = true;
		}

		// 파워셀러마크 : 파워셀러 인증 + (판매자 상위입찰 상품 or 유료 광고문구 서비스중)
		aszPlist[deli].setPower_flag("");
		if(aszPlist[deli].getEnuri_user_id().length()>0) {
			//1.파워셀러 인증
			if(powerUsersAry.indexOf("|"+aszPlist[deli].getShop_code()+"-"+aszPlist[deli].getEnuri_user_id()+"|")>-1) {
				//2-1.판매자 상위입찰 상품
				if(aszPlist[deli].getBid_flag().equals("1") || aszPlist[deli].getBid_flag().equals("2") || aszPlist[deli].getBid_flag().equals("3")){
					aszPlist[deli].setPower_flag("Y");
				}else if(arrSellerAd!=null && arrSellerAd.length>0){ //3-1.유료 광고문구 서비스중
					for(int sad_i=0; sad_i<arrSellerAd.length; sad_i++){
						if(aszPlist[deli].getPl_no()==ChkNull.chkLong(arrSellerAd[sad_i][0])){
							aszPlist[deli].setPower_flag("Y");
						}
					}
				}
			}
		}
		// 신용카드 특가 옥션 예외처리
		// 현재 요일 구하기
		Calendar oCalendar = Calendar.getInstance();
		int dayofweek = oCalendar.get(Calendar.DAY_OF_WEEK);
		if(aszPlist[deli].getShop_code()==4027 && dayofweek==5
			&& !(CutStr.cutStr(strCategory,6).equals("150202") || CutStr.cutStr(strCategory,4).equals("1020") || CutStr.cutStr(strCategory,4).equals("2304") ||
				CutStr.cutStr(strCategory,4).equals("0333"))) {
			int tempCardPrice = 0;
			if(aszPlist[deli].getTmp_price()>50000) {
				tempCardPrice = (int)(aszPlist[deli].getTmp_price() - 10000);
			} else {
				tempCardPrice = (int)(aszPlist[deli].getTmp_price() * 0.8);
			}
			aszPlist[deli].setPrice_card(tempCardPrice);
		}
		// 무료 배송이 아닌 쇼핑몰이 포함되어 있을 경우 플래그 변경
		if(aszPlist[deli].getDeliverytype2()==0 || (aszPlist[deli].getDeliverytype2()==1 && aszPlist[deli].getDeliveryinfo2()>0)) {
			allFreeFlag = false;
		}

		// 현재 리스트에 나오는 상품들 중에 배송비가 있는 것이 확실한 상품의 개수를 구함
		if(aszPlist[deli].getDeliverytype2()==1 && aszPlist[deli].getDeliveryinfo2()>0) {
			deliveryType1Num2++;
		}
	}
}
if(optionCompFlag) {
	if(optionCompCateFlag) {
	} else { // 위 분류 외에는 옵션 정보가 들어온다고 해도 옵션 데이터를 보여주지 않음
		optionCompFlag = false;
	}
}



//기본 선택탭 Start
if(ChkNull.chkStr(szCallDataOpt).equals("")) {
	if(mMinPrice > 100000) {
		szCallDataOpt = "opt_scale";
	} else {
		if(ChkNull.chkStr(szCallDataOpt).equals("") || (ChkNull.chkStr(szCallDataOpt).equals("opt_auth")))	{
			szCallDataOpt = "opt_term";
		}
	}

	if((strCategory.length() >= 2 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,2),"14"})) && mMinPrice<100000) {
		szCallDataOpt = "opt_term";
		opt_termSumFlag = false;
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,8),"02010109","02010110"})) {
		szCallDataOpt = "opt_term";
		opt_termSumFlag = false;
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"090503","090504","090505","090506","090508","090509","090511","090519"})) {
		szCallDataOpt = "opt_term";
		opt_termSumFlag = false;
	}
	if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1242","2406","2403"})) {
		szCallDataOpt = "opt_term";
		opt_termSumFlag = false;
	}
}

if((strCategory.length() >= 2 && ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,2),"14"})) && mMinPrice<100000) {	//20060523 식품, 의류, 에어컨, 3만원 미만 디폴트 조건
	opt_termSumFlag = false;
}
//영상음향 > TV > 브라운관 정렬기준 변경  : 대형몰 / 전문 쇼핑몰 → 무료배송 쇼핑몰 / 배송비 유료 쇼핑몰
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"020101","020102"})) {
	opt_termSumFlag = false;
}
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"090503","090504","090505","090506","090508","090509","090511","090519"})) {
	opt_termSumFlag = false;
}
if(CutStr.cutStr(strCategory,2).equals("14")) {
	opt_termSumFlag = false;
}

cb.SetCookie("SITEOPT3", "DETAIL_DATAOPT", szCallDataOpt);

// 배송비 기준
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0405","0503","0527","0601","0604","0621","1220","1201","1202","1203","1204","1205","1207"})
	|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"031502","031503"})
){
	szCallDataOpt = "opt_term";
	opt_termSumFlag = false;
}
// 오픈마켓/일반몰 기준
if(CutStr.cutStr(strCategory,6).equals("033308") || CutStr.cutStr(strCategory,6).equals("080710") || CutStr.cutStr(strCategory,8).equals("03330501")) {
	szCallDataOpt = "opt_scale";
}
// 오픈마켓/일반몰 기준 : 상품권
if(ControlUtil.compareValOR(new int[]{nModelNo,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})
	|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,8),"03330501"})
	|| CutStr.cutStr(strCategory,4).equals("0304")
	|| CutStr.cutStr(strCategory,8).equals("02332217")
	|| ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0404","2401"})
){
	szCallDataOpt = "opt_scale";
	opt_termSumFlag = false;
}
// 오픈마켓/일반몰 기준
if(szModelNm.indexOf("[")>=0 && szModelNm.indexOf("]")>=0 && szModelNm.indexOf("[렌탈")>=0){
	szCallDataOpt = "opt_scale";
	opt_termSumFlag = false;
}
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0527"}) && szModelNm.indexOf("약정조건")>=0) {
	szCallDataOpt = "opt_scale";
	opt_termSumFlag = false;
}
boolean deliveryShowFlag = true; //배송비 안보이게 예외처리
if(ControlUtil.compareValOR(new int[]{nModelNo,1248637,1720032,1720028,1247170,1248620,1248888,1248623,1370212,1370216,1267468,1248613,1267467,1248860,1243685})) {
	deliveryShowFlag = false;
}
// 오픈마켓/일반몰 기준
if(ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033316","033317","033318","033319","033305","033308","090813","090816","090817"})
	|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,6),"033301"}) && szModelNm.indexOf("PIN번호")>-1)
	|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && szModelNm.indexOf("PIN번호")>-1)
	|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && szSpec.indexOf("모바일상품권")>-1)
	|| (ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"1647"}) && szSpec.indexOf("모바일쿠폰")>-1)
){
	szCallDataOpt = "opt_scale";
	opt_termSumFlag = false;
	deliveryShowFlag = false;
}

//에어컨
if(CutStr.cutStr(strCategory,4).equals("2401")){
	//airconFlag = Goods_Search.getAirconFlag(nModelNo);
	if(!airconFlag.equals("")){
		szCallDataOpt = "opt_aircon";
	}
}
String IsHomeshop = ConfigManager.RequestStr(request, "IsHomeshop", "");
// 홈쇼핑에서 링크 되었을 경우 opt_phone
if(IsHomeshop.equals("Y"))	{
	szCallDataOpt = "opt_home";
	opt_termSumFlag = false;
}
// KT 보상 분류 변경(쇼킹i형-보상,쇼킹골드-보상) 문구가 있을때 실행
if(CutStr.cutStr(strCategory,6).equals("030403") && szModelNm.indexOf("지정요금제-보상")>-1) {
	szCallDataOpt = "opt_shocking2";
	opt_termSumFlag = false;
}
// 전시,중고,반품 구분이 있는지 확인
boolean jungoModelFind = false;
try {
	if(!phonePriceAllFlag && szModelNm.indexOf("[")>-1 && szModelNm.substring(szModelNm.indexOf("[")).indexOf("중고")>-1 && !((ControlUtil.compareValOR(new String[]{CutStr.cutStr(strCategory,4),"0304","0305"}) || CutStr.cutStr(strCategory,8).equals("02332217")) && szModelNm.indexOf("해외쇼핑")>-1)) {
		jungoModelFind = true;
	}
} catch(Exception e) {}
//해외쇼핑 관세기준
if(szModelNm.indexOf("[")>-1 && szModelNm.substring(szModelNm.indexOf("[")).indexOf("해외쇼핑")>-1){
	if(mMinPrice>=100000){
		szCallDataOpt = "opt_tariff";
		jungoModelFind = false;
		tariffFlag = true;
	}else{
		szCallDataOpt = "opt_term";
		opt_termSumFlag = false;
	}
}
// 배송비로 보여주는 상세창은 디폴트로 배송포함가로 셀렉트
if(szCallDataOpt.equals("opt_term") && priceListShowType.equals("0") && !priceCardFlag.equals("Y")) priceListShowType = "3";
if(priceListShowType.equals("1")) szCallDataOpt = "opt_term";

//기본 선택탭 End

//out.println("real_Plist.length>>>"+aszPlist.length);
//판매 쇼핑몰을 좌/우 두개 목록으로 분리 - 재정렬 및 정렬 케이스 산출.
Pricelist_Data[][] real_Plist = orderPricelist(goods_data_pop, aszPlist);

//out.println("real_Plist.length>>>"+real_Plist.length);

Pricelist_Data[] left = real_Plist[0];
Pricelist_Data[] right = real_Plist[1];

String strLeft_title = "";
String strRight_title = "";

//out.println("left[0].getCalldataopt()>>>"+left[0].getCalldataopt());
//out.println("right[0].getCalldataopt()>>>"+right[0].getCalldataopt());


%>
{
<%

if(left!=null && left.length > 0){
	strLeft_title = getLeftRightTitle(szCallDataOpt, strCategory, strFactory,  cur_date, strCdate, "left",  optionEssentialFlag, optionEssentialDel, priceListShowType, airconFlag, authShowFlag, junggoShowType, strCondi, nModelNo, phonePriceAllFlag, phonePlan, phonePlanNm);
	out.println("	\"leftLength\": \""+  left.length +"\",");
	out.println("	\"leftTitle\": \""+  toJS2(strLeft_title) +"\",");
	out.println("	\"leftContent\": [");

	out.println(rtnList(left, strZumFlag, strCategory, cardFreeAry, cardShopCodes, cardNameHash, cardName, lngInstanceMinPrice, mMinPrice, strCdate, strCate4));

	out.println("	],");
}else{
	strLeft_title = getLeftRightTitle(szCallDataOpt, strCategory, strFactory,  cur_date, strCdate, "left",  optionEssentialFlag, optionEssentialDel, priceListShowType, airconFlag, authShowFlag, junggoShowType, strCondi, nModelNo, phonePriceAllFlag, phonePlan, phonePlanNm);
	out.println("	\"leftLength\": \"0\",");
	out.println("	\"leftTitle\": \""+  toJS2(strLeft_title) +"\",");
	out.println("	\"leftContent\": [");
	out.println("	],");
}
if(right!=null && right.length > 0){
	strRight_title = getLeftRightTitle(szCallDataOpt, strCategory, strFactory,  cur_date, strCdate, "right",  optionEssentialFlag, optionEssentialDel, priceListShowType, airconFlag, authShowFlag, junggoShowType, strCondi, nModelNo, phonePriceAllFlag, phonePlan, phonePlanNm);
	out.println("	\"rightLength\": \""+  right.length +"\",");
	out.println("	\"rightTitle\": \""+  toJS2(strRight_title) +"\",");
	out.println("	\"rightContent\": [");

	out.println(rtnList(right, strZumFlag, strCategory, cardFreeAry, cardShopCodes, cardNameHash, cardName, lngInstanceMinPrice, mMinPrice, strCdate, strCate4));

	out.println("	]");
}else{
	strRight_title = getLeftRightTitle(szCallDataOpt, strCategory, strFactory,  cur_date, strCdate, "right",  optionEssentialFlag, optionEssentialDel, priceListShowType, airconFlag, authShowFlag, junggoShowType, strCondi, nModelNo, phonePriceAllFlag, phonePlan, phonePlanNm);
	out.println("	\"rightLength\": \"0\",");
	out.println("	\"rightTitle\": \""+  toJS2(strRight_title) +"\",");
	out.println("	\"rightContent\": [");
	out.println("	]");
}

if(!strTabinfoYnString.equals("")){
	out.println(",");
	out.println(strTabinfoYnString);
	out.println(",");
	out.println("\"szCallDataOpt\":\""+ szCallDataOpt +"\"");
	out.println(",");
	out.println("\"basictitle\":\""+ toJS2(strLeft_title) + " / " + toJS2(strRight_title) +"\"");
}else{
	if(strTabinfoYn.equals("Y")){
		out.println(",");
		out.println("\"szCallDataOpt\":\""+ szCallDataOpt +"\"");
		out.println(",");
		out.println("\"basictitle\":\""+ toJS2(strLeft_title) + " / " + toJS2(strRight_title) +"\"");
	}
}
%>
}