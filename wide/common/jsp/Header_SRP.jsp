<%@page import="com.enuri.bean.wide.RedirectRool"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/include/Inc_Mobile_Redirect.jsp" %>
<%@ page import="java.awt.List" %>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.main.Search_Category_Proc"%>
<jsp:useBean id="Goods_Search_Lsv_Proc" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page"/>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@ include file="/login/Inc_AutoLoginSet_2010.jsp" %>
<% 
//도메인 치환
RedirectRool rl = new RedirectRool();
Boolean blRedirect = rl.blRedirectDomain(request, response);
if(blRedirect) {
	return;
}

// 리스트 변수 필터
String cate = ConfigManager.RequestStr(request, "cate", ""); // 카테고리
String pageNum = ConfigManager.RequestStr(request, "page", "1"); // 페이지번호
String pageGap = ConfigManager.RequestStr(request, "pageGap", "30"); // 페이지당호출갯수
/* 1 : 인기순 , 2 : 최저가순 , 3 : 최고가순 , 4 : 신제품순 , 5 : 판매량순 , 6 : 상품평 많은 순 , 7 : 출시예정 */
String sort = ConfigManager.RequestStr(request, "sort", "1"); // 정렬기준
String factory = ConfigManager.RequestStr(request, "factory", ""); // 제조사
String factorycode = ConfigManager.RequestStr(request, "f", ""); // 제조사코드
String brand = ConfigManager.RequestStr(request, "brand", ""); // 브랜드
String shopcode = ConfigManager.RequestStr(request, "shopcode", ""); // 쇼핑몰코드
String keyword = ConfigManager.RequestStr(request, "keyword", ""); // 검색어
String inKeyword = ConfigManager.RequestStr(request, "in_keyword", ""); // 결과내 검색어
String sPrice = ConfigManager.RequestStr(request, "s_price", "0"); // 가격대 - 시작
String ePrice = ConfigManager.RequestStr(request, "e_price", "0"); // 가격대 - 끝
String spec = ConfigManager.RequestStr(request, "spec", ""); // 스펙번호
String specname = ConfigManager.RequestStr(request, "specname", ""); // 스펙명
/* 0 : 전체보기 , 1 : 모델리스트 , 2 : 일반상품리스트 , 3 : 해외직구 , 4 : 소셜상품 , */
String tabType = ConfigManager.RequestStr(request, "tabType", "0");
// 1. 심플리스트 뷰 , 2. 갤러리 뷰  
String listGridType = ConfigManager.RequestStr(request, "listGridType", "1");

String strIsRental = ConfigManager.RequestStr(request, "rental", "N");
String strIsDelivery = ConfigManager.RequestStr(request, "delivery", "N");

// 개편전버전 임시
String strKeyword = keyword;

//성인 인증 여부
boolean IsAdultFlag = false;
String isAdult = ChkNull.chkStr(cb.GetCookie("MEM_INFO", "ADULT"), "");
String USER_ID= cb.GetCookie("MEM_INFO","USER_ID");
String USER_NICK= cb.GetCookie("MEM_INFO","USER_NICK");
if(isAdult.equals("1")) {
	IsAdultFlag = true;
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

String strFrom = ChkNull.chkStr(request.getParameter("from"),""); //분류검색어에서 넘어온
String strDevice = "PC";
if(!strFrom.equals("list")) {
%>
<%@ include file="/search/ajax/mpKeywordSearch_web.jsp"%>
<%
	}
%>
<%@ include file="/lsv2016/include/IncSearch.jsp"%>
<%
// 연관검색어
int intCsearchcnt = 0; 	//10개면 멈춤
Search_Category_Proc search_category_proc = new Search_Category_Proc();
String strLinkageWords[] = search_category_proc.getLinkageWordList(keyword);
String strLinkageKeyword = "";

//out.println("strLinkageWords.legnth="+strLinkageWords.length);

if(strLinkageWords!=null && strLinkageWords.length>0) {
	int intCnt = 0;
	for(int sci=0; sci<strLinkageWords.length; sci++) {
		if(!keyword.equals(strLinkageWords[sci])) {
			if(intCnt>0) {
				strLinkageKeyword += ", ";
			}
			strLinkageKeyword += strLinkageWords[sci];
			intCnt++;

			intCsearchcnt++;
			if(intCsearchcnt > 8) break;
		}
	}
}

try {
	CSearch csearch = new CSearch();
	csearch.setIntPortSet(intEtcPortSet); //port
	csearch.setStrCollectionName(strAutoMakerCollectionName); //컬렉션명
	csearch.setStrHostSet(etcHostSet); //검색엔진 주소
	csearch.setStrUserIp(request.getRemoteAddr());
	csearch.setStrKeyword(keyword);
	csearch.setNPageSize(10);
	String strAutoMakerTemp = csearch.CSearchRunSmartMaker(); //실제 검색
	String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");

	String strAutoMakerTemp2 = "";
	int intAutoMakeWCnt = 0;
	for(int i=0; i<astrAutoMakerTemp.length; i++) {
		if(CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")) {
			boolean bWCheck = false;
			for(int j=0; j<i; j++) {
				if(CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")) {
					if(astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])) {
						bWCheck = true;
					}
				}
			}
			boolean bAdultKeyword = false;
			String strAdultKeyword = "성인용품,자위,콘돔,딜도";
			String[] strArrayAdultKeyword = strAdultKeyword.split(",");
			for(int ai=0; ai<strArrayAdultKeyword.length; ai++) {
				if(astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai])>=0) {
					bAdultKeyword = true;
					break;
				}
			}
			if(!bWCheck && !bAdultKeyword && astrAutoMakerTemp[i].trim().length()<=10 && intAutoMakeWCnt<10 && !keyword.toUpperCase().equals(ReplaceStr.replace(astrAutoMakerTemp[i].toUpperCase(),"W:",""))) {
				if(strLinkageKeyword.trim().length()>0) {
					strLinkageKeyword += ",";
				}
				strLinkageKeyword += ReplaceStr.replace(astrAutoMakerTemp[i],"W:","");
				intAutoMakeWCnt++;

				intCsearchcnt++;
				if(intCsearchcnt > 8) break;
			}
		}
	}
} catch(Exception e) {
} finally {
}

String strLinkageWords2[] = search_category_proc.getLinkageWordListByEnuriKeyword(keyword);
String strMetaKeyword = keyword;
if(strLinkageWords2!=null && strLinkageWords2.length>0) {
	int intCnt2 = 0;
	for(int sci2=0; sci2<strLinkageWords2.length; sci2++) {
		if(!keyword.equals(strLinkageWords2[sci2]) && strLinkageWords2[sci2].trim().length()<=8) {
			strLinkageKeyword += ", " + strLinkageWords2[sci2];
			intCnt2++;

			intCsearchcnt++;
			if(intCsearchcnt > 9) break;
		}
	}
	if(strLinkageKeyword.length()>0) {
		strMetaKeyword += ", "+ strLinkageKeyword;
	}
}
strMetaKeyword += ", 인기상품, 가격비교, 상품추천, 최저가";

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
	<title>'<%=keyword%>' 추천 최저가 검색 – 에누리 가격비교</title>
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
	
	<meta name="description" content="'<%=keyword%>' 가격비교 사이트. 인기 상품을 최저가로 만나보세요.">
	<meta name="keywords" content="<%=strMetaKeyword%>, 인기상품, 가격비교, 상품추천, 최저가">
	
	<link rel="alternate" media="only screen and (max width: 640px)" href="http://m.enuri.com/m/search.jsp?keyword=<%=keyword %>">
	<link rel="canonical" href="http://www.enuri.com/search.jsp?keyword=<%=keyword %>" />
	
	<meta property="og:title" content="<%=keyword%> 추천 최저가 검색 – 에누리 가격비교">
	<meta property="og:description" content="<%=keyword%> 가격비교 사이트. 인기 상품을 최저가로 만나보세요.">
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
	<!-- // Top Script -->
	
	<!-- Page 변수 선언 -->
	<script>
	// 리스트 변수
	var listType = "search";
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
	var param_keyword = "<%=keyword%>";
	var param_inKeyword = "<%=inKeyword%>";
	var param_sPrice = "<%=sPrice%>";
	var param_ePrice = "<%=ePrice%>";
	var param_spec = "<%=spec%>"; // 직링크용으로만 사용
	var param_specname = "<%=specname%>";
	var param_prtmodelno = "";
	var param_prtSrcKey = "";
	var param_tabType = "<%=tabType%>";
	var param_isDelivery = "<%=strIsDelivery%>";
	var param_isRental = "<%=strIsRental%>";
	var param_isResearch = "Y";
	var param_color = "";
	var param_discount = "";
	var param_bbsscore = "";
	var blDeepLink = false;

	var Synonym_From = "";
	var Synonym_Keyword = "";
	var Synonym_From_Keyword = "";
	
	// 스펙, 제조사, 브랜드, 결과내검색어 딥링크 처리
	if(param_spec.length>0 || param_factory.length>0 || param_factorycode.length>0 || param_brand.length>0 || param_inKeyword.length>0) {
		blDeepLink = true;
	}
	
	// 중고렌탈 유저 클릭 여부
	var blIsRentalUserClick = false;
	
	var modelNoSet = new Set();
	var plNoSet = new Set();
	var zzimTmpModelNoSet = new Set(); // 정보 수신 후 찜 등록/해제 시 임시 보관 
	var zzimTmpPlNoSet = new Set();
	var zzimTmpModelNoRemoveSet = new Set(); // 정보 수신 후 찜 등록/해제 시 임시 보관 
	var zzimTmpPlNoRemoveSet = new Set();
	var zzimLayerSet = new Set(); // 레이어 내 찜 표기에 사용됨
	
	var modelNoGroupMap = new CustomMap();
	
	var lpSetupInfo = [];
	
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
	var firstGoodsCate = ""; // 1등상품의 카테고리 ( srp 광고 전달용 )
	
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
	var defaultSpecCnt = 3;
	
	// 속성 미노출을 위한 최근 선택된 스펙인자
	// brand_{브랜드코드}
	// spec_{스펙번호}
	var recentSpec = "";
	// spec 의 그룹단위 선택여부 인자
	var specGroupSet = new Set();
	
	//미니vip ID
	var mini_sUserId = "<%=strViewID%>";
	var mini_SNSTYPE = "<%=mini_SNSTYPE%>";
	
	function fn_layer_position() {}
	function insertLog() {}
//	function _EXEN() {}
//	function _trk_img_base() {}
//	function _trk_code_base() {}
	</script>
	
	<script type="text/javascript" src="/wide/script_min/list/list_func.min.js?v=20220719"></script>
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