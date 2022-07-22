<%@page import="java.util.Arrays"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.enuri.bean.mobile.Mobile_GoodsToPricelist_Proc"%>
<%
	Mobile_GoodsToPricelist_Proc mgp = new Mobile_GoodsToPricelist_Proc();
	
	String spm_cd = ChkNull.chkStr(request.getParameter("scode")); //업체코드
	String kncd = ChkNull.chkStr(request.getParameter("kncd"));	//B 특가모음 , H 핫딜베스트
	String cate = ChkNull.chkStr(request.getParameter("cate")); //카테고리
	String kind = ChkNull.chkStr(request.getParameter("kind"),"1"); //카테고리

	int CJ = 806;
	int GSSHOP = 75;
	int QOO10 = 7857;
	int NSMALL = 974;
	int SSG = 47;
	
	String[] VALUES = new String[] {"6641" , "536" , "4027" , "5910" , "55" ,  "6508"};
	
	JSONArray jSONArray = new JSONArray();
	jSONArray = mgp.getKDealBestGoods(spm_cd, kncd, cate);
	
	JSONArray arrayTemp = new JSONArray();
	if("H".equals(kncd) &&  "1".equals(kind)  ){
		for(int i = 0 ; i < jSONArray.length() ; i++ ){
			
			JSONObject json = jSONArray.getJSONObject(i);
			String SPM_CD = json.getString("SPM_CD");
			
			boolean result = Arrays.asList(VALUES).contains(SPM_CD);
			
			if(result){
				arrayTemp.put(json);
			}
			if(i >= 100 ) break;
		}
		out.println(arrayTemp.toString());
	}else{
		out.println(jSONArray.toString());
	}
%>