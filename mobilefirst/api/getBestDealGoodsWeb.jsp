<%@page import="org.json.JSONException"%>
<%@page import="java.util.Random"%>
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
	String db = ChkNull.chkStr(request.getParameter("db"),"H"); //카테고리
	String device = ChkNull.chkStr(request.getParameter("device"),"M"); //카테고리

	int CJ = 806;
	int GSSHOP = 75;
	int QOO10 = 7857;
	int NSMALL = 974;
	int SSG = 47;

	String[] VALUES = new String[] {"536" , "4027" , "5910" , "6641" , "6508" ,  "55"  };
	if("B".equals(db) ){
		VALUES = new String[] {"536" , "4027" , "5910" , "6641" , "6508" ,  "55" , CJ+"" , NSMALL+"" , QOO10+"" , SSG+"" };
	}
	
	JSONArray jSONArray = new JSONArray();
	jSONArray = mgp.getDealBestGoodsNew(spm_cd, kncd, cate,device);
	
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
		
		if("B".equals(kncd) && !cate.equals("")){
			out.println(shuffleJsonArray(jSONArray).toString());
		}else{
			out.println(jSONArray.toString());	
		}
	}
%>
<%!
	public static JSONArray shuffleJsonArray (JSONArray array) throws JSONException {
	    // Implementing Fisher��ates shuffle
	        Random rnd = new Random();
	        for (int i = array.length() - 1; i >= 0; i--)
	        {
	          int j = rnd.nextInt(i + 1);
	          // Simple swap
	          Object object = array.get(j);
	          array.put(j, array.get(i));
	          array.put(i, object);
	        }
	    return array;
	}
%>