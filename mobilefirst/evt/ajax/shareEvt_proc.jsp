<%@page import="com.enuri.bean.event.DBWrap"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/include/Base_Inc_2010.jsp"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.enuri.util.common.ChkNull"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_ShareEvt_Proc"%>
<%@page import="org.json.*"%>
<%

String cUserId = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID")).trim(); 		//	참여 ID
String osType = ChkNull.chkStr(request.getParameter("osType"), "PC").trim(); 	// 	참여 os type

String shareType = ChkNull.chkStr(request.getParameter("shareType"),"");
String eventId = ChkNull.chkStr(request.getParameter("eventId"),"20190902");
String osCode = "1";

if( "".equals(cUserId)  ) return ;


if(osType.indexOf("PC") > -1) 	osCode = "1";
else if(osType.indexOf("MW") > -1) 	osCode = "2";
else if(osType.indexOf("MA") > -1) 	osCode = "3";

StringBuilder strQuery = new StringBuilder();

strQuery.append("	insert into TB_EVNT_SHARE_PTCP ( enr_usr_id, SHARE_TP_CD, OS_TP_CD, INS_DTM, evnt_cd ) ");	
strQuery.append("   values(?, ?, ?, getdate() , ? )    ");

JSONObject jSONObject = new JSONObject();

jSONObject.put("result", new DBWrap("member").setQuery(strQuery.toString()).addParameter(cUserId).addParameter(shareType).addParameter(osCode).addParameter(eventId).CUDTry());
out.println(jSONObject.toString());	

%>