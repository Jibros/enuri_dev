<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	//String userId  =  "doanithing";
	
	if(userId.equals("")){
		jSONObject.put("result","E"); // 유저 아이디 없습니다. 로그인 하세요
	}else{
	
		JSONObject jsonToken = new JSONObject(); 
		jsonToken = mobile_Event_Proc.getInstalllData(userId);
		
		if(jsonToken.length() == 0){
			jsonToken.put("version_first","0");
			jsonToken.put("version_first_date","0");
		}
		
		String app_ver =  StringUtils.defaultString((String)jsonToken.get("version_first"),"0");
		String version_first_date =  StringUtils.defaultString((String)jsonToken.get("version_first_date"),"0");  
		String ver = StringUtils.replace(app_ver,".","");
			//String ver = "30000";
		
			if(ver.length() >= 5){
				ver = StringUtils.substring(ver,0,3);
			}
						
		int version_first = Integer.parseInt(ver) ;
		
		version_first_date = StringUtils.substring(version_first_date,0,10);
		version_first_date = StringUtils.replace(version_first_date,"-","");
		
		int int_version_first_date = Integer.parseInt(version_first_date) ;
		
		if(int_version_first_date >= 20160215 ){
			jSONObject.put("result","Y"); // 신규유저
		}else{
			jSONObject.put("result","N"); // 신규유저
		}
	
	}
	
	out.println(jSONObject.toString());
%>