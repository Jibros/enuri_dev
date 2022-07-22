<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.member.Sns_Login"%>
<%
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();

	String userId    = ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String strSnsDcd = ChkNull.chkStr(cb.GetCookie("MEM_INFO","SNSTYPE"));
	String M_Ip = getClientIpAddr(request);

	String eventCode = ChkNull.chkStr(request.getParameter("eventCode"),"");
	String osType = ChkNull.chkStr(request.getParameter("osType"),"PC");
	String kind=ChkNull.chkStr(request.getParameter("kind"),"N");// 참여채널 추가

	JSONObject jSONObject = new JSONObject();
    int iPayBackYn = 0;

	if(userId.equals("")) {
		return;
	}

	if(userId.length() > 0){
		if("Y".equals(kind)){ // 0 : 참여가능, 1:아이디참여 중복, 2:본인인증 중복, -4:sdu 회원 미인증, -5:회원 미인증 
			//sdu 회원이 인증이 안되어 있다면 true
			//이벤트 참여 불가
			//노병원 2018/10/11
			Members_Proc mp = new Members_Proc();
			if(mp.SduCerify(userId)){
				jSONObject.put("payYN", -4);
				out.println(jSONObject.toString());
				return;
			}
			//본인인증 여부 확인
			boolean bcertify = new Sns_Login().isSnsMemberCertify(userId);
			if(!bcertify){
				jSONObject.put("payYN", -5);
				out.println(jSONObject.toString());
				return;
			}
			
			int iCntId = 0;
			int iCntCi = 0;

			if(!eventCode.equals(""))	iCntId = mobile_Event_Proc.getAllPayBack2(userId, eventCode); // 아이디 참여 확인
			else						iCntId = mobile_Event_Proc.getAllPayBack(userId);

			iCntCi = mobile_Event_Proc.getAllPayBack3(userId, eventCode); // 본인인증 중복참여 확인

			if(iCntId > 0){
				iPayBackYn = 1;
			}else if(iCntCi > 0){
				iPayBackYn = 2;
			}

			jSONObject.put("payYN", iPayBackYn);
			out.println(jSONObject.toString());
			return;
		}

		if(!eventCode.equals("")){
			jSONObject = mobile_Event_Proc.insertAllPayBack3(userId, M_Ip, eventCode, osType);
		}else{
			jSONObject = mobile_Event_Proc.insertAllPayBack(userId, M_Ip);
		}
		jSONObject.put("result",jSONObject.get("result"));
		out.println(jSONObject.toString());
	}

%>
<%!
public static String getClientIpAddr(HttpServletRequest request) {
	String ip = request.getHeader("X-Forwarded-For");

	if(ip != null && ip.indexOf(",")>-1) {
		ip = ip.split(",")[0];
	}

	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	else if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	else if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_CLIENT_IP");
	}
	else if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	}
	else if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	return ip;
}
%>