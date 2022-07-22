<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="com.enuri.bean.event.every.Hit_Brand_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();
	
	JSONObject jSONObject = new JSONObject();
	
	JSONArray jSONArray = event_Lina_Proc.megaBanner();
	jSONObject.put("banner", jSONArray);
	
    JSONArray jSONArray2 = event_Lina_Proc.goodsList();	
	jSONObject.put("goods",jSONArray2);
	
	Hit_Brand_Proc hit_brand_proc = new Hit_Brand_Proc();
	
	JSONArray event_list = (JSONArray)hit_brand_proc.getHitBrandLIst().get("event_list");
	   
    jSONObject.put("hit",event_list);
    out.println(jSONObject.toString());
	
	
	/*
	JSONArray jSONArrayHit = new JSONArray(); 
	if(event_list.length() > 0){
	
	   for(int i = 0 ; i < event_list.length() ; i++){
            JSONObject jSONTmp = (JSONObject)event_list.get(i);
            String tab = jSONTmp.getString("tab");
            int ord = jSONTmp.getInt("ord");
            
            if("디지털".equals(tab) && ord == 1 ){
                jSONArrayHit.put(jSONTmp);
            }else if("가전".equals(tab) && ord == 1 ){
                jSONArrayHit.put(jSONTmp);
            }else if("컴퓨터".equals(tab) && ord == 1  ){
                jSONArrayHit.put(jSONTmp);
            }else if("라이프".equals(tab) &&  ord == 1 ){
                jSONArrayHit.put(jSONTmp);
            }
	   }
	}
	*/

%>