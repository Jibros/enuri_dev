<%@page import="com.enuri.bean.wide.RedirectRool"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Inc_Mobile_Redirect.jsp"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/login/Inc_AutoLoginSet_2010.jsp"%>
<%@page import="org.json.simple.JSONObject"%>
<%

// 도메인 치환
RedirectRool rl = new RedirectRool();
Boolean blRedirect = rl.blRedirectDomain(request, response);
if(blRedirect) {
	return;
}

// 리스트 변수 필터
String cate = ConfigManager.RequestStr(request, "cate", ""); // 카테고리
String strCate4 = "";
String pageNum = ConfigManager.RequestStr(request, "page", "1"); // 페이지번호
String pageGap = ConfigManager.RequestStr(request, "pageGap", "30"); // 페이지당호출갯수
/* 1 : 인기순 , 2 : 최저가순 , 3 : 최고가순 , 4 : 신제품순 , 5 : 판매량순 , 6 : 상품평 많은 순 , 7 : 출시예정 */
String sort = ConfigManager.RequestStr(request, "sort", "1"); // 정렬기준
String factory = ConfigManager.RequestStr(request, "factory", ""); // 제조사
String factorycode = ConfigManager.RequestStr(request, "f", ""); // 제조사코드
String brand = ConfigManager.RequestStr(request, "brand", ""); // 브랜드
String shopcode = ConfigManager.RequestStr(request, "shopcode", ""); // 쇼핑몰코드
String inKeyword = ConfigManager.RequestStr(request, "in_keyword", ""); // 결과내 검색어
String sPrice = ConfigManager.RequestStr(request, "s_price", "0"); // 가격대 - 시작
String ePrice = ConfigManager.RequestStr(request, "e_price", "0"); // 가격대 - 끝
String spec = ConfigManager.RequestStr(request, "spec", ""); // 스펙번호
String specname = ConfigManager.RequestStr(request, "specname", ""); // 스펙명
//프린터 소모품류에 사용
String prtmodelno = ConfigManager.RequestStr(request, "prtmodelno", "");
String prtSrcKey = ConfigManager.RequestStr(request, "srckey", ""); //잉크,토너 finder 검색어
/* 0 : 전체보기 , 1 : 모델리스트 , 2 : 일반상품리스트 , 3 : 해외직구 , 4 : 소셜상품 , */
String tabType = "0";
String strTabTypeString = "";
if(prtmodelno.length()>0 ||  spec.length()>0 || brand.length()>0 || factory.length()>0) {
	// 가격비교 탭이 디폴트
	tabType = ConfigManager.RequestStr(request, "tabType", "1");
} else {
	tabType = ConfigManager.RequestStr(request, "tabType", "0");
}
switch(tabType) {
case "1" : strTabTypeString = " 가격비교"; break;
case "2" : strTabTypeString = " 쇼핑몰"; break;
case "3" : strTabTypeString = " 해외직구"; break;
case "4" : strTabTypeString = " 소셜커머스"; break;
}

//분류검색어에서 넘어온
String strFrom = ConfigManager.RequestStr(request, "from", "");
String strSKeyword = ConfigManager.RequestStr(request, "skeyword", "");
String strFromKeyword = ConfigManager.RequestStr(request, "keyword", "");

String strIsRental = ConfigManager.RequestStr(request, "rental", "N");
String strIsDelivery = ConfigManager.RequestStr(request, "delivery", "N");

String keyword_cnt = "";
String sf_factory_viewYN = "";
String sf_brand_viewYN = "";
String list_serch_flag = "";
String md_factory_flag = "";
String md_brand_flag = "";
String model_spec_add = ""; // "1" 이면 대괄호 속성 사용
String regiterday_flag = "";
String viewtype_flag = "";
String printerCateFlag = "N"; // 프린터 예외 카테고리 유무 ( 040207 카테 중 04020706 04020714 를 제외)
String hitBrandFlag = "N"; // 히트브랜드 노출 시 Y 변경

// 유효한 카테고리인지
Lp_Header_Proc lp_Header_Proc = new Lp_Header_Proc();
boolean useCategory = lp_Header_Proc.IsUseLPCategory(cate);
if(!useCategory) {
	response.sendRedirect("/");
	return;
}

strCate4 = cate;
if(cate.length()>4) strCate4 = cate.substring(0, 4);

// 전문관 (일반상품 탭이 디폴트)
/*
	1259 오늘의집
	1487 오케이몰
	1488 무신사스토어
*/
if(strCate4.equals("1487") || strCate4.equals("1488") || strCate4.equals("1259")) {
	tabType = "2";
	strTabTypeString = " 쇼핑몰";
}

//특정분류 진입시 pageGap 디폴트 변경
//shwoo 2021-04-09
if(StringUtils.contains("1434,1435,1437,1451,1452,1454,1455,1456,1457,1459,0860", strCate4)){
	pageGap = "60";
}

String strServerNm = request.getServerName();
boolean blDevFlag = false;
if (strServerNm.indexOf("dev.enuri.com") > -1) {
	blDevFlag = true;
}

// select * from tbl_cate_display;
// KEYWORD_CNT	분류 추천검색어 노출수
Goods_Search_Lsv_Proc goods_search_lsv_proc = new Goods_Search_Lsv_Proc();
int[] showCntList = goods_search_lsv_proc.getCategorySpecShowNum(strCate4);

// LP, SRP 특정 설정들(제조사나 브랜드 보여주기 여부 등
// tab_factory_flag, tab_brand_flag, list_serch_flag, md_factory_flag, md_brand_flag
Goods_Search_Lsv_Data optionInfo = goods_search_lsv_proc.getSearchOptionSet(strCate4);

keyword_cnt = String.valueOf(showCntList[2]);

JSONObject sfViewYNObj = new JSONObject();
sfViewYNObj =  lp_Header_Proc.getFactoryBrandViewYN(cate, blDevFlag);
sf_factory_viewYN = sfViewYNObj.get("factoryViewYN") != null ?  sfViewYNObj.get("factoryViewYN").toString() : "";
sf_brand_viewYN = sfViewYNObj.get("brandViewYN") != null ?  sfViewYNObj.get("brandViewYN").toString() : "";  

list_serch_flag = optionInfo.getList_serch_flag();
/* md_factory_flag = optionInfo.getMd_factory_flag();
md_brand_flag = optionInfo.getMd_brand_flag(); */
model_spec_add = optionInfo.getModel_spec_add();
regiterday_flag = optionInfo.getRegiterday_flag();
// 0:심플리스트형, 1:일반리스트형, 2:갤러리형 : 데이터베이스 저장 형태 , 일반리스트형 삭제
// LP의 사용 번호 : 1:심플리스트뷰, 2:갤러리뷰 
viewtype_flag = optionInfo.getViewtype_flag();
if(viewtype_flag.equals("0")) viewtype_flag = "1";

// 카테고리 정보
Map<String, String> getCategoryMetaData = lp_Header_Proc.getCategoryMeta(cate);

String strCateTitleAppend = "최저가 검색 - 에누리 가격비교";
String strCateTitle = "";
String strMetaDescription = "";
String strMetaKeyword = "";
String hCateName = "";

if(getCategoryMetaData.containsKey("depth_1")) {
	strMetaKeyword += getCategoryMetaData.get("depth_1") + ", ";
}
if(getCategoryMetaData.containsKey("depth_2")) {
	strMetaKeyword += getCategoryMetaData.get("depth_2") + ", ";
	hCateName = getCategoryMetaData.get("depth_2");
}
if(getCategoryMetaData.containsKey("depth_3")) {
	strMetaKeyword += getCategoryMetaData.get("depth_3") + ", ";
}
if(getCategoryMetaData.containsKey("depth_4")) {
	strMetaKeyword += getCategoryMetaData.get("depth_4") + ", ";
}
if(strMetaKeyword.length()>0) {
	strMetaKeyword += "인기상품, 가격비교, 상품추천, 최저가";
}

if(cate.length()==4 && getCategoryMetaData.containsKey("depth_2")) {
	strCateTitle = "'" + getCategoryMetaData.get("depth_2") + "'";
	strMetaDescription = "가격비교 사이트 - '"+getCategoryMetaData.get("depth_2")+"' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_2")+" 상품정보를 자세히 안내합니다.";
} else if(cate.length()==6) {
	if(getCategoryMetaData.containsKey("depth_3") && getCategoryMetaData.containsKey("depth_2")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_3") + " | " + getCategoryMetaData.get("depth_2") + "'";
		strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_3") + " " + getCategoryMetaData.get("depth_2") + "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_2")+" 상품정보를 자세히 안내합니다.";
	} else if(getCategoryMetaData.containsKey("depth_3")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_3") + "'";
		strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_3")+ "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_3")+" 상품정보를 자세히 안내합니다.";
	} else if(getCategoryMetaData.containsKey("depth_2")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_2") + "'";
		strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_2")+ "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_2")+" 상품정보를 자세히 안내합니다.";
	}
} else if(cate.length()==8) {
	if(getCategoryMetaData.containsKey("depth_4") && getCategoryMetaData.containsKey("depth_3")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_4") + " | " + getCategoryMetaData.get("depth_3") + "'";
		if(getCategoryMetaData.containsKey("depth_2")) {
			strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_4") + " " + getCategoryMetaData.get("depth_3") + "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_2")+" 상품정보를 자세히 안내합니다.";
		} else {
			strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_4") + " " + getCategoryMetaData.get("depth_3") + "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_3")+" 상품정보를 자세히 안내합니다.";
		}
	} else if(getCategoryMetaData.containsKey("depth_4")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_4") + "'";
		strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_4") + "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_4")+" 상품정보를 자세히 안내합니다.";
	} else if(getCategoryMetaData.containsKey("depth_3")) {
		strCateTitle = "'" + getCategoryMetaData.get("depth_3") + "'";
		strMetaDescription = "가격비교 사이트 - '" + getCategoryMetaData.get("depth_3") + "' "+strTabTypeString+" 최저가 검색. 다양한 "+getCategoryMetaData.get("depth_3")+" 상품정보를 자세히 안내합니다.";
	}
}

//1. 심플리스트 뷰 , 2. 갤러리 뷰  
String listGridType = ConfigManager.RequestStr(request, "listGridType", "1");
if (viewtype_flag.length() > 0) {
	listGridType = viewtype_flag;
}

//기본값 세팅(session사용)
//shwoo 20201-04-29
String ssPagegap = (String)session.getAttribute("pagegap");
String ssListgridtype = (String)session.getAttribute("listgridtype");
if(ssPagegap != null && !ssPagegap.equals("")){
	pageGap = ssPagegap;
}
if(ssListgridtype != null && !ssListgridtype.equals("")){
	listGridType = ssListgridtype;
}

//성인 인증 여부
boolean IsAdultFlag = false;
String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "ADULT"), "");
String USER_ID = cb.GetCookie("MEM_INFO", "USER_ID");
String USER_NICK = cb.GetCookie("MEM_INFO", "USER_NICK");
if (isAdult.equals("1")) {
	IsAdultFlag = true;
}

//카테고리명(전부) - 로거용
Category_Proc category_proc = new Category_Proc();
String strCate_name_all = category_proc.Category_Name_One(cate).replaceAll("/",",").replaceAll(">","/").replaceAll(" ","");

//속성 노출 개수
int intDefaultSpecCnt = 3;
intDefaultSpecCnt = lp_Header_Proc.getLPSpecViewCnt(cate, blDevFlag);

if (intDefaultSpecCnt < 0) {
	intDefaultSpecCnt = 3;
}

String mini_USER_ID= cb.GetCookie("MEM_INFO","USER_ID");
String mini_TMPUSER_ID= cb.GetCookie("MEM_INFO","TMP_ID");
String mini_USER_NICK= cb.GetCookie("MEM_INFO","USER_NICK");
String mini_SNSTYPE = cb.GetCookie("MEM_INFO","SNSTYPE");
 //VIEW ID 
String strViewID = "";
if(mini_SNSTYPE.equals("K") || mini_SNSTYPE.equals("N")){
	strViewID = mini_USER_NICK;
}else {
	if(!USER_NICK.equals("")){
		strViewID = mini_USER_NICK;
	}else{
		strViewID = mini_USER_ID;
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="x-ua-compatible" content="ie=edge"/>
	<meta name="viewport" content="width=1280"/>
	
	<title><%=(strCateTitle + strTabTypeString + " " + strCateTitleAppend)%></title>
	<link rel="shortcut icon" href="https://img.enuri.info/2014/layout/favicon_enuri.ico">
	<meta name="format-detection" content="telephone=no"/>
		
	<meta http-equiv="x-dns-prefetch-control" content="on" />
	<link rel="dns-prefetch" href="//enuri.com" />
	<link rel="dns-prefetch" href="//storage.enuri.info" />
	<link rel="dns-prefetch" href="//adimg.daumcdn.net" />
	<link rel="dns-prefetch" href="//img.enuri.com" />
	<link rel="dns-prefetch" href="//photo3.enuri.info" />
	<link rel="dns-prefetch" href="//ad-api.enuri.info" />
	<link rel="dns-prefetch" href="//ad-cdn.enuri.info" />
	<link rel="dns-prefetch" href="//image.enuri.info" />
	<link rel="dns-prefetch" href="//img.enuri.info" />
	<link rel="dns-prefetch" href="//contentsad-dp.enuri.com" />
	<link rel="dns-prefetch" href="//static.coupangcdn.com" />
	
	<meta name="description" content="<%=strMetaDescription%>">
	<meta name="keywords" content="<%=strMetaKeyword%>">
	<link rel="canonical" href="http://www.enuri.com/list.jsp?cate=<%=cate%>"/>
	<link rel="alternate" media="only screen and (max width: 640px)" href="http://m.enuri.com/m/list.jsp?cate=<%=cate%>">
	
	<meta property="og:title" content="<%=(strCateTitle + strTabTypeString + " " + strCateTitleAppend)%>">
	<meta property="og:description" content="가격비교 사이트 - <%=(strCateTitle + strTabTypeString)%> 가격비교 최저가 검색">
	<meta property="og:image" content="<%=ConfigManager.IMG_ENURI_COM%>/images/sns_basic_last2.png">
	
	<!-- Stylesheet -->
	<link rel="stylesheet" type="text/css" href="/css/swiper.css"/>
	<link rel="stylesheet" type="text/css" href="/css/rev/common.css?v=20210929"/>
	<!-- reset -->
	<link rel="stylesheet" type="text/css" href="/css/rev/template.css?v=20220718"/>
	<!-- template -->
	<link rel="stylesheet" type="text/css" href="/css/rev/lp.css?v=20220615"/>
	<!-- LP/SRP only -->
	<!-- Lib/Plugin -->
	<script type="text/javascript" src="/wide/util/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="/js/swiper.min.js"></script>
	<!-- Top Script -->
	<script type="text/javascript" src="/wide/script_min/common/util.min.js?v=20210909"></script>
	
	<!-- Page 변수 선언 -->
	<script>
	// 리스트 변수
	var listType = "list";
	// 속성노출갯수
	var attrViewCnt = 6;
	// 속성더보기 노출 여부
	var attrMoreView = false;
	var viewType = "<%=listGridType%>";
	var param_cate = "<%=cate%>";
	var param_pageNum = "<%=pageNum%>";
	var param_pageGap = "<%=pageGap%>";
	var param_sort = "<%=sort%>";
	var param_factory = "<%=factory%>";
	var param_factorycode = "<%=factorycode%>";
	var param_brand = "<%=brand%>";
	var param_brandcode = "";
	var param_shopcode = "<%=shopcode%>";
	var param_keyword = "";
	var param_inKeyword = "<%=inKeyword%>";
	var param_sPrice = "<%=sPrice%>";
	var param_ePrice = "<%=ePrice%>";
	var param_spec = "<%=spec%>"; // 직링크 용으로만 사용
	var param_specname = "<%=specname%>";
	var param_color = "";
	var param_prtmodelno = "<%=prtmodelno%>";
	var param_prtSrcKey = "<%=prtSrcKey%>";
	var param_tabType = "<%=tabType%>";
	var param_isDelivery = "<%=strIsDelivery%>";
	var param_isRental = "<%=strIsRental%>";
	var param_isResearch = "Y";
	var param_color = "";
	var param_discount = "";
	var param_bbsscore = "";
	var blDeepLink = false;
	
	// 분류검색어 처리
	var Synonym_From = "<%=strFrom%>";
	var Synonym_Keyword = "<%=strSKeyword%>";
	var Synonym_From_Keyword = "<%=strFromKeyword%>";
	if(Synonym_From=="search" && Synonym_From_Keyword.length>0) {
		param_inKeyword = Synonym_From_Keyword;
	}
	
	// 스펙, 제조사, 브랜드, 결과내검색어 딥링크 처리
	if(param_spec.length>0 || param_factory.length>0 || param_factorycode.length>0 || param_brand.length>0 || param_inKeyword.length>0) {
		blDeepLink = true;
	}
	
	// 중고렌탈 유저 클릭 여부
	var blIsRentalUserClick = false;
	
	var from = "<%=strFrom%>"; // 분류검색어
	var modelNoSet = new Set();
	var plNoSet = new Set();
	var zzimTmpModelNoSet = new Set(); // 정보 수신 후 찜 등록/해제 시 임시 보관 
	var zzimTmpPlNoSet = new Set();
	var zzimTmpModelNoRemoveSet = new Set(); // 정보 수신 후 찜 등록/해제 시 임시 보관 
	var zzimTmpPlNoRemoveSet = new Set();
	var zzimLayerSet = new Set(); // 레이어 내 찜 표기에 사용됨
	
	var modelNoSet = new Set();
	
	var modelNoGroupMap = new CustomMap();
	
	var lpSetupInfo = [];
	
	lpSetupInfo.keyword_cnt = "<%=keyword_cnt%>";
	lpSetupInfo.sf_factory_viewYN = "<%=sf_factory_viewYN%>"; 
	lpSetupInfo.sf_brand_viewYN = "<%=sf_brand_viewYN%>";
	
	lpSetupInfo.list_serch_flag = "<%=list_serch_flag%>";
	lpSetupInfo.md_factory_flag = "<%=md_factory_flag%>";
	lpSetupInfo.md_brand_flag = "<%=md_brand_flag%>";
	lpSetupInfo.model_spec_add = "<%=model_spec_add%>";
	lpSetupInfo.regiterday_flag = "<%=regiterday_flag%>";
	lpSetupInfo.viewtype_flag = "<%=viewtype_flag%>";
	
	// lp 카테고리 정보
	var lpCateTitle = "<%=strCateTitle%>";
	var lpCateTab = "<%=strTabTypeString%>";
	
	// 제조사,브랜드 속성 데이터 목록 ( 가나다 순 정렬 위해 저장 )
	var factoryAttrList = [];
	var brandAttrList = [];
	
	// 속성 선택갯수
	var attrSelCnt = 0;
	
	// 최초 실행여부 (페이지 최초 호출시에만 작동하는 이벤트 처리 판단자)
	var firstLoadFlag = true;
	var firstLoadAttrFlag = true;
	
	// 기본이미지
	var noImageStr = "http://img.enuri.info/images/home/thum_none.jpg";
	// 성인이미지
	var adultImgStr = "http://img.enuri.info/images/rev/thumb_adult216.png";
	// 성인인증 여부 ( "true", "false" )
	var isAdultFlag = "<%=IsAdultFlag%>";
	
	// 데이터 임시 저장(뷰타입 변경 시 추가 호출 방지)
	var tmpDataObj = null;
	
	// 명품 여부
	var brandReqMap = new CustomMap();
	
	// 미니VIP 스크립트 호출 여부
	var blLoadMiniVip = false;
	
	// 프린터 파인더 로 검색 시 "인기순" 정렬 고정
	if(param_prtSrcKey.length>0) {
		param_sort = 1;
		viewType = 1;
	}
	
	// 출시예정 버튼 선택여부
	var blNewListBtnCheck = false;
	// 출시예정 유무
	var blNewListBtnIsset = false;
	
	// 속성 특수문자 제거문자열
	var regSpecExp = function (selectId) {
		var replaceInstName = selectId.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi, "regSpecExp");
		replaceInstName = replaceInstName.replace(" ", "regSpecExp");
		return replaceInstName;
	}
	
	// 속성 선택자 Set
	var specSet = new Set();
	
	// 브랜드,제조사 상세검색 원본 html
	var initFactoryHtml = "";
	var initBrandHtml = "";
	// 제조사 이름-코드 매핑 Map
	var factoryNameToCodeMap = new CustomMap();
	
	// srp 추천브랜드 Set
	var srpReqSet = new Set();
	
	// 광고 등에서 사용될 카테고리 정보
	// LP 는 파라미터
	// SRP 는 첫번째 상품의 카테고리
	var firstGoodsCate = param_cate; // 1등상품의 카테고리 ( srp 광고 전달용 )
	
	// 파워클릭 구분자
	var blADPowerClick = false;
	
	// 애드쇼핑 구분자
	var blADShopping = false;

	// 애드오피스 구분자
	var blADOffice = false;
	
	// 개발/운영 구분
	var blDevMode = false;
	if(window.location.host.indexOf("dev")>-1 || window.location.host.indexOf("localhost")>-1) {
		blDevMode = true;
	}
	
	// 기본 속성 노출 갯수
	var defaultSpecCnt = <%=intDefaultSpecCnt %>;
	
	// 속성 미노출을 위한 최근 선택된 스펙인자
	// brand_{브랜드코드}
	// spec_{스펙번호}
	var recentSpec = "";
	// spec 의 그룹단위 선택여부 인자
	var specGroupSet = new Set();
	
	//미니vip ID
	var mini_sUserId = "<%=strViewID%>";
	var mini_SNSTYPE = "<%=mini_SNSTYPE%>";
	
	// 로거 카테고리별 pv 확인용
	var _TRK_CP = "<%=strCate_name_all %>";
	
	function fn_layer_position() {}
	function insertLog() {}
//	function _EXEN() {}
//	function _trk_img_base() {}
//	function _trk_code_base() {}
	</script>
	
	<script type="text/javascript" src="/wide/script_min/common/nav.min.js?v=20220712"></script>
	<script type="text/javascript" src="/wide/script_min/ad/list_banner.min.js?v=20220307"></script>
	<script type="text/javascript" src="/wide/script_min/list/list_func.min.js?v=220220719"></script>
	<script type="text/javascript" src="/wide/script_min/list/list_event.min.js?v=20220712" defer="defer"></script>
	<script type="text/javascript" src="/common/js/common_top_2022.js?v=20220712" defer="defer"></script>
	<script type="text/javascript" src="/common/js/getTopBanner_2021.js" defer="defer"></script>
	<script type="text/javascript" src="/common/js/eb/gnbTopRightBanner_2021.js" defer="defer"></script>
	<script type="text/javascript" src="/common/js/function.js"></script>
	<script type="text/javascript" src="/wide/script_min/common/common_layer.min.js?v=20220421" defer="defer"></script>
	
	<!-- Global site tag (gtag.js) - Google Ads: 966646648 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=AW-966646648"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'AW-966646648');
	</script>
</head>