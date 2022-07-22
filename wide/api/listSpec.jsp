<%@page import="java.util.stream.Stream"%>
<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.common.collect.ArrayListMultimap"%>
<%@ page import="com.google.common.collect.Multimap"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Category_Middle_Comparator"%>
<%@ page import="com.enuri.bean.main.Spec_Group_Proc"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="com.enuri.bean.main.RecKeyword_Data"%>
<%@ page import="com.enuri.bean.main.RecKeyword_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.wide.Wide_List_Proc"%>
<%@ page import="com.enuri.bean.wide.LP_ReqBrand_Json"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"/>
<%
	/**
	 * @history
	 * 2021.02.05. 최조작성
	**/
	
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
	/*
		1259 오늘의집
		1487 오케이몰
		1488 무신사스토어
	*/
	if(!strDevice.equals("pc") && strFrom.equals("list") && (strCate4.equals("1487") || strCate4.equals("1488") || strCate4.equals("1259"))) {
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
	boolean devFlag = false;
	if(strIsTest.equals("Y")){
		devFlag = true;
	}
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
	
	// 검색에서 동작을 이상하게 하기 때문에 빼버림
	// 검색 쿼리 생성에 애매함(자바스크립트로 원래 거름)
	String[] removeKeywordCharAry = { "|", ",", "'" };
	for(int i=0; i<removeKeywordCharAry.length; i++) {
		strKeyword = strKeyword.replace(removeKeywordCharAry[i], " ");
		strInKeyword = strInKeyword.replace(removeKeywordCharAry[i], " ");
	}	

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
	
	// Custom 핵심속성 순서지정 기준카테고리
	String strCustomOrderedCate = "";
	if(strFrom.equals("list")) {
		Spec_Group_Proc spec_group_proc = new Spec_Group_Proc();
		strCustomOrderedCate = spec_group_proc.getOrderedCate(strCate, devFlag);
	}
	
	// 그룹모델 수동추가
	Wide_List_Proc wide_list_proc = new Wide_List_Proc();
	String strEtcCate = wide_list_proc.getGroupModelManual(strCate, devFlag);
	if(strEtcCate.length()==6) {
		strEtcCate = strEtcCate + "*";
	}
	
	/** ES Search */
	/** // ES Search */
	
	Map<String, Object> retMap = new JsonMap<String, Object>();
	DecimalFormat formatter = new DecimalFormat("###,###");
	
	// 스마트파인더 사용목적 순서저장 문자열
	List<JSONObject> specOrderList = new ArrayList<JSONObject>();
	JSONObject tmpOrderList = new JSONObject();
	
	// 스펙 스마트파인더 아이콘 이미지 여부 저장소 
	Set<String> specImageSet = new HashSet<String>();
	
	// 스펙 스마트파인더 아이콘 이미지 여부 저장소
	Set<String> specHighlightSet = new HashSet<String>();
	
	// 스펙을 제외한 on/off 여부
	// brand, true/false
	// factory, true/false
	// discount, true/false
	// price, true/false
	Map<String, Boolean> offSpecDataMap = new JsonMap<String, Boolean>();
	
	if(strFrom.equals("list")) {
		offSpecDataMap = wide_list_proc.getSpecUseList(strCate, strIsTest);
	}
%><%@ include file="/wide/include/IncEsSearchSpec.jsp"%><%
	// LP, SRP 공통
	// 제조사
	List<JSONObject> attrFactoryList = new ArrayList<JSONObject>();
	if(spec_factory_data!=null) {
		for(int gfd=0; gfd<spec_factory_data.length; gfd++) {
			if(!spec_factory_data[gfd].getFactory().trim().equals("[추가]") && !spec_factory_data[gfd].getFactory().trim().equals("[불명]")) {
				JSONObject tmpFactoryObject = new JSONObject();
				
				tmpFactoryObject.put("code", spec_factory_data[gfd].getFactory_etc());
				tmpFactoryObject.put("name", spec_factory_data[gfd].getFactory().trim());
				tmpFactoryObject.put("cnt", spec_factory_data[gfd].getPopular());
				attrFactoryList.add(tmpFactoryObject);
			}
		}
	}
	retMap.put("factory", attrFactoryList);
	
	// 브랜드
	List<JSONObject> attrBrandList = new ArrayList<JSONObject>();
	
	// LP 추천브랜드
	JSONArray reqBrandLPArray = new JSONArray();
	
	if(strFrom.equals("list")) {
		try {
			LP_ReqBrand_Json raq_brand_json = new LP_ReqBrand_Json();
			reqBrandLPArray = raq_brand_json.parseJson(strCate);
			if(reqBrandLPArray.size()>0) {
				retMap.put("reqBrandLP", reqBrandLPArray);
			}
		} catch(Exception e) {
			System.out.println("[listSpec reqBrandLP Json Error] : " + e.getLocalizedMessage());
		}
	}
	
	if(spec_brand_data!=null) {
		for(int bi=0; bi<spec_brand_data.length; bi++) {
			if(!spec_brand_data[bi].getFactory().trim().equals("기타") && !spec_brand_data[bi].getFactory().trim().equals("[불명]")) {
				JSONObject tmpBrandObject = new JSONObject();
				tmpBrandObject.put("code", spec_brand_data[bi].getFactory_etc());
				tmpBrandObject.put("name", spec_brand_data[bi].getFactory().trim());
				tmpBrandObject.put("cnt", spec_brand_data[bi].getPopular());
				attrBrandList.add(tmpBrandObject);
			}
		}
	}
	retMap.put("brand", attrBrandList);
	
	// 쇼핑몰
	List<JSONObject> attrShopList = new ArrayList<JSONObject>();
	if(spec_shop_data!=null) {
		for(int ss=0; ss<spec_shop_data.length; ss++) {
			JSONObject tmpObject = new JSONObject();
			tmpObject.put("shop_code", spec_shop_data[ss].getFactory_etc()); // 쇼핑몰 코드
			tmpObject.put("shop_name", spec_shop_data[ss].getFactory()); // 쇼핑몰 이름
			attrShopList.add(tmpObject);
		}
	}
	retMap.put("shop", attrShopList);
	
	// 가격대
	if(strDevice.equals("all") || strDevice.equals("pc")) {
		
		if((strFrom.equals("list") && offSpecDataMap.containsKey("price") && offSpecDataMap.get("price")) || strFrom.equals("search")) {
			
			List<Long> attrPriceList3 = new ArrayList<Long>(); // 전체상품
			
			// spec_price_data1 - 가격비교 / spec_price_data2 - 일반상품 ( 미사용 )
			
			// priceSet. - 전체상품
			if(spec_price_data3!=null) {
				for(int i=0;i<spec_price_data3.length;i++) {
					attrPriceList3.add(spec_price_data3[i]);
				}
				//Collections.sort(attrPriceList3);
				retMap.put("price_all", attrPriceList3);
				// 가격 평균가 ( hit 표기위함 ) - 일반상품
				if(spec_model_avg_price3!=null) {
					retMap.put("model_avg_price_all", "\""+spec_model_avg_price3+"\"");
				}
			}
		}
	}
	
	// 가격대 범위 
	if(priceHistogram!=null) {
		retMap.put("price_historgram", priceHistogram); // 오타 앱 강제 업데이트 시 삭제
		retMap.put("price_histogram", priceHistogram);
	}
	
	// 스펙 검색
	List<JSONObject> attrSpecList = new ArrayList<JSONObject>();
	if(goods_spec_data!=null && goods_spec_data.size()>0) {
		
		boolean bAllDel = true;
		for(int i=0; i<goods_spec_data.size(); i++) {
			JSONObject tmpObject = (JSONObject) goods_spec_data.get(i);
			String StrSpecGroupDelFlag = tmpObject.containsKey("spec_group_delflag") ? (String) tmpObject.get("spec_group_delflag") : "";
			if(!StrSpecGroupDelFlag.equals("9")){
				bAllDel = false;
			}
		}
		if (bAllDel){
			return;
		}
		
		JSONObject tmpJson = new JSONObject();
		List<JSONObject> tmpMenuArray = new ArrayList<JSONObject>();
		JSONObject tmpMenuJson = new JSONObject();
		
		String strPreGroupName = "";
		int itemCnt = 0;
		int intOldGpNo = 0;
		String strImgViewYN = "N";
		String strTextHighlightYN  = "N";
		String strAllViewYN = "N";
		String strImageIconYN  = "N";
		String strSaveImageViewDcd = "0";
		
		for(int i=0; i<goods_spec_data.size(); i++) {
			
			JSONObject tmpObject = (JSONObject) goods_spec_data.get(i);
			
			boolean IsItemTitle = false;
			String strSpecNo = "0";
			if(custom_spec) {
				strSpecNo = tmpObject.containsKey("spec_group_specno") ? (String) tmpObject.get("spec_group_specno") : "0";
			} else {
				int intSpecNo = tmpObject.containsKey("spec_group_specno") ? (Integer) tmpObject.get("spec_group_specno") : 0;
				strSpecNo = String.valueOf(intSpecNo);
			}
			int intGpno = tmpObject.containsKey("gpno") ? (Integer) tmpObject.get("gpno") : 0;
			int intGpsno = tmpObject.containsKey("gpsno") ? (Integer) tmpObject.get("gpsno") : 0;
			String strGpNoAoflag = tmpObject.containsKey("spec_cate_aoflag") ? (String) tmpObject.get("spec_cate_aoflag") : "";
			String StrSpecGroupDelFlag = tmpObject.containsKey("spec_cate_delflag") ? (String) tmpObject.get("spec_cate_delflag") : "";
			String strGpsNoAoflag = tmpObject.containsKey("spec_catedetail_aoflag") ? (String) tmpObject.get("spec_catedetail_aoflag") : "";
			String strSpecCateTitle = tmpObject.containsKey("spec_cate_title") ? (String) tmpObject.get("spec_cate_title") : "";
			String strSpecGroupName = tmpObject.containsKey("group_name") ? (String) tmpObject.get("group_name") : "";
			String strSpecGroupTitle = tmpObject.containsKey("spec_group_title") ? (String) tmpObject.get("spec_group_title") : "";
			strSpecGroupTitle = strSpecGroupTitle.replace("\r\n", "");
			
			int intKbNo = tmpObject.containsKey("kb_no") ? (Integer) tmpObject.get("kb_no") : 0;
			int intCateKbNo = tmpObject.containsKey("cate_kb_no") ? (Integer) tmpObject.get("cate_kb_no") : 0;
			String strIconType = tmpObject.containsKey("icon_type") ? (String) tmpObject.get("icon_type") : "";
			String strGIconType = tmpObject.containsKey("g_icon_type") ? (String) tmpObject.get("g_icon_type") : "";
			
			String strImageViewDcd = tmpObject.containsKey("img_view_dcd") ? (String) tmpObject.get("img_view_dcd") : "0";
			
			if(strImageViewDcd.equals("1")) {
				strImageIconYN  = "Y";
				strTextHighlightYN  = "N";
			} else if(strImageViewDcd.equals("2")) {
				strImageIconYN  = "N";
				strTextHighlightYN  = "Y";
			} else {
				strImageIconYN  = "N";
				strTextHighlightYN  = "N";
			}
			
			// strSpecGroupTitle=blank 는 무시
			// StrSpecGroupDelFlag=9 는 하위 분류
			// json은 각 그룹별로 출력하되 하위 분류의 제목만 구분을 함
			if(strSpecGroupTitle.equals("blank")) continue;

			if(StrSpecGroupDelFlag.equals("9")) IsItemTitle = true;
			
			// 새로운 분류 시작
			if(itemCnt>0) {
				tmpJson.put("specMenuList", tmpMenuArray);
				if(i>0 && (!strPreGroupName.equals(strSpecCateTitle) || IsItemTitle)) {
					tmpMenuArray = new ArrayList<JSONObject>();
					tmpJson.put("strAllViewYN", strAllViewYN);
					strAllViewYN = "N";
				
					if(strSaveImageViewDcd.equals("2")) { // 텍스트 강조형
						tmpJson.put("strTextHighlightYN", "Y");
						tmpJson.put("strImgViewYN", "N");
					} else if(strSaveImageViewDcd.equals("1")) { // 아이콘 노출형
						tmpJson.put("strTextHighlightYN", "N");
						tmpJson.put("strImgViewYN", "Y");
					} else { // 일반 텍스트형
						tmpJson.put("strTextHighlightYN", "N");
						tmpJson.put("strImgViewYN", "N");
					}
					
					// 다른 리스트 시작
					attrSpecList.add(tmpJson);
					tmpJson = new JSONObject();
					strImgViewYN = "N";
					strTextHighlightYN = "N";
				}
			}
			

			if(!strPreGroupName.equals(strSpecCateTitle) || IsItemTitle) {
				String showSpecCateTitle = toJS2(strSpecCateTitle);
				String strSubTitle = "";
				
				if(IsItemTitle) {
					strSubTitle = toJS2(strSpecGroupTitle);
				}

				tmpJson.put("strSpecCateTitle", showSpecCateTitle);
				tmpJson.put("strSubTitle", strSubTitle);
				tmpJson.put("strCateKbNo", String.valueOf(intCateKbNo) );
				tmpJson.put("strGpno", String.valueOf(intGpno) );
				tmpJson.put("strGIconType", strGIconType);
				
				// 전체 포함 여부 20210913 임시
				if(intGpno==1826) {
					strAllViewYN = "Y";
				}
				
				itemCnt = 0;
			}

			strPreGroupName = strSpecCateTitle;

			if(IsItemTitle) {
				continue;
			} else {
				tmpMenuJson = new JSONObject();
				if(IsItemTitle) {
					tmpMenuJson.put("strIsItemTitleYN", "Y");
				} else {
					tmpMenuJson.put("strIsItemTitleYN", "N");
				}
				
				tmpMenuJson.put("strSpecNo", strSpecNo);
				tmpMenuJson.put("strGpsno", String.valueOf(intGpsno));
				tmpMenuJson.put("strSpecno", String.valueOf(intGpsno));
				tmpMenuJson.put("strKbNo", String.valueOf(intKbNo));
				tmpMenuJson.put("strGpNoAoflag", strGpNoAoflag);
				tmpMenuJson.put("StrSpecGroupDelFlag", StrSpecGroupDelFlag);
				tmpMenuJson.put("strGpsNoAoflag", strGpsNoAoflag);
				tmpMenuJson.put("strGroupName", strSpecGroupName);
				tmpMenuJson.put("strSpecGroupTitle", strSpecGroupTitle);
				tmpMenuJson.put("strIconType", strIconType);
				
				if(strImageIconYN.equals("Y")) {
					if(strDevice.equals("aos") || strDevice.equals("ios")) {
						tmpMenuJson.put("strIconImage_on","http://img.enuri.info/images/finder/icon/icon_"+strSpecNo+"_on.png");
						tmpMenuJson.put("strIconImage_off","http://img.enuri.info/images/finder/icon/icon_"+strSpecNo+"_off.png");
					} else {
						tmpMenuJson.put("strIconImage_on","http://img.enuri.info/images/finder/icon/icon_"+strSpecNo+"_on.svg");
						tmpMenuJson.put("strIconImage_off","http://img.enuri.info/images/finder/icon/icon_"+strSpecNo+"_off.svg");
					}
					strImgViewYN = "Y";
					specImageSet.add(String.valueOf(intGpno)); // 아이콘노출 시 노출
				} else {
					tmpMenuJson.put("strIconImage_on","");
					tmpMenuJson.put("strIconImage_off","");
				}
				
				if(strTextHighlightYN.equals("Y")) {
					specHighlightSet.add(String.valueOf(intGpno));
				}
				
				tmpMenuArray.add(tmpMenuJson);
			}
			itemCnt++;
			strSaveImageViewDcd = strImageViewDcd;
		}
	
		tmpJson.put("specMenuList", tmpMenuArray);
		if(strSaveImageViewDcd.equals("2")) { // 텍스트 강조형
			tmpJson.put("strTextHighlightYN", "Y");
			tmpJson.put("strImgViewYN", "N");
		} else if(strSaveImageViewDcd.equals("1")) { // 아이콘 노출형
			tmpJson.put("strTextHighlightYN", "N");
			tmpJson.put("strImgViewYN", "Y");
		} else { // 일반 텍스트형
			tmpJson.put("strTextHighlightYN", "N");
			tmpJson.put("strImgViewYN", "N");
		}
		
		tmpJson.put("strAllViewYN", strAllViewYN);
		attrSpecList.add(tmpJson);
	}
	retMap.put("custom", attrSpecList);
//	retMap.put("custom_origin", goods_spec_data);
	retMap.put("custom_fromcate", "\""+spec_cate+"\"");
	
	// 원분류/추가분류 구분
	if(custom_spec) {
		retMap.put("strAppendedCateYN", "\"Y\"");
	} else {
		retMap.put("strAppendedCateYN", "\"N\"");
	}
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	if(strFrom.equals("list")) {
		
		// 추천키워드
		if(offSpecDataMap.containsKey("reqkeyword") && offSpecDataMap.get("reqkeyword")) {
			try {
				RecKeyword_Proc recKeyword_Proc = new RecKeyword_Proc();
				RecKeyword_Data[] reckeyword_data = recKeyword_Proc.RecKeyword_List(strCate);
	
				List<JSONObject> attrReqKwdList = new ArrayList<JSONObject>();
				
				if(reckeyword_data!=null && reckeyword_data.length>0) {
					
					for(int i=0; i<reckeyword_data.length; i++) {
						if(reckeyword_data[i].getCa_title()!=null && reckeyword_data[i].getCa_title().length()>0) {
							JSONObject tmpReqKwdObject = new JSONObject();
							String strCaTitle = reckeyword_data[i].getCa_title();
							tmpReqKwdObject.put("code", strCaTitle);
							tmpReqKwdObject.put("name", strCaTitle);
							attrReqKwdList.add(tmpReqKwdObject); 
						}
					}
				}
				
				retMap.put("reqKwd", attrReqKwdList);
			} catch(Exception e) {
			}
		}
		
		// 카테고리 소카, 미카 리스트
		Map<String, Object> categoryDataMap = new JsonMap<String, Object>();
		String strCateNm = new String();
		List<JSONObject> categoryDataDepth3 = new ArrayList<JSONObject>();
		List<JSONObject> categoryDataDepth4 = new ArrayList<JSONObject>();
		// categoryDataDepth4Map < 소카테고리번호, 미카테고리데이터 리스트 >
		JsonMap<String,ArrayList<JSONObject>> categoryDataDepth4Map = new JsonMap<String,ArrayList<JSONObject>>();
		List<JsonMap<String, Object>> categoryDataDepth3Union = new ArrayList<JsonMap<String, Object>>();
		
		// 앱 4.1.0 하위 버전
		if((strDevice.equals("aos") || strDevice.equals("ios")) && intAppVersion <= 410) {
			if(strCate.length() >= 4){ 
				strCateNm = lp_header_proc.getCategoryList_AttributeDepth2(strCate);
				categoryDataDepth3 = lp_header_proc.getCategoryList_AttributeDepth3(strCate);
				categoryDataDepth4Map = lp_header_proc.getCategoryList_AttributeDepth4(strCate.substring(0, 4));
			}
			// 미카테 child 정보를 매핑
			for(int i=0; i<categoryDataDepth3.size(); i++) {
				JSONObject tmpCateObject = (JSONObject) categoryDataDepth3.get(i);
				String tmpCateCode = (String) tmpCateObject.get("code");;
				JsonMap<String, Object> tmpUnionMap = new JsonMap<String, Object>();
				tmpUnionMap.put("data", tmpCateObject);
				if(tmpCateCode.length()>0 && categoryDataDepth4Map.containsKey(tmpCateCode)) {
					tmpUnionMap.put("child", (ArrayList) categoryDataDepth4Map.get(tmpCateCode) );
					if(strCate.length()>=6 && tmpCateCode.equals(strCate.substring(0, 6))) {
						categoryDataDepth4 = (ArrayList) categoryDataDepth4Map.get(tmpCateCode);
					}
				}
				categoryDataDepth3Union.add(tmpUnionMap);
				
				
			}
			
			// 앱에서 활성화된 카테고리 이름 추가
			String strAppCateName = "";
			try {
				strAppCateName = lp_header_proc.activeAppCateName(strCate);
				categoryDataMap.put("appCateName", "\""+strAppCateName+"\"");
			} catch(Exception e) {
				categoryDataMap.put("appCateName", "\""+strAppCateName+"\"");
			}
			categoryDataMap.put("depth_3", categoryDataDepth3Union);
			categoryDataMap.put("depth_4", categoryDataDepth4);
		
		// 통합카테고리
		} else {
			
			if(strCate.length() >= 4){ 
				
				// 카테고리 정보
				JSONObject cateInfoObj = lp_header_proc.getUnionCate_info(strCate, strDevice, devFlag);
				String strAppCateName = cateInfoObj.containsKey("cate_nm") ? (String) cateInfoObj.get("cate_nm") : "";
				// 현재 카테고리 GNB 번호
				String strCurGnbNo = cateInfoObj.containsKey("gnb_no") ? (String) cateInfoObj.get("gnb_no") : "";
				String strCurHgGnbNo = cateInfoObj.containsKey("hg_gnb_no") ? (String) cateInfoObj.get("hg_gnb_no") : "";
				categoryDataMap.put("appCateName", "\""+strAppCateName+"\"");
				
				// 중카테 정보
				JSONObject cate4InfoObj = lp_header_proc.getUnionCate_info(strCate.substring(0, 4), strDevice, devFlag);
				if(!cate4InfoObj.isEmpty()) {
					strCateNm = cate4InfoObj.containsKey("cate_nm") ? (String) cate4InfoObj.get("cate_nm") : "";
					String strCateGnbNo = cate4InfoObj.containsKey("gnb_no") ? (String) cate4InfoObj.get("gnb_no") : "";
					if(strCateGnbNo.length()>0) {
						List<JSONObject> gnbCateData = lp_header_proc.getUnionCate_gnbData(strCateGnbNo, strDevice, devFlag);
						String strPrepareLevel = ""; // 카테고리 레벨 비교 연산자
						ArrayList<JSONObject> depth4List = new ArrayList<JSONObject>();
						String tmpHgGnbNo = ""; // depth4 Map에 Key로 사용
						
						for(JSONObject gnbCateDataObj : gnbCateData) {
							
							// 첫번재 카테고리 레벨 정보들은 categoryDataDepth3에 세팅하고 두번째 카테고리 레벨 정보들은 categoryDataDepth4Map 에 세팅 한다.
							String strGnbCateLevel = gnbCateDataObj.containsKey("cate_level") ? (String) gnbCateDataObj.get("cate_level") : "";
							String strGnbCateCode = gnbCateDataObj.containsKey("cate_cd") ? (String) gnbCateDataObj.get("cate_cd") : "";
							if(strGnbCateCode.equals("empty")) {
								strGnbCateCode = "";
							}
							String strGnbCateNm = gnbCateDataObj.containsKey("cate_nm") ? (String) gnbCateDataObj.get("cate_nm") : "";
							if(strGnbCateNm.equals("empty")) {
								strGnbCateNm = "";
							}
							String strGnbNo = gnbCateDataObj.containsKey("gnb_no") ? (String) gnbCateDataObj.get("gnb_no") : "";
							String strHgGnbNo = gnbCateDataObj.containsKey("hg_gnb_no") ? (String) gnbCateDataObj.get("hg_gnb_no") : "";
							String strGnbLink = gnbCateDataObj.containsKey("lnk") ? (String) gnbCateDataObj.get("lnk") : "";
							if(strGnbLink.equals("empty")) {
								strGnbLink = "";
							}
							if(strGnbLink.length()>0 && (strDevice.equals("mw") || strDevice.equals("aos") || strDevice.equals("ios")) && strGnbLink.indexOf("list.jsp")>-1 && strGnbLink.indexOf("enuri.com")==-1) {
								strGnbLink = "/m" + strGnbLink;
							}
							
							if(strPrepareLevel.equals("") && strGnbCateLevel.length()>0) { // 초기값 세팅
								strPrepareLevel = strGnbCateLevel;
							}
							
							// 필수조건들이 만족하는 경우에만 데이터 등록
							if(strGnbCateNm.length()>0 && (strGnbCateCode.length()>0 || strGnbLink.length()>0)) {
								
								// 3Depth
								JsonMap<String, Object> depth3Map = new JsonMap<String, Object>();
								if(strPrepareLevel.length()>0 && strPrepareLevel.equals(strGnbCateLevel)) {
									
									JSONObject depth3Obj = new JSONObject();
									depth3Obj.put("code", strGnbCateCode);
									depth3Obj.put("name", strGnbCateNm);
									depth3Obj.put("linkUrl", strGnbLink);
									depth3Obj.put("gnbNo", strGnbNo); // child 매핑용 
									categoryDataDepth3.add(depth3Obj);
									
									
								// 4Depth
								} else {
									
									if(!tmpHgGnbNo.equals(strHgGnbNo)) {
										if(depth4List.size()>0) {
											categoryDataDepth4Map.put(tmpHgGnbNo, depth4List);
											depth4List = new ArrayList<JSONObject>();
										}
										tmpHgGnbNo = strHgGnbNo;
									}
									
									JSONObject depth4Obj = new JSONObject();
									depth4Obj.put("code", strGnbCateCode);
									depth4Obj.put("name", strGnbCateNm);
									depth4Obj.put("linkUrl", strGnbLink);
									depth4Obj.put("gnbNo", strGnbNo);
									depth4List.add(depth4Obj);
									
								}
								
							}
						}
						
						if(depth4List.size()>0) {
							categoryDataDepth4Map.put(tmpHgGnbNo, depth4List);
						}
						
						// categoryDataDepth3 를 순회하여 하위정보들을 categoryDataDepth4Map 에서 찾아서 child 로 매핑시킨다.
						for(JSONObject depth3Obj : categoryDataDepth3) {
							JsonMap<String, Object> tmpUnionMap = new JsonMap<String, Object>();
							String parseGNBNo = depth3Obj.containsKey("gnbNo") ? (String) depth3Obj.get("gnbNo") : "";
							if(categoryDataDepth4Map.containsKey(parseGNBNo)) {
								tmpUnionMap.put("child", (ArrayList) categoryDataDepth4Map.get(parseGNBNo));
							}
							tmpUnionMap.put("data", depth3Obj);
							categoryDataDepth3Union.add(tmpUnionMap);
							
						}
						
						retMap.put("cur_gnb",  "\""+strCurGnbNo+"\"");
						retMap.put("cur_gnb_hg",  "\""+strCurHgGnbNo+"\"");
						retMap.put("categoryDataDepth4Map", categoryDataDepth4Map);
						
						if(strCate.length() >= 6 && (categoryDataDepth4Map.containsKey(strCurGnbNo) || categoryDataDepth4Map.containsKey(strCurHgGnbNo))) {
							if(categoryDataDepth4Map.containsKey(strCurGnbNo)) {
								categoryDataDepth4 = (ArrayList) categoryDataDepth4Map.get(strCurGnbNo);
							} else if(categoryDataDepth4Map.containsKey(strCurHgGnbNo)) {
								categoryDataDepth4 = (ArrayList) categoryDataDepth4Map.get(strCurHgGnbNo);
							}
						}
						
						categoryDataMap.put("depth_3", categoryDataDepth3Union);
						categoryDataMap.put("depth_4", categoryDataDepth4);
					}
				}
			}
		}
		
		categoryDataMap.put("mCateName", "\""+strCateNm+"\"");
		retMap.put("category", categoryDataMap);
		
		// 미분류 레이어 앱 410 버전 전까지만 사용
		if((strDevice.equals("aos") || strDevice.equals("ios")) && intAppVersion <= 410 && (strCate6.equals("163630") || strCate6.equals("040207"))) {
			JSONArray cateLayerArray = new JSONArray();
			try {
				if(strCate6.length()>0) {
					cateLayerArray = wide_list_proc.categoryLayer(strCate6);
				} else if(strCate4.length()>0) {
					cateLayerArray = wide_list_proc.categoryLayer(strCate4);
				}
				retMap.put("category_layer", cateLayerArray);
			} catch(Exception e) {
				retMap.put("category_layer", cateLayerArray);
			}
		}
	} else if(strFrom.equals("search")) {
		
		//추천 카테고리
		Category_Data[] arrayMiddelCategoryDatas = null;
		ArrayList arrayCategoryMiddleList = new ArrayList();
		String strRAMargin = "";
	
		if(resultCategoryMiddle!=null) {
			for(int ri=0; ri<resultCategoryMiddle.length; ri++) {
				if(!resultCategoryMiddleName[ri].equals("기타 일반상품")) {
					Category_Data arrayMiddelCategoryData = new Category_Data();
					arrayMiddelCategoryData.setCa_code(resultCategoryMiddle[ri][0]);
					arrayMiddelCategoryData.setC_seqno(Integer.parseInt(resultCategoryMiddle[ri][1]));
					
					// #46155 SRP > 추천카테고리 > 중카테고리명 예외처리 2건
					if(resultCategoryMiddle[ri][0].equals("2109") || resultCategoryMiddle[ri][0].equals("1001")) {
						
						if(resultCategoryMiddle[ri][0].equals("2109")) {
							arrayMiddelCategoryData.setC_name(resultCategoryMiddleName[ri].replace("공기청정기", "차량 공기청정"));
						}
						if(resultCategoryMiddle[ri][0].equals("1001")) {
							arrayMiddelCategoryData.setC_name(resultCategoryMiddleName[ri].replace("신발", "유아동 신발"));
						}
					} else {
						arrayMiddelCategoryData.setC_name(resultCategoryMiddleName[ri]);
					}
					arrayCategoryMiddleList.add(arrayMiddelCategoryData);
				}
			}
			
			retMap.put("reqCateCount", resultCategoryMiddle.length);
		}
		arrayMiddelCategoryDatas = (Category_Data[])arrayCategoryMiddleList.toArray(new Category_Data[0]);
		Arrays.sort(arrayMiddelCategoryDatas,new Category_Middle_Comparator());
	
		List<JSONObject> srpTopCateListJSON = new ArrayList<JSONObject>();
		List<Object> srpGroupListJSON = new ArrayList<Object>();
		
		for(int ri=0; ri<(arrayCategoryMiddleList.size()>=5 ? 5 : arrayCategoryMiddleList.size()); ri++){
			JSONObject tmpTopCateObj = new JSONObject();
			tmpTopCateObj.put("cate", arrayMiddelCategoryDatas[ri].getCa_code());
			tmpTopCateObj.put("name", arrayMiddelCategoryDatas[ri].getC_name());
			tmpTopCateObj.put("cnt", arrayMiddelCategoryDatas[ri].getC_seqno());
			srpTopCateListJSON.add(tmpTopCateObj);
		}
	
		retMap.put("reqCateBest", srpTopCateListJSON);

		if(resultCategoryLarge!=null) {
			for(int li=0; li<resultCategoryLarge.length; li++) {
				
				String strCateLName = resultCategoryLargeName[li];
				
				int intCateLiCnt = 0;
				for(int mi=0; mi<resultCategoryMiddle.length; mi++) {
					if(CutStr.cutStr(resultCategoryMiddle[mi][0],2).equals(resultCategoryLarge[li][0])) {
						intCateLiCnt++;
					}
				}			
				if(intCateLiCnt>0) {
					
					JSONObject tmpObject = new JSONObject();
					List<JSONObject> tmpList = new ArrayList<JSONObject>();
					tmpObject.put("name", strCateLName);
					
					intCateLiCnt = 0;
					for(int mi=0; mi<resultCategoryMiddle.length; mi++) {
						if(CutStr.cutStr(resultCategoryMiddle[mi][0],2).equals(resultCategoryLarge[li][0])) {
							String strCateMName = resultCategoryMiddleName[mi];
						
							if(!resultCategoryMiddleName[mi].equals("기타 일반상품") || (resultCategoryMiddleName[mi].equals("기타 일반상품") && resultCategoryMiddle[mi][0].substring(2,4).equals("99"))) {
								
								JSONObject tmpList_data = new JSONObject();
								tmpList_data.put("cate", resultCategoryMiddle[mi][0]);
								tmpList_data.put("name", strCateMName);
								tmpList_data.put("cnt", resultCategoryMiddle[mi][1]);
								
								tmpList.add(tmpList_data);
								intCateLiCnt++;
							}
						}
					}
					tmpObject.put("cateList", tmpList);
					srpGroupListJSON.add(tmpObject);
				}
			}
		}
		
		retMap.put("reqCateList", srpGroupListJSON);

		// 추천카테고리 선택 시
		// 집계 기준이 다르기때문에 getSearchCateList_ajax.jsp 를 사용함. ( 기존 코드 )
		if(strCate.length()>=4) {
			
			try {
				String strReqCateUrl = "http://localhost/lsv2016/ajax/getSearchCateList_ajax.jsp?procType=1&cate="+strCate+"&cateLimitedNum=4&keyword="+URLEncoder.encode(strKeyword, "utf-8")+"&searchkind="+tabSearchKindType+"&isMakeShop="+strIsMakeShop;
				
				URL targetURL = new URL(strReqCateUrl);
				HttpURLConnection httpConn = (HttpURLConnection) targetURL.openConnection();
				
				httpConn.setConnectTimeout(3000);
				httpConn.setReadTimeout(3000);
				httpConn.setDoOutput(true);
				httpConn.setUseCaches(false);
				httpConn.setRequestMethod("GET");
				httpConn.setRequestProperty("Content-Type", "application/json");
				httpConn.setRequestProperty("Accept-Charset", "UTF-8");
			
				int responseCode = httpConn.getResponseCode();
				JSONObject cateObject = new JSONObject();
				if(responseCode == 200) {
					BufferedReader in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "UTF-8"));
					String inputLine;
					StringBuffer inputBuffer = new StringBuffer();
					while ((inputLine = in.readLine()) != null) { 
						inputBuffer.append(inputLine); 
					} 
					in.close();
				
					JSONParser jsonParser = new JSONParser();
					JSONObject jsonObjectOri = (JSONObject) jsonParser.parse(inputBuffer.toString());
					JSONArray retArray = new JSONArray();
					JSONObject retObj = new JSONObject();
					 
					if(jsonObjectOri.size()>0) {
						
						if(jsonObjectOri.containsKey("sCateList")) {
							cateObject = (JSONObject) jsonObjectOri;
						}
					}
				}
				retMap.put("reqCateSelList", cateObject);
			} catch(Exception e) {
			}
		}
		
		// 추천브랜드 ( ex : 스피커 )
		if(strKeyword.length()>0) {
			
			try {
				
				// 관리형 키워드는 무조건 소문자로 검색하도록 수정
				String keywordLower = strKeyword.toLowerCase();
				
				// 키워드를 입력받아 브랜드 가져오기
				Goods_Search_Lsv_Proc goods_Search_Lsv_Proc = new Goods_Search_Lsv_Proc();
				Goods_Search_Lsv_Data[] brand_data = goods_Search_Lsv_Proc.getKeywordToRecBrand(keywordLower);
				JSONArray brandArray = new JSONArray();
				
				if(brand_data!=null && brand_data.length>0) {
					
					for(int i=0; i<brand_data.length; i++) {
						
						int brand_id = brand_data[i].getBrand_id();
						String brand_flag = brand_data[i].getBrand_flag();
						String brand_nm = brand_data[i].getBrand_nm();
						String brand_img = brand_data[i].getBrand_img();
						
						JSONObject tmpBrandObject = new JSONObject();
						
						tmpBrandObject.put("brand_id", brand_id);
						tmpBrandObject.put("brand_flag", brand_flag);
						tmpBrandObject.put("brand_nm", brand_nm);
						tmpBrandObject.put("brand_img", brand_img);
						
						brandArray.add(tmpBrandObject);
					}
				}
				retMap.put("reqBrandList", brandArray);
			} catch(Exception e) {
			}
		}
		
		// SRP 카테고리 A/B 타입
		if(!strDevice.equals("pc") && ( (strFrom.equals("list") && strInKeyword.length()>0) || (strFrom.equals("search") && strKeyword.length()>0) ) ) {
			
			try {
				String strABCateUrl = "http://localhost/lsv2016/ajax/getCateListSearchType_ajax.jsp?keyword="+URLEncoder.encode(strKeyword, "utf-8")+"&isMakeShop="+strIsMakeShop;
				
				if(strFrom.equals("list")) {
					strABCateUrl = "http://localhost/lsv2016/ajax/getCateListSearchType_ajax.jsp?keyword="+URLEncoder.encode(strInKeyword, "utf-8")+"&isMakeShop="+strIsMakeShop;
				}
				
				URL targetURL = new URL(strABCateUrl);
				HttpURLConnection httpConn = (HttpURLConnection) targetURL.openConnection();
				
				httpConn.setConnectTimeout(3000);
				httpConn.setReadTimeout(3000);
				httpConn.setDoOutput(true);
				httpConn.setUseCaches(false);
				httpConn.setRequestMethod("GET");
				httpConn.setRequestProperty("Content-Type", "application/json");
				httpConn.setRequestProperty("Accept-Charset", "UTF-8");
			
				int responseCode = httpConn.getResponseCode();
				JSONObject cateObject = new JSONObject();
				if(responseCode == 200) {
					BufferedReader in = new BufferedReader(new InputStreamReader(httpConn.getInputStream(), "UTF-8"));
					String inputLine;
					StringBuffer inputBuffer = new StringBuffer();
					while ((inputLine = in.readLine()) != null) { 
						inputBuffer.append(inputLine); 
					} 
					in.close();
				
					JSONParser jsonParser = new JSONParser();
					JSONObject jsonObjectOri = (JSONObject) jsonParser.parse(inputBuffer.toString());
					JSONArray retArray = new JSONArray();
					JSONObject retObj = new JSONObject();
					
					if(jsonObjectOri.size()>0) {
						
						if(jsonObjectOri.containsKey("mCateList") && jsonObjectOri.containsKey("keywordInfo")) {
							cateObject = (JSONObject) jsonObjectOri;
						}
					}
				}
				retMap.put("abCateList", cateObject);
			} catch(Exception e) {
			}
		}
	}
	
	// 출시예정 상품 갯수
	String strOpenExpectYN = "N";
	if(intOpenexpectCnt>0) {
		strOpenExpectYN = "Y";
	}
	retMap.put("strOpenExpectYN", "\""+strOpenExpectYN+"\"");
	
	// 할인율
	if(strFrom.equals("list")) {
		List<JSONObject> discountArray = new ArrayList<JSONObject>();
		if(offSpecDataMap.containsKey("discount") && offSpecDataMap.get("discount")) {
			if(goods_discount_rate_data!=null && goods_discount_rate_data.size()>0) {
				for(int i=0; i<goods_discount_rate_data.size(); i++) {
					JSONObject tmpObject = (JSONObject) goods_discount_rate_data.get(i);
					JSONObject discountObj = new JSONObject();
					discountObj.put("code", (String) tmpObject.get("value"));
					discountObj.put("name", (String) tmpObject.get("name"));
					discountArray.add(discountObj);
				}
			}
		}
		retMap.put("discount", discountArray);
	}
	
	// 평점 ( 하드코딩 )
	List<JSONObject> scoreArray = new ArrayList<JSONObject>();
	if(offSpecDataMap.containsKey("bbsscore") && offSpecDataMap.get("bbsscore") && bbs_point_count>=30) {
		JSONObject scoreObj = new JSONObject();
		scoreObj.put("code", "4");
		scoreObj.put("name", "4점대");
		scoreArray.add(scoreObj);
		
		scoreObj = new JSONObject();
		scoreObj.put("code", "3");
		scoreObj.put("name", "3점대");
		scoreArray.add(scoreObj);
		
		scoreObj = new JSONObject();
		scoreObj.put("code", "2");
		scoreObj.put("name", "2점대");
		scoreArray.add(scoreObj);
		
		scoreObj = new JSONObject();
		scoreObj.put("code", "1");
		scoreObj.put("name", "1점대");
		scoreArray.add(scoreObj);
	}
	retMap.put("bbsscore", scoreArray);
//	retMap.put("bbs_point_count", bbs_point_count);

	//순서저장 문자열
	if(strFrom.equals("list")) {
		try {
			List<JSONObject> orderJSONArray = wide_list_proc.getSpecOrderList(strCate, strIsTest);
			for(int i=0;i<orderJSONArray.size();i++) {
				JSONObject orderTmpObject = (JSONObject) orderJSONArray.get(i);
				if(orderTmpObject.containsKey("type")) {
					String orderType = (String) orderTmpObject.get("type");
					
					switch(orderType) {
						// 브랜드
						case "BRAND" :
							if(reqBrandLPArray.size()>0) {
								if(i==0) {
									orderTmpObject.put("type", "REQBRAND");
								}
								orderTmpObject.put("imageYN", "Y");
							} else {
								orderTmpObject.put("imageYN", "N");
							}
							orderTmpObject.put("highlightYN", "N");
							break;
						// 제조사
						case "FACTORY" :
							orderTmpObject.put("imageYN", "N");
							orderTmpObject.put("highlightYN", "N");
							break;
						// 할인율
						case "DISCOUNT" :
							orderTmpObject.put("imageYN", "N");
							orderTmpObject.put("highlightYN", "N");
							break;
						// 가격대
						case "PRICE" :
							orderTmpObject.put("imageYN", "N");
							orderTmpObject.put("highlightYN", "N");
							break;
						// 추천키워드
						case "REQKEYWORD" :
							orderTmpObject.put("imageYN", "N");
							orderTmpObject.put("highlightYN", "N");
							break;
						// 평점
						case "BBSSCORE" :
							orderTmpObject.put("imageYN", "N");
							orderTmpObject.put("highlightYN", "N");
							break;
						default : // custom
							if(specImageSet.contains(orderType)) {
								orderTmpObject.put("imageYN", "Y");
								orderTmpObject.put("highlightYN", "N");
							} else {
								orderTmpObject.put("imageYN", "N");
								if(specHighlightSet.contains(orderType)) {
									orderTmpObject.put("highlightYN", "Y");
								} else {
									orderTmpObject.put("highlightYN", "N");
								}
							}
							break;
					}
					
					specOrderList.add(orderTmpObject);
				}
			}
			
			
			
		} catch(Exception e) {
			System.out.println ( "error : " + e.getMessage() );
			e.printStackTrace();
		}
	}
	retMap.put("order", specOrderList);
	
 	//속성 펼침 수 
	if(strFrom.equals("list") && strDevice.equals("pc")) {
		JSONArray jarrUnfoldAttr = new JSONArray();
		String strServerNm = request.getServerName();
		jarrUnfoldAttr = lp_header_proc.getUnfoldAttrData(strCate, devFlag);
		retMap.put("unfoldAttr", jarrUnfoldAttr);
	}
	// 중고/렌탈 속성 노출 여부
	retMap.put("strRentalDisplayYN", "\"Y\"");
	
	// 배송비포함 속성 노출 여부
	retMap.put("strDeliveryDisplayYN", "\"Y\"");
	
	// [LP] 최저가 매칭 상품 수
	/*
	if(strFrom.equals("list")) {
		JSONObject lpMinPriceToastObj = wide_list_proc.getLPMinpriceToast(strCate);
		if(lpMinPriceToastObj.isEmpty()) {
			retMap.put("minprice_toast", new JSONObject());
		} else {
			retMap.put("minprice_toast", lpMinPriceToastObj);
		}
	}
	*/
	
	ret = new JsonResponse(true).setData(retMap).setTotal(intTotRsCnt);
	out.print ( ret );
	
%>