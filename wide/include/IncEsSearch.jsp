<%@ page import="com.enuri.bean.wide.LP_Notincate_Json"%>
<%@ page import="com.enuri.bean.main.SimilarGoods_Proc"%>
<jsp:useBean id="LP_Notincate_Json" class="com.enuri.bean.wide.LP_Notincate_Json" scope="page" />
<%!
String strAdModelsSearch = "";
String strSpecName = "";
String strColor = "";
String strEtcCate = "";
String strParamBrandCode = "";
String strParamFactoryCode = "";
String strIsMakeShop = "N";
String strDiscount = ""; // 할인율 조건 예)50~70,20~50
String strBbsScore = "";
%>
<%
String strGoodsCollectionName = "enuri-goods";
String strOrgKeyword = ""; //해당 값을 list api 에서 제외검색용으로 사용해야하므로 전역 처리
String strKeywordDetails = ""; // 키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)

String serverName = request.getServerName() == null ? "" : request.getServerName();
String referer = request.getHeader("Referer") == null ? "" : request.getHeader("Referer");

boolean blp = strFrom.equals("list"); // LP 여부
boolean bDebug = (serverName.equals("localhost") ||serverName.equals("127.0.0.1") || serverName.indexOf("dev") > -1) && strIsTest.equals("Y"); // 디버그 여부
boolean bModelNo = strCate.equals("00000000"); // 모델번호 검색 여부
boolean bLog = (referer.startsWith("http://www.enuri.com/search.jsp") || referer.startsWith("http://www.enuri.com/list.jsp")) && !bDebug && !bModelNo; // 검색 로깅 여부
int nVersion = 2;

int nOptionFlag = OPT_FLAG;

//CSearchClient csearch = com.enuri.bean.search.CSearchClientBuilder.build(1, blp, bDebug);
CSearchClient csearch = com.enuri.bean.search.CSearchClientBuilder.buildProxy(nVersion, blp, bDebug);

csearch.setIntPortSet(intPortSet);
if (intTab == 3) { // 해외직구 별도 컬렉션 사용
	csearch.setEsGroupName(strEnuriOvsGroupName);
	csearch.setStrCollectionName(strEnuriOvsCollectionName);
	csearch.setBLog(false);
	csearch.setEsClientCode(3);
} else {
	csearch.setEsGroupName(strGroupName);
	csearch.setStrCollectionName(strCollectionName);
	csearch.setBLog(bLog);	
	csearch.setEsClientCode(!blp ? 1 : 2);
}
csearch.setStrHostSet(strHostSet); //검색엔진 주소
csearch.setStrUserIp(getUserAddr(request)); //사용자 주소
csearch.setStrUserAgent(getUserAgent(request)); // 사용자 Agent
csearch.addParameter("strUserId", getUserID(request)); // 사용자 ID
csearch.addParameter("strUserDevice", strDevice); // 사용자 디바이스종류

csearch.setRequestUrl(ChkNull.chkStr(request.getRequestURI()));
csearch.setUriQuerystring(ChkNull.chkStr(getQueryString(request)));
csearch.setIsMakeshop(strIsMakeShop);

csearch.setStrEtype("");
csearch.setStrPrintModelno(strPrtModelNo); // 프린트 모델번호
csearch.setBModelNo(bModelNo); // 모델번호 검색 여부

if(!bModelNo) {
	csearch.setStrRealCate(strCate); // 원카테
	csearch.setStrCate(Searchfunction.getCopyCate(strCate)); // 추가카테 ( 없으면 원카테 )	
}

if (!bModelNo && blp && (strPrtModelNo.equals("") || strPrtModelNo.length() == 0)) { // LP
	// LP 제외카테
	LP_Notincate_Json notinCateJson = new LP_Notincate_Json();
	Map<String, String> notinCateMap = notinCateJson.parseJson();
	String strNotCateEs = "";
	String strNotInCateSearchKey = strCate;
	
	if (notinCateMap.containsKey(strNotInCateSearchKey)) {
		strNotCateEs = (String) notinCateMap.get(strNotInCateSearchKey);
	}
	if (strNotCateEs.length() > 0)
		csearch.setStrNotCate(strNotCateEs);
}

if (strKeyword.length() > 0 || strInKeyword.length() > 0) { // 검색어
	if(bModelNo) {
		String strSearchKeyword = strKeyword.trim();
		if(strSearchKeyword.length() == 0)
			strSearchKeyword = strInKeyword.trim();
		
		csearch.setStrFirstKeyword(strSearchKeyword); //처음 검색어 (결과내검색 제외)
		csearch.setStrOrgKeyword(strSearchKeyword); // 검색어 + 결과내검색
		csearch.setStrKeyword(strSearchKeyword); // 검색어 + 결과내검색 + 동의어
	} else {
		strOrgKeyword = (strKeyword + " " + strInKeyword).trim();
		String strSearchKeyword = Searchfunction.removeExceptionKeyword(strOrgKeyword);
		strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
		
		csearch.setStrFirstKeyword(strKeyword.trim()); //처음 검색어 (결과내검색 제외)
		csearch.setStrOrgKeyword(strOrgKeyword); // 검색어 + 결과내검색
		csearch.setStrKeyword(strSearchKeyword.trim()); // 검색어 + 결과내검색 + 동의어
	}
}

csearch.setBNoSale(true); //판매중단,출시예정상품 검색 여부(ture :제외 , false: 포함)
csearch.setBOpenExpect(true); //판매중단은 제외더라도 출시예정은 검색

// 중고/렌탈 제외 유무 체크 시
if (strIsRental.equals("Y")) {
	csearch.setbRentalRemove(true);
}
//제조사
if ((intTab == 0 || intTab == 1 || intTab == 3) && (strParamFactoryCode.length() > 0 || strParamFactory.length() > 0)) {
	if(strParamFactoryCode.length() > 0) {
		nOptionFlag = nOptionFlag | OPT_FLAG_FACTORY_ID;
		csearch.setStrFactory(strParamFactoryCode);
	} else {
		nOptionFlag = nOptionFlag & ~OPT_FLAG_FACTORY_ID;
		csearch.setStrFactory(strParamFactory);
	}
}
/*
//브랜드
if ((intTab == 0 || intTab == 1 || intTab == 3) && (strParamBrandCode.length() > 0 || strParamBrand.length() > 0)) {
	if(strParamBrandCode.length() > 0) {
		nOptionFlag = nOptionFlag | OPT_FLAG_BRAND_ID;
		csearch.setStrBrand(strParamBrandCode);
	} else {
		nOptionFlag = nOptionFlag & ~OPT_FLAG_BRAND_ID;
		csearch.setStrBrand(strParamBrand);
	}
}
*/
//브랜드
if ((intTab == 0 || intTab == 1 || intTab == 3) && strParamBrand.length() > 0) {
	nOptionFlag = nOptionFlag & ~OPT_FLAG_BRAND_ID;
	csearch.setStrBrand(strParamBrand);
}
// 쇼핑몰코드
if (intTab == 2 && strParamShopCode.length() > 0) {
	csearch.setStrShop(strParamShopCode);
}
// 속성 ( spec )
if ((intTab == 0 || intTab == 1 || intTab == 3) && strSpec.length() > 0) {
	csearch.setStrSpec(strSpec);
}
// 색상 ( specColor ) ###
if((intTab == 0 || intTab == 1 || intTab == 3) && strColor.length()>0) {
	csearch.setStrSpecColor(strColor);
}
// 가격대
if (lngSPrice > 0 || lngEPrice > 0) {
	csearch.setStrMPrice(lngSPrice + "~" + lngEPrice); //가격조건("10000~20000")
}

String tabSearchKindType = "";
if (intTab == 1)
	tabSearchKindType = "1";
if (intTab == 2)
	tabSearchKindType = "2";

//if (strSort != null && (strSort.indexOf("sale_cnt") > -1 || strSort.indexOf("c_date") > -1))
//	tabSearchKindType = "1";
csearch.setStrSearchKind(tabSearchKindType); //1:가격비교 2:추가검색 "" 이면 전체

/* 2021.06.21 사용안함
// 서비스구분 플래그 srvflag
if (blp) { // lp 
	csearch.setStrSrvflag("0,L,R,M,C");
} else if (strFrom.equals("search")) { // srp
	csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");
}
// 재검색여부
if (strIsReSearch.equals("Y") && blp && strInKeyword.trim().length() > 0) {
	csearch.setResearchType(RESEARCH_EXCLUDE_ENABLED);
}

if (strIsReSearch.equals("Y")) {
	if (strKeyword.trim().length() > 0 || strInKeyword.trim().length() > 0) {
		csearch.setIsReSearch("Y");
	} else {
		csearch.setIsReSearch("N");
	}
} else {
	csearch.setIsReSearch("N");
} 
*/
//2021.06.21 srvflag SRP, LP 모두 통일
csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");
//2021.06.21 결과내 검색 재검색 해제
if(!bModelNo && strIsReSearch.equals("Y")) {
	if(strInKeyword.trim().length()>0) { // 결과내 검색 존재 시
		csearch.setIsReSearch("N");
	} else if(strKeyword.trim().length() > 0) {
		csearch.setIsReSearch("Y");
	}
} else {
	csearch.setIsReSearch("N");
}

csearch.setStrKey(strSort);
csearch.setCPage(pageNum);
csearch.setNPageSize(pageGap);
csearch.setListShowFlag(true);

// LP 유사상품 
if (blp) {
	SimilarGoods_Proc sgp = new SimilarGoods_Proc();
	HashMap<String, String> simGoodsCaCode = null;
	simGoodsCaCode = sgp.getSimilarGoodsCaCode();

	if (null != simGoodsCaCode && simGoodsCaCode.containsKey(strCate4.trim())) {
		csearch.setLikenessShow(true);
	}
}

// 출시예정 만 다른 조건으로 조회
if (intSort == 7) {
	csearch.setStrSearchArea("10");
} else {
	csearch.setStrSearchArea("111");
}

// 프린터모델
if (strPrtModelNo.length() > 0) {
	csearch.setBSuModelNo(true);
	csearch.setStrPrintModelno(strPrtModelNo);
}

//# LP/SRP 개편 2021.07.12 신규 추가 - 시작 ###
// 일반상품 조회 시 strKeywordDetails 세팅
if(intTab==2) {
	List<String> KeywordDetailArray = new ArrayList<String>();
	if(strSpecName.length()>0) { // 스펙명
		KeywordDetailArray.add(strSpecName);
	}
	if(strParamBrand.length()>0) { // 브랜드명
		KeywordDetailArray.add(strParamBrand);
	}
	if(strParamFactory.length()>0) { // 제조사명
		KeywordDetailArray.add(strParamFactory);
	}
	if(KeywordDetailArray.size()>0) {
		strKeywordDetails = String.join("_", KeywordDetailArray);
	}
} 
// 키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)	
if (strKeywordDetails.length() > 0) {
	csearch.addParameter("strKeywordDetails", strKeywordDetails);
}
// 그룹모델 수동추가 ###
if (strEtcCate.length() > 0) {
	nOptionFlag = nOptionFlag | OPT_FLAG_LIST_ETC_CATE;
	csearch.addParameter("strEtcCate", strEtcCate);	
}
// 할인율
if (strDiscount.length() > 0) {
	csearch.addParameter("strDiscountRate", strDiscount);
}
//평점
if (strBbsScore.length() > 0) {
	csearch.addParameter("strBbsPoint", strBbsScore);	
}
// 하위모델별 정렬 flag
if(intSort == 2) {
	csearch.addParameter("nInnerHitSortFlag", String.valueOf(INNER_HIT_SORT_MINPRICE_ASC));
} else if(intSort == 3) {
	csearch.addParameter("nInnerHitSortFlag", String.valueOf(INNER_HIT_SORT_MINPRICE_DESC));
} else {
	csearch.addParameter("nInnerHitSortFlag", String.valueOf(INNER_HIT_SORT_PC));
}
// 옵션 flag
csearch.addParameter("nOptionFlag", String.valueOf(nOptionFlag));
//# LP/SRP 개편 2021.07.12 신규 추가 - 끝

// 메인 LP/SRP 검색
CSearchResult cSearchResult = csearch.CSearchRun();
String strQueryOut = csearch.getStrQuery();
//광고모델 조회
CSearchResult adSearchResult = null;
if (strAdModelsSearch.length() > 0)  {
	csearch.setStrCollectionName(strGoodsCollectionName);
	adSearchResult = csearch.CSearchGet(strAdModelsSearch.split(","));
}
	

String strModelNo_Group = cSearchResult.getStrModelNos();//모델번호들
String strPlNos = cSearchResult.getStrPlNos();//PL_NO들
int intTotRsCnt = cSearchResult.getIntTotRsCnt(); // 전체 검색 결과
int intRsCnt = cSearchResult.getIntRsCnt();
int intEnuriCnt = cSearchResult.getIntEnuriCnt() + cSearchResult.getIntMakeshopCnt(); // 가격비교 + 메이크샵 상품
int intWebCnt = cSearchResult.getIntWebCnt();
int intFuzzy = cSearchResult.getIntFuzzy();
String searchedKeyword = cSearchResult.getSearchedKeyword();
String strMcates = cSearchResult.getStrMcates();
String strMpnos = cSearchResult.getStrMpnos();
JsonMap<String, JsonMap<String, Object>> hitsSourceMap = cSearchResult.getSource();
JsonMap<String, JsonMap<String, Object>> adHitsSourceMap = adSearchResult != null ? adSearchResult.getSource() : null;

/*
System.out.println("Query = " + csearch.getStrQuery() );
System.out.println("strCategory = "+strCate);
System.out.println("intTotRsCnt = "+intTotRsCnt);
System.out.println("intRsCnt = "+intRsCnt);
System.out.println("intEnuriCnt = "+intEnuriCnt);
System.out.println("intWebCnt = "+intWebCnt);
System.out.println("adHitsSourceMap = "+ adHitsSourceMap);
*/

%>
<%--
# JsonMap<String, JsonMap<String, Object>> hitsSourceMap
# JsonMap<String, JsonMap<String, Object>> adHitsSourceMap
--------------------------------------------------
id = (java.lang.String) G666276
mcate = (java.lang.String) 1513
modelno = (java.lang.String) 666276
modelno_group_flag = (java.lang.String) 1
r_modelno = (java.lang.String) 666276
dc_rt = (java.lang.String) 12
opn_prc = (java.lang.String) 69800
sub_models = (java.util.ArrayList)
[
        [0] = (java.util.HashMap)
        {
                condiname = (java.lang.String) 108개
                modelno = (java.lang.String) 70043987
                model_sort = (java.lang.String) 108
                popular = (java.lang.String) 2
                minprice3 = (java.lang.String) 70760
                dc_rt = (java.lang.String) 32
        }
]
--------------------------------------------------
--%>

