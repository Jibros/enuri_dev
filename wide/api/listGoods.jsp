<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.ZonedDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ page import="com.google.common.collect.ArrayListMultimap"%>
<%@ page import="com.google.common.collect.Multimap"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Change_Data"%>
<%@ page import="com.enuri.bean.knowbox.Know_termdic_title_Proc"%>
<%@ page import="com.enuri.bean.wide.Wide_List_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.ad.SrpAdCmpnProc"%>
<%@ page import="com.enuri.bean.ad.SrpAdvCmpnData"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Data"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Coupon_Layer_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.global.Global_Shop_Json"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Category_Set_Data"%>
<%@ page import="com.enuri.bean.logdata.Model_log_Proc"%>
<%@ page import="com.enuri.bean.wide.Search_Comparator"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Wide_List_Proc" class="com.enuri.bean.wide.Wide_List_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search_Lsv_Proc" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"  />
<jsp:useBean id="SrpAdCmpnProc" class="com.enuri.bean.ad.SrpAdCmpnProc" scope="page" />
<jsp:useBean id="Coupon_Layer_Proc" class="com.enuri.bean.lsv2016.Coupon_Layer_Proc" scope="page" />
<jsp:useBean id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean id="Lp_Header_Proc" class="com.enuri.bean.wide.Lp_Header_Proc" scope="page" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" scope="page" />
<%

	/**
	 * @history
	 	2020.12.24. ????????????
	 	2021.09.08. 2??? ??????
	*/
	
	/** Parameter Sets */
	// ??????????????? ( list , search )
	String strFrom = ConfigManager.RequestStr(request, "from", "list");
	// ???????????? ?????? ( pc , mw , aos, ios, all )
	String strDevice = ConfigManager.RequestStr(request, "device", "pc");
	strDevice = strDevice.toLowerCase();
	// ?????????
	String strAppVersion = ConfigManager.RequestStr(request, "appVersion", "");
	int intAppVersion = 0;
	if(strAppVersion.length()>0) {
		strAppVersion = strAppVersion.replace(".", "");
		strAppVersion = CutStr.cutStr(strAppVersion,3);
		intAppVersion = Integer.parseInt(strAppVersion);
	}
		
	// ????????????
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
	
	// ???(???????????????) ( 0:?????? / 1:??????????????? / 2:????????????????????? / 3:????????????)
	int intTab = ChkNull.chkInt(request.getParameter("tab"), 0);
	// ????????? ????????? ???????????? ??? ??????
	/*
		1259 ????????????
		1487 ????????????
		1488 ??????????????????
	*/
	if(!strDevice.equals("pc") && strFrom.equals("list") && (strCate4.equals("1487") || strCate4.equals("1488") || strCate4.equals("1259"))) {
		intTab = 2;
	}
	
	// ????????? ?????? ??????
	String strIsDelivery = ConfigManager.RequestStr(request, "isDelivery", "N");
	// ???????????? ????????? ?????? ??????
	/*if(!strDevice.equals("pc")) {
		strIsDelivery = "Y";
	}*/
	
	// ??????/?????? ?????? ??????
	String strIsRental = ConfigManager.RequestStr(request, "isRental", "N");
	// ????????? ??????
	int pageNum = ChkNull.chkInt(request.getParameter("pageNum"), 1);
	// ???????????? ?????? ??????
	int pageGap = ChkNull.chkInt(request.getParameter("pageGap"), 30);
	// ??????
	/**
	1. ?????????  // popular DESC
	2. ???????????? // minprice3 ASC
	3. ???????????? // minprice3 DESC
	4. ???????????? // c_date DESC
	5. ???????????? // sale_cnt DESC
	6. ????????? ?????? ??? // bbs_num DESC
	7. ???????????? ??? // newGoods ASC
	8. ???????????? // dc_rt DESC
	9. ?????????(?????????????????????) // npopular DESC
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
	// ????????? ?????? ?????? ??? minprice3 -> minprice2 ??? ?????????.
	if(strIsDelivery.equals("Y")) {
		if(strSort.indexOf("minprice2")<0) strSort = ReplaceStr.replace(strSort, "minprice3", "minprice2");
	}
	
	// ?????????
	String strParamFactory = ChkNull.chkStr(request.getParameter("factory"), "");
	// ????????? ??????
	String strParamFactoryCode = ChkNull.chkStr(request.getParameter("factory_code"), "");
	// ?????????
	String strParamBrand = ChkNull.chkStr(request.getParameter("brand"), "");
	// ????????? ??????
	String strParamBrandCode = ChkNull.chkStr(request.getParameter("brand_code"), "");
	// ???????????????
	String strParamShopCode = ChkNull.chkStr(request.getParameter("shopcode"), "");
	// ?????????
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"), "");
	// ?????? ??? ?????????
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"), "");
	// ????????? ?????? - ??????
	long lngSPrice = ChkNull.chkLong(request.getParameter("s_price"), 0);
	// ????????? ?????? - ???
	long lngEPrice = ChkNull.chkLong(request.getParameter("e_price"), 0);
	// ??????
	String strSpec = ChkNull.chkStr(request.getParameter("spec"), "");
	// ?????????
	String strSpecName = ChkNull.chkStr(request.getParameter("spec_name"), "");
	// ??????????????? 
	String strIsReSearch = ChkNull.chkStr(request.getParameter("isReSearch"), "Y");
	// ????????? ?????? ??????
	String strIsTest = ChkNull.chkStr(request.getParameter("isTest"), "N");
	boolean devFlag = false;
	if(strIsTest.equals("Y")){
		devFlag = true;
	}
	// ?????????????????????
	String strPrtModelNo = ChkNull.chkStr(request.getParameter("prtmodelno"), "");
	// ???????????? ?????? ?????? ??????
	String strIsMakeShop = ChkNull.chkStr(request.getParameter("isMakeshop"), "N");
	// ??????(??????) - ????????????
	String strColor = ChkNull.chkStr(request.getParameter("color"), "");
	// ?????????
	String strDiscount = ChkNull.chkStr(request.getParameter("discount"), "");
	// ??????
	String strBbsScore = ChkNull.chkStr(request.getParameter("bbsscore"), "");
	
	// ??? T1
	String strAppT1 = ChkNull.chkStr(request.getParameter("t1"), "");
	// ??? PD
	String strAppPD = ChkNull.chkStr(request.getParameter("pd"), "");
	
	PDManager_PD_Data pdData = new PDManager_PD_Data();
	if((strDevice.equals("aos") || strDevice.equals("ios")) && strAppT1.length()>0 && strAppPD.length()>0) {
		PDManager_Proc pdmanager = new PDManager_Proc();
		PDManager_T1_Data t1Data = pdmanager.getT1(request);
		pdData = pdmanager.chkT1PD(request,t1Data);
	}
	/** // Parameter Sets */
	
	/** Parameter Validation Check */
	boolean blParam = true;
	JsonResponse ret = null;
	if(strFrom.equals("list") && strCate.length()==0) { // LP ?????? ???????????? ????????? ??????
		blParam = false;
	} else if(strFrom.equals("list") && (strCate.length()!=4 && strCate.length()!=6 && strCate.length()!=8)) { // LP ?????? ???????????? ???????????? ???????????? ????????? ??????
		blParam = false;
	} else if(strFrom.equals("search") && strKeyword.trim().length()==0) { // SRP ?????? ????????? ????????? ??????
		blParam = false;
	}
	
	if(!blParam) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	/** // Parameter Validation Check */
	
	// ?????? ????????? ?????? ??????
	if(strDevice.equals("pc") || strDevice.equals("mw")) {
		strParamFactory = URLDecoder.decode(strParamFactory, "UTF-8");
		strParamBrand = URLDecoder.decode(strParamBrand, "UTF-8");
		strKeyword = URLDecoder.decode(strKeyword, "UTF-8");
		strInKeyword = URLDecoder.decode(strInKeyword, "UTF-8");
		strSpecName = URLDecoder.decode(strSpecName, "UTF-8");
	}
	
	// ????????? 100??? ???????????? ?????????
	if(strKeyword.length()>100) {
		strKeyword = strKeyword.substring(0,100);
	}
	
	// ????????? ????????? ?????? ??? ??????/????????? ??????
	if( (strDevice.equals("mw") || strDevice.equals("aos") || strDevice.equals("ios")) && intSort==2) {
		strIsRental = "Y";
	}

	Map<String, Object> retMap = new JsonMap<String, Object>();
	Wide_List_Proc wide_list_proc = new Wide_List_Proc();
	
	// ???????????? ????????? ???????????? ?????? ????????? ?????????
	// ?????? ?????? ????????? ?????????(????????????????????? ?????? ??????)
	String[] removeKeywordCharAry = { "|", ",", "'" };
	for(int i=0; i<removeKeywordCharAry.length; i++) {
		strKeyword = strKeyword.replace(removeKeywordCharAry[i], " ");
		strInKeyword = strInKeyword.replace(removeKeywordCharAry[i], " ");
	}
	
	// ???????????? ????????????
	String strEtcCate = wide_list_proc.getGroupModelManual(strCate, devFlag);
	if(strEtcCate.length()==6) {
		strEtcCate = strEtcCate + "*";
	}
	
	/** Supertop AD */
	/*
	// ????????? ?????? ??????
	1. 1?????????????????? ??????
	2. ????????????, ???????????? ???????????? ??????
	3. ????????? ?????? ????????? ( ???, ???????????? ??? ?????? ) 
	4. ???????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????? ?????? ?????? ?????????.
	*/
	Set<String> supertopADModelSet = new HashSet<String>(); // ????????? ?????? ?????? 
	Set<Integer> supertopADNoSet = new HashSet<Integer>(); // ????????? ?????? ?????? ??????
	String strAdNos = "";
	String strAdModelsSearch = "";
	if(pageNum==1 && (intTab==0 || intTab==1) && (intSort==1 || intSort==8) && strIsDelivery.equals("N") && strIsRental.equals("N") && strParamFactory.length()==0 && strParamBrand.length()==0 && lngSPrice==0 && lngEPrice==0 && strInKeyword.length()==0 && strSpec.length()==0) {
		if(strFrom.equals("list")) { // LP
			List<JSONObject> supertopADAry = new ArrayList<JSONObject>(); // LP ????????? A+B ????????? ?????? 
			if(strCate.length()==8) {
				supertopADAry = wide_list_proc.getInfoAdShowRandomModelno(strCate.substring(0,6));
			} else {
				supertopADAry = wide_list_proc.getInfoAdShowRandomModelno(strCate);	
			}
			
			if(supertopADAry.size()>0) {
				for(int i=0;i<supertopADAry.size();i++) {
					JSONObject supertopObj = supertopADAry.get(i);
					if(supertopObj.containsKey("modelno")) {
						int intTmpSponsorModelno = (Integer) supertopObj.get("modelno");
						if(intTmpSponsorModelno>0) {
							// key iterator ??? ???????????? ?????? string ?????? ??????.
							supertopADModelSet.add(String.valueOf(intTmpSponsorModelno));
							if(strAdModelsSearch.length()>0) {
								strAdModelsSearch += ",";
							}
							strAdModelsSearch += "G"+String.valueOf(intTmpSponsorModelno);
						}
					}
					if(supertopObj.containsKey("adno")) {
						int intTmpSponsorADno = (Integer) supertopObj.get("adno");
						supertopADNoSet.add(intTmpSponsorADno);
					}
				}
			}
			
		} else if(strFrom.equals("search")) { // SRP
			boolean isdev = (strIsTest.equals("Y")) ? true : false;
			List<SrpAdvCmpnData> sacdList = SrpAdCmpnProc.getSeachSponsorModelList(strKeyword.toUpperCase(), isdev) ;
			if(sacdList.size()>0) {
				for(int i=0;i<sacdList.size();i++) {
					SrpAdvCmpnData srpAdvCmpnData = sacdList.get(i);
					if(srpAdvCmpnData.getModel_no()>0) {
						supertopADModelSet.add(String.valueOf(srpAdvCmpnData.getModel_no()));
						if(strAdModelsSearch.length()>0) {
							strAdModelsSearch += ",";
						}
						strAdModelsSearch += "G"+String.valueOf(srpAdvCmpnData.getModel_no());
					}
					if(srpAdvCmpnData.getContentsad_add_no()>0) {
						supertopADNoSet.add((Integer) srpAdvCmpnData.getContentsad_add_no());
					}
				}
			}
		}
		// ?????? ??? ?????? ??????
		if(supertopADNoSet.size()>0) {
			Iterator<Integer> iter = supertopADNoSet.iterator();
			while(iter.hasNext()) {
				strAdNos += iter.next() + ",";
			}
		}
		if(strAdNos.length()>0) {
			strAdNos = strAdNos.substring(0, strAdNos.length()-1);
		}
		
	}
	retMap.put("supertopADNos", "\""+strAdNos+"\"");
	// retMap.put("supertopADModels", "\""+strAdModelsSearch+"\"");
	/** // Supertop AD */
	
	/** ES Search */
%><%@ include file="/wide/include/IncEsSearch.jsp"%><%
	/** // ES Search */
	
	/** Oracle Data Fetch */
	Goods_Data goods_data = null;
	Map<String, Goods_Data> goods_data_map = new HashMap<String, Goods_Data>(); // ??????,???????????? ???
	Pricelist_Data pricelist_data = null;
	Map<String, Pricelist_Data> pricelist_data_map = new HashMap<String, Pricelist_Data>(); // ???????????? ???
	List<JSONObject> goodsOrderList = new ArrayList<JSONObject>();
	List<String> queryModelList = new ArrayList<String>(); // ?????? ?????? goods modelno
	List<String> queryPlnoList = new ArrayList<String>(); // ?????? ?????? pricelist plno
	DecimalFormat formatter = new DecimalFormat("###,###");
	
	// ????????? ??????????????? ?????? ?????? ??????????????? ?????? ??????
	if(strAdModelsSearch.length()>0) {
		String[] splitAdModels = strAdModelsSearch.split(",");
		
		for(int i=0;i<splitAdModels.length;i++) {
			JSONObject tmpObject = new JSONObject();
			
			tmpObject.put("dataid", splitAdModels[i]);
			if(adHitsSourceMap.containsKey(splitAdModels[i])) {
				
				JsonMap<String, Object> tmpDataMap = (JsonMap<String, Object>) adHitsSourceMap.get(splitAdModels[i]);
				
				JSONObject tmpGroupModelObject = new JSONObject();
				List<JSONObject> tmpGroupModelList = new ArrayList<JSONObject>();
				
				int tmpDiscountRate = 0;
				if(tmpDataMap.containsKey("sub_models")) {
					List<HashMap<String, String>> subModelsArray = ((ArrayList<HashMap<String, String>>) tmpDataMap.get("sub_models"));
					List<Search_Comparator> rankComparator = new ArrayList<Search_Comparator>();
					
					for(int s=0;s<subModelsArray.size();s++) {
				
						HashMap<String, String> parseMap = (HashMap<String, String>) subModelsArray.get(s);
						
						String parseModelno = (parseMap.containsKey("modelno")) ? (String) parseMap.get("modelno") : "0";
						int parsePopular = (parseMap.containsKey("popular")) ? Integer.parseInt((String) parseMap.get("popular")) : 0;
						int parseModelSort = (parseMap.containsKey("model_sort")) ? Integer.parseInt((String) parseMap.get("model_sort")) : 0;
						String parseCondiname = (parseMap.containsKey("condiname")) ? (String) parseMap.get("condiname") : "";
						
						if(!parseModelno.equals("0")) {
							JSONObject subModelObject = new JSONObject();
							subModelObject.put("data_subid", "G"+parseModelno);
							tmpGroupModelList.add(subModelObject);
							queryModelList.add(parseModelno);
							
							if( !(parseCondiname.indexOf("??????")>=0 || parseCondiname.indexOf("??????")>=0 || parseCondiname.indexOf("????????????")>=0) ) {
								Search_Comparator compData = new Search_Comparator();
								compData.setModelno(parseModelno);
								compData.setPopular(parsePopular);
								compData.setModelSort(parseModelSort);
								rankComparator.add(compData);
							}
						}
					}
					
					Collections.sort(rankComparator, new Comparator<Search_Comparator>(){
						@Override
						public int compare(Search_Comparator c1, Search_Comparator c2) {
							if(c1.getPopular()<c2.getPopular()) {
								return 1;
							} else if(c1.getPopular()>c2.getPopular()) {
								return -1;
							} else {
								return 0;
							}
						}
					});
					
					List<String> rankModelArray = new ArrayList<String>(); // ???????????????
					if(rankComparator.size()>=3) {
						tmpObject.put(rankComparator.get(0).getModelno(), "1");
						rankModelArray.add(rankComparator.get(0).getModelno());
					}
					if(rankComparator.size()>=4) {
						tmpObject.put(rankComparator.get(1).getModelno(), "2");
						rankModelArray.add(rankComparator.get(1).getModelno());
					}
					if(rankComparator.size()>=8) {
						tmpObject.put(rankComparator.get(2).getModelno(), "3");
						rankModelArray.add(rankComparator.get(2).getModelno());
					}
					tmpObject.put("rankArray", rankModelArray);
				}
				
				tmpGroupModelObject.put("list", tmpGroupModelList);
				tmpObject.put("groupModelTemp", tmpGroupModelObject);
				
				// ?????????
 				String strDcrt = (tmpDataMap.containsKey("dc_rt")) ? (String) tmpDataMap.get("dc_rt") : "";
				// ????????? ???????????? ???????????? ?????? ??????.
				if(strDiscount.length()>0) {
					tmpObject.put("strDiscountRate", strDcrt);
				} else {
					tmpObject.put("strDiscountRate", "");
				}
				
				String strOpnPrc = (tmpDataMap.containsKey("opn_prc")) ? (String) tmpDataMap.get("opn_prc") : "";
				if(strOpnPrc.length()>0) {
					tmpObject.put("strExtraPrice", formatter.format(Long.parseLong(strOpnPrc)));
				} else {
					tmpObject.put("strExtraPrice", "");
				}
				
				goodsOrderList.add(tmpObject);
			}
		}
		
	}
	
	if(strMpnos.length()>0) { // ES??? ????????? ??????
		String[] splitMpNos = strMpnos.split(",");
		
		for(int i=0;i<splitMpNos.length;i++) {
			if(splitMpNos.length>0) {
				JSONObject tmpObject = new JSONObject();
				String tmpProdType = splitMpNos[i].substring(0, 1);
				String strDcrt = ""; // ?????????
				String strOpnPrc = ""; // ?????????/?????????
				
				tmpObject.put("dataid", splitMpNos[i]);
				
				if(tmpProdType.equals("G")) { // ???????????? ??????
	
					if(hitsSourceMap.containsKey(splitMpNos[i])) {
					
						JsonMap<String, Object> tmpDataMap = (JsonMap<String, Object>) hitsSourceMap.get(splitMpNos[i]);
					
						JSONObject tmpGroupModelObject = new JSONObject();
						List<JSONObject> tmpGroupModelList = new ArrayList<JSONObject>();
						
						int tmpDiscountRate = 0;
						if(tmpDataMap.containsKey("sub_models")) {
							List<HashMap<String, String>> subModelsArray = ((ArrayList<HashMap<String, String>>) tmpDataMap.get("sub_models"));
							List<Search_Comparator> rankComparator = new ArrayList<Search_Comparator>();
							
							for(int s=0;s<subModelsArray.size();s++) {
						
								HashMap<String, String> parseMap = (HashMap<String, String>) subModelsArray.get(s);
								
								String parseModelno = (parseMap.containsKey("modelno")) ? (String) parseMap.get("modelno") : "0"; // ????????????
								int parsePopular = (parseMap.containsKey("popular")) ? Integer.parseInt((String) parseMap.get("popular")) : 0;
								int parseModelSort = (parseMap.containsKey("model_sort")) ? Integer.parseInt((String) parseMap.get("model_sort")) : 0;
								String parseCondiname = (parseMap.containsKey("condiname")) ? (String) parseMap.get("condiname") : "";
								
								if(!parseModelno.equals("0")) {
									JSONObject subModelObject = new JSONObject();
									subModelObject.put("data_subid", "G"+parseModelno);
									tmpGroupModelList.add(subModelObject);
									queryModelList.add(parseModelno);
									
									if( !(parseCondiname.indexOf("??????")>=0 || parseCondiname.indexOf("??????")>=0 || parseCondiname.indexOf("????????????")>=0) ) {
										Search_Comparator compData = new Search_Comparator();
										compData.setModelno(parseModelno);
										compData.setPopular(parsePopular);
										compData.setModelSort(parseModelSort);
										rankComparator.add(compData);
									}
								}
							}
								
							Collections.sort(rankComparator, new Comparator<Search_Comparator>(){
								@Override
								public int compare(Search_Comparator c1, Search_Comparator c2) {
									if(c1.getPopular()<c2.getPopular()) {
										return 1;
									} else if(c1.getPopular()>c2.getPopular()) {
										return -1;
									} else {
										return 0;
									}
								}
							});
							
							List<String> rankModelArray = new ArrayList<String>(); // ???????????????
							if(rankComparator.size()>=3) {
								tmpObject.put(rankComparator.get(0).getModelno(), "1");
								rankModelArray.add(rankComparator.get(0).getModelno());
							}
							if(rankComparator.size()>=4) {
								tmpObject.put(rankComparator.get(1).getModelno(), "2");
								rankModelArray.add(rankComparator.get(1).getModelno());
							}
							if(rankComparator.size()>=8) {
								tmpObject.put(rankComparator.get(2).getModelno(), "3");
								rankModelArray.add(rankComparator.get(2).getModelno());
							}
							tmpObject.put("rankArray", rankModelArray);
						}
							
						tmpGroupModelObject.put("list", tmpGroupModelList);
						tmpObject.put("groupModelTemp", tmpGroupModelObject);
						
						// ?????????
						strDcrt = (tmpDataMap.containsKey("dc_rt")) ? (String) tmpDataMap.get("dc_rt") : "";
						// ?????????/?????????
						strOpnPrc = (tmpDataMap.containsKey("opn_prc")) ? (String) tmpDataMap.get("opn_prc") : "";
						
					}
				} else if(tmpProdType.equals("P")) { // ?????? ??????
					queryPlnoList.add(splitMpNos[i].substring(1));
				}
				
				// ????????? ???????????? ???????????? ?????? ??????.
				if(strDiscount.length()>0) {
					tmpObject.put("strDiscountRate", strDcrt);
				} else {
					tmpObject.put("strDiscountRate", "");
				}
				
				if(strOpnPrc.length()>0) {
					tmpObject.put("strExtraPrice", formatter.format(Long.parseLong(strOpnPrc)));
				} else {
					tmpObject.put("strExtraPrice", "");
				}

				goodsOrderList.add(tmpObject);
			}
		}
	}
	
	// ?????? ???????????? ( LP ??? ?????? ???????????? , SRP ??? 1??? ????????? ??? ????????????  ) 
	String strCateCode = strCate;
	
	// ????????? ????????? ?????? ??????
	int intNonAdItemCount = 0;
	
	List<JSONObject> listJson = new ArrayList<JSONObject>();

	//?????? ?????? ?????? ????????? (?????? ?????????)
	Map<String, Object> iconAttr = null;
	// ?????? ?????? ????????? (?????? ?????????)
	Map<String, Object> adAttr = null;
	// LP ???????????? ?????? ?????????(?????? ?????????)
	Map<String, Object> lpEtcAttr = null;
	// ???????????? ?????? ?????? 
	Map<String, Object> priceAttr = null;

	Gson gson = new Gson();
	
	// ??????????????? pricelist ???????????? ????????????
	if(intTab==2) {
	
		/** Oracle Data Fetch */
		try {
			pricelist_data_map = wide_list_proc.getPricelistData(queryPlnoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	// ??????, ????????????
	} else {
		
		/** Oracle Data Fetch */
		try {
			// ??????????????? ?????? ????????? 1000?????? ????????? ?????? ????????? ????????????.
			// oracle where in 1000??? ??????
			if(queryModelList.size()>1000) {
				int roopCount = (queryModelList.size() / 1000) + 1;
				int model_param_length = queryModelList.size(); // ??????????????? ?????? ?????? ??????
				for(int i=0;i<roopCount;i++) {
					List<String> tmp_queryModelList = new ArrayList<String>(); // ?????? ?????? goods modelno
					int calcLength = (model_param_length>1000) ? 1000 : model_param_length;
					for(int j=((roopCount-1)*1000);j<(((roopCount-1)*1000)+calcLength);j++) {
						tmp_queryModelList.add(queryModelList.get(j));
					}
					
					Map<String, Goods_Data> tmp_goods_data_map = new HashMap<String, Goods_Data>();
					if(tmp_queryModelList.size()>0) {
						if(i==0) {
							tmp_goods_data_map = wide_list_proc.getData(tmp_queryModelList, queryPlnoList);
						} else {
							tmp_goods_data_map = wide_list_proc.getData(tmp_queryModelList, null);
						}
						goods_data_map.putAll(tmp_goods_data_map);
					}
				}
				
			} else {
				if(queryModelList.size()>0 || queryPlnoList.size()>0) {
					goods_data_map = wide_list_proc.getData(queryModelList, queryPlnoList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/** ???????????? ?????? ????????? ?????? */
	boolean IsAdultFlag = false;
	String strAdultCookie = "";
	HashSet<String> cateListHashSet = new HashSet<String>();
	HashMap<String, HashMap<String,Integer>> tHashMap = new HashMap<String, HashMap<String,Integer>>();
	//????????? ?????? ????????? ?????? ??????
	String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();
	HashMap	cardNameHash = getCardNameHash();
	String strCouponContents = "";
	String[][] CouponLayerAry = Coupon_Layer_Proc.getCouponLayerList(1); // ?????? ??????
	Map<Integer,Integer> hitBrandMap = new HashMap<Integer, Integer>();
	Map<Integer, List<JSONObject>> cosmeticMap = new HashMap<Integer, List<JSONObject>>();
	Map<Integer, List<JSONObject>> furnitureMap = new HashMap<Integer, List<JSONObject>>();
	boolean bAdultKeyword = false;
	Global_Shop_Json shopJson = new Global_Shop_Json();
	Map<Integer, Object> shopMap = shopJson.parseGlobalShopListJson();
	// ????????? - ????????????
	Set<Integer> zzimModelSet = new HashSet<Integer>();
	// ????????? - PriceList
	Set<Long> zzimPLSet = new HashSet<Long>();
	// ????????? - ????????????
	Set<String> zzimMKSet = new HashSet<String>();
	// ????????? ID
	String strUserId = "";
	String strUserUct = "";
	if(strDevice.equals("pc") || strDevice.equals("mw")) {
		if(cb.GetCookie("MEM_INFO","USER_ID")!=null) {
			strUserId = cb.GetCookie("MEM_INFO", "USER_ID");
			
		}
	} else if(strDevice.equals("aos") || strDevice.equals("ios")) {
		if(pdData!=null){
			strUserId = pdData.getEnuri_id();
		}
	}
	if(strUserId != null && !strUserId.equals("")) {
		strUserUct = Login_Proc.getUsrMtcEnc(strUserId);
	}
	
	

	// ??????????????? ????????????
	Category_Set_Proc category_set_proc = new Category_Set_Proc();
	Category_Set_Data[] category_set_data = category_set_proc.getCategorySetList("");
	HashMap<Integer, Goods_Change_Data> groupModelnosInfoHash = new HashMap<Integer, Goods_Change_Data>();
	Set<Integer> modelVideoSet = new HashSet<Integer>();
	Map<Integer, HashMap<String, String>> promotionMap = new HashMap<Integer, HashMap<String, String>>();
	
	/** ????????? ?????? ????????? ??????????????? ????????? ???????????? ?????? */
	if(goodsOrderList.size()>0) {
		
		if(goods_data_map.size()>0 || pricelist_data_map.size()>0) {
		
			/**?????????????????? ????????? ?????? ?????? ?????? */
			if(intTab==2) {
			
			/**??????, ?????????????????? ????????? ?????? ?????? ??????*/
			} else {
				
				// ????????????
				if(strFrom.equals("search")) {
					String[] astrMcates = null;
					astrMcates = strMcates.split(",");
					if(astrMcates!=null && astrMcates.length>0) {
						for(int i=0; i<astrMcates.length; i++) {
							cateListHashSet.add(astrMcates[i]);
						}
					}
					
					if(cateListHashSet.size()>0) {
						tHashMap = Know_termdic_title_Proc.getCondiNameToDicSrp(cateListHashSet);
					}
				}else{
					cateListHashSet.add(strCate4);
					tHashMap = Know_termdic_title_Proc.getCondiNameToDicSrp(cateListHashSet);
				}
				
				// ??????????????? ?????? ??????
				hitBrandMap = wide_list_proc.getHitBrandItem();
				
				// ?????????
				if(strFrom.equals("list") && ( strCate2.equals("08") || strCate2.equals("14"))) {
					cosmeticMap = wide_list_proc.getCptSkinGoodness_mobile_getAllmodel(strModelNo_Group, strCate4);
				}
				
				// ??????
				if(strFrom.equals("list") && ( strCate4.equals("1202") || strCate4.equals("1201")) ) {
					furnitureMap = wide_list_proc.getGoodsAttrGraph(strModelNo_Group, "123660,211331,133553,205023");
				}
				
				// ????????? ??????
				modelVideoSet = wide_list_proc.getVideoModelSet(strModelNo_Group);
				
				// ????????????
				promotionMap = wide_list_proc.getPromotionMap(strModelNo_Group, strFrom);
				
				// ?????? ??????
				// ??????????????? ?????????????????? ?????? ????????? ????????????
				Goods_Change_Data[] goods_change_data = null;
				if(queryModelList.size()>0) {
					// ????????? where in ?????? ?????? ?????? ??????, ????????? ?????? ?????? ?????? ??????.
					if(queryModelList.size()>1000) {
						ArrayList<Goods_Change_Data> sumChangeData = new ArrayList<Goods_Change_Data>();
						Goods_Change_Data[] tmpChangeData = null;
						int model_param_length = queryModelList.size();
						int roopCount = (model_param_length / 1000) + 1;
						int m = 0;
						for(int i=0;i<roopCount;i++) {
							int calcLength = (model_param_length>1000) ? 1000 : model_param_length;
							List<String> tmpModelsParamAry = new ArrayList<String>();
							for(int j=(m*1000);j<((m*1000)+calcLength);j++) {
								tmpModelsParamAry.add(queryModelList.get(j));
							}
							tmpChangeData = wide_list_proc.getGoods_Bind_Change(tmpModelsParamAry);
							for(int l=0;l<tmpChangeData.length;l++) {
								sumChangeData.add(tmpChangeData[l]);
							}
							
							model_param_length = model_param_length - calcLength;
							m++;
						}
						
						if(sumChangeData.size()>0) {
							goods_change_data = (Goods_Change_Data[]) sumChangeData.toArray(new Goods_Change_Data[0]);
						}
						
					} else {
						goods_change_data = wide_list_proc.getGoods_Bind_Change(queryModelList);
					}
					
					if(goods_change_data!=null && goods_change_data.length>0) {
						for(int i=0; i<goods_change_data.length; i++) {
							groupModelnosInfoHash.put(goods_change_data[i].getModelno(), goods_change_data[i]);
						}
					}
				}
			}
			
			/**?????? ?????? ??????*/
			
			// ?????? ??????
			if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
				strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
				// ???????????? ??? 
				if(strAdultCookie.equals("1")) IsAdultFlag = true;
			}
		
			// ???????????????
%>
<%@ include file="/include/IncAdultKeywordCheck_2010.jsp" %>
<%
				
			//????????? ????????? ??????
			String strMViewFlag = "1";
			if(strFrom.equals("list")) {
				Goods_Search_Lsv_Data viewTypeOptionInfo = Goods_Search_Lsv_Proc.getSearchOptionSet(strCate4);
				if(viewTypeOptionInfo.getViewtype_m_flag()!=null && viewTypeOptionInfo.getViewtype_m_flag().length()>0) {
					strMViewFlag = viewTypeOptionInfo.getViewtype_m_flag();
				}
			}
			retMap.put("mViewFlag", "\""+strMViewFlag+"\"");
			
			// ????????? ?????? ( ????????? )
			// LP ??? ????????? ?????? ??????, SRP ??? ????????? ?????? 
			// 0 ?????? 1 ????????? 2 ?????????
			String list_search_flag = "1";
			if(strFrom.equals("list")) {
				Goods_Search_Lsv_Data optionInfo = Goods_Search_Lsv_Proc.getSearchOptionSet(strCate);
				list_search_flag = optionInfo.getList_serch_flag();
				if(list_search_flag.length()==0) {
					String strServerNm = request.getServerName();
					boolean blDevFlag = false;
					if (strServerNm.indexOf("dev.enuri.com") > -1) {
						blDevFlag = true;
					}
					
					JSONObject sfViewYNObj = new JSONObject();
					sfViewYNObj =  Lp_Header_Proc.getFactoryBrandViewYN(strCate, blDevFlag);
					
					String sf_factory_viewYN = sfViewYNObj.get("factoryViewYN") != null ?  sfViewYNObj.get("factoryViewYN").toString() : "";
					String sf_brand_viewYN = sfViewYNObj.get("brandViewYN") != null ?  sfViewYNObj.get("brandViewYN").toString() : "";  
					if(sf_factory_viewYN.equals("") || sf_factory_viewYN.equals("Y")) {
						list_search_flag = "1";
					} else if(sf_brand_viewYN.equals("") || sf_brand_viewYN.equals("Y")) {
						list_search_flag = "2";
					}
				}
			}
			retMap.put("strReSearch", "\""+list_search_flag+"\"");
		}
	
		// ???
		if(strUserId.length()>0) {
			Goods_Data[] goods_save_data = Goods_Search_Lsv_Proc.getSaveGoodList2022(strUserId);
			
			if(goods_save_data!=null && goods_save_data.length>0) {
				
				for(int i=0; i<goods_save_data.length; i++) {
					int modelno = goods_save_data[i].getModelno();
					long pl_no = goods_save_data[i].getP_pl_no();
					String mk_no = goods_save_data[i].getMksp_model_no();
					
					if(modelno>0) {
						zzimModelSet.add(modelno);
					}
					if(pl_no>0) {
						zzimPLSet.add(pl_no);
					}
					if(!mk_no.equals("0") && mk_no.length()>0) {
						zzimMKSet.add(mk_no);
					}
				}
			}
		}
	}
	
	JSONObject relProdBtnTextObj = getRelProdBtnTextObj(); //?????? ???????????? ?????????
				
	/** goodsOrderList??? ??????????????? ??????????????? ????????? */
	for(int g=0;g<goodsOrderList.size();g++) {
		
		JSONObject listItem = (JSONObject) goodsOrderList.get(g);
			
		iconAttr = new HashMap<String, Object>();
		adAttr = new HashMap<String, Object>();
		lpEtcAttr = new HashMap<String, Object>();
		priceAttr = new HashMap<String, Object>();
		String strTotRank = "0";
		
		if(listItem.containsKey("dataid")) {

			String targetID = (String) listItem.get("dataid");
			
			strTotRank = String.valueOf((pageGap*(pageNum-1))+(intNonAdItemCount+1));
			
			// ????????????
			if(intTab==2) {
				
				if(pricelist_data_map.containsKey(targetID)) {
					
					pricelist_data = (Pricelist_Data) pricelist_data_map.get(targetID);
					
					long lngPlno = pricelist_data.getPl_no();
					
					String strGoodsName = StringReplace(pricelist_data.getGoodsnm());
					String strOrgGoodsName = StringReplace(pricelist_data.getGoodsnm());
					int intShopCode = pricelist_data.getShop_code();
					String strShopType = pricelist_data.getShop_type();
					String strSrvFlag = pricelist_data.getSrvflag();
					long lngPrice = pricelist_data.getPrice();
					String strGoodsCode  = pricelist_data.getGoodscode();
					String strPCa_Code = pricelist_data.getCa_code();
					String strUrl = pricelist_data.getUrl();
					String strMobile_url = pricelist_data.getMobile_url();
					String strImgUrl = pricelist_data.getImgurl();
					String strImgUrlFlag = pricelist_data.getImgurlflag();
					long lngInstancePrice = pricelist_data.getInstance_price();
					String strDeliveryInfo = pricelist_data.getDeliveryinfo();
					String strShopName = pricelist_data.getShop_name();
					String strFreeinterest = pricelist_data.getFreeinterest();
					String strGoodsfactory = pricelist_data.getGoodsfactory();
					String strUdate = pricelist_data.getU_date();
					int intDeliverytype2 = pricelist_data.getDeliverytype2();
					int intDeliveryinfo2 = pricelist_data.getDeliveryinfo2();
					
					//?????? ?????? ?????????
					int intBbsNum = pricelist_data.getBbs_num();
					float fltBbsPoint = pricelist_data.getBbs_point();
					
					if(intShopCode==6641 && strUrl.indexOf("<<<mourl>>>")>-1) strUrl = strUrl.substring(0, strUrl.indexOf("<<<mourl>>>"));
					strGoodsName = getRemoveCardSale(cardNameHash, strGoodsName, intShopCode, lngPrice, strPCa_Code, strFreeinterest, cardFreeAry);

					if(strGoodsfactory.trim().length()>0 && strGoodsfactory.trim().indexOf("??????")<0 && strGoodsfactory.trim().indexOf("??????")<0 && strGoodsfactory.indexOf("??????")<0 && strGoodsfactory.trim().indexOf("??????")<0) {
						strGoodsName = "["+strGoodsfactory.trim()+"]"+strGoodsName;
					}
					
					strFreeinterest = getForceFreeInterest2(intShopCode, strPCa_Code, strFreeinterest, lngPrice, cardFreeAry);
					if(strFreeinterest.trim().length()>0) {
						strFreeinterest = "??????: " + strFreeinterest;
					}
					
					if(strDeliveryInfo.trim().length()>0) {
						String strTempDeliveryInfo = strDeliveryInfo;
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,",","");
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"???","");
						if(strTempDeliveryInfo.indexOf("????????????")>=0 || strTempDeliveryInfo.indexOf("??????")>=0 || strTempDeliveryInfo.indexOf("?????????")>=0) {
							strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"??????","????????????");
							strDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"?????????","???????????????");
						} else {
							if(ChkNull.chkNumber(strTempDeliveryInfo)) {
								strDeliveryInfo = "?????????"+FmtStr.moneyFormat(strTempDeliveryInfo)+"???";
							} else {
								strDeliveryInfo = "?????????"+strTempDeliveryInfo;
							}
						}
					}
					
					// ?????????
					if(strSrvFlag.equals("C")) {
						iconAttr.put("cash", new JSONObject());
					}
					
					//???????????? ?????? ???????????? ?????? 20191122
					if( shopMap.containsKey(intShopCode) ) {
						strDeliveryInfo= "????????????(??????)";
						iconAttr.put("ovs", new JSONObject());
					}
					listItem.put("strDeliveryInfo", strDeliveryInfo);

					// ??????
					if(bAdultKeyword || adultKeywordCheck(strGoodsName) || adultCategoryCheck(strPCa_Code) || strSrvFlag.equals("S")) {
						IsAdultFlag = true;
					}
					strImgUrl = getSearchGoodsImage(IsAdultFlag, strAdultCookie, strImgUrl, true);
					
					String adultYN = "N";
					if(IsAdultFlag) adultYN = "Y";
					listItem.put("strAdultYN", adultYN);
					
					// ????????? ????????? ?????????
					long lngPrice2 = lngPrice;
					if(intDeliverytype2==1) lngPrice2 += intDeliveryinfo2;
					
					String strMinPriceMobileTag = "N";
					String intMinPrice = formatter.format(lngInstancePrice);
					if(strIsDelivery.equals("Y")) {
						intMinPrice = formatter.format(lngPrice2);
					} else if(lngInstancePrice==0) {
						intMinPrice = formatter.format(lngPrice);
					} else {
						if(lngInstancePrice>0 && lngPrice>lngInstancePrice) {
							strMinPriceMobileTag = "Y";
						}
					}
					
					// ???????????? ??? price??? instance_price ?????? ??? ?????? price??? ??? ?????????
					if(lngPrice<lngInstancePrice) {
						intMinPrice = formatter.format(lngPrice);
					}
					
					listItem.put("strMinPriceMobileTag", strMinPriceMobileTag);
					listItem.put("strMinPrice", intMinPrice);
					
					strCouponContents = "";
					int coupon = pricelist_data.getCoupon();
					String[] strcoponLayer = getCouponLayerInfo(intShopCode, coupon, (int)lngPrice, 1, CouponLayerAry);
					if(strcoponLayer != null){
						strCouponContents = strcoponLayer[0];
					}
					
					// SRP ??? 1??? ??????
					if(strFrom.equals("search") && g==0) {
						strCateCode = strPCa_Code;
					}
					
					listItem.put("prodType", "P");
					listItem.put("strPlNo", String.valueOf(lngPlno));
					listItem.put("strModelNo", "0");
					listItem.put("strShopCode", String.valueOf(intShopCode));
					listItem.put("strShopName", strShopName);
					listItem.put("strModelName", strGoodsName);
					listItem.put("strLandUrl", strUrl);
					listItem.put("strImageUrl", strImgUrl);
					
					listItem.put("strFreeinterest", strFreeinterest);
					listItem.put("strCouponContents", strCouponContents);
					
					if(strShopType.equals("4")) {
						iconAttr.put("naverpay", new JSONObject()); // ??????????????? ?????????
					}
					
					Date uDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(strUdate);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String strFormatDate = sdf.format(uDate);
					listItem.put("strCdate", strFormatDate);
					
					// 20191101 #36643 bbspoint [Core] APP LP > ???????????? ????????? API ?????? 
					// ??????????????? ?????? ?????? fltBbsPoint ??? bbs_point ??? ???????????? ?????? ??????
					// bbs_point / bbs_num ?????? ??????
					listItem.put("strBbsNum", String.valueOf(intBbsNum));
					if(fltBbsPoint > 5 && intBbsNum > 0) {
						listItem.put("strBbsPoint", String.format("%.1f", fltBbsPoint / intBbsNum));
					} else {
						listItem.put("strBbsPoint", String.valueOf( String.format("%.1f", fltBbsPoint) ));
					}

					// ??? ??????
					String strZzimYN = "N";
					if(zzimPLSet.contains(lngPlno)) {
						strZzimYN = "Y";
					}
					listItem.put("strZzimYN", strZzimYN);
					listItem.put("strOpenExpectYN", "N"); // pricelist ??? ??????????????? ??????.
					
					// ??????
					listItem.put("strTotRank", strTotRank);

					listItem.put("iconAttr", iconAttr);
					listItem.put("adAttr", adAttr);
					listItem.put("lpEtcAttr", lpEtcAttr);
					
					listJson.add(listItem);
					
					intNonAdItemCount++;
				}
				
			// ??????, ???????????? ??????
			} else {
				
				if(goods_data_map.containsKey(targetID)) {
					
					goods_data = (Goods_Data) goods_data_map.get(targetID);
					
					int intModelNo = goods_data.getModelno();
					int intModelNoGroup = goods_data.getModelno_group();
					
					// ????????????
					if(intModelNo==0) {
						listItem.put("prodType", "P");
					} else {
						listItem.put("prodType", "G");
					}
					
					listItem.put("strModelNo", String.valueOf(intModelNo));
					listItem.put("strModelNoRep", String.valueOf(intModelNoGroup));

					String strCa_code = goods_data.getCa_code();
					listItem.put("strCate", strCa_code);
					// SRP ??? 1??? ??????
					if(strFrom.equals("search") && g==0) {
						strCateCode = strCa_code;
					}
					
					String strFactory = goods_data.getFactory();
					String strBrand = goods_data.getBrand();
					String strFactoryID = String.valueOf(goods_data.getFactory_id());
					String strBrandID = String.valueOf(goods_data.getBrand_id());
					
					String strModelName = "";
					if(goods_data.getModelnm()!=null) {
						strModelName = goods_data.getModelnm();
					}
					if(intModelNo>0) {
						if(!(strCate2.equals("93"))) {
							if(strModelName.lastIndexOf("[")>0) {
								strModelName = strModelName.substring(0,strModelName.lastIndexOf("["));
							}
						}
					}
						
					String[] strModel_FBN = getModel_FBN_2016(strCate, strModelName, strFactory, strBrand, category_set_data);
					String strFormatModelnm = strModelName;
					if(intModelNo>0) {
						strFormatModelnm = strModel_FBN[1] +" "+  strModel_FBN[2] +" "+ strModel_FBN[0];
					} else {
						String[] tempPriceCodeAry = goods_data.getSpec().split(":");
						if(tempPriceCodeAry!=null && tempPriceCodeAry.length>0) {
							int intShopCode = 0;
							try {
								intShopCode = Integer.parseInt(tempPriceCodeAry[0]);
							} catch(Exception e) {}
		
							if(intShopCode>0) {
								strFormatModelnm = getRemoveCardSale(cardNameHash, strFormatModelnm, intShopCode, goods_data.getMinprice(), strCa_code, goods_data.getFactory_etc(), cardFreeAry);
							}
						}
		
						if(strModel_FBN[1].trim().length()>0 && strModel_FBN[1].trim().indexOf("??????")<0 && strModel_FBN[1].trim().indexOf("??????")<0 && strModel_FBN[1].indexOf("??????")<0 && strModel_FBN[1].trim().indexOf("??????")<0) {
							strFormatModelnm = "["+strModel_FBN[1].trim()+"]"+strFormatModelnm;
						}
					}
					listItem.put("strModelName", strFormatModelnm);
		
					// ????????? , ?????????
					if(strFactory.indexOf("??????")>-1) strFactory = "";
					if(strBrand.indexOf("??????")>-1) strBrand = "";
					
					listItem.put("strFactory", strFactory);
					listItem.put("strFactoryCode", strFactoryID);
					listItem.put("strBrand", strBrand);
					listItem.put("strBrandCode", strBrandID);
					
					// ????????????
					Goods_Change_Data modelnosInfoOne = groupModelnosInfoHash.get(intModelNo);
					String spec_tag = "";
					String spec_tag2= "";
					String spec_tag3= "";
					if(modelnosInfoOne!=null) {
						
						// PC ??? vip tag , ???????????? lp tag 
						if(strDevice.equals("pc")) {
							spec_tag = modelnosInfoOne.getSpec_vip_tag();
							spec_tag2 = modelnosInfoOne.getSpec_vip_tag2();
						} else {
							spec_tag = modelnosInfoOne.getSpec_lp_tag();
							spec_tag2 = modelnosInfoOne.getSpec_lp_tag2();
							spec_tag2 = Goods_Search_Lsv_Proc.getSpecTagDelLink(spec_tag2);
						}
						spec_tag3 = modelnosInfoOne.getSpec_lp_tag3();
					}
					
					// ????????? ?????? ????????? ???????????? ?????? 08 ?????? ml -> mL
					if( (strFrom.equals("list") && strCate2.equals("08")) || (strFrom.equals("search") && strCa_code.length()>=2 && strCa_code.substring(0, 2).equals("08"))) {
						if(spec_tag.indexOf("ml")>-1) {
							spec_tag = spec_tag.replace("ml", "mL");
							listItem.put("strSpec1", spec_tag);
						}
					}
					
					listItem.put("strSpec1", spec_tag);
					listItem.put("strSpec2", spec_tag2);
					listItem.put("strSpec3", spec_tag3);
					
					if(listItem.get("strExtraPrice").equals("")) {
						listItem.put("strExtraPriceTitle", "");
					} else {
					
						// 1: ????????? , 2: ?????????
						int intExtraWordType = 1;
						if(strFrom.equals("list")) {
							
							switch(strCate2) {
								case "02" : intExtraWordType = 2; break;
								case "03" : intExtraWordType = 2; break;
								case "04" : intExtraWordType = 2; break;
								case "05" : intExtraWordType = 2; break;
								case "06" : intExtraWordType = 2; break;
								case "21" : intExtraWordType = 2; break;
								case "22" : intExtraWordType = 2; break;
								case "24" : intExtraWordType = 2; break;
						//		case "14" : listItem.put("strExtraPrice", ""); intExtraWordType = 0; break;
						//		case "25" : listItem.put("strExtraPrice", ""); intExtraWordType = 0; break;
								default : intExtraWordType = 1; break;
							}
							
						} else if(strFrom.equals("search") && strCa_code.length()>=2) {
							
							switch(strCa_code.substring(0, 2)) {
								case "02" : intExtraWordType = 2; break;
								case "03" : intExtraWordType = 2; break;
								case "04" : intExtraWordType = 2; break;
								case "05" : intExtraWordType = 2; break;
								case "06" : intExtraWordType = 2; break;
								case "21" : intExtraWordType = 2; break;
								case "22" : intExtraWordType = 2; break;
								case "24" : intExtraWordType = 2; break;
						//		case "14" : listItem.put("strExtraPrice", ""); intExtraWordType = 0; break;
						//		case "25" : listItem.put("strExtraPrice", ""); intExtraWordType = 0; break;
								default : intExtraWordType = 1; break;
							}
						}
						
						if(intExtraWordType==1) {
							listItem.put("strExtraPriceTitle", "?????????");
						} else if(intExtraWordType==2) {
							listItem.put("strExtraPriceTitle", "?????????");
						} else {
							listItem.put("strExtraPriceTitle", "");
						}
						
						// ??? ?????? ?????? ?????????/????????? ?????? ( ??? 4.0.0 ?????? ?????? ????????? ?????? )
						if((strDevice.equals("aos") || strDevice.equals("ios")) && intAppVersion<400) {
							if(spec_tag.indexOf("?????????") == -1 && spec_tag.indexOf("?????????") == -1 && intExtraWordType > 0) {
								spec_tag = spec_tag + "/" + listItem.get("strExtraPriceTitle") + ": " + listItem.get("strExtraPrice") + "???";
								listItem.put("strSpec1", spec_tag);
							}
						}
					}
					
					/*???????????? V2*/
					JSONObject relProdV2Obj = new JSONObject();
					String strRelProdModelNo = "";
					String strRelProdModelNm = ""; 
					String strRelProdBtnText = "";
					String strTempRelProdBtnText = "";
					String strRelCate = "";
					int intRelProdCnt = 0;
					if (spec_tag3.length() > 0) {
						try{
							String strRelProd = spec_tag3.replaceAll("\\$TAG\\$_", "");
							String strRelProdArr [] = strRelProd.split("\\$END\\$");
							intRelProdCnt = strRelProdArr.length;
							
							for (int i = 0 ; i < intRelProdCnt; i ++)	{
								 if (strRelProdArr[i].indexOf(",") == 0) {
									strRelProdArr[i] = strRelProdArr[i].substring(1, strRelProdArr[i].length());
								} 
								String strTempRelArr [] = strRelProdArr[i].split("_");
								strRelProdModelNo += strTempRelArr[0] +(i == intRelProdCnt-1 ? "" : ",");
								strRelProdModelNm += strTempRelArr[1] +(i == intRelProdCnt-1 ? "" : ",");
							}
							
							strRelCate = strCa_code;
							if (strRelCate.length() >= 6) { 
								strRelCate =  CutStr.cutStr(strRelCate,6);
								strTempRelProdBtnText = (String)relProdBtnTextObj.get(strRelCate);
								if (strTempRelProdBtnText == null) {
									strRelCate =  CutStr.cutStr(strRelCate,4);
									strTempRelProdBtnText = (String)relProdBtnTextObj.get(strRelCate);
								}
							} else {
								strTempRelProdBtnText = (String)relProdBtnTextObj.get(strRelCate);
							}
							strRelProdBtnText = (strTempRelProdBtnText == null ? "????????????" :  strTempRelProdBtnText);
						} catch (Exception e) {}
					}
					relProdV2Obj.put("modelNo", strRelProdModelNo);
					relProdV2Obj.put("modelNm", strRelProdModelNm);
					relProdV2Obj.put("btnText", strRelProdBtnText);	
					relProdV2Obj.put("cnt", intRelProdCnt);	
					listItem.put("relProdV2Obj", relProdV2Obj);
					
					/*?????? ????????????*/
                    JSONObject relProdObj = new JSONObject();
                    JSONArray relProdJarr = new JSONArray();
                    if ((CutStr.cutStr(strCa_code,6).equals("040206") || CutStr.cutStr(strCa_code,6).equals("040209") || CutStr.cutStr(strCa_code,6).equals("040224") || CutStr.cutStr(strCa_code,6).equals("040221")) && spec_tag3.length() > 0) {
                        String strRelProd = spec_tag3.replaceAll("\\$TAG\\$_", "");
                        String strRelProdArr [] = strRelProd.split("\\$END\\$");
                        
                        try {
                        	for (int i = 0 ; i < strRelProdArr.length; i ++)    {
                                if (strRelProdArr[i].indexOf(",") == 0) {
                                   strRelProdArr[i] = strRelProdArr[i].substring(1, strRelProdArr[i].length());
                               } 
                               String strTempRelArr [] = strRelProdArr[i].split("_");
                               relProdJarr.add(i, strTempRelArr[0]);
                           }                        	
                        } catch(Exception e){}
                    }
                    
                    if (relProdJarr.size() > 0){
                        relProdObj.put("text", "?????? ????????????");
                    }else {
                        relProdObj.put("text", "");
                    }    
                    relProdObj.put("list", relProdJarr);
                    listItem.put("relProdObj", relProdObj); //???????????? ???????????????
					
					// ????????? ???????????? ??????
					if(supertopADModelSet.contains(String.valueOf(intModelNoGroup))) {
						listItem.put("strAdProdFlagYN", "Y");
						listItem.put("strTotRank", "0");
						supertopADModelSet.remove(String.valueOf(intModelNoGroup)); // ??????????????? ?????????????????? ????????? ???????????????, ?????? ???????????? ?????? ??????
					} else {
						listItem.put("strAdProdFlagYN", "N");
						listItem.put("strTotRank", strTotRank);
						intNonAdItemCount++;
					}
					
					// plno
					listItem.put("strPlNo", String.valueOf(goods_data.getP_pl_no()));
					
					// ?????????
					long lngMinPrice = goods_data.getMinprice();
					long lngMinPrice2 = goods_data.getMinprice2();
					long lngMinPrice3 = goods_data.getMinprice3();
					
					// ????????????, ????????? ????????? ?????? 
					long lngCashMinPrice = goods_data.getCalc_cash_min_prc();
					String strCashMinFlag = goods_data.getCalc_cash_min_prc_yn();
					if(lngCashMinPrice == 0 && goods_data.getCash_min_prc() > 0 ) {
						lngCashMinPrice = goods_data.getCash_min_prc();
						strCashMinFlag = goods_data.getCash_min_prc_yn();
					}
					String strOvsMinFlag =  goods_data.getOvs_min_prc_yn();
					// 20191122 ????????? ????????? ???????????? ?????? jinwook
					if(intModelNo > 0 && strCashMinFlag != null && strCashMinFlag.equals("Y") && lngCashMinPrice>=lngMinPrice3 && lngMinPrice3>0) {
						strCashMinFlag = "N";
					}
						
					// 20191218 ????????? ????????? ???????????? ?????? jinwook ??? ?????? ??????
					if(intModelNo > 0 && strCashMinFlag != null && strCashMinFlag.equals("N") && lngCashMinPrice<lngMinPrice3 && lngCashMinPrice>0) {
						strCashMinFlag = "Y";
					}
					
					// 20200206 plno ?????? ?????? ??? ?????? ????????? ????????? ???  ????????? ???????????? Y ??? ????????????. jinwook
					if(intModelNo == 0 && goods_data.getCash_min_prc_yn().equals("Y") && strCashMinFlag.equals("N")) {
						lngCashMinPrice = lngMinPrice3;
						strCashMinFlag = "Y";
					}
					
					if(false && strCashMinFlag.equals("Y")) { // ????????? ?????? ????????? ???
						JSONObject cashObject = new JSONObject();
						if(lngCashMinPrice>0) {
							cashObject.put("price", formatter.format(lngCashMinPrice));
						}
						iconAttr.put("cash", cashObject);
					}
					
					// ???????????? ?????? ????????????
					if(intModelNo>0) {
						if(strOvsMinFlag.equals("Y")) {
							iconAttr.put("ovs", new JSONObject());
						}	
					}
						
					String strMinPriceMobileTag = "N";
					String intMinPrice = formatter.format(lngMinPrice3);
					
					// ???????????? ??? price??? instance_price ?????? ??? ?????? price??? ??? ?????????
					if(intModelNo==0 && lngMinPrice<lngMinPrice3) {
						intMinPrice = formatter.format(lngMinPrice);
					}
					
					if(strIsDelivery.equals("Y")) {
						intMinPrice = formatter.format(lngMinPrice2);
						if(intModelNo==0 && goods_data.getDeliverytype2()!=null && goods_data.getDeliveryInfo2()!=null && goods_data.getDeliverytype2().equals("1") && goods_data.getDeliveryInfo2().length()>0) {
							long lngCalcDeliveryPrice = lngMinPrice2 + Long.parseLong(goods_data.getDeliveryInfo2());
							intMinPrice = formatter.format(lngCalcDeliveryPrice);
						}
					
					} else if(lngMinPrice2==0) {
						intMinPrice = formatter.format(lngMinPrice);
					} else {
						if(goods_data.getMallcnt()>0 && goods_data.getMallcnt3()>0 && (lngMinPrice3<lngMinPrice)) {
							strMinPriceMobileTag = "Y";
						}
					}
					
					// #46975 [PC/MW/APP] ????????? ????????? ?????? ?????? ??????
					// strCashMinFlag "N" ?????? ??????
					if(intMinPrice.equals("0") && lngCashMinPrice>0 && strCashMinFlag.equals("Y")) {
						String strCashMinPriceFormat = formatter.format(lngCashMinPrice);
						intMinPrice = strCashMinPriceFormat;
					}
					
					listItem.put("strMinPriceMobileTag", strMinPriceMobileTag);
					listItem.put("strMinPrice", intMinPrice);
					
					int intMallCnt = goods_data.getMallcnt();
					int intMallCnt3 = goods_data.getMallcnt3();
					String strOpenExpectFlag = goods_data.getOpenexpectflag();
					String strCdate = goods_data.getC_date();
					// ???????????? ??????????????? ??????
					Boolean blProdStatus = false;
					if(intMallCnt3==0 && intMallCnt==0) {
						blProdStatus = true;
					} else if(intMallCnt==1 && DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) {
						blProdStatus = true;
					} else if(strOpenExpectFlag.equals("Y")) {
						blProdStatus = true;
						intMallCnt = 0;
						intMallCnt3 = 0;
					} else if(DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0 && goods_data.getIsgroup()!=1) {
						blProdStatus = true;
						intMallCnt = 0;
						intMallCnt3 = 0;
					} else if((CutStr.cutStr(strCa_code,4).equals("0304") || CutStr.cutStr(strCa_code,4).equals("0305") || CutStr.cutStr(strCa_code,4).equals("0233")) && lngMinPrice3==0) {
						blProdStatus = true;
					}
					
					listItem.put("strProdStatusTxt", (blProdStatus)? "????????????" : "");
					listItem.put("strMallCnt", String.valueOf(intMallCnt));
					listItem.put("strMallCnt3", String.valueOf(intMallCnt3));
					listItem.put("strCdate", strCdate);
					listItem.put("strOpenExpectYN", strOpenExpectFlag);
					
					// ???????????? ?????? 
					String strImageUrl = goods_data.getP_imgurl2();
					String strAdultYn = "N";
					
					if(intModelNo>0) {
							
						// ?????? ????????? true ?????? ????????? ??????
						if(strDevice.equals("aos") || strDevice.equals("ios")) {
							goods_data.setAdultChk(true);
						} else {
							goods_data.setAdultChk(IsAdultFlag); // ????????????
						}
						
						strImageUrl = ImageUtil_lsv.getImageSrc(goods_data);
						
						if(strFrom.equals("list") && CutStr.cutStr(strCate,6).equals("163630") || CutStr.cutStr(strCate,6).equals("931004") || CutStr.cutStr(strCate,6).equals("168623") || CutStr.cutStr(strCate,6).equals("168613")) {
							strAdultYn = "Y";
						} else if(strFrom.equals("search") && CutStr.cutStr(strCa_code,6).equals("163630") || CutStr.cutStr(strCa_code,6).equals("931004") || CutStr.cutStr(strCa_code,6).equals("168623") || CutStr.cutStr(strCa_code,6).equals("168613")) {
							strAdultYn = "Y";
						}
			
					} else {
						
						if(bAdultKeyword || adultKeywordCheck(strModelName) || adultCategoryCheck(strCa_code)) {
							strAdultYn = "Y";
						}
						
						boolean blAdult = (strAdultYn.equals("Y")) ? true : false;
						strImageUrl = getSearchGoodsImage(blAdult, strAdultCookie, strImageUrl, true);
					
					}
					
					listItem.put("strAdultYN", strAdultYn);
					listItem.put("strImageUrl", strImageUrl);
					
					// ??????
					float fltBbsPoint = goods_data.getBbs_point_avg();
					int intBbsNum = goods_data.getBbs_num();
					
					// ??????????????? ?????? strBbsPoint ??? ????????? ?????? ????????? ?????? ????????? ?????? ????????? ??? ??? ???????????? ?????? ????????????
					if(fltBbsPoint > 5 && intBbsNum > 0) {
						String strBbsPoint = String.format("%.1f", fltBbsPoint / intBbsNum);
						fltBbsPoint = Float.parseFloat(strBbsPoint);
						listItem.put("strBbsPoint", String.valueOf(fltBbsPoint));
					} else {
						listItem.put("strBbsPoint", String.valueOf( String.format("%.1f", fltBbsPoint) ));
					}
					listItem.put("strBbsNum", String.valueOf(intBbsNum));
					
					// ??? ????????????
					if(goods_data.getKeyword2()!=null) {
						listItem.put("strTip", goods_data.getKeyword2());
					} else {
						listItem.put("strTip", "");
					}
					
					// ??????????????? ??????
					if(hitBrandMap.containsKey(intModelNoGroup)) {
						adAttr.put("hitbrand", new JSONObject());
					}
					
					// ?????????
					if(strFrom.equals("list") && ( strCate2.equals("08") || strCate2.equals("14") ) && cosmeticMap.containsKey(intModelNo)) {
						Map<String, Object> cosmeticParseMap = new HashMap<String, Object>();
						cosmeticParseMap.put("title", "?????????");
						cosmeticParseMap.put("value", cosmeticMap.get(intModelNo));
						
						lpEtcAttr.put("cosmetic", cosmeticParseMap);
					}
					
					// ??????
					if(strFrom.equals("list") && furnitureMap.containsKey(intModelNo)) {
						lpEtcAttr.put("furniture", furnitureMap.get(intModelNo));
					}
				
					// ?????? D?????? ??????
					if(strFrom.equals("search") && goods_data.isDtypeFlag()) {
						listItem.put("strKeywordDTypeYN", "Y");
					} else {
						listItem.put("strKeywordDTypeYN", "N");
					}
					
					// ?????? ??????, ????????????, ???????????????
					strCouponContents = "";
					if(intModelNo==0) {
						String strDataSpec = goods_data.getSpec();
						String[] strSpecAry = strDataSpec.split(":");
						int intShopCode = 0;
						if(strSpecAry!=null && strSpecAry.length>0) {
							try {
								intShopCode = Integer.parseInt(strSpecAry[0]);
							} catch(Exception e) {}
						}
						int coupon = goods_data.getHeight();
						if(intShopCode>0) {
							String[] strcoponLayer = getCouponLayerInfo(intShopCode, coupon, (int)lngMinPrice, 1, CouponLayerAry);
							if(strcoponLayer != null){
								strCouponContents = strcoponLayer[0];
							}
							
							String strShopName = HtmlStr.removeHtml(goods_data.getKb_title()); // ??????????????? ???????????? shop_name??? ??????
							// ????????????????????? ??????
							listItem.put("strShopCode", String.valueOf(intShopCode));
							listItem.put("strShopName", strShopName);
							
							// ????????????
							if( shopMap.containsKey(intShopCode) ) {
								iconAttr.put("ovs", new JSONObject());
							}
						}
					}
					listItem.put("strCouponContents", strCouponContents);
						
					// ????????? ??????, ????????? ??????
					String strEventTxt = "";
					long lngEventPrice = 0;
					listItem.put("strEventTxt", strEventTxt);
					listItem.put("strEventPrice", formatter.format(lngEventPrice));
					
					// ?????? ?????? ?????? ??????
					if(intModelNo==0) {
						listItem.put("strLandUrl", goods_data.getUrl1());
					} else {
						listItem.put("strLandUrl", "");
					}
					
					// ???????????? pricelist ???????????????
					String strDeliveryInfo = "";
					if(goods_data.getDeliveryInfo()!=null && goods_data.getDeliveryInfo().trim().length()>0) {
						strDeliveryInfo = goods_data.getDeliveryInfo();
					}
					if(strDeliveryInfo.trim().length()>0) {
						String strTempDeliveryInfo = strDeliveryInfo;
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,",","");
						strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"???","");
						if(strTempDeliveryInfo.indexOf("????????????")>=0 || strTempDeliveryInfo.indexOf("??????")>=0 || strTempDeliveryInfo.indexOf("?????????")>=0) {
							strTempDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"??????","????????????");
							strDeliveryInfo = ReplaceStr.replace(strTempDeliveryInfo,"?????????","???????????????");
						} else {
							if(ChkNull.chkNumber(strTempDeliveryInfo)) {
								strDeliveryInfo = "?????????"+FmtStr.moneyFormat(strTempDeliveryInfo)+"???";
							} else {
								strDeliveryInfo = "?????????"+strTempDeliveryInfo;
							}
						}
					}
						
					// ????????? ????????? 
					String strShopType = "";
					if(goods_data.getShop_type()!=null && goods_data.getShop_type().trim().length()>0) {
						strShopType = goods_data.getShop_type();
					}
					if(strShopType.equals("4")) {
						iconAttr.put("naverpay", new JSONObject());
					}
					
					listItem.put("strDeliveryInfo", strDeliveryInfo);
					
					// ????????? ????????????
					String strVideoYN = "N";
					if(modelVideoSet.contains(intModelNo)) {
						strVideoYN = "Y";
					}
					listItem.put("strVideoYN", strVideoYN);
					
					// ???????????? ??????
					String strPromotionUrl = "";
					String strPromotionShopNm = "";
					Map<String, String> promotionDataMap = new HashMap<String, String>();
					if(promotionMap.containsKey(intModelNo)) {
						promotionDataMap = promotionMap.get(intModelNo);
					} else if(promotionMap.containsKey(intModelNoGroup)) {
						promotionDataMap = promotionMap.get(intModelNoGroup);
					}
					if(!promotionDataMap.isEmpty()) {
						if(promotionDataMap.containsKey("url")) {
							strPromotionUrl = promotionDataMap.get("url");
						}
						if(promotionDataMap.containsKey("shop_name")) {
							strPromotionShopNm = promotionDataMap.get("shop_name");
						}
					}
					listItem.put("strPromotionUrl", strPromotionUrl);
					listItem.put("strPromotionShopName", strPromotionShopNm);
					
					// ??? ??????
					String strZzimYN = "N";
					if(zzimModelSet.contains(intModelNo)) {
						strZzimYN = "Y";
					} else if(zzimPLSet.contains(goods_data.getP_pl_no())) {
						strZzimYN = "Y";
					}
					listItem.put("strZzimYN", strZzimYN);
							
					// ????????????
					JSONObject groupModelOutput = new JSONObject();
					List<JSONObject> groupModelOutputItem = new ArrayList<JSONObject>();
					
					// ???????????? ?????? ??????
					int intPositionRank1 = 0; // 1??? ?????? ?????????
					int intPositionRank2 = 0; // 2??? ?????? ?????????
					boolean blCreateRank1 = false; // 1??? ?????? ??????
					boolean blCreateRank2 = false; // 1??? ?????? ??????
					
					if(listItem.containsKey("groupModelTemp")) {
						JSONObject groupModelObj = (JSONObject) listItem.get("groupModelTemp");
						if(groupModelObj.containsKey("list")) {
							List<JSONObject> groupModelItem = (List<JSONObject>) groupModelObj.get("list");
							
							if(groupModelItem.size()>0) {
								
								// ???????????? ????????????
								HashMap<String,Integer> termdictitle_data = new HashMap<String, Integer>(); 
								if(strFrom.equals("list")) {
									termdictitle_data = tHashMap.get(strCate4);
								}
								
								// ??????????????? ????????? ????????????.
								int minPriceIdx = -1; // ????????? ?????? ?????????
								int minUnitPriceIdx = -1; // ??????????????? ????????? ?????????
								long lngPriceComp = 0; // ????????? ?????? ??????
								long lngUnitPriceComp = 0; // ??????????????? ????????? ??????
								// ?????????????????? ???????????? ??????
								Map<String, Object> groupTagAttr = null;
								for(int m=0;m<groupModelItem.size();m++) {
							
									JSONObject groupItem = (JSONObject) groupModelItem.get(m);

									if(groupItem.containsKey("data_subid")) {
										String targetSubID = (String) groupItem.get("data_subid");
									
										if(goods_data_map.containsKey(targetSubID)) {
										
											Goods_Data goods_sub_data = (Goods_Data) goods_data_map.get(targetSubID);
											
											int g_intModelNo = goods_sub_data.getModelno();
											int g_intModelNoGroup = goods_sub_data.getModelno_group();
											
											// ?????? - ???????????? SR 48169
											/* ?????? ????????? ?????????
											if(g_intModelNo==71706645 || g_intModelNo==71706625) {
												JSONObject groupADObj = new JSONObject();
												groupADObj.put("modelno", String.valueOf(g_intModelNo));
												groupADObj.put("url", "http://img.enuri.info/images/rev/ad_brand_samsung.png");
												adAttr.put("groupImage", new JSONObject());
											}
											*/
											
											// ?????????, ????????????
											long g_lngCashMinPrice = goods_sub_data.getCash_min_prc();
											String g_strCashMinFlag = goods_sub_data.getCash_min_prc_yn();
											String g_strOvsMinFlag =  goods_sub_data.getOvs_min_prc_yn();
											
											groupTagAttr = new HashMap<String, Object>();
											
											groupItem.put("strModelNo", String.valueOf(g_intModelNo));
											if(g_intModelNo==g_intModelNoGroup) {
												groupItem.put("strModelNoRepYN", "Y");
											} else {
												groupItem.put("strModelNoRepYN", "N");
											}
											
											// ????????????
											// LP??? strCate4??? ??????, SRP??? ????????? ???????????? ??????
											String strModelCate4 = strCate4;
											String g_cate = goods_sub_data.getCa_code();
											if(strFrom.equals("search")) {
												strModelCate4 = g_cate.substring(0,4);
												termdictitle_data = tHashMap.get(strModelCate4);
											}
											
											// ?????????
											String strCondiname = goods_sub_data.getCondiname();
											strCondiname = replaceSpecialCharacter(strModelCate4, strCondiname);
											
											// ???????????? ??????
											if(termdictitle_data != null && termdictitle_data.containsKey(strCondiname)){
												groupItem.put("strDicKbNo",String.valueOf(termdictitle_data.get(strCondiname)));
											}else{
												groupItem.put("strDicKbNo","0");
											}
											
											groupItem.put("strCondiName", strCondiname);
											
											// ??????
											if(listItem.containsKey(String.valueOf(g_intModelNo))) {
												groupItem.put("strRank", listItem.get(String.valueOf(g_intModelNo)));
												
												if(listItem.get(String.valueOf(g_intModelNo)).equals("1")) {
													blCreateRank1 = true;
													intPositionRank1 = m;
												} else if(listItem.get(String.valueOf(g_intModelNo)).equals("2")) {
													blCreateRank2 = true;
													intPositionRank2 = m;
												}
												
											} else {
												groupItem.put("strRank", "");
											}
											
											// ????????? ?????????
											Goods_Change_Data groupModelnosInfoOne = groupModelnosInfoHash.get(g_intModelNo);
											long unitPrice = 0;
											String unit = "";
											int change = 0;
											long unitPriceTxt = 0;
											int standard = 0;
											long lngDeliveryPrice = 0;
											if(groupModelnosInfoOne!=null && goods_sub_data.getIsgroup()==1) {
												int modelno = groupModelnosInfoOne.getModelno();
												standard = groupModelnosInfoOne.getStandard();
												int amount = groupModelnosInfoOne.getAmount();
												String all_component = groupModelnosInfoOne.getAll_component();
												change = groupModelnosInfoOne.getChange();
												unit = groupModelnosInfoOne.getUnit();
												unitPrice = 0;
								
												if(standard>0 && amount>0 && change>0) {
												
													// ?????????????????? ????????? ???????????? ??????
													if(strIsDelivery.equals("Y")) {
														lngDeliveryPrice = goods_sub_data.getMinprice2();
													} else {
														lngDeliveryPrice = goods_sub_data.getMinprice();;
													}
								
													long lngTempIndividualChangeUnitPrice = lngTempIndividualChangeUnitPrice = (long)((double)lngDeliveryPrice/(double)(standard*(double)amount)*(double)change+0.5);
								
													unitPrice = lngTempIndividualChangeUnitPrice;
													unitPriceTxt =  (long)((double)goods_sub_data.getMinprice()/(double)(standard*(double)amount)*(double)change+0.5);
												}
											}
											groupItem.put("strUnitPrice",formatter.format(unitPrice));
											groupItem.put("strMinUnitPriceYN","N"); // N?????? ?????? ?????? ??? ????????? ???????????? Y??? ????????????
											
											if(m==0) {
												groupModelOutput.put("strUnit", unit);
												groupModelOutput.put("strChange", String.valueOf(change));
												
												//?????? ?????? ?????? ????????? (?????? ?????????)
												if(CutStr.cutStr(strCa_code, 6).equals("163604") && standard>0 && unitPriceTxt>0) {
													String unitPriceMsg = formatter.format(change) + unit + "??? " + formatter.format(unitPriceTxt) + "???";
													groupModelOutput.put("unitPriceMsg", unitPriceMsg);
												}
											}
											
											// ????????????
											int g_intMallCnt = goods_sub_data.getMallcnt();
											int g_intMallCnt3 = goods_sub_data.getMallcnt3();
											
											String g_strMallCnt = "";
											if(strDevice.equals("pc")) {
												g_strMallCnt = String.valueOf(g_intMallCnt);
												if(g_intMallCnt3>9999) {
													g_strMallCnt = "9999+";
												}
											} else {
												g_strMallCnt = String.valueOf(g_intMallCnt3);
											}
											groupItem.put("strMallCnt",g_strMallCnt);
											
											// ?????????????????? ?????? (PC?????? ?????? )
											long g_longMinPrice = goods_sub_data.getMinprice();
											long g_longMinPrice2 = goods_sub_data.getMinprice2();
											long g_longMinPrice3 = goods_sub_data.getMinprice3();
											long g_lngMinPrice = goods_sub_data.getMinprice3(); // ????????????
											String g_strMobileMinPriceYn = "N";
											if(g_intMallCnt==0 && g_intMallCnt3>0) {
												g_strMobileMinPriceYn = "Y";
											}
											if(g_intMallCnt>0 && g_intMallCnt3>0 && g_longMinPrice3<g_longMinPrice) {
												g_strMobileMinPriceYn = "Y";
											}
											groupItem.put("strMobileMinPriceYn", g_strMobileMinPriceYn);
											
											// ??????
											String g_strPrice = formatter.format(g_longMinPrice3);
											// ????????? ???????????? ??? minPrice2 ??? ??????
											// ???????????? minPrice2 ??? ??????
											if(strIsDelivery.equals("Y")) {
												g_strPrice = formatter.format(g_longMinPrice2);
												g_lngMinPrice = g_longMinPrice2;
											}
											
											Boolean g_blPriceExpectCase = false;
											String g_cDate = goods_sub_data.getC_date();
											String g_openexpectflag = goods_sub_data.getOpenexpectflag();
											int g_intIsGroup = goods_sub_data.getIsgroup();
											
											g_cDate = CutStr.cutStr(g_cDate, 10);
											
											if(g_intMallCnt==0 && g_intMallCnt3==0) {
												g_blPriceExpectCase = true;
											} else if(g_intMallCnt==1 && DateUtil.getDaysBetween(g_cDate, DateStr.nowStr())>0) {
												g_blPriceExpectCase = true;
											} else if( (g_openexpectflag.equals("1") || DateUtil.getDaysBetween(g_cDate, DateStr.nowStr())>0) && g_intIsGroup!=1) {
												g_blPriceExpectCase = true;
											}
											
											if(g_blPriceExpectCase) {
												g_strPrice = "????????????"; // ?????????????????? ?????????????????? ??????
											}
											
											// ????????? ????????? ?????????
											if( (lngUnitPriceComp==0 || (unitPrice<lngUnitPriceComp)) && !g_blPriceExpectCase ) {
												lngUnitPriceComp = unitPrice;
												minUnitPriceIdx = m;
											}
											
											// ????????? ?????? ?????????
											if( (lngPriceComp==0 || g_lngMinPrice<lngPriceComp) && !g_blPriceExpectCase) {
												lngPriceComp = g_lngMinPrice;
												minPriceIdx = m;
											}
											
											// #46975 [PC/MW/APP] ????????? ????????? ?????? ?????? ??????
											if(g_strCashMinFlag.equals("Y") && g_strPrice.equals("0") && g_lngCashMinPrice>0) {
												g_strPrice = formatter.format(g_lngCashMinPrice);
											}
											groupItem.put("strPrice", g_strPrice);
											groupItem.put("strMinPriceYN", "N");
											
											// ???????????? ( ????????? ?????? ?????? ????????? ??????. ?????? ??? ?????? )
											if(false && g_strCashMinFlag.equals("Y")) {
												JSONObject cashObject = new JSONObject();
												cashObject.put("price", formatter.format(g_lngCashMinPrice));
												groupTagAttr.put("cash", cashObject);
											}
											if(g_strOvsMinFlag.equals("Y")) {
												groupTagAttr.put("ovs", new JSONObject());
											}
											
											groupItem.put("tag", groupTagAttr);
											
											// ?????????
											String strSmallImg = "";
											goods_sub_data.setAdultChk(IsAdultFlag);
											strSmallImg = ImageUtil_lsv.getImageSrc(goods_sub_data);
											groupItem.put("strSmallImg", strSmallImg);
											
											// ??? ?????? ??????
											String g_strGroupZzimYN = "N";
											if(zzimModelSet.contains(g_intModelNo)) {
												g_strGroupZzimYN = "Y";
											}
											groupItem.put("strZzimYN",g_strGroupZzimYN);
											
											// ???????????? ?????? ?????? ??????
											groupItem.remove("data_subid");
											
											groupModelOutputItem.add(groupItem);
										}
									}
								}
								
								if(minUnitPriceIdx>-1 && groupModelItem.size()>minUnitPriceIdx && groupModelOutputItem.contains(minUnitPriceIdx)) {
									((JSONObject) groupModelOutputItem.get(minUnitPriceIdx)).put("strMinUnitPriceYN", "Y");
								}
								if(minPriceIdx>-1 && groupModelItem.size()>minPriceIdx && groupModelOutputItem.contains(minPriceIdx)) {
									((JSONObject) groupModelOutputItem.get(minPriceIdx)).put("strMinPriceYN", "Y");
								}
								// ?????? ??? ?????? ( model : ????????????, shop : ????????????????????????, '' : ?????????  )
								String strOptionViewType = "";
								if(groupModelItem.size()>0 && goods_data.getCondiname().length()>0) {
									strOptionViewType = "model";
								} else if(goods_data.getMallcnt3()>0) {
									strOptionViewType = "shop";
								}
								listItem.put("optionViewType", strOptionViewType);
								
								// ???????????? ?????? ???
							}
						}
					}
						
					
					
					listItem.put("intPositionRank1", intPositionRank1);
					listItem.put("intPositionRank2", intPositionRank2);
					listItem.put("blCreateRank1", String.valueOf(blCreateRank1));
					listItem.put("blCreateRank2", String.valueOf(blCreateRank2));
					
					// ???????????? ?????? ?????? ?????????
					if(blCreateRank1 && blCreateRank2) {
						
						JSONObject rank1Object = groupModelOutputItem.get(intPositionRank1);
						JSONObject rank2Object = groupModelOutputItem.get(intPositionRank2);
						
						// ?????? 5??? ?????? ????????? ????????? ?????? ??????
						if(intPositionRank1 >= 5 && intPositionRank2 >= 5) {
							
							if(intPositionRank1>intPositionRank2) {
								groupModelOutputItem.remove(intPositionRank1);
								groupModelOutputItem.remove(intPositionRank2);
							} else {
								groupModelOutputItem.remove(intPositionRank2);
								groupModelOutputItem.remove(intPositionRank1);
							}
							
							groupModelOutputItem.add(3, rank1Object); // 4??????
							groupModelOutputItem.add(4, rank2Object); // 5??????
							
							
						// 2?????? ???????????? ?????? 1?????? ???????????? ?????? ?????? ??????
						} else if(intPositionRank1 >= 5) {
							
							// 4?????? ?????? ???????????? ?????? ??????
							if(intPositionRank2 < 4) {
								groupModelOutputItem.remove(intPositionRank1);
								groupModelOutputItem.add(4, rank1Object);
							// 5?????? ??? ??????. ?????? ?????? 4????????? ???????????? 5?????????
							} else if(intPositionRank2 == 4) {
								groupModelOutputItem.remove(intPositionRank1);
								groupModelOutputItem.remove(intPositionRank2);
								
								groupModelOutputItem.add(3, rank2Object);
								groupModelOutputItem.add(4, rank1Object);
							}
							
						// 1?????? ???????????? ?????? 2?????? ???????????? ?????? ?????? ??????
						} else if(intPositionRank2 >= 5) {
							
							// 4?????? ?????? ???????????? ?????? ??????
							if(intPositionRank1 < 4) {
								groupModelOutputItem.remove(intPositionRank2);
								groupModelOutputItem.add(4, rank2Object);
							// 5?????? ??? ??????. ?????? ?????? 4????????? ???????????? 5?????????
							} else if(intPositionRank1 == 4) {
								groupModelOutputItem.remove(intPositionRank2);
								groupModelOutputItem.remove(intPositionRank1);
								
								groupModelOutputItem.add(3, rank1Object);
								groupModelOutputItem.add(4, rank2Object);
							}
							
						}
						
					}
					
					groupModelOutput.put("list", groupModelOutputItem);
					listItem.put("groupModel", groupModelOutput);
					
					// ???????????? ?????? ????????? ????????????.
					listItem.remove("dataid");
					listItem.remove("groupModelTemp");
					if(listItem.containsKey("rankArray")) {
						List<String> rArray = (ArrayList<String>) listItem.get("rankArray");
						for(int rI=0; rI<rArray.size(); rI++) {
							listItem.remove(rArray.get(rI)); // ??????????????? ????????? ????????? ?????? ???????????? ?????????, ???????????? ????????? ?????? ???????????? ????????????.
						}
					}
					listItem.remove("rankArray");
					
					listItem.put("iconAttr", iconAttr);
					listItem.put("adAttr", adAttr);
					listItem.put("lpEtcAttr", lpEtcAttr);
					listItem.put("priceAttr", priceAttr);
					
					listJson.add(listItem);
				
				// ???????????? ??????
				} else if(targetID.startsWith("M") && hitsSourceMap.containsKey(targetID)) {
					
					JsonMap<String, Object> tmpMakeShopMap = hitsSourceMap.get(targetID);
					
					String msID = tmpMakeShopMap.containsKey("id") ? (String) tmpMakeShopMap.get("id") : "";
					String msShopCode = tmpMakeShopMap.containsKey("shop_code") ? (String) tmpMakeShopMap.get("shop_code") : "";
					String msShopName = tmpMakeShopMap.containsKey("shop_name") ? (String) tmpMakeShopMap.get("shop_name") : "";
					String msModelName = tmpMakeShopMap.containsKey("modelnm") ? (String) tmpMakeShopMap.get("modelnm") : "";
					String msImgUrl = tmpMakeShopMap.containsKey("imgurl") ? (String) tmpMakeShopMap.get("imgurl") : "";
					String msCdate = tmpMakeShopMap.containsKey("c_date") ? (String) tmpMakeShopMap.get("c_date") : "";
					String msBrand = tmpMakeShopMap.containsKey("brand") ? (String) tmpMakeShopMap.get("brand") : "";
					String msFactory = tmpMakeShopMap.containsKey("factory") ? (String) tmpMakeShopMap.get("factory") : "";
					String msMinPrice = tmpMakeShopMap.containsKey("minprice3") ? (String) tmpMakeShopMap.get("minprice3") : "0";
					String msBbsNum = tmpMakeShopMap.containsKey("bbs_num") ? (String) tmpMakeShopMap.get("bbs_num") : "0";
					String msUrl = tmpMakeShopMap.containsKey("url") ? (String) tmpMakeShopMap.get("url") : "";
					String msUrl2 = tmpMakeShopMap.containsKey("url2") ? (String) tmpMakeShopMap.get("url2") : "";
					
					// struserid
					
					StringBuffer msSb = new StringBuffer();
					String domain = "http://enuri.com";
					if(!strDevice.equals("pc")) {
						domain = "http://m.enuri.com";
					}
					if(devFlag) {
						domain = "http://dev.enuri.com";
					}
					
					msSb.append(domain + "/brandstore/move.jsp?"); // ?????????
					if(strDevice.equals("pc")) {
						msSb.append("url=" + URLEncoder.encode(msUrl, "utf-8"));
					} else {
						msSb.append("url=" + URLEncoder.encode(msUrl2, "utf-8"));
					}
					msSb.append("&makeshopno=" + msID);
					if(strFrom.equals("list")) {
						msSb.append("&pageType=list");
					} else if(strFrom.equals("search")) {
						msSb.append("&pageType=search");
					}
					msSb.append("&shopcode=" + msShopCode);
					msSb.append("&cate=" + strCate);
					msSb.append("&price=" + msMinPrice);
					msSb.append("&keyword=" + URLEncoder.encode(strKeyword, "utf-8"));
					if(strDevice.equals("all")) {
						msSb.append("&device=pc");
					} else {
						msSb.append("&device=" + strDevice);
					}
					
					if(strUserUct.length()>0){
						msSb.append("&uct=" + strUserUct);
					}
					
					if(strDevice.equals("aos") || strDevice.equals("ios")) {
						msSb.append("&freetoken=outlink");
					}

					
					String msEnuriCaCode = tmpMakeShopMap.containsKey("ca_code") ? (String) tmpMakeShopMap.get("ca_code") : "";
					
					ZonedDateTime uDate = ZonedDateTime.parse(msCdate);
					String fDate = uDate.plus(9, ChronoUnit.HOURS).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
					
					// ???????????? ?????? ????????? ????????????.
					listItem.remove("dataid");
				
					listItem.put("prodType", "M");
					listItem.put("strMakeshopID", msID);
					listItem.put("strShopCode", msShopCode);
					listItem.put("strShopName", msShopName);
					listItem.put("strModelName", msModelName);
					listItem.put("strImageUrl", msImgUrl);
					listItem.put("strCdate", fDate);
					listItem.put("strBrand", msBrand);
					listItem.put("strFactory", msFactory);
					listItem.put("strMinPrice", formatter.format(Long.valueOf(msMinPrice)));
					listItem.put("strBbsNum", msBbsNum);
					listItem.put("strLandUrl", msSb.toString());
					listItem.put("strCate", msEnuriCaCode);
					listItem.put("strTotRank", strTotRank);
					
					/* ??? */
					String strZzimYN = "N";
					if(zzimMKSet.contains(msID)) {
						strZzimYN = "Y";
					}
					listItem.put("strZzimYN", strZzimYN);
					listJson.add(listItem);
				}
			}
		} else {
			ret = new JsonResponse(false).setMessage("????????? ?????? ??????").setParam(request);
			out.print(ret);
			return;
		}
	}
		
	retMap.put("list", listJson);
	retMap.put("strCaCode", "\""+String.valueOf(strCateCode)+"\"");
	retMap.put("nonAdItemSize", intNonAdItemCount);
	
	// SRP????????? ??? C????????? ????????? ??????.
	String blKeywordCType = "N";
	if(strFrom.equals("search")) {
		boolean keywordCTypeCheck = wide_list_proc.getCountSRPCType(strKeyword);
		if(keywordCTypeCheck) {
			blKeywordCType = "Y";
		}
	}
	retMap.put("strKeywordCTypeYN", "\""+blKeywordCType+"\"");
		
	// ???????????? 
	// strFuzzy ( LP -1 , SRP??? ??????????????? 0 )
	String strFuzzy = "-1";
	if(strFrom.equals("search")) { // lp 
		strFuzzy = String.valueOf(intFuzzy);
	}
	retMap.put("strFuzzy", "\""+strFuzzy+"\"");
	
	JSONArray searchedKeywordAry = new JSONArray();
	JSONArray searchedKeywordOrgAry = new JSONArray();
	// ??????????????? ??? ?????? ??????
	if(searchedKeyword.length()>0) {
		retMap.put("searchedKeyword", "\""+searchedKeyword+"\"");
		String[] splitSearchedKeyword  = searchedKeyword.split(" ");
		for(int i=0;i<splitSearchedKeyword.length;i++) {
			searchedKeywordAry.add(splitSearchedKeyword[i]);
		}
		if(strOrgKeyword.trim().length()>0) {
			String[] splitSearchedOrgKeyword  = strOrgKeyword.split(" ");
			for(int j=0;j<splitSearchedOrgKeyword.length;j++) {
				searchedKeywordOrgAry.add(splitSearchedOrgKeyword[j]);
			}
		}
	} else {
		retMap.put("searchedKeyword", "\"\"");
	}
	retMap.put("searchedKeywordAry", searchedKeywordAry);
	retMap.put("searchedKeywordOrgAry", searchedKeywordOrgAry);
	
	// ??????????????????, ??????????????????
	retMap.put("modelCnt", intEnuriCnt);
	retMap.put("plCnt", intWebCnt);
	
	retMap.put("strMpnos", "\""+strMpnos+"\"");
	
	ret = new JsonResponse(true).setData(retMap).setTotal(intTotRsCnt);
	
	out.print ( ret );
	
	// ?????? ??????
	String ipaddress = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
	String strTmpId = cb.GetCookie("MYINFO","TMP_ID");
	String userid = cb.GetCookie("MEM_INFO","USER_ID");
	String strGubun = "1";
	
	try {  
		if(strDevice.equals("pc")) {
			Model_log_Proc.Cate_log_Insert(strCate, strGubun, strTmpId, ipaddress, userid);
		}
	} catch(Exception ex) {}
%>
<%!
public JSONObject getRelProdBtnTextObj () throws Exception{
	String strFileNm = "/was/lena/1.3/depot/lena-application/ROOT/lsv2016/include/relProdBtnText.json";
	JSONObject jobject = new JSONObject();
	try{
		JSONParser parser = new JSONParser();
		Reader reader = new FileReader(strFileNm);
		jobject = (JSONObject)parser.parse(reader);
	}catch(Exception ex) {}
	return jobject;
}
%>