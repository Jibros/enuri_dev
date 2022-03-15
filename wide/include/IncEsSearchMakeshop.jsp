<%@ page import="com.enuri.bean.wide.LP_Notincate_Json"%>
<%@ page import="com.enuri.bean.main.SimilarGoods_Proc"%>
<jsp:useBean id="LP_Notincate_Json" class="com.enuri.bean.wide.LP_Notincate_Json" scope="page" />
<%
String strOrgKeyword = ""; //해당 값을 list api 에서 제외검색용으로 사용해야하므로 전역 처리
String strKeywordDetails = ""; // 키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)
String strDiscountRate = ""; // 할인율 조건 예)50~70,20~50

boolean blp = strFrom.equals("list"); // LP 여부
boolean bDebug = strIsTest.equals("Y"); // 디버그 여부
boolean bModelNo = strCate.equals("00000000"); // 모델번호 검색 여부
boolean bLog = !bDebug && !bModelNo; // 검색 로깅 여부

//CSearchClient csearch = com.enuri.bean.search.CSearchClientBuilder.build(1, blp, bDebug);
CSearchClient csearch = com.enuri.bean.search.CSearchClientBuilder.buildProxy(1, blp, bDebug);

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
}
csearch.setStrUserIp(getUserAddr(request)); //사용자 주소
csearch.setStrUserAgent(getUserAgent(request)); // 사용자 Agent
csearch.addParameter("strUserId", getUserID(request)); // 사용자 ID

csearch.setRequestUrl(request.getRequestURI());
csearch.setUriQuerystring(request.getQueryString());

csearch.setStrEtype("");
csearch.setStrPrintModelno(strPrtModelNo); // 프린트 모델번호
csearch.setBModelNo(bModelNo); // 모델번호 검색 여부

if(!bModelNo) {
	csearch.setStrRealCate(strCate); // 원카테
	csearch.setStrCate(Searchfunction.getCopyCate(strCate)); // 추가카테 ( 없으면 원카테 )	
}

if(!bModelNo && blp && (strPrtModelNo.equals("") || strPrtModelNo.length() == 0)) { // LP

	// LP 제외카테
	LP_Notincate_Json notinCateJson = new LP_Notincate_Json();
	Map<String, String> notinCateMap = notinCateJson.parseJson();
	String strNotCateEs = "";
	String strNotInCateSearchKey = strCate;
	// gb1, gb2 액세사리
	if(strGb1.trim().length()>0 && strGb2.trim().length()>0) {
		strNotInCateSearchKey = strNotInCateSearchKey + "_" + strGb1 + "_" + strGb2;
		
		// 검색엔진에 브랜드코드 삽입
		csearch.setStrBrandDetail(strGb1, strGb2);
	}
	if( notinCateMap.containsKey(strNotInCateSearchKey) ) {
		strNotCateEs = (String) notinCateMap.get(strNotInCateSearchKey);
	}
	if(strNotCateEs.length()>0) csearch.setStrNotCate(strNotCateEs);
}

if(strKeyword.length()>0 || strInKeyword.length()>0) { // 검색어
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
if(strIsRental.equals("Y")) {
	csearch.setbRentalRemove(true);
}
// 제조사
if((intTab == 0 || intTab == 1 || intTab == 3) && strParamFactory.length()>0) {
	csearch.setStrFactory(strParamFactory);
}
// 브랜드
if((intTab == 0 || intTab == 1 || intTab == 3) && strParamBrand.length()>0) {
	csearch.setStrBrand(strParamBrand);
}
// 쇼핑몰코드
if(intTab == 2 && strParamShopCode.length()>0) {
	csearch.setStrShop(strParamShopCode);
}
// 속성 ( spec )
if((intTab == 0 || intTab == 1 || intTab == 3) && strSpec.length()>0) {
	csearch.setStrSpec(strSpec);
}
// 색상 ( specColor ) ###
if((intTab == 0 || intTab == 1 || intTab == 3) && strColor.length()>0) {
	csearch.setStrSpecColor(strColor);
}
// 가격대
if(lngSPrice>0 || lngEPrice>0) {
	csearch.setStrMPrice(lngSPrice+"~"+lngEPrice); //가격조건("10000~20000,30000~40000")
}

String tabSearchKindType = "";
if(intTab==1) tabSearchKindType = "1";
if(intTab==2) tabSearchKindType = "2";

if(strSort != null && (strSort.indexOf("sale_cnt") > -1 || strSort.indexOf("c_date") > -1))
	tabSearchKindType = "1";
csearch.setStrSearchKind(tabSearchKindType); //1:가격비교 2:추가검색 "" 이면 전체

/* 2021.06.21 사용안함
// 서비스구분 플래그 srvflag
if(blp) { // lp 
	csearch.setStrSrvflag("0,L,R,M,C");
} else if(strFrom.equals("search")) { // srp
	csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");
}
// 재검색여부
if(strIsReSearch.equals("Y") && blp && strInKeyword.trim().length()>0) {
	csearch.setResearchType(RESEARCH_EXCLUDE_ENABLED);
}

if(strIsReSearch.equals("Y")) {
	if(strKeyword.trim().length()>0 || strInKeyword.trim().length()>0) {
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

//메이크샵 체크여부
if(strIsMakeShop.equals("Y")){
	csearch.setIsMakeshop("Y");
}else if(strIsMakeShop.equals("N")){
	csearch.setIsMakeshop("N");
}
csearch.setStrKey(strSort);
csearch.setCPage(pageNum);
csearch.setNPageSize(pageGap);
csearch.setListShowFlag(true);

// LP 유사상품 
if(blp) {
	SimilarGoods_Proc sgp = new SimilarGoods_Proc();
	HashMap<String, String> simGoodsCaCode = null;
	simGoodsCaCode = sgp.getSimilarGoodsCaCode();
	
	if(null != simGoodsCaCode && simGoodsCaCode.containsKey(strCate4.trim())){
		csearch.setLikenessShow(true);
	}
}

// 출시예정 만 다른 조건으로 조회
if(intSort==7) {
	csearch.setStrSearchArea("10");
} else {
	csearch.setStrSearchArea("111");
}

// 프린터모델
if(strPrtModelNo.length()>0) {
	csearch.setBSuModelNo(true);
	csearch.setStrPrintModelno(strPrtModelNo);
}

//# LP/SRP 개편 2021.07.12 신규 추가 - 시작
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
//키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)	
if (strKeywordDetails.length() > 0) {
	csearch.addParameter("strKeywordDetails", strKeywordDetails);
}
//그룹모델 수동추가 ###
if (strEtcCate.length() > 0) {
	csearch.addParameter("strEtcCate", strEtcCate);	
}
//할인율
if (strDiscountRate.length() > 0) {
	csearch.addParameter("strDiscountRate", strDiscountRate);
}
//옵션 flag
csearch.addParameter("nOptionFlag", String.valueOf(OPT_FLAG));
//# LP/SRP 개편 2021.07.12 신규 추가 - 끝

CSearchResult cSearchResult = csearch.CSearchRun();
String strQueryOut = csearch.getStrQuery();

String strModelNo_Group = cSearchResult.getStrModelNos();//모델번호들
String strPlNos = cSearchResult.getStrPlNos();//PL_NO들
int intTotRsCnt =  cSearchResult.getIntTotRsCnt(); // 전체 검색 결과
int intRsCnt = cSearchResult.getIntRsCnt();
int intEnuriCnt = cSearchResult.getIntEnuriCnt(); // 한페이지에 표
int intWebCnt = cSearchResult.getIntWebCnt();
int intFuzzy = cSearchResult.getIntFuzzy();
String searchedKeyword = cSearchResult.getSearchedKeyword();
String strMcates = cSearchResult.getStrMcates();
String strMpnos  = cSearchResult.getStrMpnos();
JsonMap<String, JsonMap<String, Object>> hitsSourceMap = cSearchResult.getSource();
%>
<%--
# List<Map<String, Object>> hitsSourceMap 
--------------------------------------------------
shop_code = (java.lang.String) 268193
modelnm = (java.lang.String) 포근한 디자인으로 제작되어 따듯해보여요
cate_nm = (java.lang.String) PUMPS&HEELS펌프스힐
ca_dcode_ran = (java.lang.String) 14540101
modelnm2 = (java.lang.String) 포근한 디자인으로 제작되어 따듯해보여요
bookflag = (java.lang.String) 0
imgurl = (java.lang.String) http://www.zizhel.net/shopimages/zizhel/0260000000223.jpg?1554195516
mcate = (java.lang.String) 1454
c_date = (java.lang.String) 2014-02-10T06:57:44Z
minprice = (java.lang.String) 89000
maxprice3 = (java.lang.String) 89000
ca_lcode_ran = (java.lang.String) 14
sale_cnt = (java.lang.String) 0
keyword = (java.lang.String) 1953 여성빅사이즈구두 여성큰신발 여자빅사이즈구두 큰구두 여성빅슈즈 여성빅사이즈슈즈 빅사이즈여자신발 발큰여자신발 빅사이즈여자구두 255신발 큰사이즈여자신발 빅사이즈부티 예쁜큰신발 발볼넓은여성구두
modelno_group_flag = (java.lang.String) 0
brand = (java.lang.String) 1953
ca_mcode_ran = (java.lang.String) 1454
minprice3 = (java.lang.String) 89000
service_gubun = (java.lang.String) 0
popular2 = (java.lang.String) 9223372036854775807
bbs_num = (java.lang.String) 11
url = (java.lang.String) http://www.zizhel.net/index.html?branduid=128
cate_cd = (java.lang.String) 026000000
cat2 = (java.lang.String) 026000
cat3 = (java.lang.String) 026000000
cat1 = (java.lang.String) 026
pl_no = (java.lang.String) 128
category = (java.lang.String) 14 1454 145401 14540101
ca_scode_ran = (java.lang.String) 145401
--------------------------------------------------
--%>
