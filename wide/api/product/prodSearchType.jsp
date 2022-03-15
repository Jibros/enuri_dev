<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.common.JsonResponse"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Change_Data"%>
<%@ page import="com.enuri.bean.main.Search_Type_Proc"%>
<jsp:useBean id="Search_Type_Proc" class="com.enuri.bean.main.Search_Type_Proc" scope="page" />
<%@page import="org.json.*"%>
<%@ page import="java.util.regex.*"%>
<%
	
	Search_Type_Proc search_type_proc = new Search_Type_Proc();
	JsonResponse ret = null;
	//deviceType=1 : PC
	//deviceType=2 : 모바일
	String deviceType = ConfigManager.RequestStr(request, "deviceType", "1");  		//PC VIP C타입 전용 API
	String strKeyword = ChkNull.chkStr(request.getParameter("keyword"));
	String strKeywordTmp = strKeyword.replaceAll(" ","");
	String strModelType = "";

	String serverName = request.getServerName();
	String strServerName = "";

	if(serverName.indexOf("dev.enuri.com") > -1 ) {
		strServerName = "dev";
	}else{
		strServerName = "real";
	}

	/***************************************************************************************
		PC VIP 휴대폰/스마트폰(0304) SRP2 C타입 추가 Start : 2018.09.11
	****************************************************************************************/
	int intVipModelNo = ChkNull.chkInt(ConfigManager.RequestStr(request, "vipModelNo", "0"));

	// db에 있는 키워드 정보를 가져 옴.
	if(intVipModelNo > 0) strKeywordTmp = search_type_proc.getVipModelNoSearchType(intVipModelNo, strServerName);
	/***************************************************************************************
		PC VIP 휴대폰/스마트폰(0304) SRP2 C타입 추가 End
	***************************************************************************************/

	int iModelno = 0;
	String type_cd = "";
	JSONArray jsonArray = new JSONArray();
	jsonArray = search_type_proc.getSearchTypeJson(strKeywordTmp, strServerName);

	JSONObject result = new JSONObject();
    boolean bDtypeAuto = false;

	if(jsonArray.length() == 0){
		jsonArray = new JSONArray();
		strKeywordTmp = strKeyword.replaceAll("-","").replaceAll(" ","");
		jsonArray = search_type_proc.getSearchTypeJsonByGoodsModelnm(strKeywordTmp);		//기본 C,D가 아닐때 D타입 자동화 로직
		bDtypeAuto = true;	// D타입 자동화 로직은 영문+숫자+4자이상 제한있음
	}

	if(jsonArray.length() == 0){
		jsonArray = new JSONArray();
		jsonArray = search_type_proc.getSearchTypeJsonByEnuriKeyword(strKeyword);		//기본 C,D가 아닐때 C타입 동의어태움
		bDtypeAuto = false;
	}

	JSONObject tabObject = new JSONObject(); //option1
	ArrayList<String> arrayList = new ArrayList<String>(); //option2

	for(int i = 0 ; i < jsonArray.length(); i ++){
		JSONArray tmpArray = new JSONArray();
		JSONObject tmpObject = jsonArray.getJSONObject(i);

		if(!arrayList.contains(tmpObject.getString("OPTION_2"))){
			arrayList.add(tmpObject.getString("OPTION_2"));
		}

		if(tabObject.has(tmpObject.getString("OPTION_1"))){
			tmpArray = tabObject.getJSONArray(tmpObject.getString("OPTION_1"));
		}else{
			tmpArray = new JSONArray();
		}

		tmpArray.put(tmpObject);
		tabObject.put(tmpObject.getString("OPTION_1"), tmpArray);
	}

	result.put("option1", tabObject);
	result.put("option2", arrayList);

	ret = new JsonResponse(true).setData(result).setTotal(jsonArray.length());
	out.println(ret);
%>