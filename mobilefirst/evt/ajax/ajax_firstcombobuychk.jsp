<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%
    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID").trim());
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));
	String referer = ChkNull.chkStr(request.getHeader("referer"));
	
	//userId = "omom35";
	//userData = "abdcbcca913c8d30";
	//System.out.println("referer:"+referer.indexOf("enuri.com"));
	//System.out.println("userData:"+userData);
	
	//userData = "bbdcbcca913c8d30";
	
    JSONObject jSONObject = new JSONObject();
    int resultType = 0; //유형체크
    
	//sns 인증회원 확인
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
	if(!bcertify){
		jSONObject.put("result", -66);
		out.println(jSONObject.toString());
		return;
	}
    
	try{
		if(!"".equals(userId) && !"".equals(userData) && referer.indexOf("enuri.com") > -1){
			Mobile_Event_Proc mobile_event_proc = new Mobile_Event_Proc();
			resultType = mobile_event_proc.firstComboChk(userId, userData);
			
			//System.out.println("resultType : "+resultType);
	        //if(resultType==5){//즉시 적립 없어짐
	        	//mobile_event_proc.firstComboDirectEmoney(userId);
	        //}
	    }
	}catch(Exception e){
		System.out.println("e:"+e);
	}
	
	jSONObject.put("result",resultType); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>