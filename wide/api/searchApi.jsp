<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/wide/include/IncSearch.jsp"%>
<%@ include file="/include/IncGroupTool_2010.jsp"%>
<%@ page import="java.util.*,java.text.*,java.net.*"%>
<%@ page import="com.enuri.include.*"%>
<%@ page import="com.enuri.util.etc.*"%>
<%@ page import="com.enuri.util.common.*"%>
<%@ page import="com.enuri.util.image.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="com.enuri.util.date.*"%>
<%@ page import="com.enuri.bean.main.Category_Data"%>
<%@ page import="com.enuri.bean.main.Category_Proc"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.common.collect.ArrayListMultimap"%>
<%@ page import="com.google.common.collect.Multimap"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.bean.main.Goods_Data"%>
<%@ page import="com.enuri.bean.main.Rental_Model_Proc"%>
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
<%@ page import="com.enuri.bean.main.Category_Middle_Comparator"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="com.enuri.bean.main.Keyword_Cate_Zum_Proc"%>
<%@ page import="com.enuri.bean.main.RecKeyword_Data" %>
<jsp:useBean id="Know_termdic_title_Proc" class="com.enuri.bean.knowbox.Know_termdic_title_Proc" scope="page" />
<jsp:useBean id="Wide_List_Proc" class="com.enuri.bean.wide.Wide_List_Proc" scope="page" />
<jsp:useBean id="Pricelist_Proc" class="com.enuri.bean.main.Pricelist_Proc" scope="page" />
<jsp:useBean id="Goods_Search_Lsv_Proc" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page" />
<jsp:useBean id="Searchfunction" class="com.enuri.bean.search.SearchFunction"  />
<jsp:useBean id="SrpAdCmpnProc" class="com.enuri.bean.ad.SrpAdCmpnProc" scope="page" />
<jsp:useBean id="Coupon_Layer_Proc" class="com.enuri.bean.lsv2016.Coupon_Layer_Proc" scope="page" />
<jsp:useBean id="Model_log_Proc" class="com.enuri.bean.logdata.Model_log_Proc" scope="page" />
<jsp:useBean id="Keyword_Cate_Zum_Proc" class="com.enuri.bean.main.Keyword_Cate_Zum_Proc" scope="page" />
<jsp:useBean id="Category_Data" class="com.enuri.bean.main.Category_Data" scope="page" />
<jsp:useBean id="Category_Proc" class="com.enuri.bean.main.Category_Proc" scope="page" />
<jsp:useBean id="Lp_Header_Proc" class="com.enuri.bean.wide.Lp_Header_Proc" scope="page" />
<%!
public static String toJS2(String str) {
	return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("&" , "&amp;")
				.replace("\'", "&#39")
				.replace("\b", "\\b")
				.replace("\f", "\\f")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
}
public static String toJS3(String str) {
	return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\b", "\\b")
				.replace("\f", "\\f")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
}

public static String strReplaceKeyword(String strKeyword){
	strKeyword = ReplaceStr.replace(strKeyword, "'"," ");		
	strKeyword = ReplaceStr.replace(strKeyword, "\""," ");				
	strKeyword = ReplaceStr.replace(strKeyword, "^"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "~"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "!"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "@"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "$"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "%"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "*"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "+"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "="," ");
	strKeyword = ReplaceStr.replace(strKeyword, "\\"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "{"," ");
	strKeyword = ReplaceStr.replace(strKeyword, "}"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "["," ");
    strKeyword = ReplaceStr.replace(strKeyword, "]"," ");
    strKeyword = ReplaceStr.replace(strKeyword, ";"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "/"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "<"," ");
    strKeyword = ReplaceStr.replace(strKeyword, ">"," ");
    strKeyword = ReplaceStr.replace(strKeyword, ","," ");
    strKeyword = ReplaceStr.replace(strKeyword, "?"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "("," ");
    strKeyword = ReplaceStr.replace(strKeyword, ")"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "'"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "_"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "-"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "`"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "|"," ");
    strKeyword = ReplaceStr.replace(strKeyword, ","," ");	

    strKeyword = ReplaceStr.replace(strKeyword, "???","&");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","|");	
    strKeyword = ReplaceStr.replace(strKeyword, "???",":");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","(");	
    strKeyword = ReplaceStr.replace(strKeyword, "???",")");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","~");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","+");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","#");	
    strKeyword = ReplaceStr.replace(strKeyword, "???","/");	
    strKeyword = ReplaceStr.replace(strKeyword, "??"," ");
    strKeyword = ReplaceStr.replace(strKeyword, "'"," ");
    strKeyword = strKeyword.trim();

    //strKeyword = ReplaceStr.replace(strKeyword, "."," ");
    return strKeyword;
}
%>
<%
	CookieBean cb = null;
	cb = new CookieBean( request.getCookies());

	String strUser_ip = szConnectIp(request);

	/*if(!strUser_ip.equals("100.100.110.83")){
		return;
	}*/
	/**
	 * @history
	 	2020.12.24. ????????????
	*/
	
	/** Parameter Sets */
	// ??????????????? ( list , search )
	String strFrom = ConfigManager.RequestStr(request, "from", "search");
	// ???????????? ?????? ( pc , mw , aos, ios, all )
	String strDevice = ConfigManager.RequestStr(request, "device", "pc");
	strDevice = strDevice.toLowerCase();
	// ?????????
	int intAppVersion = ChkNull.chkInt(request.getParameter("appVersion"), 0);
	// ????????????
	String strCate = ConfigManager.RequestStr(request, "cate", "");
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
	int intTab = ChkNull.chkInt(request.getParameter("_t"), 0);
	// ????????? ????????? ???????????? ??? ??????
	if(!strDevice.equals("pc") && strFrom.equals("list") && (strCate4.equals("1487") || strCate4.equals("1488"))) {
		intTab = 2;
	}
	
	// ????????? ?????? ??????
	String strIsDelivery = ConfigManager.RequestStr(request, "isDelivery", "N");
	// ??????/?????? ?????? ??????
	String strIsRental = ConfigManager.RequestStr(request, "isRental", "N");
	// ????????? ??????
	int pageNum = ChkNull.chkInt(request.getParameter("page"), 1);
	// ???????????? ?????? ??????
	int pageGap = ChkNull.chkInt(request.getParameter("pagesize"), 4);
	
	if(pageGap > 90){
		pageGap = 90;
	}
	//1?????????????????? ????????? 8?????? ??????
	//if(pageNum==1 && pageGap==4 ) pageGap = 8;
	// ??????
	/**
	1. ???????????? // minprice3 ASC
	2. ???????????? // minprice3 DESC
	3. ?????????  // popular DESC
	4. ???????????? // c_date DESC
	5. ???????????? // sale_cnt DESC
	6. ????????? ?????? ??? // bbs_num DESC
	7. ???????????? ??? // newGoods ASC
	*/
	int intSort = ChkNull.chkInt(request.getParameter("_sort"), 3);
	String strSort = "";
	switch(intSort) {
		case 1 : strSort = "minprice3"; break;
		case 2 : strSort = "minprice3 DESC"; break;
		case 3 : strSort = "popular DESC"; break;
		case 4 : strSort = "c_date DESC"; break;
		case 5 : strSort = "sale_cnt DESC"; break;
		case 6 : strSort = "bbs_num DESC"; break;
		case 7 : strSort = "popular DESC"; intTab = 1; break;
	}
	// ????????? ?????? ?????? ??? minprice3 -> minprice2 ??? ?????????.
	if(strIsDelivery.equals("Y")) {
		if(strSort.indexOf("minprice2")<0) strSort = ReplaceStr.replace(strSort, "minprice3", "minprice2");
	}
	
	// ?????????
	String strParamFactory = ChkNull.chkStr(request.getParameter("factory"), "");
	// ?????????
	String strParamBrand = ChkNull.chkStr(request.getParameter("brand"), "");
	// ???????????????
	String strParamShopCode = ChkNull.chkStr(request.getParameter("shopcode"), "");
	// ?????????
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"), "");
	
	strKeyword = strReplaceKeyword(strKeyword);
	// ?????? ??? ?????????
	String strInKeyword = ChkNull.chkStr(request.getParameter("in_keyword"), "");
	// ????????? ?????? - ??????
	long lngSPrice = ChkNull.chkLong(request.getParameter("min_price"), 0);
	// ????????? ?????? - ???
	long lngEPrice = ChkNull.chkLong(request.getParameter("max_price"), 0);
	// ??????
	String strSpec = ChkNull.chkStr(request.getParameter("spec"), "");
	// ???????????????????????? ( gb1, gb2)
	String strGb1 = ChkNull.chkStr(request.getParameter("gb1"), "");
	String strGb2 = ChkNull.chkStr(request.getParameter("gb2"), "");
	// ??????????????? 
	String strIsReSearch = ChkNull.chkStr(request.getParameter("isReSearch"), "Y");
	// ????????? ?????? ??????
	String strIsTest = ChkNull.chkStr(request.getParameter("isTest"), "N");
	// ?????????????????????
	String strPrtModelNo = ChkNull.chkStr(request.getParameter("prtmodelno"), "");
	// ???????????? ?????? ?????? ??????
	String strIsMakeShop = ChkNull.chkStr(request.getParameter("isMakeshop"), "N");
	// ??????(??????) - ????????????
	String strColor = ChkNull.chkStr(request.getParameter("color"), "");
	/** // Parameter Sets */
	
	String strMobile = ChkNull.chkStr(request.getParameter("_m"),"");
    String strIsNeov = ChkNull.chkStr(request.getParameter("isneov"),"");
    String strAll = ChkNull.chkStr(request.getParameter("_all"),"N");
	
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
	
   	// ????????? ???????????? ??????, ?????? ????????? ????????? ????????????
   	String[] noSearchKeywords = { "kb????????????", "????????????", "????????????", "????????????", "nh??????", "nk????????????", "????????????" };
   	boolean noSearchFlag = false;
   	for(int i=0; i<noSearchKeywords.length; i++) {
   		if(strKeyword.toLowerCase().equals(noSearchKeywords[i])) {
   			blParam = false;
   		}
   	}
   	//?????????????????? ????????? ??????,??????,????????????????????? 1???????????? ????????????
   	if(!strKeyword.matches(".*[???-??????-??????-???]+.*") && strKeyword.trim().length()==1) {
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
	List<JSONObject> listJson = new ArrayList<JSONObject>();
		
	// ???????????? ??? ??????????????? ?????? ??????
	Boolean blGroupModelADFlag = false;
	
	if(strFrom.equals("search") && strKeyword.trim().length()>0) {
		retMap.put("keyword", "\""+strKeyword.trim()+"\"");
	}
	
	// ???????????? ????????? ???????????? ?????? ????????? ?????????
	// ?????? ?????? ????????? ?????????(????????????????????? ?????? ??????)
	String[] removeKeywordCharAry = { "|", ",", "'" };
	for(int i=0; i<removeKeywordCharAry.length; i++) {
		strKeyword = strKeyword.replace(removeKeywordCharAry[i], " ");
		strInKeyword = strInKeyword.replace(removeKeywordCharAry[i], " ");
	}

/** ES Search */
%><%@ include file="/wide/include/IncEsSearchZum.jsp"%><%
/** // ES Search */

	/** Supertop AD */
	/*
	// ????????? ?????? ??????
	1. 1?????????????????? ??????
	2. ????????????, ???????????? ???????????? ??????
	3. ????????? ?????? ????????? ( ???, ???????????? ??? ?????? ) 
	4. ???????????? ?????? ????????? ?????? ?????? ?????? ?????? ????????? ?????? ?????? ?????????.
	*/
	Wide_List_Proc wide_list_proc = new Wide_List_Proc();

	Set<String> supertopADModelSet = new HashSet<String>(); // ????????? ?????? ?????? 
	Set<Integer> supertopADNoSet = new HashSet<Integer>(); // ????????? ?????? ?????? ??????
	String strAdNos = "";
	
	// ????????? - ????????????
	Set<Integer> zzimModelSet = new HashSet<Integer>();
	// ????????? - PriceList
	Set<Long> zzimPLSet = new HashSet<Long>();

	/* ??? ??? ?????????
	if(cb.GetCookie("MEM_INFO","USER_ID")!=null) {
		String strUserId = cb.GetCookie("MEM_INFO", "USER_ID");
		Goods_Data[] goods_save_data = Goods_Search_Lsv_Proc.getSaveGoodList(strUserId);
		
		if(goods_save_data!=null && goods_save_data.length>0) {
			
			for(int i=0; i<goods_save_data.length; i++) {
				int modelno = goods_save_data[i].getModelno();
				long pl_no = goods_save_data[i].getP_pl_no();
				
				if(modelno>0) {
					zzimModelSet.add(modelno);
				} else if(pl_no>0) {
					zzimPLSet.add(pl_no);
				}
			}
		}
	}
	*/
	
	if(pageNum==1 && (intTab==0 || intTab==1) && intSort==1 && strIsDelivery.equals("N") && strIsRental.equals("N") && strParamFactory.length()==0 && strParamBrand.length()==0 && lngSPrice==0 && lngEPrice==0 && strInKeyword.length()==0) {
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
						supertopADModelSet.add(String.valueOf((Integer) srpAdvCmpnData.getModel_no()));
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
	//retMap.put("supertopADNos", "\""+strAdNos+"\"");
	/** // Supertop AD */
	
	/** Oracle Data Fetch */
	Goods_Data[] goods_data = null;
	Map<String, Goods_Data> goods_data_map = new HashMap<String, Goods_Data>();
	List<String> goodsOrderList = new ArrayList<String>();
	if(strMpnos.length()>0) { // ES??? ????????? ??????
		String[] splitMpNos = strMpnos.split(",");
		for(int i=0;i<splitMpNos.length;i++) {
			if(splitMpNos.length>0) {
				goodsOrderList.add(splitMpNos[i]);
			}
		}
	}
	
	// ?????? ???????????? ( LP ??? ?????? ???????????? , SRP ??? 1??? ????????? ??? ????????????  ) 
	String strCateCode = strCate;
	
	// ????????? ????????? ?????? ??????
	int intNonAdItemCount = 0;
	
	//????????? ??????
	String keywordCate = "";
	
	if(intRsCnt>0) {
		
		//?????? ?????? ?????? ????????? (?????? ?????????)
		Map<String, Object> iconAttr = null;
		// ?????? ?????? ????????? (?????? ?????????)
		Map<String, Object> adAttr = null;
		// LP ???????????? ?????? ?????????(?????? ?????????)
		Map<String, Object> lpEtcAttr = null;
		// ???????????? ?????? ?????? 
		Map<String, Object> priceAttr = null;
		
		Gson gson = new Gson();
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		// ?????? ??????
		boolean IsAdultFlag = false;
		String strAdultCookie = "";
		if(cb.GetCookie("MEM_INFO","ADULT")!=null) {
			strAdultCookie = cb.GetCookie("MEM_INFO","ADULT");
			// ???????????? ??? 
			if(strAdultCookie.equals("1")) IsAdultFlag = true;
		}
		
		// ????????????
		HashSet<String> cateListHashSet = new HashSet<String>();
		HashMap<String, HashMap<String,Integer>> tHashMap = new HashMap<String, HashMap<String,Integer>>();
		
		if(strFrom.equals("search")) {
			
			String[] astrMcates = null;
			astrMcates = strMcates.split(",");
			if(astrMcates!=null && astrMcates.length>0) {
				for(int i=0; i<astrMcates.length; i++) {
					cateListHashSet.add(astrMcates[i]);
				}
			}
			
			if(cateListHashSet.size()>0) {
				//tHashMap = Know_termdic_title_Proc.getCondiNameToDicSrp(cateListHashSet);
			}
		}else{
			cateListHashSet.add(strCate4);
			
			tHashMap = Know_termdic_title_Proc.getCondiNameToDicSrp(cateListHashSet);
		}
		
		// ??????
		Rental_Model_Proc rental_model_proc = new Rental_Model_Proc();

		// ???????????? ??????
		List<JSONObject> arrGroupModel = new ArrayList<JSONObject>();
		String strGroupSort = "";
		if(intSort==2 || intSort==3) {
			strGroupSort = strSort;
		} else {
			if(strDevice.equals("pc")) {
				strGroupSort = " model_sort, condiname ";
			} else {
				strGroupSort = " case when min_ins_prc = modelno_group ||'-'|| minprice3  then 0 else v.model_sort end , condiname";
			}
		}
		Goods_Data[] goods_all_group_data = null;
		if(strModelNo_Group.length()>0) {
			
			String strGroupModelData = strModelNo_Group;
			String strADModels = "";
			if(!supertopADModelSet.isEmpty()) {
				Iterator<String> keys = supertopADModelSet.iterator();
				while(keys.hasNext()) {
					strADModels += keys.next() + ",";
				}
				strADModels = strADModels.substring(0, strADModels.length()-1);
			}
			// ????????? ????????? ?????????.
			if(strADModels.length()>0) {
				strGroupModelData = strADModels + "," + strGroupModelData;
			}
			
			// ???????????? > ????????????:?????????:?????????
			String strGroupPriceFilter = "N:0:0";
			if(lngSPrice>0 || lngEPrice>0) {
				if(strIsRental.equals("Y")) {
					strGroupPriceFilter = "Y:"+lngSPrice+":"+lngEPrice;
				} else {
					strGroupPriceFilter = "N:"+lngSPrice+":"+lngEPrice;
				}
			}
			
			// ???????????? ???????????? ?????????
			String strEtcCate = "";
			if( strCate.equals("18032401") || strCate.equals("18032402") || strCate.equals("18032403") || strCate.equals("18032405") || 
					strCate.equals("18032406") || strCate.equals("125406") || strCate.equals("060290") || strCate.equals("060631") ||
					strCate.equals("030532") || strCate.equals("070715") || strCate.equals("050321") || strCate.equals("051006") ||
					strCate.equals("051003") || strCate.equals("240630") || strCate.equals("04044627") || strCate.equals("090853") ||
					strCate.equals("180324") || strCate.equals("060129") || strCate.equals("211553")
			) {
				if(strCate.length()==6) {
					strEtcCate = strCate + "00";
				
					if( strCate.equals("180324") ) {
						strEtcCate += ",18032401,18032402,18032403,18032405,18032406";
					}
					
				} else {
					strEtcCate = strCate;
				}
			}
			
			goods_all_group_data = wide_list_proc.Goods_Bind_All_Group_List(strGroupModelData, strGroupSort, strKeyword, strSpec, strGroupPriceFilter, strIsRental, strEtcCate);
		}
		
		goods_data_map = wide_list_proc.getProdInfoGoods_Data(strModelNo_Group, strPlNos, strSort, strFrom);
		// ?????? ???????????????
		if(goodsOrderList.size()>0) {
			List<Goods_Data> tmpListData = new ArrayList<Goods_Data>();
			int icnt = 1;
			for(int i=0;i<goodsOrderList.size();i++) {
				String strTargetItemNo = goodsOrderList.get(i);
				if(goods_data_map.containsKey(strTargetItemNo)) {
					tmpListData.add(goods_data_map.get(strTargetItemNo));
					icnt++;
					//1?????????????????? pageGap = 4 ?????? ???????????? ????????? ?????? 8??? ???????????? 4?????? ?????????.
					//if(pageGap==8 && icnt>4) break;
				}
			}
			goods_data = (Goods_Data[])tmpListData.toArray(new Goods_Data[0]);
		}
		intNonAdItemCount = goods_data.length;
		
		//????????? ?????? ????????? ?????? ??????
		String[][] cardFreeAry = Pricelist_Proc.getPriceList_CardFree();
		HashMap cardNameHash = getCardNameHash();
		
		// ?????? ??????
		String strCouponContents = "";
		String[][] CouponLayerAry = Coupon_Layer_Proc.getCouponLayerList(1);
		
		// ??????
		boolean bAdultKeyword = false;
		
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
	//retMap.put("mViewFlag", "\""+strMViewFlag+"\"");
	
	// ?????????????????? ???????????? ???????????? ?????????
	List<JSONObject> specOrderList = new ArrayList<JSONObject>();
	JSONObject tmpOrderList = new JSONObject();
	
	// ?????????
	List<JSONObject> attrFactoryList = new ArrayList<JSONObject>();
	if(spec_factory_data!=null) {
		for(int gfd=0; gfd<spec_factory_data.length; gfd++) {
			if(!spec_factory_data[gfd].getFactory().trim().equals("[??????]") && !spec_factory_data[gfd].getFactory().trim().equals("[??????]")) {
				JSONObject tmpFactoryObject = new JSONObject();
				tmpFactoryObject.put("factory", spec_factory_data[gfd].getFactory().trim());
				//tmpFactoryObject.put("name", spec_factory_data[gfd].getFactory().trim());
				tmpFactoryObject.put("cnt", spec_factory_data[gfd].getPopular());
				attrFactoryList.add(tmpFactoryObject);
			}
		}
		
		tmpOrderList = new JSONObject();
		tmpOrderList.put("type", "FACTORY");
		tmpOrderList.put("imageYN", "N");
		specOrderList.add(tmpOrderList);
	}
	retMap.put("factories", attrFactoryList);
	
	// ?????????
	List<JSONObject> attrBrandList = new ArrayList<JSONObject>();
	if(spec_brand_data!=null) {
		for(int bi=0; bi<spec_brand_data.length; bi++) {
			if(!spec_brand_data[bi].getFactory().trim().equals("??????") && !spec_brand_data[bi].getFactory().trim().equals("[??????]")) {
				JSONObject tmpBrandObject = new JSONObject();
				tmpBrandObject.put("brand", spec_brand_data[bi].getFactory().trim());
				//tmpBrandObject.put("name", spec_brand_data[bi].getFactory().trim());
				tmpBrandObject.put("cnt", spec_brand_data[bi].getPopular());
				attrBrandList.add(tmpBrandObject);
			}
		}
		
		tmpOrderList = new JSONObject();
		tmpOrderList.put("type", "BRAND");
		tmpOrderList.put("imageYN", "N");
		specOrderList.add(tmpOrderList);
	}
	retMap.put("brands", attrBrandList);
	
	// ?????????
	if(strDevice.equals("all") || strDevice.equals("pc")) {
		List<Long> attrPriceList1 = new ArrayList<Long>(); // ????????????
		List<Long> attrPriceList2 = new ArrayList<Long>(); // ????????????
		List<Long> attrPriceList3 = new ArrayList<Long>(); // ????????????
		
		// priceSet. - ????????????
		if(spec_price_data1!=null) {
			for(int i=0;i<spec_price_data1.length;i++) {
				attrPriceList1.add(spec_price_data1[i]);
			}
			//Collections.sort(attrPriceList1);
			//retMap.put("price_model", attrPriceList1);
			// ?????? ????????? ( hit ???????????? ) - ????????????
			if(spec_model_avg_price1!=null) {
				//retMap.put("model_avg_price_model", "\""+spec_model_avg_price1+"\"");
			}
		}
		// priceSet. - ????????????
		if(spec_price_data2!=null) {
			for(int i=0;i<spec_price_data2.length;i++) {
				attrPriceList2.add(spec_price_data2[i]);
			}
			//Collections.sort(attrPriceList2);
			//retMap.put("price_pl", attrPriceList2);
			// ?????? ????????? ( hit ???????????? ) - ????????????
			if(spec_model_avg_price2!=null) {
				//retMap.put("model_avg_price_pl", "\""+spec_model_avg_price2+"\"");
			}
		}
		// priceSet. - ????????????
		if(spec_price_data3!=null) {
			for(int i=0;i<spec_price_data3.length;i++) {
				attrPriceList3.add(spec_price_data3[i]);
			}
			//Collections.sort(attrPriceList3);
			if(spec_price_data3.length>0){
				retMap.put("min_price", spec_price_data3[0]);
			}else{
				retMap.put("min_price", "");
			}
			if(spec_price_data3.length>=19){
				retMap.put("max_price", spec_price_data3[19]);
			}else{
				retMap.put("max_price", "");
			}
			// ?????? ????????? ( hit ???????????? ) - ????????????
			if(spec_model_avg_price3!=null) {
				//retMap.put("model_avg_price_all", "\""+spec_model_avg_price3+"\"");
			}
		}
	}
	
	//?????? ????????????
	Category_Data[] arrayMiddelCategoryDatas = null;
	ArrayList arrayCategoryMiddleList = new ArrayList();
	String strRAMargin = "";

	if(resultCategoryMiddle!=null) {
		for(int ri=0; ri<resultCategoryMiddle.length; ri++) {
			if(!resultCategoryMiddleName[ri].equals("?????? ????????????") || (resultCategoryMiddleName[ri].equals("?????? ????????????") && resultCategoryMiddle[ri][0].substring(2,4).equals("99"))) {
				Category_Data arrayMiddelCategoryData = new Category_Data();
				arrayMiddelCategoryData.setCa_code(resultCategoryMiddle[ri][0]);
				arrayMiddelCategoryData.setC_seqno(Integer.parseInt(resultCategoryMiddle[ri][1]));
				arrayMiddelCategoryData.setC_name(resultCategoryMiddleName[ri]);
				arrayCategoryMiddleList.add(arrayMiddelCategoryData);
			}
		}
		
		//retMap.put("reqCateCount", resultCategoryMiddle.length);
	}
	arrayMiddelCategoryDatas = (Category_Data[])arrayCategoryMiddleList.toArray(new Category_Data[0]);
	Arrays.sort(arrayMiddelCategoryDatas,new Category_Middle_Comparator());

	List<JSONObject> srpTopCateListJSON = new ArrayList<JSONObject>();
	List<Object> srpGroupListJSON = new ArrayList<Object>();
	
	for(int ri=0; ri<arrayCategoryMiddleList.size(); ri++){
		JSONObject tmpTopCateObj = new JSONObject();
		tmpTopCateObj.put("category_code", arrayMiddelCategoryDatas[ri].getCa_code());
		tmpTopCateObj.put("category_name", arrayMiddelCategoryDatas[ri].getC_name());
		tmpTopCateObj.put("cnt", arrayMiddelCategoryDatas[ri].getC_seqno());
		srpTopCateListJSON.add(tmpTopCateObj);
	}

	retMap.put("categories", srpTopCateListJSON);


		// ??????????????? pricelist ???????????? ????????????
		if(intTab==2) {
			
			// plnolist??? long???????????? ??????
			long[] longPlNos = null;
			String[] astrPlNos = null;
			if(strPlNos.length()>0) {
				astrPlNos = strPlNos.split(",");
				if(astrPlNos!=null && astrPlNos.length>0) {
					longPlNos = new long[astrPlNos.length];
					for(int i=0; i<astrPlNos.length; i++) {
						longPlNos[i] = 0;
						try {
							longPlNos[i] = Long.parseLong(astrPlNos[i]);
						} catch(Exception e) {}
					}
				}
			}
			
			Pricelist_Data[] pricelist_data_info = Goods_Search_Lsv_Proc.getPricelistDataPdnoCheckLsv2016(longPlNos, true, "");
			if(pricelist_data_info!=null && pricelist_data_info.length>0) {
				
				intNonAdItemCount = pricelist_data_info.length;
				
				JSONObject listItem = null;
				for(int i=0; i<pricelist_data_info.length; i++) {
					
					Global_Shop_Json shopJson = new Global_Shop_Json();
					Map<Integer, Object> shopMap = shopJson.parseGlobalShopListJson();
					
					listItem = new JSONObject();
					iconAttr = new HashMap<String, Object>();
					adAttr = new HashMap<String, Object>();
					lpEtcAttr = new HashMap<String, Object>();
					
					if(pricelist_data_info[i].getPl_no()>0) {
						
						long lngPlNo = Long.parseLong(astrPlNos[i]);

						String strGoodsName = StringReplace(pricelist_data_info[i].getGoodsnm());
						String strOrgGoodsName = StringReplace(pricelist_data_info[i].getGoodsnm());
						int intShopCode = pricelist_data_info[i].getShop_code();
						String strShopType = pricelist_data_info[i].getShop_type();
						String strSrvFlag = pricelist_data_info[i].getSrvflag();
						long lngPrice = pricelist_data_info[i].getPrice();
						String strGoodsCode  = pricelist_data_info[i].getGoodscode();
						String strPCa_Code = pricelist_data_info[i].getCa_code();
						String strUrl = pricelist_data_info[i].getUrl();
						String strMobile_url = pricelist_data_info[i].getMobile_url();
						String strImgUrl = pricelist_data_info[i].getImgurl();
						String strImgUrlFlag = pricelist_data_info[i].getImgurlflag();
						long lngInstancePrice = pricelist_data_info[i].getInstance_price();
						String strDeliveryInfo = pricelist_data_info[i].getDeliveryinfo();
						String strShopName = pricelist_data_info[i].getShop_name();
						String strFreeinterest = pricelist_data_info[i].getFreeinterest();
						String strGoodsfactory = pricelist_data_info[i].getGoodsfactory();
						String strUdate = pricelist_data_info[i].getU_date();
						int intDeliverytype2 = pricelist_data_info[i].getDeliverytype2();
						int intDeliveryinfo2 = pricelist_data_info[i].getDeliveryinfo2();
						
						//?????? ?????? ?????????
						int intBbsNum = pricelist_data_info[i].getBbs_num();
						float fltBbsPoint = pricelist_data_info[i].getBbs_point();
						
						if(intShopCode==6641 && strUrl.indexOf("<<<mourl>>>")>-1) strUrl = strUrl.substring(0, strUrl.indexOf("<<<mourl>>>"));
						strGoodsName = getRemoveCardSale(cardNameHash, strGoodsName, intShopCode, lngPrice, strPCa_Code, strFreeinterest, cardFreeAry);

						if(strGoodsfactory.trim().length()>0 && strGoodsfactory.trim().indexOf("??????")<0 && strGoodsfactory.trim().indexOf("??????")<0 && strGoodsfactory.indexOf("??????")<0 && strGoodsfactory.trim().indexOf("??????")<0 && strGoodsfactory.trim().indexOf("UnKnown")<0) {
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
								if (ChkNull.chkNumber(strTempDeliveryInfo)){
		                            strDeliveryInfo = "??????:"+FmtStr.moneyFormat(strTempDeliveryInfo)+"???";
		                        }else{
		                            strDeliveryInfo = "??????:"+strTempDeliveryInfo;
		                        }
							}
						}
						
						// ?????????
						if(strSrvFlag.equals("C")) {
							iconAttr.put("cash", new JSONObject());
						}
						
						//???????????? ?????? ???????????? ?????? 20191122 jinwook
						if( shopMap.containsKey(intShopCode) ) {
							strDeliveryInfo= "????????????(??????)";
							iconAttr.put("ovs", new JSONObject());
						}
						//listItem.put("strDeliveryInfo", strDeliveryInfo);
						
						boolean bAdult = false;
						if(bAdultKeyword || adultKeywordCheck(strGoodsName) || adultCategoryCheck(strPCa_Code) || strSrvFlag.equals("S")) {
							bAdult = true;
						}
						strImgUrl = getSearchGoodsImage(bAdult, strAdultCookie, strImgUrl, true);
						
						String adultYN = "N";
						if(bAdult) adultYN = "Y";
						listItem.put("isadultimg", adultYN);
						String strGoodsResult = "";
						switch (strPCa_Code.length()) {
					      case 2   : strGoodsResult += CutStr.cutStr(strPCa_Code,2);
					      				break;
					      case 4   : strGoodsResult += CutStr.cutStr(strPCa_Code,2) + " > " + CutStr.cutStr(strPCa_Code,4);
					      				break;
					      case 6   : strGoodsResult += CutStr.cutStr(strPCa_Code,2) + " > " + CutStr.cutStr(strPCa_Code,4) + " > "+ CutStr.cutStr(strPCa_Code,6);
					      				break;
					      case 8   : strGoodsResult += CutStr.cutStr(strPCa_Code,2) + " > " + CutStr.cutStr(strPCa_Code,4) + " > "+ CutStr.cutStr(strPCa_Code,6) + " > " +CutStr.cutStr(strPCa_Code,8);
					      				break;
					      default    : strGoodsResult += "";
					      				break;
					    } 
						listItem.put("catename", Keyword_Cate_Zum_Proc.Category_Name_One(strPCa_Code));
						listItem.put("catecode", strGoodsResult);
						
						// ????????? ????????? ?????????
						long lngPrice2 = lngPrice;
						if(intDeliverytype2==1) lngPrice2 += intDeliveryinfo2;
						
						String strMinPriceMobileTag = "N";
						String intMinPrice = formatter.format(lngInstancePrice);
						if(strIsDelivery.equals("Y")) {
							//intMinPrice = formatter.format(lngPrice2);
						} else if(lngInstancePrice==0) {
							intMinPrice = formatter.format(lngPrice);
						} else {
							if(lngInstancePrice>0 && lngPrice>lngInstancePrice) {
								strMinPriceMobileTag = "Y";
							}
						}
						//listItem.put("strMinPriceMobileTag", strMinPriceMobileTag);
						listItem.put("price", intMinPrice.replaceAll("\\,", ""));
						
						JSONObject goodsItem = new JSONObject();
						goodsItem.put("deliveryinfo", strDeliveryInfo);
						goodsItem.put("shopname", toJS2(strShopName));
						goodsItem.put("price", intMinPrice.replaceAll("\\,", ""));
						goodsItem.put("unit", "");
						goodsItem.put("unitprice", "");
						goodsItem.put("op_mallcnt", "");
						
						//listItem.put("goods_group", goodsItem);
						List<JSONObject> goods_listJson = new ArrayList<JSONObject>();
						goods_listJson.add(goodsItem);
						
						listItem.put("goods_group", goods_listJson);
						
						listItem.put("mallcnt", "1");
						listItem.put("spec", "");
						listItem.put("salecnt", "");
						listItem.put("factory", "");
						listItem.put("brand", "");
						
						strCouponContents = "";
						int coupon = pricelist_data_info[i].getCoupon();
						String[] strcoponLayer = getCouponLayerInfo(intShopCode, coupon, (int)lngPrice, 1, CouponLayerAry);
						if(strcoponLayer != null){
							strCouponContents = strcoponLayer[0];
						}
						
						// SRP ??? 1??? ??????
						if(strFrom.equals("search") && i==0) {
							strCateCode = strPCa_Code;
						}
						
						//listItem.put("prodType", "P");
						//listItem.put("strPlNo", String.valueOf(lngPlNo));
						String strLandingUrl = "http://www.enuri.com/move/zumRedirect.jsp?plno="+String.valueOf(lngPlNo);
						if (strMobile.equals("Y")){
							strLandingUrl = "http://m.enuri.com/mobilefirst/zumRedirectMobile.jsp?plno="+String.valueOf(lngPlNo)+"&from=zum"; 
						} else if (!strIsNeov.isEmpty() && strIsNeov.equals("Y")) {	//17.04.13 ???????????? ??????
							strLandingUrl = "http://www.enuri.com/move/neovRedirect.jsp?plno="+String.valueOf(lngPlNo)+"&keyword="+URLEncoder.encode(strKeyword, "UTF-8")+"&from=neov"; 
						} 
						listItem.put("landingurl", strLandingUrl);
						//listItem.put("strModelNo", "0");
						listItem.put("iscatalog","N");
						//listItem.put("strShopCode", String.valueOf(intShopCode));
						//listItem.put("strShopname", toJS2(strShopName));
						listItem.put("modelname", toJS2(strGoodsName));
						//listItem.put("strLandUrl", strUrl);
						listItem.put("imgurl", strImgUrl);
						
						//listItem.put("strFreeinterest", strFreeinterest);
						//listItem.put("strCouponContents", toJS2(strCouponContents));
						
						if(strShopType.equals("4")) {
							iconAttr.put("naverpay", new JSONObject()); // ??????????????? ?????????
						}
						
						Date uDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(strUdate);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String strFormatDate = sdf.format(uDate);
						listItem.put("cdate", strFormatDate);
						
						// 20191101 #36643 bbspoint [Core] APP LP > ???????????? ????????? API ?????? 
						// ??????????????? ?????? ?????? fltBbsPoint ??? bbs_point ??? ???????????? ?????? ??????
						// bbs_point / bbs_num ?????? ??????
						listItem.put("evl_cnt", String.valueOf(intBbsNum));
						if(fltBbsPoint > 5 && intBbsNum > 0) {
							listItem.put("bbspoint", String.format("%.1f", fltBbsPoint / intBbsNum));
						} else {
							listItem.put("bbspoint", String.valueOf( String.format("%.1f", fltBbsPoint) ));
						}

						// ??? ??????
						String strZzimYN = "N";
						if(zzimPLSet.contains(lngPlNo)) {
							strZzimYN = "Y";
						}
						//listItem.put("strZzimYN", strZzimYN);
						//listItem.put("strOpenExpectYN", "N"); // pricelist ??? ??????????????? ??????.
						
						//listItem.put("iconAttr", iconAttr);
						//listItem.put("adAttr", adAttr);
						//listItem.put("lpEtcAttr", lpEtcAttr);
						
						listJson.add(listItem);
						
					}
				}
			}
		
		// ??????, ????????????
		} else {
			
			// ????????? ?????? ???????????? ?????? ?????? goods_data ??? ??? ????????? ???????????????.
			if(!supertopADModelSet.isEmpty()) {
				Iterator<String> keys = supertopADModelSet.iterator();
				String strADModels = "";
				while(keys.hasNext()) {
					strADModels += keys.next() + ",";
				}
				strADModels = strADModels.substring(0, strADModels.length()-1);
				Goods_Data[] adModels = wide_list_proc.getGoodsModel(strADModels);
				
				if(adModels!=null && adModels.length>0) {
					// ?????? ???????????? ???????????? ??? ????????? ????????????
					ArrayList<Goods_Data> sumGoods_Data = new ArrayList<Goods_Data>();
	
					for(int i=0; i<adModels.length; i++) {
						if(adModels[i] != null && adModels[i].getModelno()>0) {
							sumGoods_Data.add(adModels[i]);
						}
					}
	
					for(int i=0; i<goods_data.length; i++) {
						sumGoods_Data.add(goods_data[i]);
					}
					goods_data = (Goods_Data[])sumGoods_Data.toArray(new Goods_Data[0]);
				}
			}
			
			// ??????????????? ?????? ??????
			Map<Integer,Integer> hitBrandMap = new HashMap<Integer, Integer>();
			hitBrandMap = wide_list_proc.getHitBrandItem(); // ??????????????? ??????????????? ???????????? ???????????? ??????
			
			// ?????? ??????
			// ??????????????? ?????????????????? ?????? ????????? ????????????
			HashMap<Integer, Goods_Change_Data> groupModelnosInfoHash = new HashMap<Integer, Goods_Change_Data>();
			int[] modelnosParamAry = null;
			int modelnosMax = 0;
			int modelnosCnt = 0;
			if(goods_data!=null && goods_data.length>0) modelnosMax += goods_data.length;
			if(goods_all_group_data!=null && goods_all_group_data.length>0) modelnosMax += goods_all_group_data.length;
			if(modelnosMax>0) {
				modelnosParamAry = new int[modelnosMax];
				if(goods_data!=null && goods_data.length>0) {
					for(int i=0; i<goods_data.length; i++) {
						if(goods_data[i]!=null) modelnosParamAry[modelnosCnt++] = goods_data[i].getModelno();
					}
				}
				if(goods_all_group_data!=null && goods_all_group_data.length>0) {
					for(int i=0; i<goods_all_group_data.length; i++) {
						if(goods_all_group_data[i]!=null) {
							modelnosParamAry[modelnosCnt++] = goods_all_group_data[i].getModelno();
						}
					}
				}
			}
			Goods_Change_Data[] goods_change_data = null;
			if(modelnosParamAry!=null && modelnosParamAry.length>0) {
				
				// ????????? where in ?????? ?????? ?????? ??????, ????????? ?????? ?????? ?????? ??????.
				if(modelnosParamAry.length>1000) {
					ArrayList<Goods_Change_Data> sumChangeData = new ArrayList<Goods_Change_Data>();
					Goods_Change_Data[] tmpChangeData = null;
					int roopCount = (modelnosParamAry.length / 1000) + 1;
					int model_param_length = modelnosParamAry.length;
					int m = 0;
					for(int i=0;i<roopCount;i++) {
						int calcLength = (model_param_length>1000) ? 1000 : model_param_length;
						int[] tmpModelsParamAry = new int[calcLength];
						int k = 0;
						for(int j=(m*1000);j<((m*1000)+calcLength);j++) {
							tmpModelsParamAry[k++] = modelnosParamAry[j];
						}
						tmpChangeData = Goods_Search_Lsv_Proc.getGoods_Bind_Change(tmpModelsParamAry);
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
					goods_change_data = Goods_Search_Lsv_Proc.getGoods_Bind_Change(modelnosParamAry);
				}
				
				if(goods_change_data!=null && goods_change_data.length>0) {
					for(int i=0; i<goods_change_data.length; i++) {
						groupModelnosInfoHash.put(goods_change_data[i].getModelno(), goods_change_data[i]);
					}
				}
			}
			
			// ?????????
			Map<Integer, List<JSONObject>> cosmeticMap = new HashMap<Integer, List<JSONObject>>();
			if(strFrom.equals("list") && ( strCate2.equals("08") || strCate2.equals("14"))) {
				cosmeticMap = wide_list_proc.getCptSkinGoodness_mobile_getAllmodel(strModelNo_Group, strCate4);
			}
			// ??????
			Map<Integer, List<JSONObject>> furnitureMap = new HashMap<Integer, List<JSONObject>>();
			if (strCate4.equals("1202") || strCate4.equals("1201")) {
				furnitureMap = wide_list_proc.getGoodsAttrGraph(strModelNo_Group, "123660,211331,133553,205023");
			}
		
%>
<%@ include file="/wide/include/IncGroupModelListJsonZum.jsp"%>
<%
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
			//retMap.put("strReSearch", "\""+list_search_flag+"\"");

			// ????????? ??????
			Set<Integer> modelVideoSet = wide_list_proc.getVideoModelSet(strModelNo_Group);
			
			// ????????????
			Map<Integer, HashMap<String, String>> promotionMap = wide_list_proc.getPromotionMap(strModelNo_Group, strFrom);
			
			Category_Set_Proc category_set_proc = new Category_Set_Proc();
			Category_Set_Data[] category_set_data = category_set_proc.getCategorySetList("");
			
			if(goods_data!=null && goods_data.length>0) {
				for(int i=0;i<goods_data.length;i++) {
					
					JSONObject listItem = new JSONObject();
					iconAttr = new HashMap<String, Object>();
					adAttr = new HashMap<String, Object>();
					lpEtcAttr = new HashMap<String, Object>();
					priceAttr = new HashMap<String, Object>();
					
					int intModelNo = goods_data[i].getModelno();
					int intModelNoGroup = goods_data[i].getModelno_group();
					long strPlNo = goods_data[i].getP_pl_no();
					
					// ????????????
					if(intModelNo==0) {
						//listItem.put("prodType", "P");
					} else {
						//listItem.put("prodType", "G");
					}
					
					//listItem.put("strModelNo", String.valueOf(intModelNo));
					//listItem.put("strPlNo", String.valueOf(strPlNo));
					String strLandingUrl = "";
					if(intModelNo==0) {
						listItem.put("iscatalog","N");
						strLandingUrl = "http://www.enuri.com/move/zumRedirect.jsp?plno="+String.valueOf(strPlNo);
						if (strMobile.equals("Y")){
							strLandingUrl = "http://m.enuri.com/mobilefirst/zumRedirectMobile.jsp?plno="+String.valueOf(strPlNo)+"&from=zum"; 
						} else if (!strIsNeov.isEmpty() && strIsNeov.equals("Y")) {	//17.04.13 ???????????? ??????
							strLandingUrl = "http://www.enuri.com/move/neovRedirect.jsp?plno="+String.valueOf(strPlNo)+"&keyword="+URLEncoder.encode(strKeyword, "UTF-8")+"&from=neov"; 
						} 
					}else{
						listItem.put("iscatalog","Y");
						strLandingUrl = "http://www.enuri.com/move/zumRedirect.jsp?modelno="+String.valueOf(intModelNo);
						if (strMobile.equals("Y")){
							strLandingUrl = "http://m.enuri.com/mobilefirst/zumMove.jsp?modelno="+String.valueOf(intModelNo)+"&from=zum";
						} else if (!strIsNeov.isEmpty() && strIsNeov.equals("Y")) {	//17.04.13 ???????????? ??????
							strLandingUrl = "http://www.enuri.com/move/neovRedirect.jsp?modelno="+String.valueOf(intModelNo)+"&keyword="+URLEncoder.encode(strKeyword, "UTF-8")+"&from=neov";
						} 
					}
					listItem.put("landingurl", strLandingUrl);
					//listItem.put("strModelNoRep", String.valueOf(intModelNoGroup));
					
					String strCa_code = goods_data[i].getCa_code();
					//listItem.put("strCate", strCa_code);
					// SRP ??? 1??? ??????
					if(strFrom.equals("search") && i==0) {
						strCateCode = strCa_code;
					}
					
					String strFactory = goods_data[i].getFactory();
					String strBrand = goods_data[i].getBrand();
					
					String strModelName = "";
					if(goods_data[i].getModelnm()!=null) {
						strModelName = goods_data[i].getModelnm();
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
						strFormatModelnm = strModel_FBN[2] +" "+ strModel_FBN[0];
					} else {
						String[] tempPriceCodeAry = goods_data[i].getSpec().split(":");
						if(tempPriceCodeAry!=null && tempPriceCodeAry.length>0) {
							int intShopCode = 0;
							try {
								intShopCode = Integer.parseInt(tempPriceCodeAry[0]);
							} catch(Exception e) {}
		
							if(intShopCode>0) {
								strFormatModelnm = getRemoveCardSale(cardNameHash, strFormatModelnm, intShopCode, goods_data[i].getMinprice(), strCa_code, goods_data[i].getFactory_etc(), cardFreeAry);
							}
						}
		
						if(strModel_FBN[1].trim().length()>0 && strModel_FBN[1].trim().indexOf("??????")<0 && strModel_FBN[1].trim().indexOf("??????")<0 && strModel_FBN[1].indexOf("??????")<0 && strModel_FBN[1].trim().indexOf("??????")<0) {
							strFormatModelnm = "["+strModel_FBN[1].trim()+"]"+strFormatModelnm;
						}
					}
					
					listItem.put("modelname", toJS2(strFormatModelnm.trim()));
					
					// ????????? , ?????????
					if(strFactory.indexOf("??????")>-1) strFactory = "";
					if(strBrand.indexOf("??????")>-1) strBrand = "";
					
					listItem.put("factory", toJS2(strFactory));
					listItem.put("brand", toJS2(strBrand));
					
					// ????????????
					Goods_Change_Data modelnosInfoOne = groupModelnosInfoHash.get(intModelNo);
					String spec_tag = "";
					String spec_tag2= "";
					String spec_tag3= "";
					String strExtraPriceTitle = "";
					String strExtraPrice = "";
					if(modelnosInfoOne!=null) {
						
						// PC ??? vip tag , ???????????? lp tag 
						if(strDevice.equals("pc")) {
							spec_tag = modelnosInfoOne.getSpec_tag();
							spec_tag2 = modelnosInfoOne.getSpec_vip_tag2();
						} else {
							spec_tag = modelnosInfoOne.getSpec_tag();
							spec_tag2 = modelnosInfoOne.getSpec_lp_tag2();
							spec_tag2 = Goods_Search_Lsv_Proc.getSpecTagDelLink(spec_tag2);
						}
						spec_tag3 = modelnosInfoOne.getSpec_lp_tag3();
						
						// ????????? , ????????? ?????? ??? ?????? ?????? ???????????? ???????????????.
						String strSplitKeyword = "";
						
						// ???????????? ??????
						//spec_tag = spec_tag.replace("</b>", "");
						
						String strSpecTagParse[] = spec_tag.split("/");
						for(int j=0; j<strSpecTagParse.length; j++) {
							if(strSpecTagParse[j].indexOf("?????????")>-1) {
								strSplitKeyword = "?????????";
							} else if(strSpecTagParse[j].indexOf("?????????")>-1) {
								strSplitKeyword = "?????????";
							}
							
							if(strSplitKeyword.length()>0) {
								if(strSpecTagParse[j].indexOf(":")>-1) {
									String strSplitSpecTag[] = strSpecTagParse[j].split(":");
									strExtraPriceTitle = strSplitKeyword;
									strExtraPrice = strSplitSpecTag[1];
									strExtraPrice = strExtraPrice.replace("???", "");
									break;
								}
							}
						}
					}
					if(spec_tag.length()==0 && goods_data[i].getSpec().length()>0 && intModelNo>0) {
						listItem.put("spec", toJS2(goods_data[i].getSpec()));
					} else {
						listItem.put("spec", toJS2(spec_tag));
					}
					
					strExtraPrice = strExtraPrice.replace("<b>", "");
					strExtraPrice = strExtraPrice.replace("<", "");
					strExtraPrice = strExtraPrice.replace("</b>", "");
					
					//listItem.put("strSpec2", toJS2(spec_tag2));
					//listItem.put("strSpec3", toJS2(spec_tag3));
					//listItem.put("strExtraPriceTitle", strExtraPriceTitle);
					//listItem.put("strExtraPrice", strExtraPrice);
					
					// ????????????
					String strOptionViewType = "";
					// optionViewType
					if(groupModelListMap.containsKey(intModelNo)) {
						
						Map<String, Object> parseGroupModelMap = groupModelListMap.get(intModelNo);
						Map<String, Object> retGroupModelMap = new HashMap<String, Object>();
						
						if(parseGroupModelMap.containsKey("list")) {
							//retGroupModelMap.put("list", parseGroupModelMap.get("list"));
							listItem.put("goods_group", parseGroupModelMap.get("list"));
						} else {
							listItem.put("goods_group", new JSONObject());
						}
						
						// ??????????????????
						if(parseGroupModelMap.containsKey("unit")) {
							retGroupModelMap.put("strUnit", (String) parseGroupModelMap.get("unit"));
						} else {
							retGroupModelMap.put("strUnit", "");
						}
						
						if(parseGroupModelMap.containsKey("change")) {
							retGroupModelMap.put("strChange", (String) parseGroupModelMap.get("change"));
						} else {
							retGroupModelMap.put("strChange", "1");
						}
						
						// ??????????????? ?????? 
						if(parseGroupModelMap.containsKey("unitPriceMsg")) {
							Map<String, String> unitTxtMap = new JsonMap<String, String>();
							unitTxtMap.put("text", (String) parseGroupModelMap.get("unitPriceMsg"));
							priceAttr.put("unit", unitTxtMap);
						}
						
						// ?????? ????????? ??????
						if(parseGroupModelMap.containsKey("optionViewType")) {
							strOptionViewType = (String) parseGroupModelMap.get("optionViewType");
						}
						
						// ???????????? ??? ??????????????? ?????? ?????? 
						if(parseGroupModelMap.containsKey("groupImageAD")) {
							adAttr.put("groupImage", (JSONObject) parseGroupModelMap.get("groupImageAD"));
						}
					}
					//listItem.put("optionViewType", strOptionViewType);
					
					// ????????? ???????????? ??????
					if(supertopADModelSet.contains(String.valueOf(intModelNoGroup))) {
						//listItem.put("strAdProdFlagYN", "Y");
						supertopADModelSet.remove(String.valueOf(intModelNoGroup)); // ??????????????? ?????????????????? ????????? ???????????????, ?????? ???????????? ?????? ??????
					} else {
						//listItem.put("strAdProdFlagYN", "N");
					}
					
					// plno
					//listItem.put("strPlNo", String.valueOf(goods_data[i].getP_pl_no()));
					
					// ?????????
					long lngMinPrice = goods_data[i].getMinprice();
					long lngMinPrice2 = goods_data[i].getMinprice2();
					long lngMinPrice3 = goods_data[i].getMinprice3();
					
					int intSaleCnt = goods_data[i].getSum_sale_cnt();
					
					// ????????????, ????????? ????????? ?????? 
					long lngCashMinPrice = goods_data[i].getCalc_cash_min_prc();
					String strCashMinFlag = goods_data[i].getCalc_cash_min_prc_yn();
					if(lngCashMinPrice == 0 && goods_data[i].getCash_min_prc() > 0 ) {
						lngCashMinPrice = goods_data[i].getCash_min_prc();
						strCashMinFlag = goods_data[i].getCash_min_prc_yn();
					}
					String strOvsMinFlag =  goods_data[i].getOvs_min_prc_yn();
					// 20191122 ????????? ????????? ???????????? ?????? jinwook
					if(intModelNo > 0 && strCashMinFlag != null && strCashMinFlag.equals("Y") && lngCashMinPrice>=lngMinPrice3 && lngMinPrice3>0) {
						strCashMinFlag = "N";
					}
					
					// 20191218 ????????? ????????? ???????????? ?????? jinwook ??? ?????? ??????
					if(intModelNo > 0 && strCashMinFlag != null && strCashMinFlag.equals("N") && lngCashMinPrice<lngMinPrice3 && lngCashMinPrice>0) {
						strCashMinFlag = "Y";
					}
					
					// 20200206 plno ?????? ?????? ??? ?????? ????????? ????????? ???  ????????? ???????????? Y ??? ????????????. jinwook
					if(intModelNo == 0 && goods_data[i].getCash_min_prc_yn().equals("Y") && strCashMinFlag.equals("N")) {
						lngCashMinPrice = lngMinPrice3;
						strCashMinFlag = "Y";
					}
					
					if(strCashMinFlag.equals("Y")) {
						Map<String, String> cashMap = new JsonMap<String, String>();
						if(lngCashMinPrice>0) {
							cashMap.put("price", formatter.format(lngCashMinPrice).replaceAll("\\,", ""));
						}
					//	iconAttr.put("cash", cashMap);
					}
					if(strOvsMinFlag.equals("Y")) {
						iconAttr.put("ovs", new JSONObject());
					}
					
					String strMinPriceMobileTag = "N";
					String intMinPrice = formatter.format(lngMinPrice3);
					
					if(strIsDelivery.equals("Y")) {
						//intMinPrice = formatter.format(lngMinPrice2);
					} else if(lngMinPrice2==0) {
						intMinPrice = formatter.format(lngMinPrice);
					} else {
						if(goods_data[i].getMallcnt()>0 && goods_data[i].getMallcnt3()>0 && (lngMinPrice3<lngMinPrice)) {
							strMinPriceMobileTag = "Y";
						}
					}
					
					// #46975 [PC/MW/APP] ????????? ????????? ?????? ?????? ??????
					// strCashMinFlag "N" ?????? ??????
					if(intMinPrice.equals("0") && lngCashMinPrice>0 && strCashMinFlag.equals("Y")) {
						String strCashMinPriceFormat = formatter.format(lngCashMinPrice);
						intMinPrice = strCashMinPriceFormat;
					}
					
					//listItem.put("strMinPriceMobileTag", strMinPriceMobileTag);
					listItem.put("price", intMinPrice.replaceAll("\\,", ""));
					
					int intMallCnt = goods_data[i].getMallcnt();
					int intMallCnt3 = goods_data[i].getMallcnt3();
					String strOpenExpectFlag = goods_data[i].getOpenexpectflag();
					String strCdate = goods_data[i].getC_date();
					// ?????? ?????? ?????? ( ????????????, ?????? )
					String strProdStatusTxt = ""; // ??????(??????), ??????(????????????)
					if(intMallCnt3==0 && intMallCnt==0) {
						if(strOpenExpectFlag.equals("Y") || DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) { // ????????????
							strProdStatusTxt = "??????";
						} else { // ??????
							strProdStatusTxt = "??????";
						}
					} else {
						if(intMallCnt==1 && DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) { // ????????????
							strProdStatusTxt = "??????";
						} else if((strOpenExpectFlag.equals("Y") || DateUtil.getDaysBetween(strCdate,DateStr.nowStr())>0) && goods_data[i].getIsgroup()!=1) { // ????????????
							strProdStatusTxt = "??????";
							intMallCnt = 0;
							intMallCnt3 = 0;
						} else {
							if((CutStr.cutStr(strCa_code,4).equals("0304") || CutStr.cutStr(strCa_code,4).equals("0305") || CutStr.cutStr(strCa_code,4).equals("0233")) && lngMinPrice3==0) {
								strProdStatusTxt = "??????";
							}
						}
					}
					
					//listItem.put("strProdStatusTxt", strProdStatusTxt);
					listItem.put("mallcnt", String.valueOf(intMallCnt));
					//listItem.put("strMallCnt3", String.valueOf(intMallCnt3));
					Date uDate = new SimpleDateFormat("yyyyMMdd").parse(strCdate);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String strFormatDate = sdf.format(uDate);
					listItem.put("cdate", strFormatDate);
					//listItem.put("strOpenExpectYN", strOpenExpectFlag);
					
					// ???????????? ?????? 
					String strImageUrl = goods_data[i].getP_imgurl2();
					String strAdultYn = "N";
					
					if(intModelNo>0) {
						
						// ?????? ????????? true ?????? ????????? ??????
						if(strDevice.equals("aos") || strDevice.equals("ios")) {
							goods_data[i].setAdultChk(true);
						} else {
							goods_data[i].setAdultChk(IsAdultFlag); // ????????????
						}
						
						strImageUrl = ImageUtil_lsv.getImageSrc(goods_data[i]);
						
						if(CutStr.cutStr(strCate,6).equals("163630") || CutStr.cutStr(strCate,6).equals("931004") || CutStr.cutStr(strCate,6).equals("051523") || CutStr.cutStr(strCate,6).equals("051513")) {
							strAdultYn = "Y";
						}
					} else {
						
						if(bAdultKeyword || adultKeywordCheck(strModelName) || adultCategoryCheck(strCa_code)) {
							strAdultYn = "Y";
						}
						
						boolean blAdult = (strAdultYn.equals("Y")) ? true : false;
						strImageUrl = getSearchGoodsImage(blAdult, strAdultCookie, strImageUrl, true);
					
					}
					
					listItem.put("isadultimg", strAdultYn);
					listItem.put("imgurl", strImageUrl);
					
					// ??????
					float fltBbsPoint = goods_data[i].getBbs_point_avg();
					int intBbsNum = goods_data[i].getBbs_num();
					
					// ??????????????? ?????? strBbsPoint ??? ????????? ?????? ????????? ?????? ????????? ?????? ????????? ??? ??? ???????????? ?????? ????????????
					if(fltBbsPoint > 5 && intBbsNum > 0) {
						String strBbsPoint = String.format("%.1f", fltBbsPoint / intBbsNum);
						fltBbsPoint = Float.parseFloat(strBbsPoint);
						listItem.put("bbspoint", String.valueOf(fltBbsPoint));
					} else {
						listItem.put("bbspoint", String.valueOf( String.format("%.1f", fltBbsPoint) ));
					}
					listItem.put("evl_cnt", String.valueOf(intBbsNum));
					listItem.put("salecnt", String.valueOf(intSaleCnt));
					
					// ??? ????????????
					if(goods_data[i].getKeyword2()!=null) {
						listItem.put("desc", goods_data[i].getKeyword2());
					} else {
						listItem.put("desc", "");
					}
					
					// ??????????????? ??????
					if(hitBrandMap.containsKey(intModelNoGroup)) {
						adAttr.put("hitbrand", new JSONObject());
					}
					
					// ?????????
					if(strFrom.equals("list") && ( strCate2.equals("08") || strCate2.equals("14") ) && cosmeticMap.containsKey(intModelNoGroup)) {
						Map<String, Object> cosmeticParseMap = new HashMap<String, Object>();
						cosmeticParseMap.put("title", "?????????");
						cosmeticParseMap.put("value", cosmeticMap.get(intModelNoGroup));
						
						lpEtcAttr.put("cosmetic", cosmeticParseMap);
					}
					
					// ??????
					if(furnitureMap.containsKey(intModelNo)) {
						lpEtcAttr.put("furniture", furnitureMap.get(intModelNo));
					}
					
					//listItem.put("iconAttr", iconAttr);
					//listItem.put("adAttr", adAttr);
					//listItem.put("lpEtcAttr", lpEtcAttr);
					//listItem.put("priceAttr", priceAttr);
					
					// ?????? D?????? ??????
					if(strFrom.equals("search") && goods_data[i].isDtypeFlag()) {
						//listItem.put("strKeywordDTypeYN", "Y");
					} else {
						//listItem.put("strKeywordDTypeYN", "N");
					}
					
					// ?????? ??????, ????????????, ???????????????
					strCouponContents = "";
					if(intModelNo==0) {
						String strDataSpec = goods_data[i].getSpec();
						String[] strSpecAry = strDataSpec.split(":");
						int intShopCode = 0;
						if(strSpecAry!=null && strSpecAry.length>0) {
							try {
								intShopCode = Integer.parseInt(strSpecAry[0]);
							} catch(Exception e) {}
						}
						int coupon = goods_data[i].getHeight();
						if(intShopCode>0) {
							String[] strcoponLayer = getCouponLayerInfo(intShopCode, coupon, (int)lngMinPrice, 1, CouponLayerAry);
							if(strcoponLayer != null){
								strCouponContents = strcoponLayer[0];
							}
							
							String strShopName = HtmlStr.removeHtml(goods_data[i].getKb_title()); // ??????????????? ???????????? shop_name??? ??????
							// ????????????????????? ??????
							//listItem.put("strShopCode", String.valueOf(intShopCode));
							//listItem.put("strShopName", strShopName);
						}
					}
					//listItem.put("strCouponContents", strCouponContents);
					
					// ????????? ??????, ????????? ??????
					String strEventTxt = "";
					long lngEventPrice = 0;
					//listItem.put("strEventTxt", strEventTxt);
					//listItem.put("strEventPrice", formatter.format(lngEventPrice));
					
					// ?????? ?????? ?????? ??????
					if(intModelNo==0) {
						//listItem.put("strLandUrl", goods_data[i].getUrl1());
					} else {
						//listItem.put("strLandUrl", "");
					}
					
					// ???????????? pricelist ???????????????
					String strDeliveryInfo = "";
					if(goods_data[i].getDeliveryInfo()!=null && goods_data[i].getDeliveryInfo().trim().length()>0) {
						strDeliveryInfo = goods_data[i].getDeliveryInfo();
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
					if(goods_data[i].getShop_type()!=null && goods_data[i].getShop_type().trim().length()>0) {
						strShopType = goods_data[i].getShop_type();
					}
					if(strShopType.equals("4")) {
						iconAttr.put("naverpay", new JSONObject());
					}
					
					// ????????? ????????????
					String strVideoYN = "N";
					if(modelVideoSet.contains(intModelNo)) {
						strVideoYN = "Y";
					}
					//listItem.put("strVideoYN", strVideoYN);
					
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
					//listItem.put("strPromotionUrl", strPromotionUrl);
					//listItem.put("strPromotionShopName", strPromotionShopNm);
					
					// ??? ??????
					String strZzimYN = "N";
					if(zzimModelSet.contains(intModelNo)) {
						strZzimYN = "Y";
					} else if(zzimPLSet.contains(goods_data[i].getP_pl_no())) {
						strZzimYN = "Y";
					}
					//listItem.put("strZzimYN", strZzimYN);
					listJson.add(listItem);
				}
			}
		}
		
		if(strKeyword.length()>0){
			keywordCate = Keyword_Cate_Zum_Proc.getCategory(strKeyword);
		}
		if (keywordCate.length() > 0){
			retMap.put("iscate", "\"Y\"");
		}else{
			retMap.put("iscate", "\"N\"");
		}
		retMap.put("cate", "\""+keywordCate+"\"");
		
		//retMap.put("strCaCode", "\""+String.valueOf(strCateCode)+"\"");
	}
	
	//???????????????
	String strLinkageKeyword = "";
	if(keywordCate.trim().length() > 0 && !keywordCate.equals("00000000")){
		if (keywordCate.trim().length() > 0 && !strAll.equals("Y")){
			RecKeyword_Data[] reckeyword_data = Keyword_Cate_Zum_Proc.RecKeyword_List(keywordCate);
			if (reckeyword_data != null && reckeyword_data.length > 0){
				for (int i=0;i<reckeyword_data.length;i++){
					if(i>0){
						strLinkageKeyword += ",";
					}
					strLinkageKeyword += ReplaceStr.replace(strJsonReplace(reckeyword_data[i].getCa_title()),"\r\n","");
				}
			}
		}
	}else{
		/*String strLinkageWords[] = Keyword_Cate_Zum_Proc.getLinkageWordList(strKeyword);
		if (strLinkageWords != null && strLinkageWords.length > 0 ){
			int intCnt = 0;
			for (int sci=0;sci<strLinkageWords.length;sci++){
				if (!strKeyword.equals(strLinkageWords[sci])){
					if (intCnt > 0 ){
						strRecKeywordResult += ",";
					}			
					strRecKeywordResult += strLinkageWords[sci];
					intCnt++;
				}
			}
		}*/
		try{
			String serverIPcore = "192.168.213.168";
			String serverIPzum = "192.168.213.168";
			String serverIPsmartmaker = "192.168.213.163";
			//String strCollectionName = "enuri-srp";
			//String strAutoMakerCollectionName = "enuri-smartmaker";
			//String strGroupName = "main";
			int builderPort = 8080;
			int esCordiPort = 9200;
			
			csearch.setIntPortSet(esCordiPort);//port
			csearch.setStrCollectionName(strAutoMakerCollectionName);//????????????
			csearch.setStrHostSet(serverIPsmartmaker);//???????????? ??????

			csearch.setStrUserIp(request.getRemoteAddr());
			csearch.setStrKeyword(strKeyword);
			csearch.setNPageSize(30);
			String strAutoMakerTemp = csearch.CSearchRunSmartMaker();//?????? ??????
			String astrAutoMakerTemp[] = strAutoMakerTemp.split("\\^");
			String strAutoMakerTemp2 = "";
			int intAutoMakeWCnt = 0;
			for (int i=0;i<astrAutoMakerTemp.length;i++){
				if (CutStr.cutStr(astrAutoMakerTemp[i],2).equals("W:")){
					boolean bWCheck = false;
					for (int j=0;j<i;j++){
						if (CutStr.cutStr(astrAutoMakerTemp[j],2).equals("W:")){
							if (astrAutoMakerTemp[i].equals(astrAutoMakerTemp[j])){
								bWCheck = true;
							}
						}
					}
					boolean bAdultKeyword = false;
					String strAdultKeyword = "????????????,??????,??????,??????";
					String[] strArrayAdultKeyword = strAdultKeyword.split(",");
					for (int ai=0;ai<strArrayAdultKeyword.length;ai++){
						if (astrAutoMakerTemp[i].indexOf(strArrayAdultKeyword[ai]) >= 0){
							bAdultKeyword = true;
							break;
						}
					}				
					if (!bWCheck && !bAdultKeyword && astrAutoMakerTemp[i].trim().length() <= 10 && intAutoMakeWCnt < 10 && !strKeyword.toUpperCase().equals(ReplaceStr.replace(astrAutoMakerTemp[i].toUpperCase(),"W:",""))){
						if (strLinkageKeyword.trim().length() > 0){
							strLinkageKeyword += ",";
						}
						strLinkageKeyword += ReplaceStr.replace(astrAutoMakerTemp[i],"W:","");
						intAutoMakeWCnt++; 
					}
				}
			}		
		}catch(Exception e){
			//System.out.println("smartmaker error = "+e.toString());
		}finally {
		}
	}
	//retMap.put("strCate", "\""+strCateCode.substring(0, 4)+"\"");
	if(strLinkageKeyword.length()>0){
		retMap.put("rec_keywords", "\""+strLinkageKeyword+"\"");
	}else{
		retMap.put("rec_keywords", "\"\"");
	}
	retMap.put("goods", listJson);
	//retMap.put("nonAdItemSize", intNonAdItemCount);
	
	// SRP????????? ??? C????????? ????????? ??????.
	String blKeywordCType = "N";
	if(strFrom.equals("search")) {
		boolean keywordCTypeCheck = wide_list_proc.getCountSRPCType(strKeyword);
		if(keywordCTypeCheck) {
			blKeywordCType = "Y";
		}
	}
	//retMap.put("strKeywordCTypeYN", "\""+blKeywordCType+"\"");
	
	// ???????????? 
	// strFuzzy ( LP -1 , SRP??? ??????????????? 0 )
	String strFuzzy = "-1";
	if(strFrom.equals("search")) { // lp 
		strFuzzy = String.valueOf(intFuzzy);
	}
	//retMap.put("strFuzzy", "\""+strFuzzy+"\"");
	
	JSONArray searchedKeywordAry = new JSONArray();
	JSONArray searchedKeywordOrgAry = new JSONArray();
	// ??????????????? ??? ?????? ??????
	if(searchedKeyword.length()>0) {
		//retMap.put("searchedKeyword", "\""+searchedKeyword+"\"");
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
		//retMap.put("searchedKeyword", "\"\"");
	}
	//retMap.put("searchedKeywordAry", searchedKeywordAry);
	//retMap.put("searchedKeywordOrgAry", searchedKeywordOrgAry);
	retMap.put("totalcnt", "\""+intTotRsCnt+"\"");
	retMap.put("enuricnt", "\""+intEnuriCnt+"\"");
	retMap.put("webcnt", "\""+intWebCnt+"\"");
	retMap.put("deptcnt", "\"0\"");
	
	ret = new JsonResponse(true).setData(retMap).setTotal(intTotRsCnt);
	out.print ( retMap );
	
	
	// ?????? ??????
	String ipaddress = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
	String strTmpId = cb.GetCookie("MYINFO","TMP_ID");
	String userid = cb.GetCookie("MEM_INFO","USER_ID");
	String strGubun = "1";
	
	/*try {  
		if(strDevice.equals("pc")) {
			Model_log_Proc.Cate_log_Insert(strCate, strGubun, strTmpId, ipaddress, userid);
		}
	} catch(Exception ex) {
	}*/ 
%>

<%!
public static String connect_other_api(String str) {

	int timeout = 30000;

	HttpURLConnection c = null;
	StringBuilder sb = new StringBuilder();
	
	try {
		URL u = new URL(str);

		c = (HttpURLConnection)
		u.openConnection();
		c.setRequestMethod("GET");
	//	c.setRequestProperty("Content-length", "0");
		c.setRequestProperty("Content-Type", "application/json");
		c.setRequestProperty("Accept-Charset", "UTF-8");
		c.setUseCaches(false);
		c.setAllowUserInteraction(false);
		c.setConnectTimeout(timeout);
		c.setReadTimeout(timeout);
		c.connect();
		
		int status = c.getResponseCode();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
	
		String line;

		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
	
		br.close();

	} catch (FileNotFoundException fe) {
		System.out.println("[List Old API fe] " + fe.getMessage() + " == str : " + str);
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println("[List Old API  e] " + e.getMessage() + " == str : " + str);
	} finally {
		if (c != null) {
			c.disconnect();
		}
	}
	return sb.toString() ;
}

private String strJsonReplace(String str){
	str = ReplaceStr.replace(str, "&#47;", "/");
	return str.replace("\\", "\\\\")
		     .replace("\"", "&quot;")
		     .replace("\'", "&apos;")
		     .replace("\b", "")
		     .replace("\f", "")
		     .replace("\n", "") 
		     .replace("\r", "")
		     .replace("\t", "");
}

public static String szConnectIp(HttpServletRequest request)
{
	String ip = request.getHeader("X-Forwarded-For");
    String ip2 = request.getHeader("X-Forwarded-For");
	 
	if(ip != null && ip.indexOf(",")>-1) {
		ip = ip.split(",")[0];
	}
    
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        if(ip2 != null && ip2.length() > 0){
            if(ip2.indexOf(",")>-1) {
                ip = ip2.split(",")[1];
            }
        }
	}
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	} 
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_CLIENT_IP");
	} 
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	} 
    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	return ip;
}
%>