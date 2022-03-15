<%@ page contentType="text/html; charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="org.json.simple.JSONObject"%>
<%

	/**
	 * @history
	 	2021.02.24. 최조작성
	*/
	
	/** Parameter Sets */
	// 카테고리
	String strCate = ConfigManager.RequestStr(request, "category", "");
	String strName = ConfigManager.RequestStr(request, "name", "");
	
	/** // Parameter Sets */
	
	/** Parameter Validation Check */
	boolean blParam = true;
	JsonResponse ret = null;
	if(strCate.length()==0) {
		blParam = false;
	}
	if(!blParam) {
		ret = new JsonResponse(false).setCode(10).setParam(request);
		out.print(ret);
		return;
	}
	/** // Parameter Validation Check */
	
	Map<String, Object> dataMap = new JsonMap<String, Object>();
	
	// 매핑 카테 세팅
	// Map<String, HashMap<String, JSONObject>> 
	// Map<레벨, 레벨별 카테고리 데이터>
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	dataMap = lp_header_proc.getCategoryList_GNB(strCate, strName);
	
	// 결과 데이터 리턴
	Map<String, Object> retMap = new JsonMap<String, Object>();
	
	if(dataMap.size()>0) {
		Iterator<String> keys = dataMap.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			retMap.put(key, dataMap.get(key));
		}
	}
	
	retMap.put("param_cate",  "\""+strCate+"\"");
	if(strName.length()>0) {
		retMap.put("param_name",  "\""+strName+"\"");
	}
	ret = new JsonResponse(true).setData(retMap);
	out.print ( ret );
%>