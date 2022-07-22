<%@ page import="com.enuri.bean.wide.LP_Notincate_Json"%>
<%@ page import="com.enuri.bean.main.SimilarGoods_Proc"%>
<%@ page import="com.enuri.bean.search.ObjectConverter"%>
<jsp:useBean id="LP_Notincate_Json" class="com.enuri.bean.wide.LP_Notincate_Json" scope="page"/>
<%!
String strColor = "";
String strEtcCate = "";
String strParamBrandCode = "";
String strParamFactoryCode = "";
String strSpecName = "";
String strKeywordDetails = "";
String strIsMakeShop = "N";
String strDiscount = ""; // 할인율 조건 예)50~70,20~50
%>
<%
String strOrgKeyword = ""; //해당 값을 list api 에서 제외검색용으로 사용해야하므로 전역 처리
String strKeywordDetails = ""; // 키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)

String serverName = request.getServerName() == null ? "" : request.getServerName();

boolean blp = strFrom.equals("list"); // LP 여부
boolean bDebug = (serverName.equals("localhost") ||serverName.equals("127.0.0.1") || serverName.indexOf("dev") > -1) && strIsTest.equals("Y"); // 디버그 여부
int nVersion = 2;

boolean bSpecGroup = blp; // 속성 그룹여부 (LP일 때만)
boolean bBrandGroup = true; //브랜드그룹
boolean bBrandFactoryGroup = false; //브랜드 + 제조사그룹여부
boolean bFactoryGroup = true; //제조사그룹여부
boolean bPriceRangeGroup = blp && strCate.startsWith("14"); // 패션/잡화 카테고리만
boolean bPriceGroup = strDevice.equals("all") || strDevice.equals("pc");
boolean bBbsPointGroup = true;

boolean bDiscountRateGroup = true; // 할인율 그룹여부
String strDiscountRateGroups = "[70~100]70%이상,[50~70]70%~50%,[20~50]50%~20%,[0~20]20%미만"; // 할인율 그룹 정의
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
	csearch.setBLog(false); // 집계시에는 검색로그 저장 않함
	csearch.setEsClientCode(!blp ? 1 : 2);
}
csearch.setStrHostSet(strHostSet); //검색엔진 주소
csearch.setStrUserIp(getUserAddr(request)); //사용자 주소
csearch.setStrUserAgent(getUserAgent(request)); // 사용자 Agent
csearch.addParameter("strUserId", getUserID(request)); // 사용자 ID
csearch.addParameter("strUserDevice", strDevice); // 사용자 디바이스종류
csearch.addParameter("esProfileName", strProfileName); // 검색 프로파일

csearch.setRequestUrl(ChkNull.chkStr(request.getRequestURI()));
csearch.setUriQuerystring(ChkNull.chkStr(getQueryString(request)));
csearch.setIsMakeshop(strIsMakeShop);

if(strCate.length()>0) {
	if (blp) {
		bBrandGroup = offSpecDataMap.containsKey("brand") && offSpecDataMap.get("brand");
		bFactoryGroup = offSpecDataMap.containsKey("factory") && offSpecDataMap.get("factory");
		bBbsPointGroup = offSpecDataMap.containsKey("bbsscore") && offSpecDataMap.get("bbsscore");
		bDiscountRateGroup = offSpecDataMap.containsKey("discount") && offSpecDataMap.get("discount");
	}
	/*
	// 브랜드 검색만 존재하는 경우
	if(bBrandGroup && !bFactoryGroup)
		nOptionFlag = nOptionFlag & ~OPT_FLAG_GROUP_BRAND2;
	*/
	csearch.setStrEtype("");
	csearch.setStrRealCate(strCate); // 원카테
	csearch.setStrCate(Searchfunction.getCopyCate(strCate)); // 추가카테 ( 없으면 원카테 )
}

if(blp) { // LP
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
	strOrgKeyword = (strKeyword + " " + strInKeyword).trim();
	String strSearchKeyword = Searchfunction.removeExceptionKeyword(strOrgKeyword);
	strSearchKeyword = Searchfunction.getSynonym(strSearchKeyword);
	
	csearch.setStrFirstKeyword(strKeyword.trim()); //처음 검색어 (결과내검색 제외)
	csearch.setStrOrgKeyword(strOrgKeyword); // 검색어 + 결과내검색
	csearch.setStrKeyword(strSearchKeyword.trim()); // 검색어 + 결과내검색 + 동의어
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
if(intTab==1) tabSearchKindType = "1";
if(intTab==2) tabSearchKindType = "2";
if(intTab==3) tabSearchKindType = "2";

/* 2021-04-07 service_gubun이 움직이더라도 가격대 영향을 주지않기위함 
if(strSort != null && (strSort.indexOf("sale_cnt") > -1 || strSort.indexOf("c_date") > -1))
	tabSearchKindType = "1";
csearch.setStrSearchKind(tabSearchKindType); //1:가격비교 2:추가검색 "" 이면 전체  

// 서비스구분 플래그 srvflag
if(blp) { // lp 
	csearch.setStrSrvflag("0,L,R,M,C");
} else if(strFrom.equals("search")) { // srp
	csearch.setStrSrvflag("0,L,R,S,M,2,3,D,P,C,O");
}
//재검색여부
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
if(strIsReSearch.equals("Y")) {
	if(strInKeyword.trim().length()>0) { // 결과내 검색 존재 시
		csearch.setIsReSearch("N");
	} else if(strKeyword.trim().length() > 0) {
		csearch.setIsReSearch("Y");
	}
} else {
	csearch.setIsReSearch("N");
}

csearch.setBCateGroup1(true); //대분류 그룹핑 여부
csearch.setBCateGroup2(true); //중분류 그룹핑 여부

//브랜드 집계
csearch.setbBrandGroup(bBrandGroup);
//제조사 집계
csearch.setBFacgoryGroup(bFactoryGroup); 
//가격 범위 집계(percentile)
csearch.setBPriceGroup(bPriceGroup);
//쇼핑몰 집계
csearch.setBShopGroup(true);
//유사상품
csearch.setLikenessShow(true);
//모델의 가격 평균가격
csearch.setBPriceAvgGroup(true);
//출시예정 상품 유무
csearch.setBOpenexpectGroup(true);

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
// 키워드 조합 조건 (브랜드, 제조사, 속성 명칭 검색)	
if (strKeywordDetails.length() > 0) {
	csearch.addParameter("strKeywordDetails", strKeywordDetails);
}
// 그룹모델 수동추가 ###
if (strEtcCate.length() > 0) {
	csearch.addParameter("strEtcCate", strEtcCate);	
}
// 할인율
if (strDiscount.length() > 0) {
	csearch.addParameter("strDiscountRate", strDiscount);
}
//가격 범위 집계(histogram)
csearch.addParameter("bPriceRangeGroup", String.valueOf(bPriceRangeGroup));
// 속성 그룹여부
csearch.addParameter("bSpecGroup", String.valueOf(bSpecGroup)); 
//브랜드 + 제조사그룹여부
csearch.addParameter("bBrandFactoryGroup", String.valueOf(bBrandFactoryGroup)); 
//할인율 그룹여부
csearch.addParameter("bDiscountRateGroup", String.valueOf(bDiscountRateGroup));
//할인율 그룹 정의
csearch.addParameter("strDiscountRateGroups", strDiscountRateGroups);
//평점 그룹여부
csearch.addParameter("bBbsPointGroup", String.valueOf(bBbsPointGroup));
//옵션 flag
csearch.addParameter("nOptionFlag", String.valueOf(nOptionFlag)); 
//# LP/SRP 개편 2021.07.12 신규 추가 - 끝

ObjectConverter converter = new ObjectConverter();
CSearchResult cSearchResult = csearch.CSearchRun();
String strQueryOut = csearch.getStrQuery();

int intTotRsCnt = cSearchResult.getIntTotRsCnt();  // 전체 검색 결과
String [][]resultCategoryLarge = cSearchResult.getResultCategoryLarge(); // 추천카테고리
String resultCategoryLargeName[] = cSearchResult.getResultCategoryLargeName();
String [][]resultCategoryMiddle = cSearchResult.getResultCategoryMiddle(); // 추천카테고리
String resultCategoryMiddleName[] = cSearchResult.getResultCategoryMiddleName();
String [][]resultCategorySmall = cSearchResult.getResultCategorySmall(); // 추천카테고리
String resultCategorySmallName[] = cSearchResult.getResultCategorySmallName();
String [][]resultCategorySSmall = cSearchResult.getResultCategorySSmall(); // 추천카테고리
String resultCategorySSmallName[] = cSearchResult.getResultCategorySSmallName();
Goods_Data[] spec_brand_data = cSearchResult.getGoods_brand_data(); // 브랜드 집계
if (spec_brand_data == null) spec_brand_data = new Goods_Data[0];
Goods_Data[] spec_factory_data = cSearchResult.getGoods_factory_data(); // 제조사 집계
if (spec_factory_data == null) spec_factory_data = new Goods_Data[0];
Goods_Data[] spec_shop_data = cSearchResult.getGoods_shop_data(); // 쇼핑몰 집계
if (spec_shop_data == null) spec_shop_data = new Goods_Data[0];
long[] spec_price_data1 = null; // 가격대 집계 ( 가격비교 )
spec_price_data1 = cSearchResult.getLongPriceRange1();
String spec_model_avg_price1 = cSearchResult.getStrAvgMinprice1(); // 가격 평균가 ( 가격비교 )
long[] spec_price_data2 = null; // 가격대 집계 ( 일반상품 )
spec_price_data2 = cSearchResult.getLongPriceRange2();
String spec_model_avg_price2 = cSearchResult.getStrAvgMinprice2(); // 가격 평균가 ( 일반상품 )
long[] spec_price_data3 = null; // 가격대 집계 ( 전체상품 )
spec_price_data3 = cSearchResult.getLongPriceRange3();
String spec_model_avg_price3 = cSearchResult.getStrAvgMinprice3(); // 가격 평균가 ( 전체상품 )
JSONArray priceHistogram = cSearchResult.getLongPriceHistogram(); // 가격 범위 집계
int intOpenexpectCnt = cSearchResult.getIntOpenexpectCnt(); // 출시예정 상품 갯수
//# LP/SRP 개편 2021.07.12 신규 추가 - 시작
JSONArray goods_spec_data = converter.convertList((List<Map<String, Object>>) cSearchResult.getValue("goods_spec_data", null)); // 속성 집계
JSONArray goods_brand_factory_data = converter.convertList((List<Map<String, Object>>) cSearchResult.getValue("goods_brand_factory_data", null)); // 브랜드 + 제조사 집계
JSONArray goods_discount_rate_data = converter.convertList((List<Map<String, Object>>) cSearchResult.getValue("goods_discount_rate_data", null)); // 할인율 집계
JSONArray goods_bbs_point_data = converter.convertList((List<Map<String, Object>>) cSearchResult.getValue("goods_bbs_point_data", null)); // 평점 집계
String spec_cate = cSearchResult.getValue("spec_cate", "");
boolean custom_spec = cSearchResult.getValue("custom_spec", false);
long bbs_point_count = cSearchResult.getValue("bbs_point_count", 0L);
//# LP/SRP 개편 2021.07.12 신규 추가 - 끝

//System.out.println("goods_spec_data >>> " + goods_spec_data);
//System.out.println("goods_brand_factory_data >>> " + goods_brand_factory_data);
//System.out.println("goods_discount_rate_data >>> " + goods_discount_rate_data);
//System.out.println("spec_cate >>> " + spec_cate);
//System.out.println("bbs_point_count >>> " + bbs_point_count);
%>
<%--
# List<Map<String, Object>> goods_spec_data 
--------------------------------------------------
spec_group_title = (java.lang.String) 그레이
spec_type = (java.lang.String) c
spec_catedetail_delflag = (java.lang.String) 0
gpsno = (java.lang.Integer) 1
g_icon_type = (java.lang.String) 0
ca_code_detail = (java.lang.String) 
img_view_yn = (java.lang.String) N
spec_group_specno = (java.lang.Integer) 25561
stair_flag = (java.lang.String) 
spec_cate_title = (java.lang.String) 색상
spec_catedetail_title = (java.lang.String) 색상
spec_catedetail_aoflag = (java.lang.String) 0
cate_kb_no = (java.lang.Integer) 0
gpno = (java.lang.Integer) 3036
img_view_dcd = (java.lang.String) 0
height = (java.lang.Integer) 0
icon_type = (java.lang.String) 0
spec_group_count = (java.lang.Long) 2201
comments = (java.lang.String) 
group_name = (java.lang.String) 
isleftright = (java.lang.String) 
spec_group_delflag = (java.lang.String) 0
width = (java.lang.Integer) 0
kb_no = (java.lang.Integer) 0
spec_cate_delflag = (java.lang.String) 0
spec_cate_aoflag = (java.lang.String) 0
--------------------------------------------------

# List<Map<String, Object>> goods_brand_factory_data 
--------------------------------------------------
count = (java.lang.Integer) 1
brand = (java.lang.String) 플라스틱아일랜드
--------------------------------------------------

# List<Map<String, Object>> goods_discount_rate_data 
--------------------------------------------------
name = (java.lang.String) 70%~50%
count = (java.lang.Long) 1335
from = (java.lang.Integer) 50
to = (java.lang.Integer) 70
value = (java.lang.String) 50~70
--------------------------------------------------

# List<Map<String, Object>> goods_bbs_point_data 
--------------------------------------------------
count = (java.lang.Long) 3232
point = (java.lang.Integer) 1
--------------------------------------------------
--%>
