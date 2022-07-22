<%@page import="org.json.simple.JSONObject"%>
<%@ include file="/lsv2016/include/IncAjaxHeader.jsp"%>
<%@ page import="com.enuri.bean.wide.Lp_Header_Proc"%>
<%@ page import="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc"%>
<jsp:useBean id="Goods_Search_Lsv" class="com.enuri.bean.lsv2016.Goods_Search_Lsv_Proc" scope="page" />
<%
	// 구 api -> /lsv2016/ajax/getCateNameList_ajax.jsp
	String ingiModelnos = ConfigManager.RequestStr(request, "ingiModelnos", "");
	String strServerNm = request.getServerName();
	boolean blDevFlag = false;
	if (strServerNm.indexOf("dev.enuri.com") > -1) {
		blDevFlag = true;
	}
	
	char checkKey = ',';
	long checkKeyCnt = ingiModelnos.chars().filter(c -> c == checkKey).count();
	
	JsonResponse ret = null;
	
	if(ingiModelnos.trim().length()==0) {
		ret = new JsonResponse(false).setMessage("parameter empty!");
		out.println(ret);
		return;
	}
	
	if(checkKeyCnt>=90) {
		ret = new JsonResponse(false).setMessage("parameter count over");
		out.println(ret);
		return;
	}
	
	String[] strCateListAry = null;
	// 카테고리 , 카테고리 내용
	Map<String, List<JSONObject>> cateObject = new JsonMap<String, List<JSONObject>>();
	List<Map<String,Object>> modelList = new ArrayList<Map<String,Object>>();
	
	String strCateList = "";
	try {
		strCateList = Goods_Search_Lsv.getCategoryStrList1(ingiModelnos);
	} catch(Exception e) {
		System.out.println("[gnbNameListByCate Error] : " + e.getLocalizedMessage());
	}
		
	if(strCateList.length()==0) {
		ret = new JsonResponse(false).setMessage("category empty!");
		out.println(ret);
		return;
	}
	
	if(strCateList!=null && strCateList.length()>0) {
		strCateListAry = strCateList.split(",");
	}
	
	
	Lp_Header_Proc lp_header_proc = new Lp_Header_Proc();
	if(strCateListAry!=null && strCateListAry.length>0) {
		for(int c=0; c<strCateListAry.length; c++) {
			String[] modelData = null;
			if(strCateListAry[c].indexOf(":")>-1) {
				modelData = strCateListAry[c].split(":");
			}

			// 오류 데이터 처리
			if(modelData==null || modelData.length<2) continue;
			
			Map<String, Object> retMap = new JsonMap<String, Object>();
			String modelItem = modelData[0];
			String cateItem = modelData[1];
			
			// 중카테 이상일때부터
			if(cateItem.length()>=4) {
				
				if(cateItem.length() == 8 && cateItem.substring(6,8).equals("00") ){
					cateItem = cateItem.substring(0,6);
				}
				if(cateItem.length() == 6 && cateItem.substring(4,6).equals("00") ){
					cateItem = cateItem.substring(0,4);
				}
				
				retMap.put("modelno", "\""+modelItem+"\"");
				
				// 해당 카테고리 정보가 있을 경우 map에서 꺼내서 사용
				if(cateObject.containsKey(cateItem)) {
					List<JSONObject> dataObj = (List<JSONObject>) cateObject.get(cateItem);
					retMap.put("cateNameList", dataObj);
					if(!dataObj.isEmpty()) {
						retMap.put("cateCode", "\"" + (String) ((JSONObject) dataObj.get(0)).get("cate_cd") + "\"");
					} else {
						retMap.put("cateCode", "\"\"");
					}
				} else {
					List<JSONObject> gnbData = lp_header_proc.getUnionCate_gnbDataByCate(cateItem, "pc", blDevFlag);
					if(gnbData.isEmpty()) {
						for(int j=cateItem.length();j>4;j-=2) {
							gnbData = lp_header_proc.getUnionCate_gnbDataByCate(cateItem.substring(0, j), "pc", blDevFlag);
							if(!gnbData.isEmpty()) {
								break;
							}
						}
					}
					
					if(!gnbData.isEmpty()) {
						cateObject.put(cateItem, gnbData);
						retMap.put("cateCode", "\"" + (String) ((JSONObject) gnbData.get(0)).get("cate_cd") + "\"");
					} else {
						retMap.put("cateCode", "\"\"");
					}
					retMap.put("cateNameList", gnbData);
				}
				modelList.add(retMap);
			}
		}
	}
	
	ret = new JsonResponse(true).setData(modelList).setTotal(modelList.size());
	out.println(ret);
%>