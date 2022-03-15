<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"  />
<%

	/**
	 * @history
	 	2021.05.11. 최조작성
	 	2021.09.16. 2차 개편
	*/

	/** Parameter Sets */
	// 페이지종류 ( list , search )
	String strFrom = ConfigManager.RequestStr(request, "from", "list");
	// 디바이스 유형 ( pc , mw , aos, ios, all )
	String strDevice = ConfigManager.RequestStr(request, "device", "pc");
	strDevice = strDevice.toLowerCase();
	// 앱버전
	String strAppVersion = ConfigManager.RequestStr(request, "appVersion", "");
	int intAppVersion = 0;
	if(strAppVersion.length()>0) {
		strAppVersion = strAppVersion.replace(".", "");
		strAppVersion = CutStr.cutStr(strAppVersion,3);
		intAppVersion = Integer.parseInt(strAppVersion);
	}
	// 카테고리
	String strCate = ConfigManager.RequestStr(request, "category", "");
	String strCate2 = "";
	String strCate4 = "";
	String strCate6 = "";
	String strCate8 = "";
	if(strCate.length()>=8) {
		strCate8 = CutStr.cutStr(strCate,8);
	}
	if(strCate.length()>=6) {
		strCate6 = CutStr.cutStr(strCate,6);
	}
	if(strCate.length()>=4) {
		strCate4 = CutStr.cutStr(strCate,4);
	}
	if(strCate.length()>=2) {
		strCate2 = CutStr.cutStr(strCate,2);
	}
	
	// 탭(리스트유형) ( 0:전체 / 1:모델리스트 / 2:일반상품리스트 / 3:해외직구)
	int intTab = ChkNull.chkInt(request.getParameter("tab"), 0);
	// 모바일 전문몰 일반상품 탭 고정
	if(!strDevice.equals("pc") && strFrom.equals("list") && (strCate4.equals("1487") || strCate4.equals("1488"))) {
		intTab = 2;
	}
	
	// 배송비 포함 유무
	String strIsDelivery = ConfigManager.RequestStr(request, "isDelivery", "N");
	// 중고/렌탈 제외 유무
	String strIsRental = ConfigManager.RequestStr(request, "isRental", "N");
	// 페이지 번호
	int pageNum = ChkNull.chkInt(request.getParameter("pageNum"), 1);
	// 페이지당 호출 갯수
	int pageGap = ChkNull.chkInt(request.getParameter("pageGap"), 30);
	// 정렬
	/**
	1. 인기순  // popular DESC
	2. 최저가순 // minprice3 ASC
	3. 최고가순 // minprice3 DESC
	4. 신제품순 // c_date DESC
	5. 판매량순 // sale_cnt DESC
	6. 상품평 많은 순 // bbs_num DESC
	7. 출시예정 순 // newGoods ASC
	8. 할인율순 // dc_rt DESC
	9. 인기순(상품평점수추가) // npopular DESC
	*/
	int intSort = ChkNull.chkInt(request.getParameter("sort"), 1);
	
	// 인기도 정렬 변경
	if(intSort==1) {
	//	intSort = 9;
	}
	
	String strSort = "";
	switch(intSort) {
		case 1 : strSort = "popular DESC"; break;
		case 2 : strSort = "minprice3 ASC"; break;
		case 3 : strSort = "minprice3 DESC"; break;
		case 4 : strSort = "c_date DESC"; break;
		case 5 : strSort = "sale_cnt DESC"; break;
		case 6 : strSort = "bbs_num DESC"; break;
		case 7 : strSort = "popular DESC"; intTab = 1; break;
		case 8 : strSort = "dc_rt DESC"; break;
		case 9 : strSort = "npopular DESC"; break;
	}
	// 배송비 포함 체크 시 minprice3 -> minprice2 로 바뀐다.
	if(strIsDelivery.equals("Y")) {
		if(strSort.indexOf("minprice2")<0) strSort = ReplaceStr.replace(strSort, "minprice3", "minprice2");
	}
	
	// 제조사
	String strParamFactory = ChkNull.chkStr(request.getParameter("factory"), "");
	// 제조사 코드
	String strParamFactoryCode = ChkNull.chkStr(request.getParameter("factory_code"), "");
	// 브랜드
	String strParamBrand = ChkNull.chkStr(request.getParameter("brand"), "");
	// 브랜드 코드
	String strParamBrandCode = ChkNull.chkStr(request.getParameter("brand_code"), "");
	// 쇼핑몰코드
	String strParamShopCode = ChkNull.chkStr(request.getParameter("shopcode"), "");
	// 검색어
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"), "");
	// 결과 내 검색어
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"), "");
	// 가격대 검색 - 시작
	long lngSPrice = ChkNull.chkLong(request.getParameter("s_price"), 0);
	// 가격대 검색 - 끝
	long lngEPrice = ChkNull.chkLong(request.getParameter("e_price"), 0);
	// 속성
	String strSpec = ChkNull.chkStr(request.getParameter("spec"), "");
	// 재검색여부 
	String strIsReSearch = ChkNull.chkStr(request.getParameter("isReSearch"), "Y");
	// 테스트 모드 여부
	String strIsTest = ChkNull.chkStr(request.getParameter("isTest"), "N");
	// 프린터모델번호
	String strPrtModelNo = ChkNull.chkStr(request.getParameter("prtmodelno"), "");
	// 메이크샵 상품 포함 유무
	String strIsMakeShop = ChkNull.chkStr(request.getParameter("isMakeshop"), "N");
	// 속성(색상) - 메이크샵
	String strColor = ChkNull.chkStr(request.getParameter("color"), "");
	// 할인율
	String strDiscount = ChkNull.chkStr(request.getParameter("discount"), "");
	// 평점
	String strBbsScore = ChkNull.chkStr(request.getParameter("bbsscore"), "");
	/** // Parameter Sets */
	
	/** Parameter Validation Check */
	boolean blParam = true;
	JsonResponse ret = null;
	if(strFrom.equals("list") && strCate.length()==0) { // LP 인데 카테고리 없으면 예외
		blParam = false;
	} else if(strFrom.equals("list") && (strCate.length()!=4 && strCate.length()!=6 && strCate.length()!=8)) { // LP 인테 카테고리 자릿수가 유효하지 않으면 예외
		blParam = false;
	} else if(strFrom.equals("search") && strKeyword.trim().length()==0) { // SRP 인데 검색어 없으면 예외
		blParam = false;
	}
	
	if(!blParam) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	/** // Parameter Validation Check */
	
	// 한글 인코딩 깨짐 방지
	if(strDevice.equals("pc") || strDevice.equals("mw")) {
		strParamFactory = URLDecoder.decode(strParamFactory, "UTF-8");
		strParamBrand = URLDecoder.decode(strParamBrand, "UTF-8");
		strKeyword = URLDecoder.decode(strKeyword, "UTF-8");
		strInKeyword = URLDecoder.decode(strInKeyword, "UTF-8");
	}
	
	// 키워드 100자 넘을경우 자르기
	if(strKeyword.length()>100) {
		strKeyword = strKeyword.substring(0,100);
	}
	
	// 모바일 최저가 정렬 시 중고/렌탈은 제외
	if( (strDevice.equals("mw") || strDevice.equals("aos") || strDevice.equals("ios")) && intSort==2) {
		strIsRental = "Y";
	}
	
	int intTotalCnt = 0; // 초기값
	
	Map<String, Object> retMap = new JsonMap<String, Object>();
	
	// 검색에서 동작을 이상하게 하기 때문에 빼버림
	// 검색 쿼리 생성에 애매함(자바스크립트로 원래 거름)
	String[] removeKeywordCharAry = { "|", ",", "'" };
	for(int i=0; i<removeKeywordCharAry.length; i++) {
		strKeyword = strKeyword.replace(removeKeywordCharAry[i], " ");
		strInKeyword = strInKeyword.replace(removeKeywordCharAry[i], " ");
	}
	
	// 그룹모델 수동추가
	String strEtcCate = "";
	// 슈퍼탑 모델
	String strAdModelsSearch = "";
		
	/** ES Search */
%><%@ include file="/wide/include/IncEsSearch.jsp"%><%
	/** // ES Search */
		
	// 모델상품갯수, 일반상품갯수
	retMap.put("modelCnt", intEnuriCnt);
	retMap.put("plCnt", intWebCnt);
	
	intTotalCnt = intTotRsCnt;
	
	ret = new JsonResponse(true).setData(retMap).setTotal(intTotalCnt);
	
	out.print ( ret );
%>