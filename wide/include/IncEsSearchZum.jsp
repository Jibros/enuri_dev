<%@ page import="com.enuri.bean.wide.LP_Notincate_Json"%>
<%@ page import="com.enuri.bean.main.SimilarGoods_Proc"%>
<%@ page import="com.enuri.bean.main.Category_Middle_Comparator"%>
<jsp:useBean id="LP_Notincate_Json" class="com.enuri.bean.wide.LP_Notincate_Json" scope="page"/>

<%
String serverName = request.getServerName() == null ? "" : request.getServerName();
int nOptionFlag = OPT_FLAG_GROUP_BRAND | OPT_FLAG_PRICE_GROUP3;

boolean blp = strFrom.equals("list"); // LP 여부
boolean bDebug = (serverName.equals("localhost") ||serverName.equals("127.0.0.1") || serverName.indexOf("dev") > -1) && strIsTest.equals("Y"); // 디버그 여부

CSearchClient csearch = com.enuri.bean.search.CSearchClientBuilder.buildProxy(1, blp, bDebug);

csearch.setIntPortSet(intPortSet);
if (intTab == 3) { // 해외직구 별도 컬렉션 사용
	csearch.setEsGroupName(strEnuriOvsGroupName);
	csearch.setStrCollectionName(strEnuriOvsCollectionName);
	csearch.setBLog(false);
} else {
	csearch.setEsGroupName(strGroupName);
	csearch.setStrCollectionName(strCollectionName);
}
csearch.setStrUserIp(getUserAddr(request)); //사용자 주소
csearch.setStrUserAgent(getUserAgent(request)); // 사용자 Agent
csearch.setRequestUrl(request.getRequestURI());
csearch.setUriQuerystring(request.getQueryString());
csearch.setEsClientCode(4);

// 해당 값을 list api 에서 제외검색용으로 사용해야하므로 전역 처리
String strOrgKeyword = "";

csearch.setStrEtype("");
csearch.setStrRealCate(strCate); // 원카테
csearch.setStrCate(Searchfunction.getCopyCate(strCate)); // 추가카테 ( 없으면 원카테 )
csearch.setStrPrintModelno(strPrtModelNo);

if (strFrom.equals("list") && (strPrtModelNo.equals("") || strPrtModelNo.length() == 0)) { // LP

	// LP 제외카테
	LP_Notincate_Json notinCateJson = new LP_Notincate_Json();
	Map<String, String> notinCateMap = notinCateJson.parseJson();
	String strNotCateEs = "";
	String strNotInCateSearchKey = strCate;
	// gb1, gb2 액세사리
	if (strGb1.trim().length() > 0 && strGb2.trim().length() > 0) {
		strNotInCateSearchKey = strNotInCateSearchKey + "_" + strGb1 + "_" + strGb2;

		// 검색엔진에 브랜드코드 삽입
		csearch.setStrBrandDetail(strGb1, strGb2);
	}
	if (notinCateMap.containsKey(strNotInCateSearchKey)) {
		strNotCateEs = (String) notinCateMap.get(strNotInCateSearchKey);
	}
	if (strNotCateEs.length() > 0)
		csearch.setStrNotCate(strNotCateEs);
}

if (strKeyword.length() > 0 || strInKeyword.length() > 0) { // 검색어
	csearch.setStrFirstKeyword(strKeyword.trim()); //처음 검색어 (결과내검색 제외)
	strOrgKeyword = (strKeyword + " " + strInKeyword).trim();
	csearch.setStrOrgKeyword(strOrgKeyword); // 검색어 + 결과내검색
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strOrgKeyword);
	strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	csearch.setStrKeyword(strSearchKeyword.trim()); // 검색어 + 결과내검색 + 동의어
}

csearch.setBNoSale(true); //판매중단,출시예정상품 검색 여부(ture :제외 , false: 포함)
csearch.setBOpenExpect(true); //판매중단은 제외더라도 출시예정은 검색
csearch.setbZum(true);
csearch.setStrSrvflag("0,L,R,S,M");

// 중고/렌탈 제외 유무 체크 시
if (strIsRental.equals("Y")) {
	csearch.setbRentalRemove(true);
}
// 제조사
if (strParamFactory.length() > 0) {
	csearch.setStrFactory(strParamFactory);
}
// 브랜드
if (strParamBrand.length() > 0) {
	csearch.setStrBrand(strParamBrand);
}
// 쇼핑몰코드
if (strParamShopCode.length() > 0) {
	csearch.setStrShop(strParamShopCode);
}
// 속성 ( spec )
if (strSpec.length() > 0) {
	csearch.setStrSpec(strSpec);
}
//색상 ( specColor )
if(strColor.length()>0) {
	csearch.setStrSpecColor(strColor);
}
// 가격대
if (lngSPrice > 0 || lngEPrice > 0) {
	csearch.setStrMPrice(lngSPrice + "~" + lngEPrice); //가격조건("10000~20000,30000~40000")
}

String tabSearchKindType = "";
if (intTab == 1)
	tabSearchKindType = "1";
if (intTab == 2)
	tabSearchKindType = "2";

if (strSort != null && (strSort.indexOf("sale_cnt") > -1 || strSort.indexOf("c_date") > -1))
	tabSearchKindType = "1";
csearch.setStrSearchKind(tabSearchKindType); //1:가격비교 2:추가검색 "" 이면 전체

// 서비스구분 플래그 srvflag
/* 
if (strFrom.equals("list")) { // lp 
	csearch.setStrSrvflag("0,L,R,M,C");
} else if (strFrom.equals("search")) { // srp
	csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");
}
*/
//2021.06.21 srvflag SRP, LP 모두 통일
csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");

// 재검색여부
/* 
if (strIsReSearch.equals("Y") && strFrom.equals("list") && strInKeyword.trim().length() > 0) {
	csearch.setResearchType(CSearchClient.RESEARCH_EXCLUDE_ENABLED);
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
//2021.06.21 결과내 검색 재검색 해제
if(strIsReSearch.equals("Y")) {
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
if (strFrom.equals("list")) {
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

//브랜드 집계
csearch.setbBrandGroup(true);
//제조사 집계
csearch.setBFacgoryGroup(true);

//가격 범위 집계(percentile)
csearch.setBPriceGroup(true);

csearch.setBCateGroup1(false); //대분류 그룹핑 여부
csearch.setBCateGroup2(true); //중분류 그룹핑 여부

csearch.addParameter("nOptionFlag", String.valueOf(nOptionFlag));

CSearchResult cSearchResult = csearch.CSearchRun();
String strQueryOut = csearch.getStrQuery();

String strModelNo_Group = cSearchResult.getStrModelNos();//모델번호들
String strPlNos = cSearchResult.getStrPlNos();//PL_NO들
int intTotRsCnt = cSearchResult.getIntTotRsCnt(); // 전체 검색 결과
int intRsCnt = cSearchResult.getIntRsCnt();
int intEnuriCnt = cSearchResult.getIntEnuriCnt(); // 한페이지에 표
int intWebCnt = cSearchResult.getIntWebCnt();
int intFuzzy = cSearchResult.getIntFuzzy();
String searchedKeyword = cSearchResult.getSearchedKeyword();
String strMcates = cSearchResult.getStrMcates();
String strMpnos = cSearchResult.getStrMpnos();

Goods_Data[] spec_brand_data = null; // 브랜드 집계
spec_brand_data = cSearchResult.getGoods_brand_data();
Goods_Data[] spec_factory_data = null; // 제조사 집계
spec_factory_data = cSearchResult.getGoods_factory_data();

long[] spec_price_data1 = null; // 가격대 집계 ( 가격비교 )
spec_price_data1 = cSearchResult.getLongPriceRange1();
String spec_model_avg_price1 = cSearchResult.getStrAvgMinprice1(); // 가격 평균가 ( 가격비교 )
long[] spec_price_data2 = null; // 가격대 집계 ( 일반상품 )
spec_price_data2 = cSearchResult.getLongPriceRange2();
String spec_model_avg_price2 = cSearchResult.getStrAvgMinprice2(); // 가격 평균가 ( 일반상품 )
long[] spec_price_data3 = null; // 가격대 집계 ( 전체상품 )
spec_price_data3 = cSearchResult.getLongPriceRange3();
String spec_model_avg_price3 = cSearchResult.getStrAvgMinprice3(); // 가격 평균가 ( 전체상품 )

String [][]resultCategoryLarge = cSearchResult.getResultCategoryLarge(); // 추천카테고리
String resultCategoryLargeName[] = cSearchResult.getResultCategoryLargeName();
String [][]resultCategoryMiddle = cSearchResult.getResultCategoryMiddle(); // 추천카테고리
String resultCategoryMiddleName[] = cSearchResult.getResultCategoryMiddleName();
String [][]resultCategorySmall = cSearchResult.getResultCategorySmall(); // 추천카테고리
String resultCategorySmallName[] = cSearchResult.getResultCategorySmallName();
String [][]resultCategorySSmall = cSearchResult.getResultCategorySSmall(); // 추천카테고리
String resultCategorySSmallName[] = cSearchResult.getResultCategorySSmallName();

/*
System.out.println("Query = " + csearch.getStrQuery() );
System.out.println("strModelNo_Group = " + strModelNo_Group.toString() );
System.out.println("strCategory = "+strCate);
System.out.println("intTotRsCnt = "+intTotRsCnt);
System.out.println("intRsCnt = "+intRsCnt);
System.out.println("intEnuriCnt = "+intEnuriCnt);
System.out.println("intWebCnt = "+intWebCnt);

System.out.println("spec_model_avg_price1 = "+spec_model_avg_price1);
*/
System.out.println("zum mpnos : " + strMpnos );

%>
