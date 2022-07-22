<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Hit_Brand_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.json.*"%>
<%
	Hit_Brand_Proc hit_Brand_Proc = new Hit_Brand_Proc();
	
	//JSONArray jSONArray1 =  hit_Brand_Proc.getHitGoodsList();
	
	ArrayList<String> al = new ArrayList<String>(); 
	al.add("14917796");
	al.add("13768079");
	al.add("12289114");
	al.add("12401373");
	al.add("13005411");
	al.add("12904511");
	al.add("12373504");
	al.add("14804130");
	al.add("13260749");
	al.add("13200453");
	
	JSONArray jSONArray2 =  hit_Brand_Proc.getHitBrandList(al);
	
	JSONArray jSONArray3 =  new JSONArray (); 
	
	for(int i=0 ; i < al.size();i++){
	
	   String modelno = al.get(i);
	   
	   for(int j=0; j < jSONArray2.length() ; j++){
	       
	       JSONObject jSONObject2  = (JSONObject)jSONArray2.get(j);
           String modelno2 = (String)jSONObject2.get("modelno");
	       
	       if(modelno.equals(modelno2) ){
	           jSONArray3.put(jSONObject2);
	           continue;
	       }
	   }
	}
	
	
    out.println(jSONArray3.toString());

%>

