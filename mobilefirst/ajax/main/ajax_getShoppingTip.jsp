<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="com.enuri.bean.mobile.Shopping_Guide_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.commons.lang3.*"%>
<%@page import="org.json.*"%>
<%
String strNews_cate = StringUtils.defaultString(request.getParameter("cate"));

if(!strNews_cate.equals("")){
	
	Shopping_Guide_Proc shopping_guide_proc = new Shopping_Guide_Proc();
	
	JSONObject jsonList = new JSONObject();
	int pagesize = 10;
	
	if(strNews_cate.equals("01")){//디지털
		String[] arr = {"02","03","24","05","06","22"};
		jsonList = shopping_guide_proc.getShoppingGuide_cate(pagesize,arr,"kb_regdate","desc");
	}else if(strNews_cate.equals("02")){//컴퓨터
		String[] arr = {"04","07"};
		jsonList = shopping_guide_proc.getShoppingGuide_cate(pagesize,arr,"kb_regdate","desc");
	}else if(strNews_cate.equals("03")){//스포츠 자동차
		String[] arr = {"21","09"};
		jsonList = shopping_guide_proc.getShoppingGuide_cate(pagesize,arr,"kb_regdate","desc");
	}else if(strNews_cate.equals("04")){//유아/라이프
		String[] arr = {"12","10","15","18","16","24","93","95"};
		jsonList = shopping_guide_proc.getShoppingGuide_cate(pagesize,arr,"kb_regdate","desc");
	}
	
	JSONArray jSONArray = new JSONArray(); 
	jSONArray = shuffleJsonArray(jsonList.getJSONArray("list"));
	
	
	JSONArray jSONTemp = new JSONArray();
	for(int i = 0 ; i < jSONArray.length() ; i ++){
		jSONTemp.put(jSONArray.getJSONObject(i));
		if(i == 4){
			break;
		}
	}
	out.println(jSONTemp.toString());
}
%>
<%!
public JSONArray shuffleJsonArray (JSONArray array) throws JSONException {
        int cnt = 0;
	
		Random rnd = new Random();
        for (int i = array.length() - 1; i >= 0; i--){
          int j = rnd.nextInt(i + 1);
          // Simple swap
          Object object = array.get(j);
          array.put(j, array.get(i));
          array.put(i, object);
        }
    return array;
}
%>