<%@page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%> 
<%

	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
	
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"));
	String M_Ip = getClientIpAddr(request);
	
	String strEventid = ChkNull.chkStr(request.getParameter("eventid"),"");
	String type = ChkNull.chkStr(request.getParameter("type"),"");
    String osType=ChkNull.chkStr(request.getParameter("osType"),"");// 참여채널 추가
    String kind=ChkNull.chkStr(request.getParameter("kind"),"N");// 참여채널 추가
    
	JSONObject jSONObject = new JSONObject(); 
	
	int iPayBackYn = 0;
	
	iPayBackYn = mobile_Event_Proc.getAllPayBack(userId);
	
	if(!strEventid.equals("")){ 
		iPayBackYn = mobile_Event_Proc.getAllPayBack2(userId, strEventid);
	}
	
	if("Y".equals(kind)){
		jSONObject.put("payYN", iPayBackYn);
		out.println(jSONObject.toString());
		return;
	}
	
	//sdu 회원이 인증이 안되어 있다면 true
	//이벤트 참여 불가 
	//노병원 2018/10/11
	Members_Proc mp = new Members_Proc();
	if(mp.SduCerify(userId)){
		jSONObject.put("result", -4);
		out.println(jSONObject.toString());
		return;
	}
	
	
	if(userId.length() > 0){
		if(type.equals("1")){
			if(iPayBackYn > 0){   
				out.println(jSONObject.put("result", "chk1"));
			}else{ 
				if(!strEventid.equals("")){
					//jSONObject = mobile_Event_Proc.insertAllPayBack2(userId, M_Ip, strEventid);
					jSONObject = mobile_Event_Proc.insertAllPayBack3(userId, M_Ip, strEventid,osType);// 참여채널 추가
				}else{
					jSONObject = mobile_Event_Proc.insertAllPayBack(userId, M_Ip);
				} 
				jSONObject.put("result",jSONObject.get("result"));
				out.println(jSONObject.toString()); 
			} 
		}else if(type.equals("2")){
			if(iPayBackYn > 0){   
				out.println(jSONObject.put("result", "ok"));
			}else{
				out.println(jSONObject.put("result", "chk1"));
			}
		}
		
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