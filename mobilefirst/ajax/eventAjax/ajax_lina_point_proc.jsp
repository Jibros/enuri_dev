<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Event_Lina_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Event_Lina_Proc event_Lina_Proc = new Event_Lina_Proc();
	//String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	
	String seq = StringUtils.defaultString(request.getParameter("seq"));
	
	if(!"".equals(seq)){
	    int seqInt = Integer.parseInt(seq);
	    int result = event_Lina_Proc.linaProcPointCall(seqInt);
    
	    JSONObject jSONObject = new JSONObject();    
	    jSONObject.put("result",result);
	    out.println(jSONObject.toString());
	}
	
	
%>