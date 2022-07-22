<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ include file="/mobiledepart/include/common.jsp"%>
<%@ page import="com.enuri.api.Pricelist_Api"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.Save_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Save_PriceList_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Proc"%>
<%@ page import="com.enuri.bean.main.depart.Depart_Goods_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Data"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Proc"%>
<%@ page import="com.enuri.bean.mobile.FactoryBrand_Data"%>
<%@ page import="com.enuri.bean.search.ESSearchClient"%>
<%@ page import="org.json.*"%>
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"  />
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="FactoryBrand_Proc" class="com.enuri.bean.mobile.FactoryBrand_Proc" scope="page" />
<%@ include file="/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%
	boolean bAdultKeyword = false;
	String strCate = "";
%>
<%@ include file="/include/IncSponsorGoods_2010.jsp"%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
{
<%
// 데이터의 타입
// 보여줘야할 데이터를 구분해서 필요없는 것을 뺌
// 최근본 찜 목록에서는 모든 데이터가 필요하고 목록이나 메인의 간략 보기에는 단순 정보만 필요
// dataType이 2인 경우 이미지와 상품번호만 노출
int dataType = Integer.parseInt(ChkNull.chkStr(request.getParameter("dataType"), "1"));
int appType = Integer.parseInt(ChkNull.chkStr(request.getParameter("appType"), "1"));

String pageString = ChkNull.chkStr(request.getParameter("pageNum"),"1");
if(pageString.equals("NaN")) pageString = "1"; 

// 페이징 관련 추가
int pageNum = Integer.parseInt(pageString);
int pageGap = Integer.parseInt(ChkNull.chkStr(request.getParameter("pageGap"), "10"));
int totalCnt = 0;
int tempTotalCnt=0;
int allTotalCnt = 0;
int pageStart = (pageNum-1) * pageGap + 1;
int pageEnd = pageStart + pageGap - 1;
int pageMax = 1;

String deviceType = ChkNull.chkStr(request.getParameter("deviceType"), "");
String listTypeStr = ChkNull.chkStr(request.getParameter("listType"), "1");
String folder_idStr = ChkNull.chkStr(request.getParameter("folder_id"), "0");
String strUserId = "";
String adultStr = "";
String deleteAdult = "";
boolean IsAdultFlag = false;
String strServerName = ChkNull.chkStr(request.getServerName(),"");
String strRequestURI = ChkNull.chkStr(request.getRequestURI(),"");

String mailYN = ChkNull.chkStr(request.getParameter("mailYN"), "");
String goodsNumList = ChkNull.chkStr(request.getParameter("goodsNumList"), "");

// 20191104 Cookie resentList 값에 모델번호가 공백인 경우 G:, 형태로 세팅이 되어 해당 경우 방지 //  jinwook
goodsNumList = goodsNumList.replaceAll("G:,", "");
String strMobileAppAdult = ChkNull.chkStr(request.getParameter("mobileAppAdult"), "");

// listType:1 최근본
// listType:2 찜
// listType:9 검색에서 최근본 보기
int listType = 1;
int folder_id = 0;
try {
	listType = Integer.parseInt(listTypeStr);
} catch(Exception e) {}
try {
	folder_id = Integer.parseInt(folder_idStr);
} catch(Exception e) {}

int goodsCnt = 0;
long priceSum = 0;

Save_Goods_Proc save_goods_proc = new Save_Goods_Proc();
Goods_Data[] goods_data = null;
HashMap cardNameHash  = getCardNameHash();

//쇼핑몰 카드 무이자 할부 정보
String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();
String strUserIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
String strUserAgent = ChkNull.chkStr(request.getHeader("User-Agent"));
String strUserDevice = "";

log(request,"requestQueryString", request.getQueryString());

if(listType==1 || (listType!=9 && mailYN.equals("Y"))) { //최근본 상품
	
	if(strMobileAppAdult.equals("Y")){	//앱에서 호출시 Y값이 넘어옴
		IsAdultFlag = true;
	}else if(strMobileAppAdult.equals("N")){
		IsAdultFlag = false;
	}else{
		strUserId = cb.GetCookie("MYINFO","TMP_ID");
	
		if(!strUserId.equals("")){
			IsAdultFlag = false;
			if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
				adultStr = cb.GetCookie("MEM_INFO","ADULT");
				// 성인인증 됨 
				if(adultStr.equals("1")) IsAdultFlag = true;
			}
		}
	}


	String strTodayGoods = goodsNumList;
	
	//strTodayGoods = "M:M255622_1133397,M:M255622_1133401,M:M255622_1133403,M:M255622_1133421,M:M255622_1133425,M:M255622_1133426,M:M255622_1133428,M:M255622_1133430,M:M255622_1133432,M:M255622_1133439,M:M410084_18,";
	//strTodayGoods += goodsNumList;

	if(pageNum>0) {
		String tempListStr = "";
		String[] tempListAry = strTodayGoods.split("\\,");

		// 불필요한 데이터를 먼저 제거
		totalCnt = 0;
		for(int i=0; i<tempListAry.length; i++) {
			if(tempListAry[i].indexOf(":") > 0) {
				tempTotalCnt++;
				
				if(tempTotalCnt>=pageStart && tempTotalCnt<=pageEnd) {
					if(tempListStr.length()>0) tempListStr += ",";
					tempListStr += tempListAry[i];
				}
			}
		}

		pageMax = (int)Math.ceil((double)totalCnt/pageGap);

		strTodayGoods = tempListStr;
	}
	allTotalCnt = tempTotalCnt;

	Goods_Proc goods_proc = new Goods_Proc();
	ArrayList arrayTodayGoods = new ArrayList();

	if(strTodayGoods.trim().length()>0) {
		
		String astrTodayGoods[] = strTodayGoods.split("\\,");
	
		/****************************************************************
			MakeShop 호출 전 MakeShop 최근본 모델 번호 추출 , 단위 
		****************************************************************/
		Map<String,JSONObject> mapBrandStoreProduct = new HashMap<String,JSONObject>();
	
		String strBrandStoreProduct = "";
		List<String> brandStoreProductList = new ArrayList<String>();
		for(int i=0; i<astrTodayGoods.length; i++) {
			String strTodayGoodsOne = astrTodayGoods[i];
			String tmpArrTodayGoods[] = strTodayGoodsOne.split(":");
			if(tmpArrTodayGoods.length==2) {
				String tmpStrTodayGoodsType = tmpArrTodayGoods[0];
				String tmpStrTodayGoodsOne = tmpArrTodayGoods[1];
				if(tmpStrTodayGoodsType.equals("M") && tmpStrTodayGoodsOne.length() > 0) {
					brandStoreProductList.add(tmpStrTodayGoodsOne);
				}else{
					continue;
				}
			}
		}
		log(request,"strTodayGoods", strTodayGoods);

		if(brandStoreProductList.size() > 0){
			strBrandStoreProduct = String.join(",",  brandStoreProductList);

			log(request,"strBrandStoreProduct", strBrandStoreProduct);
		/****************************************************************
			MakeShop 호출 호출 strUserDevice 주의 (pc,mw,ios,aos => 여기선 mw,app만 )
		****************************************************************/
			ESSearchClient c = null;
			String body = null;
			JSONObject result = null;
			String source = "modelnm,minprice3,enr_ca_*code,imgurl*,url,enr_srv_yn,c_date,mallcnt,shop_name,brand,sale_cnt,shop_code"; // enr_srv_yn: 단종/품절 여부
			String[] headers = null;
			int intBrandStoreProductCnt = 0;
			if(strMobileAppAdult.equals("Y")){
				//앱에서 호출시 Y값이 넘어옴
				if(strUserAgent.indexOf("Android") >= 0){
					strUserDevice = "aos";
				}else{
					strUserDevice = "ios";
				}
			}else{
				//mw만 호출 
				strUserDevice="mw";
			}
			log(request,"strUserId",strUserId);
			log(request,"strUserIp",strUserIp);
			log(request,"strUserAgent",strUserAgent);
			log(request,"strUserDevice",strUserDevice);

			headers = new String[]{ "Content-Type:application/x-www-form-urlencoded", "log.user_ip:" + strUserIp,
				"log.user_agent:" + strUserAgent, "log.user_device:" + strUserDevice, "log.client_code:13" };
			c = new ESSearchClient(2, "c/rest/makeshop");
			body = String.format("cmd=brand.favorite.goods&_ids=%s&source=%s&format=json", strBrandStoreProduct , source);
			result = c.loadEsSearchResult("search", body, headers);

			intBrandStoreProductCnt = result.getInt("total");
			//System.out.println(result.toString());
			if(intBrandStoreProductCnt > 0){
				JSONArray tmpJsonArray = result.getJSONArray("items");
				for(int i=0;i<tmpJsonArray.length();i++){
					JSONObject tmpObject =tmpJsonArray.getJSONObject(i);
					if(tmpObject.getBoolean("_found")){
						mapBrandStoreProduct.put(tmpObject.getString("_id"),tmpObject);
					}else{
						continue;					
					}
				}
			}
		}
		for(int i=0; i<astrTodayGoods.length; i++) {
			String strTodayGoodsOne = astrTodayGoods[i];
			if(strTodayGoodsOne.indexOf(":") > 0) {
				String tmpArrTodayGoods[] = strTodayGoodsOne.split(":");
				if(tmpArrTodayGoods.length==2){
					String tmpStrTodayGoodsType = tmpArrTodayGoods[0];
					String tmpStrTodayGoodsOne = tmpArrTodayGoods[1];
					if(tmpStrTodayGoodsType.equals("G") && ChkNull.chkNumber(tmpStrTodayGoodsOne)) {
						int nModelNo = Integer.parseInt(tmpStrTodayGoodsOne);
						
						Goods_Data goods_data_one = save_goods_proc.Goods_One(nModelNo,0);
						if(goods_data_one == null) continue;
						
						if(isAdultCate(goods_data_one.getCa_code()) && (!IsAdultFlag)){ //성인용품+미성년or인증안됨
							deleteAdult = "Y";
						}else{
							deleteAdult="N";
						}
						if(goods_data_one != null && deleteAdult != "Y") {
							totalCnt++;//바꾼부분
							goods_data_one.setModelno(nModelNo);
							goods_data_one.setKb_num1(goods_data_one.getKb_num());
							//goods_data_one.setAdultChk(IsAdultFlag);//바꾼부분
							arrayTodayGoods.add(goods_data_one);
						}else{
							continue;
						}
					} else if (tmpStrTodayGoodsType.equals("P") && ChkNull.chkNumber(tmpStrTodayGoodsOne)) {
					
						long nPlNo = Long.parseLong(tmpStrTodayGoodsOne);
						Pricelist_Data pricelist_data_info = save_goods_proc.getPricelistData(nPlNo);
											
						if(pricelist_data_info != null) {
							// 상품명 자동변경 적용
							String tempGoodsnm = getGoodsNmReplace2(pricelist_data_info.getShop_code(), pricelist_data_info.getGoodsnm(), pricelist_data_info.getPrice(), pricelist_data_info.getCa_code(), false, pricelist_data_info.getFreeinterest(), cardFreeAry);
							pricelist_data_info.setGoodsnm(tempGoodsnm);
							Goods_Data goods_data_one = new Goods_Data();
							goods_data_one.setP_pl_no(nPlNo);
							goods_data_one.setCa_code(pricelist_data_info.getCa_code());
							goods_data_one.setModelnm(pricelist_data_info.getGoodsnm());
							goods_data_one.setMinprice(pricelist_data_info.getPrice_long());
							goods_data_one.setMinprice3(pricelist_data_info.getPrice_long());
							goods_data_one.setFactory(pricelist_data_info.getShop_name());
							goods_data_one.setP_imgurl(pricelist_data_info.getImgurl());
							goods_data_one.setGb1_no(pricelist_data_info.getShop_code());
							goods_data_one.setGoods_info(pricelist_data_info.getDeliveryinfo());
							goods_data_one.setUrl1(pricelist_data_info.getUrl());
							goods_data_one.setCa_code(pricelist_data_info.getCa_code());
							goods_data_one.setGoods_info_date(pricelist_data_info.getFreeinterest());
							goods_data_one.setMallcnt(1);
							goods_data_one.setP_imgurl2("SHOP");
							goods_data_one.setFunc(pricelist_data_info.getSrvflag());
							goods_data_one.setProduct_id(pricelist_data_info.getGoodscode());
							goods_data_one.setC_date(pricelist_data_info.getU_date());
							goods_data_one.setFactory_etc(pricelist_data_info.getGoodsfactory());
							goods_data_one.setModelno_group(pricelist_data_info.getModelno());
							// 모바일 가격
							goods_data_one.setTmp_price(pricelist_data_info.getInstance_price());
							
							//pricelist는 현금몰 최저가 여부 없으므로 default 값 추가 (2019.11.07)
							goods_data_one.setCash_min_prc(0);
							goods_data_one.setCash_min_prc_yn("N");
							goods_data_one.setOvs_min_prc_yn("N");
							goods_data_one.setTlc_min_prc(0);

							if(isAdultCate(goods_data_one.getCa_code()) && (!IsAdultFlag)){ //성인용품+미성년or인증안됨
								continue;

							}else{
								arrayTodayGoods.add(goods_data_one);
							}
						}
					} else if (tmpStrTodayGoodsType.equals("M") && tmpStrTodayGoodsOne.length() > 0) {
						//브랜드 스토어 info
						if(mapBrandStoreProduct.containsKey(tmpStrTodayGoodsOne)){
							JSONObject tmpJSONObject = mapBrandStoreProduct.get(tmpStrTodayGoodsOne);
							String strModelNm = tmpJSONObject.optString("modelnm");
							String strCategory = tmpJSONObject.optString("enr_ca_dcode");
							String strCategory2 = tmpJSONObject.optString("enr_ca_lcode");
							String strCategory4 = tmpJSONObject.optString("enr_ca_mcode");
							String strSmallImageUrl = tmpJSONObject.optString("imgurl");
							String strMiddleImageUrl = tmpJSONObject.optString("imgurl2");
							long lngMinPrice3 = tmpJSONObject.optLong("minprice3");
							String strUrl = tmpJSONObject.optString("url");
							String strCdate = tmpJSONObject.optString("c_date");
							String strBrand = tmpJSONObject.optString("brand");
							String strFactory = tmpJSONObject.optString("factory");
							String strShopName = tmpJSONObject.optString("shop_name");
							String strShopCode = tmpJSONObject.optString("shop_code");
							int intMallCnt =  tmpJSONObject.optInt("mallcnt");
							int intMallCnt3 = tmpJSONObject.optInt("mallcnt3");
							
							strUrl = "http://" + strServerName + "/brandstore/move.jsp?url=" + URLEncoder.encode(strUrl, "utf-8");
							strUrl += "&freetoken=outlink";
							strUrl += "&makeshopno=" + tmpStrTodayGoodsOne;
							strUrl += "&pageType=mypage";
							strUrl += "&shopcode=" + strShopCode;
							strUrl += "&cate=" + strCategory;
							strUrl += "&device=" + strUserDevice;
							Goods_Data goods_data_one = new Goods_Data();
						
							goods_data_one.setFactory(strShopName);
							goods_data_one.setP_pl_no(0);
							goods_data_one.setCa_code(strCategory);
							goods_data_one.setModelnm(strModelNm);
							goods_data_one.setMinprice(lngMinPrice3);
							goods_data_one.setMinprice3(lngMinPrice3);
							goods_data_one.setP_imgurl(strMiddleImageUrl);
							goods_data_one.setC_date(strCdate);
							goods_data_one.setUrl1(strUrl);
							goods_data_one.setMallcnt(1);
							goods_data_one.setP_imgurl2(strSmallImageUrl);
							goods_data_one.setMksp_model_no(tmpStrTodayGoodsOne);
							// 모바일 가격
							arrayTodayGoods.add(goods_data_one);
						}
					}
				}
			}
		}
		goods_data = (Goods_Data[])arrayTodayGoods.toArray(new Goods_Data[0]);
	}

} else if(listType==2) {
	// 찜 상품일 때 폴더 정보 읽어옴
	strUserId = cb.GetCookie("MEM_INFO","USER_ID");
	totalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, folder_id);
	
	allTotalCnt = save_goods_proc.getSaveGoodListCnt(strUserId, 0);

	if(pageNum>0) {
		pageMax = (int)Math.ceil((double)totalCnt/pageGap);
		goods_data = save_goods_proc.getSaveGoodListPage(strUserId, folder_id, pageNum, pageGap);

	} else {
		goods_data = save_goods_proc.getSaveGoodList(strUserId, folder_id);
	}

} else if(listType==9) { // 검색에서 최근본 보기
	if(strMobileAppAdult.equals("Y")){	//앱에서 호출시 Y값이 넘어옴
		IsAdultFlag = true;
	}else if(strMobileAppAdult.equals("N")){
		IsAdultFlag = false;
	}else{
		strUserId = cb.GetCookie("MYINFO","TMP_ID");
		
		if(strUserId != ""){
			IsAdultFlag = false;
			if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
				adultStr = cb.GetCookie("MEM_INFO","ADULT");
				// 성인인증 됨 
				if(adultStr.equals("1")) IsAdultFlag = true;
			}
		}
	}
	if(pageNum>0) {
		
		
		String tempListStr = "";
		String[] tempListAry = goodsNumList.split("\\,");

		// 불필요한 데이터를 먼저 제거
		tempTotalCnt = 0;
		for(int i=0; i<tempListAry.length; i++) {
			if(tempListAry[i].indexOf(":") > 0) {
				if(tempListStr.length()>0) tempListStr += ",";
				tempListStr += tempListAry[i];
				tempTotalCnt++;

				if(appType==1) {
					// 7개 까지만 보여줌
					if(tempTotalCnt==10) break;
				}
			}
		}

		goodsNumList = tempListStr;
	}

	Pricelist_Api pricelist_api = new Pricelist_Api();

	int intEstimateModelCount = 0;

	Goods_Proc goods_proc = new Goods_Proc();
	ArrayList arrayList = new ArrayList();

	String estimateGoods[] = goodsNumList.split("\\,");

	intEstimateModelCount = estimateGoods.length;
	
	if(estimateGoods!=null) {
		totalCnt=0;
		for(int i=0; i<estimateGoods.length; i++) {
			String estimateGoodsOne = estimateGoods[i];

			if(estimateGoodsOne.split(":")[0].equals("G") && ChkNull.chkNumber(estimateGoodsOne.split(":")[1])) {
				int nModelNo = Integer.parseInt(estimateGoodsOne.split(":")[1]);
				Goods_Data goods_data_one = save_goods_proc.Goods_One(nModelNo,0);
				
				if(goods_data_one == null ) continue;
				
				if(isAdultCate(goods_data_one.getCa_code()) && (!IsAdultFlag)){ //성인용품+미성년or인증안됨
					deleteAdult = "Y";
				}else{
					deleteAdult="N";
				}
				
				if(goods_data_one != null && !deleteAdult.equals("Y")) {					
					totalCnt++;
					goods_data_one.setModelno(nModelNo);
					goods_data_one.setKb_num1(goods_data_one.getKb_num());
					
					// Goods_Data 에서 개봉상품 사용변수에 견적보기의 가격을 저장함(3개)
					// pic_txt_1, pic_txt_2, pic_txt_3
					//Pricelist_Data[] pricelist_dataTemp = pricelist_api.getApPricelistByModelNoEstimate(nModelNo,1000);
					Pricelist_Data[] pricelist_dataTemp = pricelist_api.getApPricelistByModelNoMobile(nModelNo,1000);
					
					// 한정판매 상품을 걸러냄 3개까지 보여주지만 한정 판매 상품이 최저가보다 클 경우는 보여주지 않음
					int pdCnt = 0;
					if(pricelist_dataTemp!=null) {
						for(int j=0; j<pricelist_dataTemp.length; j++) {
							if((pricelist_dataTemp[j].getSrvflag().equals("M") && j==0) || !pricelist_dataTemp[j].getSrvflag().equals("M")) {
								if(pdCnt<3) {
									// pl_no:price:shop_code:shop_name:url:deliveryinfo
									String tempShopText = "";

									tempShopText += pricelist_dataTemp[j].getPl_no() + "**";
									tempShopText += FmtStr.moneyFormat(pricelist_dataTemp[j].getPrice_long()+"") + "**";
									tempShopText += pricelist_dataTemp[j].getShop_code() + "**";
									tempShopText += pricelist_dataTemp[j].getShop_name() + "**";
									tempShopText += pricelist_dataTemp[j].getUrl() + "**";

									String deliveryText = "";
									if(pricelist_dataTemp[j].getDeliverytype2()==1) {
										if(pricelist_dataTemp[j].getDeliveryinfo2()==0) {
											deliveryText = "무료배송";
										} else {
											deliveryText = FmtStr.moneyFormat(pricelist_dataTemp[j].getDeliveryinfo2()+"") + "원";
										}
									} else {
										deliveryText = pricelist_dataTemp[j].getDeliveryinfo();
										if(deliveryText.length()>6) deliveryText = "배송비유무료";
									}
									tempShopText += deliveryText + "**";

									pdCnt++;

									if(pdCnt==1) goods_data_one.setPic_txt_1(tempShopText);
									if(pdCnt==2) goods_data_one.setPic_txt_2(tempShopText);
									if(pdCnt==3) goods_data_one.setPic_txt_3(tempShopText);
								}
							}
						}
					}

					arrayList.add(goods_data_one);
				}else{
					continue;
				}
			} else if (estimateGoodsOne.split(":")[0].equals("P") && ChkNull.chkNumber(estimateGoodsOne.split(":")[1])) {
				long nPlNo = Long.parseLong(estimateGoodsOne.split(":")[1]);
				Pricelist_Data pricelist_data_info = save_goods_proc.getPricelistData(nPlNo);
				
				if(pricelist_data_info != null) {
					// 상품명 자동변경 적용
					String tempGoodsnm = getGoodsNmReplace2(pricelist_data_info.getShop_code(), pricelist_data_info.getGoodsnm(), pricelist_data_info.getPrice(), pricelist_data_info.getCa_code(), false, pricelist_data_info.getFreeinterest(), cardFreeAry);
					pricelist_data_info.setGoodsnm(tempGoodsnm);

					Goods_Data goods_data_one = new Goods_Data();
					goods_data_one.setP_pl_no(nPlNo);
					goods_data_one.setCa_code(pricelist_data_info.getCa_code());
					goods_data_one.setModelnm(pricelist_data_info.getGoodsnm());
					goods_data_one.setMinprice(pricelist_data_info.getPrice_long());
					goods_data_one.setFactory(pricelist_data_info.getShop_name());
					goods_data_one.setP_imgurl(pricelist_data_info.getImgurl());
					goods_data_one.setGb1_no(pricelist_data_info.getShop_code());
					goods_data_one.setGoods_info(pricelist_data_info.getDeliveryinfo());
					goods_data_one.setUrl1(pricelist_data_info.getUrl());
					goods_data_one.setCa_code(pricelist_data_info.getCa_code());
					goods_data_one.setGoods_info_date(pricelist_data_info.getFreeinterest());
					goods_data_one.setMallcnt(1);
					goods_data_one.setP_imgurl2("SHOP");
					goods_data_one.setFunc(pricelist_data_info.getSrvflag());
					goods_data_one.setProduct_id(pricelist_data_info.getGoodscode());
					goods_data_one.setC_date(pricelist_data_info.getU_date());
					goods_data_one.setFactory_etc(pricelist_data_info.getGoodsfactory());
					goods_data_one.setModelno_group(pricelist_data_info.getModelno());
					goods_data_one.setImgchk(pricelist_data_info.getImgchk());
					
					arrayList.add(goods_data_one);
				}
			}
		}
	}

	goods_data = (Goods_Data[])arrayList.toArray(new Goods_Data[0]);
}

int totalLength = 0;
if(listType==2 && cb.GetCookie("MEM_INFO","USER_ID") != "") {
	strUserId = cb.GetCookie("MEM_INFO","USER_ID");
}
totalLength = totalCnt;

out.println("	\"myGoodsTotalCnt\":\""+totalLength+"\",");
out.println("	\"myGoodsAllTotalCnt\":\""+allTotalCnt+"\",");

if(goods_data!=null && goods_data.length>0) {
	String strSearckKeywordSynonym = "";

	out.println("	\"goodsList\": [");
	boolean listFirstPrintFlag = false;
	for(int i=0; i<goods_data.length; i++) {

		int modelno = goods_data[i].getModelno();
		long p_pl_no = goods_data[i].getP_pl_no();
		String ca_code = goods_data[i].getCa_code();
		String modelnm = goods_data[i].getModelnm();
		long minprice = goods_data[i].getMinprice3();
		int sale_cnt = goods_data[i].getSale_cnt();
		String factory = goods_data[i].getFactory();
		String imgchk = goods_data[i].getImgchk();
		String p_imgurl = goods_data[i].getP_imgurl();
		int gb1_no = goods_data[i].getGb1_no();
		String url1 = goods_data[i].getUrl1();
		String p_imgurlflag = goods_data[i].getP_imgurlflag();
		String mksp_model_no = goods_data[i].getMksp_model_no();
		String smallImageUrl = ImageUtil.getImageSrc(CutStr.cutStr(ca_code,4), modelno, imgchk, p_pl_no, p_imgurl, p_imgurlflag);

		//String smallImageUrl = ImageUtil_lsv.getVIPImageSrc(goods_data[i]);
		String middleImageUrl = "";

		String departImgSrc ="";

		String dept_yn = ChkNull.chkStr(goods_data[i].getDept_yn());

	//	System.out.println("dept_yn : "+dept_yn);

		int intDept_code = 0;
		String departlogo = "";
		int szVcode = 0;
		String strShopnm = "";
		//String maxprice = "";
		String departName = "";

		long maxprice = goods_data[i].getMaxprice();

		if("Y".equals(dept_yn)){

			departImgSrc = getDepartImgSrc(ca_code,modelno,imgchk, p_pl_no , p_imgurl, p_imgurlflag);

			Depart_Goods_Proc depart_goods_proc =  new Depart_Goods_Proc();
			Depart_Goods_Data depart_goods_data = new Depart_Goods_Data();
			depart_goods_data = depart_goods_proc.getMinShop(modelno);

			if(depart_goods_data !=null){
				intDept_code = depart_goods_data.getMin_pl_dept();
				szVcode =  depart_goods_data.getMin_pl_shop();
				strShopnm = getShopName(_shop_code, szVcode+"");
				maxprice = depart_goods_data.getMax_pl_price();

				minprice = depart_goods_data.getMin_pl_price();

				departName = getDeptName(_dept_code, intDept_code+"");
				departlogo = getDepartLogo(intDept_code+"");

			}
		}
		
		String strFactory = ChkNull.chkStr(goods_data[i].getFactory());
		String strBrand = ChkNull.chkStr(goods_data[i].getBrand());
		
		if(modelno > 0){

			String strModelnmText[] = getModel_FBN(ca_code, modelnm, strFactory ,strBrand);
			String strNm_factory = toJS2(strModelnmText[1]);
			String strNm_brand   = toJS2(strModelnmText[2]); 
			String strNm_model  = toJS2(strModelnmText[0]);

			if(!ca_code.equals("93")){ 
				if(strNm_model.lastIndexOf("[")>0){ 
					strNm_model = strNm_model.substring(0,strNm_model.lastIndexOf("["));
				} 
			}
			
			String modelName = strNm_factory + " "+ strNm_brand+ " "+ strNm_model; 
			modelnm = toJS2(modelName.replace("  "," ").trim());
		
		}

		// 유사상품일 경우 이미지 경로가 바뀜
		if(imgchk.equals("G")) smallImageUrl = goods_data[i].getP_imgurl2();

		int kb_num = goods_data[i].getKb_num();
		String kb_title = HtmlStr.removeHtml(goods_data[i].getKb_title());
		kb_title = ReplaceStr.replace(ReplaceStr.replace(ReplaceStr.replace(kb_title,"'",""),"\"",""),"[뉴스]","");

		String keyword2 = goods_data[i].getKeyword2();
		keyword2 = ReplaceStr.replace(keyword2,"\r\n", "");
		keyword2 = ReplaceStr.replace(keyword2,"  ", " ");
		keyword2 = ReplaceStr.replace(keyword2,"★", "");
		keyword2 = ReplaceStr.replace(keyword2,"▶", "");
		//keyword2 = ReplaceStr.replace(keyword2,"★", "▶");

		String strSpec = goods_data[i].getSpec_group();
		if(strSpec.trim().length()==0) strSpec = goods_data[i].getSpec();
        if(CutStr.cutStr(ca_code,2).equals("15") && strSpec.trim().length()==0) strSpec = modelnm;

		// 출시일
		String c_date = goods_data[i].getC_date();
		c_date = CutStr.cutStr(c_date,10);
		String c_dateStr = c_date;
		/*
		if(c_dateStr.length()==10) {
			c_dateStr = c_dateStr.substring(2, 7);
			String[] c_dateStrAry = c_dateStr.split("-");

			try {
				c_dateStr = c_dateStrAry[0] + "년 " + Integer.parseInt(c_dateStrAry[1]) + "월";
			} catch(Exception e) {}
		}
		*/
		if(c_dateStr.length()==10) {
			java.util.Calendar calend = java.util.Calendar.getInstance();
			String nowYear = calend.get(cal.YEAR) + "";

			// 현재 년도랑 같을 경우에만  년, 월로 표시
			if(c_dateStr.substring(0, 4).equals(nowYear)) {
				c_dateStr = c_dateStr.substring(2, 7);
				c_dateStr = ReplaceStr.replace(c_dateStr, "-0", "-");
			} else {
				c_dateStr = c_dateStr.substring(2, 4);
			}
		}
		if(c_dateStr.indexOf("-")>-1) {
			c_dateStr = "'" + ReplaceStr.replace(c_dateStr, "-", "년 ") + "월";
		} else {
			c_dateStr = "'" + c_dateStr+ "년";
		}

		// 요약 / 좌우 공백 안들어가 있음
		strSpec = ReplaceStr.replace(strSpec, "</", "****");
		strSpec = ReplaceStr.replace(strSpec, "/", " / ");
		strSpec = ReplaceStr.replace(strSpec, "****", "</");

		// 패션(14), 유사상품 모델은 요약칸에 모델명 나오도록 함
		// 유사상품은 스펙에 모델명이 나오지 않게~
		//if(imgchk.equals("G") || CutStr.cutStr(ca_code,2).equals("14")) {
		if((CutStr.cutStr(ca_code,2).equals("14") || CutStr.cutStr(ca_code,2).equals("15")) && strSpec.trim().length() == 0 ) {
			strSpec = modelnm;
			strSpec = ReplaceStr.replace(strSpec, "특가!", "");
		}

		modelnm = ReplaceStr.replace(modelnm,"[일반]","");

		// 모델명과 조건명[ 사이 한칸 공백
		modelnm = ReplaceStr.replace(modelnm, "[", " [");
		/*
		// 조건명 []는 볼드체 제외
		// ※패션(14), 도서,음반(93) 모델명의 []는 조건명 아니므로 볼드체로 나오도록 함
		if(!CutStr.cutStr(ca_code,2).equals("14") && !CutStr.cutStr(ca_code,2).equals("93")) {
			if(modelnm.indexOf("[")>-1 && modelnm.indexOf("]")>-1) {
				modelnm = ReplaceStr.replace(modelnm, "[", "<span class=normalWeight>[") + "</span>";
			}
		}
		// 휴대폰(0304) 모델명-조건명 앞의 ()내용은 볼드체 제외
		if(CutStr.cutStr(ca_code,4).equals("0304")) {
			int sIdx = modelnm.indexOf("(");
			int eIdx = modelnm.indexOf(")") + 1;

			if(sIdx>0 && eIdx>0) {
				modelnm = modelnm.substring(0, sIdx) + "<span class=normalWeight>" + modelnm.substring(sIdx, eIdx) + "</span>" + modelnm.substring(eIdx);
			}
		}
		*/

		// 찜한 날짜
		String moddate = goods_data[i].getModdate();

		// yyyy-mm-dd/hh24:mi 이런 형태를 변환함
		// 년도 제거하기
		//if(moddate.indexOf("-")>-1 && moddate.indexOf("-")!=moddate.lastIndexOf("-")) {
		//	moddate = moddate.substring(moddate.indexOf("-")+1);
		//}
		//if(moddate.length()>1 && moddate.charAt(0)=='0') moddate = moddate.substring(1);
		//moddate = ReplaceStr.replace(moddate, "-0", "-");
		//moddate = ReplaceStr.replace(moddate, "-", "월 ");
		//moddate = ReplaceStr.replace(moddate, "/", "일 ");

		// 즐겨찾기나 목록 저장의 경우는 찜한 날짜를 보여주지 않음
		if(mailYN.equals("Y") && goodsNumList.length()>0) {
			moddate = "";
		}

        int mallcnt = goods_data[i].getMallcnt3();

		//keyword2 = ReplaceStr.replace(keyword2,"\"","&quot;");
		
		keyword2 = toJS2(keyword2);
		modelnm = toJS2(modelnm);
		strSpec = toJS2(strSpec);

		// 더큰 사진 여부 체크
		String bBigImageYN = "N";
		if(imgchk.equals("6")) {
			bBigImageYN = "Y";
		}

		// 배송비 정보 읽어오기
		String goods_info = goods_data[i].getGoods_info();
		if(!goods_info.equals("무료배송")) {
			int intGoods_info = -1;
			try {
				intGoods_info = Integer.parseInt(goods_info);
			} catch(Exception e) {}
			if(intGoods_info>-1) {
				goods_info = "배송:" + FmtStr.moneyFormat(goods_info) + "원";
			}
		}
		// 찜의 경우는 배송비 정보가 필요없음
		// goods_info에 불필요한 정보가 들어있음, 제거
		if(listType==2) {
			goods_info = "";
		}

		// 가격 정보 보여주기
		String minPriceText = "";
		if(goods_data[i].getMallcnt3()==1 && DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0) {
			minPriceText = "미정";
			mallcnt = 0;
		} else if((goods_data[i].getOpenexpectflag().equals("1") || DateUtil.getDaysBetween(c_date,DateStr.nowStr())>0 ) && goods_data[i].getIsgroup() != 1) {
			minPriceText = "미정";
			mallcnt = 0;
		} else {
			if ((CutStr.cutStr(ca_code,4).equals("0304") || CutStr.cutStr(ca_code,4).equals("0305") || CutStr.cutStr(ca_code,4).equals("0353")) && minprice==0){
				minPriceText = "클릭";
				if(deviceType.equals("m") && goods_data[i].getMallcnt3()==0){
					minPriceText = "별도확인";
				}
			}
		}

		if(minPriceText.length()==0 && minprice==0 && mallcnt == 0) {
			minPriceText = "단종/품절";
		}
		if(minPriceText.equals("미정")) {
			c_dateStr = "출시예정";
			mallcnt = 0; 
		} else {
			if(p_pl_no==0) {
				c_dateStr += " 출시";
			}
		}

		if(c_dateStr.indexOf("예정") > -1){
			minPriceText = "출시예정";
			c_dateStr = "출시예정"; 
		}   
  
		String strAdultCookie = "";
		String adultImageFlag = "N";
		
		if(strMobileAppAdult.equals("Y")){	//앱에서 호출시 Y값이 넘어옴
			if(modelno>0) {
				if(isAdultCate(goods_data[i].getCa_code())){ //성인용품
					adultImageFlag = "Y";
				}
			}else{
				String strTmp_img = getSearchGoodsImage(true,"1",smallImageUrl,false);

				if(strTmp_img.indexOf("2012/search/19_50.gif")>-1) {
					adultImageFlag = "Y";
				}
			}
		}else{
			if(cb.GetCookie("MEM_INFO","ADULT") != null) {
				strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
			}
			
			if(modelno>0) {
				if(isAdultCate(goods_data[i].getCa_code()) && !cb.GetCookie("MEM_INFO", "ADULT").equals("1")){ //성인용품+미성년or인증안됨
					adultImageFlag = "Y";
				}
			} else {
				boolean bAdult = false;
				if (adultKeywordCheck(modelnm) || adultCategoryCheck(goods_data[i].getCa_code())){
					bAdult = true;
				}
				
				smallImageUrl = getSearchGoodsImage(bAdult,strAdultCookie,smallImageUrl,false);
				// plno상품의 경우는 getSearchGoodsImage를 이용해 성인용 체크를 하고 이미지는
				// 아래와 같이 변경해야함
				if(smallImageUrl.indexOf("2012/search/19_50.gif")>-1) {
					adultImageFlag = "Y";
				}
			}

			if(adultImageFlag.equals("Y")) {
				smallImageUrl = ConfigManager.IMG_ENURI_COM+"/2014/mobilenew/contents/img_19.jpg";
			}
		}

		if(smallImageUrl.indexOf("gmarket.co.kr") >= 0) {
			smallImageUrl = ReplaceStr.replace(smallImageUrl,"/large_img/","/large_jpgimg/");
		}

		// 무이자 할부 정보
		String strFreeinterest = goods_data[i].getGoods_info_date();

		modelnm = getRemoveCardSale(cardNameHash, modelnm, goods_data[i].getGb1_no(), minprice, ca_code, strFreeinterest, cardFreeAry);

		/*
		if (goods_data[i].getFactory_etc().trim().length() > 0 && !goods_data[i].getFactory_etc().trim().equals("기타") && !goods_data[i].getFactory_etc().trim().equals("없음") && !goods_data[i].getFactory_etc().trim().equals("(기타)")
			&& !goods_data[i].getFactory_etc().trim().equals("기타제조사") && !goods_data[i].getFactory_etc().trim().equals("알수없음")
			&& !goods_data[i].getFactory_etc().trim().equals("상품상세설명 참조")
			&& !goods_data[i].getFactory_etc().trim().equals("상세 설명 참조")
		){
			modelnm = "["+goods_data[i].getFactory_etc()+"]"+modelnm;
		}
		*/


		strFreeinterest = getForceFreeInterest2(goods_data[i].getGb1_no(), ca_code, strFreeinterest, minprice, cardFreeAry);

		if(strFreeinterest.trim().length() > 0) {
			strFreeinterest = "할부: " + strFreeinterest;
		}

		// 해당 분류로 이동
		String modelCateLink = "";
		String strTempCateGory = "";
		String strCategoryName = "";
		if(ca_code.trim().length()>=6) {
			strTempCateGory = CutStr.cutStr(ca_code,6);
		} else {
			strTempCateGory = ca_code;
		}

		if(strTempCateGory.trim().length()>=4) {
			strCategoryName = Category_Proc.Category_Name_DetailTitle_One(strTempCateGory);
		}
		if(strCategoryName.trim().length()>0 && !CutStr.cutStr(strTempCateGory,2).equals("93") && !isAdultCate(strTempCateGory)) {
			strCategoryName = "&quot;"+strCategoryName+"&quot; 분류로 이동";
			strCategoryName = ReplaceStr.replace(strCategoryName, "\"", "&quot;");

			if(strCategoryName.indexOf("temp") >= 0  && strTempCateGory.trim().length() >= 4 ) {
				strTempCateGory = CutStr.cutStr(strTempCateGory,4);
				strCategoryName = "&quot;"+Category_Proc.Category_Name_DetailTitle_One(strTempCateGory)+"&quot; 분류로 이동";
			}
			modelCateLink = "/view/List.jsp?cate="+strTempCateGory;
		}
		// 최근본 찜에서는 불명 제조사명 노출 안함
		if(factory.equals("불명") || factory.equals("[불명]")) {
			factory = "";
		}
		
		String modelnoID = "";
		if(modelno==0) {
			modelnoID = "P" + p_pl_no;
		} else if(!mksp_model_no.equals("")) {
			modelnoID = "M" + mksp_model_no;
		} else {
			modelnoID = "G" + modelno;
		}

		middleImageUrl = smallImageUrl;
		if(listType!=9) {
			middleImageUrl = smallImageUrl;
			String smallImgUrlFinder = "/data/images/service/small/";
			int smallFinderIdx = smallImageUrl.indexOf(smallImgUrlFinder);
			// 500이미지로 변경
			if(smallFinderIdx>-1) {
				middleImageUrl = smallImageUrl.substring(0, smallFinderIdx);
				middleImageUrl += "/data/images/service/middle/";
				middleImageUrl += smallImageUrl.substring(smallFinderIdx + smallImgUrlFinder.length());

				int lastDotIdx = middleImageUrl.lastIndexOf(".");
				middleImageUrl = middleImageUrl.substring(0, lastDotIdx) + ".jpg";
			}

			if(middleImageUrl.equals(smallImageUrl)) {
				smallImageUrl = "http://photo3.enuri.com/data/working.gif";
			}

		}else{
			middleImageUrl = smallImageUrl.replace("small", "middle");
			middleImageUrl = middleImageUrl.replace(".gif", ".jpg");
		}

		// 스폰서 상품 찾기
		//스폰서 엠블럼
		String IsSponsor = "";
		if (getIsSponserGoods(modelno)) {
			IsSponsor = "Y";
		}

		// 추가 검색 상품 플래그
		String plnoGoodFlag = "";
		String minpriceTextFlag = "Y";
		if(minPriceText.length()>0 && minprice==0) {
			minpriceTextFlag = "";
		}
		if(modelno==0 && p_pl_no>0) {
			minpriceTextFlag = "";
			plnoGoodFlag = "Y";
		}

		String factory_etc = goods_data[i].getFactory_etc();
		if (factory_etc.equals("불명") || factory_etc.equals("없음")){
			factory_etc = "";
		}

		factory_etc = ReplaceStr.replace(factory_etc, "[", "");
		factory_etc = ReplaceStr.replace(factory_etc, "]", "");

		String strFactoryCate = "";
		if(!ca_code.equals("")){
			if(ca_code.length() > 2 ){
				strFactoryCate = ca_code.substring(0,2);
			}
		}
			
   		if(!strFactory.equals("")){
   			strFactory = strFactory.replace("["," ").replace("]","");
   		}
		
		String strFactoryCateFlag = "";
		if(strFactoryCate.length() > 0){
			FactoryBrand_Data[] factorybrand_data = FactoryBrand_Proc.FactoryBrand_flag(strFactoryCate);
			if(strFactoryCateFlag!=null && factorybrand_data.length>0) {
				strFactoryCateFlag = factorybrand_data[0].getStrFactory_view_flag();
			}
		}
		if(strFactoryCateFlag.equals("1")){
			factory = strFactory;
		}else if(strFactoryCateFlag.equals("2")){
			factory = strBrand;
		}else if(strFactoryCateFlag.equals("3")){
			if(strBrand.length() > 0){
				if(strFactory.equals(strBrand) || strFactory.indexOf(strBrand) > -1 ){
					factory = factory;
				}else{
					factory = factory +" "+ strBrand;
				}
			}
		}else if(strFactoryCateFlag.equals("4")){
			factory = "";
		}

		factory = ReplaceStr.replace(factory, "[", "");
		factory = ReplaceStr.replace(factory, "]", "");
		factory_etc = CutStr.cutStr(factory_etc, 9);
		factory_etc = factory_etc.replace("㈜","(주)");

		modelnm = ReplaceStr.replace(modelnm, "특가! ", "");
		modelnm = ReplaceStr.replace(modelnm, "특가!", "");
		
		//현금몰,해외직구 가격 추가 (2019.11.06)
		//mobilefirst/resentzzim/resentzzimList.jsp 에서 템플릿 엔진을 사용해서 viewminprice 추가
		long cashMinPrc = goods_data[i].getCash_min_prc();
		String cashMinPrcYn =  goods_data[i].getCash_min_prc_yn();
		String ovsMinPrcYn =  goods_data[i].getOvs_min_prc_yn();
		long lngTlcMinPrc = goods_data[i].getTlc_min_prc();
		
		long viewminprice = 0;
		
		if(cashMinPrcYn != null && cashMinPrcYn.equals("Y")) {
			viewminprice = cashMinPrc;
		} else if(lngTlcMinPrc > 0) {
			viewminprice = lngTlcMinPrc;
		} else {
			viewminprice = minprice;
		}
        if(!mksp_model_no.equals("")) {
			factory = goods_data[i].getFactory();
			middleImageUrl = goods_data[i].getP_imgurl();
			smallImageUrl = goods_data[i].getP_imgurl2();
		}
		if(modelnm.length()>0) {
			if(listFirstPrintFlag) out.print(",\r\n");

			// 금액의 총합을 구함
			priceSum += viewminprice;
 
			out.println("			{");
			out.println("			\"modelno\":\""+modelno+"\", ");
			out.println("			\"p_pl_no\":\""+p_pl_no+"\", ");
			out.println("			\"plnoGoodFlag\":\""+plnoGoodFlag+"\", ");
			out.println("			\"factory_etc\":\""+factory_etc+"\", ");
			out.println("			\"smallImageUrl\":\""+smallImageUrl+"\", ");
			out.println("			\"middleImageUrl\":\""+middleImageUrl+"\", ");
			out.println("			\"goodscode\":\""+goods_data[i].getProduct_id()+"\", ");
			out.println("			\"instance_price\":\""+goods_data[i].getTmp_price()+"\", ");
			out.println("			\"maxprice\":\""+FmtStr.moneyFormat(maxprice+"")+"\", ");
			out.println("			\"dept_yn\":\""+dept_yn+"\", ");
			out.println("			\"departImgSrc\":\""+departImgSrc+"\", ");
			out.println("			\"departName\":\""+departName+"\", ");
			out.println("			\"strShopnm\":\""+strShopnm+"\", ");
			out.println("			\"departLogo\":\""+departlogo+"\", ");
			out.println("			\"shopCode\":\""+szVcode+"\", ");
			out.println("			\"price\":\""+minprice+"\", ");
			if(listType!=9) {
				if((cashMinPrc > 0 || lngTlcMinPrc > 0) && mallcnt > 0){
					out.println("			\"minprice\":\""+FmtStr.moneyFormat(minprice+"")+"\", ");
					out.println("			\"viewminprice\":\""+FmtStr.moneyFormat(viewminprice+"")+"\", ");
				}else if(minPriceText.length()>0 && minprice==0) {
					out.println("			\"minprice\":\"\", ");
					out.println("			\"viewminprice\":\"\", ");
				} else {
					out.println("			\"minprice\":\""+FmtStr.moneyFormat(minprice+"")+"\", ");
					out.println("			\"viewminprice\":\""+FmtStr.moneyFormat(viewminprice+"")+"\", ");
				}
				out.println("			\"minPriceText\":\""+minPriceText+"\", ");
				out.println("			\"minpriceTextFlag\":\""+minpriceTextFlag+"\", ");
				out.println("			\"factory\":\""+factory+"\", ");
				out.println("			\"strFreeinterest\":\""+strFreeinterest+"\", ");
				out.println("			\"c_date\":\""+c_date+"\", ");
				out.println("			\"c_dateStr\":\""+c_dateStr+"\", ");
				out.println("			\"moddate\":\""+moddate+"\", ");
				out.println("			\"gb1_no\":\""+gb1_no+"\", ");
				out.println("			\"IsSponsor\":\""+IsSponsor+"\", ");
				out.println("			\"adultImageFlag\":\""+adultImageFlag+"\", ");
				out.println("			\"cashMinPrc\":\""+cashMinPrc+"\", ");
				out.println("			\"cashMinPrcStr\":\""+FmtStr.moneyFormat(cashMinPrc+"")+"\", ");
				out.println("			\"cashMinPrcYn\":\""+cashMinPrcYn+"\", ");
				out.println("			\"ovsMinPrcYn\":\""+ovsMinPrcYn+"\", ");
				out.println("			\"tlcMinPrc\":\""+lngTlcMinPrc+"\", ");
				out.println("			\"tlcMinPrcStr\":\""+FmtStr.moneyFormat(lngTlcMinPrc+"")+"\", ");

			}
			if(dataType==1 && listType!=9) {
				out.println("			\"kb_num\":\""+kb_num+"\", ");
				out.println("			\"kb_title\":\""+toJS(kb_title)+"\", ");
				out.println("			\"url1\":\""+ toUrlCode(url1) +"\", ");
				out.println("			\"bBigImageYN\":\""+bBigImageYN+"\", ");
				out.println("			\"modelCateLink\":\""+modelCateLink+"\", ");
				out.println("			\"goods_info\":\""+toJS(goods_info)+"\", ");
				
				if(goods_data[i].getBbs_num() > 1 ){
					out.println("			\"bbsNum\":\""+FmtStr.moneyFormat(goods_data[i].getBbs_num()+"")+"\", ");
				}
				
				if(goods_data[i].getBbs_num() > 1 && sale_cnt > 9){
					out.println("			\"sale_cnt\":\"판매량("+FmtStr.moneyFormat(sale_cnt+"")+")\", ");
				}
				
				//out.println("			\"mallcnt\":\""+((mallcnt==0)?"":FmtStr.moneyFormat(mallcnt+""))+"\", ");
				out.println("			\"mallcnt\":\""+FmtStr.moneyFormat(mallcnt+"")+"\", ");
				out.println("			\"ca_code\":\""+ca_code+"\", ");
				out.println("			\"modelnm\":\""+modelnm+"\", ");
				//out.println("			\"modelnm\":\""+modelName+"\", ");
				out.println("			\"keyword2\":\""+keyword2+"\", ");
				out.println("			\"strCategoryName\":\""+toJS(strCategoryName)+"\", ");
				out.println("			\"price_txt1\":\""+goods_data[i].getPic_txt_1()+"\", ");
				out.println("			\"price_txt2\":\""+goods_data[i].getPic_txt_2()+"\", ");
				out.println("			\"price_txt3\":\""+goods_data[i].getPic_txt_3()+"\", ");
				out.println("			\"strSpec\":\""+toJS(strSpec)+"\", ");
				out.println("			\"modelnoID\":\""+modelnoID+"\", ");
				out.println("			\"mksp_model_no\":\""+mksp_model_no+"\", ");
				
			}
			out.println("			\"pList_modelno\":\""+goods_data[i].getModelno_group()+"\" ");

			out.print("			}");

			goodsCnt++;
			listFirstPrintFlag = true;
		}
	}
	out.println("\r\n	], ");
}
out.println("	\"goodsCnt\":\""+goodsCnt+"\",");
out.println("	\"priceSum\":\""+FmtStr.moneyFormat(priceSum+"")+"\" ");

%>
}
<%!
	public void log(HttpServletRequest request, String k, String v) throws Exception {
		String uri = request.getRequestURI();
		String servername = request.getServerName();
		if(servername.indexOf("dev.enuri") > -1 ){
			System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+" "+uri+" ] => ["+k+"] = ["+v+"]");
		}
	}
%>
