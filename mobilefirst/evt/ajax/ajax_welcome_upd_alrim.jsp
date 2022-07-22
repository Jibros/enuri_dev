<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@ page import="com.enuri.bean.member.Join_Data"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc2"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%
    String userId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String userData  =  StringUtils.defaultString(request.getParameter("chkid"));

    int result = 0;
	Members_Friend_Proc2 members_Friend_Proc2 = new Members_Friend_Proc2();
	Mobile_Event_Proc eventProc = new Mobile_Event_Proc();
	JSONObject jSONObject = new JSONObject();
	if("".equals(userData)){
		userData = ChkNull.chkStr(cb.getCookie_One("chk_id"));
	}
	boolean bcertify= new Sns_Login().isSnsMemberCertify2(userId);
	if(!bcertify){
		jSONObject.put("result", -5);
		out.println(jSONObject.toString());
		return;
	}
	
	userId = userId.trim();	
		
	Join_Data Join_Data = new Join_Data();
	Join_Data = members_Friend_Proc2.getMemberData(userId);
	String conf_ci_key = Join_Data.getConf_ci_key();
	if(conf_ci_key.equals("")){
		jSONObject.put("result", -99);
		out.println(jSONObject.toString());
		return;
	}
	
	if("".equals(userData) ){
		JSONObject installUser = eventProc.getInstalllData(userId);
		
		if(installUser.has("user_data")){
			userData = installUser.getString("user_data");	
		}
	}
	result = eventProc.setAppAlrimYn(userId, userData);
	jSONObject.put("result",result); // 결과를 넣는다.
	out.println(jSONObject.toString());
%>