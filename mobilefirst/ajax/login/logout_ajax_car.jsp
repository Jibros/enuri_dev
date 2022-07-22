<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*,java.text.*,com.enuri.util.common.*,com.enuri.util.http.*,com.enuri.util.date.*"%>
<%@ include file="/include/Base_Inc_2010.jsp"%> 
<%@ page import="com.enuri.bean.notification.Mobile_Push_Proc"%>
<%
String sfashoinDiv = ConfigManager.RequestStr(request, "fashoinDiv", "");
String srtnUrl = ConfigManager.RequestStr(request, "rtnUrl", "");
String strFrom = ConfigManager.RequestStr(request, "from", "").trim();

if(strFrom.equals("car")) {
	String userid = cb.GetCookie("MEM_INFO","USER_ID");
	String device_id = ConfigManager.RequestStr(request, "device_id", "");
	// 로그아웃하면 푸쉬메세지를 받지 않음
	Mobile_Push_Proc mobile_push_proc = new Mobile_Push_Proc();
	mobile_push_proc.setAutoLoginPushYN(userid, device_id, "N");
}

cb.SetCookie("MEM_INFO", "USER_ID", "");
cb.SetCookie("MEM_INFO", "USER_NAME", "");
cb.SetCookie("MEM_INFO", "USER_NICK", "");
cb.SetCookie("MEM_INFO", "USER_GROUP", "");
cb.SetCookie("MEM_INFO", "USER_BROWSERNO", "");
cb.SetCookie("MEM_INFO", "USER_REGDATE", "");
cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "");
cb.SetCookie("MEM_INFO", "ADULT", "");
cb.SetCookie("MEM_INFO", "LOGIN_NICK", "");
cb.SetCookieExpire("MEM_INFO",0);

cb.setCookie_One("LSTATUS", "");
cb.SetCookieExpire("LSTATUS",0);

cb.SetCookie("SDU", "SHOP_ID", "");
cb.SetCookie("SDU", "SHOP_CODE", ""); 
cb.SetCookie("SDU", "SHOP_NAME", "");
cb.SetCookie("SDU", "SHOP_OPT", "");
cb.SetCookie("SDU", "SHOP_AUTH", "");
cb.SetCookie("SDU", "SHOP_GRADE", "");
cb.SetCookie("SDU", "SHOP_MAX_UNIT", "");
cb.SetCookie("SDU", "SHOP_COUPON", "");
cb.SetCookie("SDU", "ES_AGREEMENT_YN", "");
cb.SetCookie("SDU", "SHOP_NO","");
cb.SetCookieExpire("SDU",0);

cb.setCookie_One("AUTO", "");
cb.SetCookieExpire("AUTO",0);

cb.SetCookie("CAR","DEALERID", "");
cb.SetCookie("CAR","DEALERTYPE", "");	
cb.SetCookieExpire("CAR",0);

cb.responseAddCookie(response);

//자동로그인 설정상태 초기화
cb.SetCookie("MYINFO","AUTOLOGIN","");
cb.SetCookie("MYINFO","AUTOLOGINID","");
cb.SetCookieExpire("MYINFO", 3600*24*30);
cb.responseAddCookie(response);

if(strFrom.equals("car")) {
	cb.SetCookie("CAR","COUNSELINGLIST", "");
	cb.SetCookie("CAR","DEALERID", "");
	cb.SetCookie("CAR","DEALERTYPE", "");
	cb.SetCookie("CAR","COUNSELINGCOUNT", "");
	cb.SetCookieExpire("CAR",0);
	cb.SetCookie("CAR_LOGOUT","FLOGIN","1");
	cb.SetCookieExpire("CAR_LOGOUT", 3600*24*30);
 	cb.responseAddCookie(response);
}

// 로그아웃시 공통 도메인 아이디 저장 초기화
{
	Cookie c = new Cookie("DOMAIN_LOGIN_ID", "");
	c.setMaxAge(3600*24*30);
	c.setPath("/");
	c.setDomain(".enuri.com");
	response.addCookie(c);
}

// 로그아웃 플래그 세팅
{
	Cookie c = new Cookie("DOMAIN_LOGOUT_YN", "Y");
	c.setMaxAge(3600*24*30);
	c.setPath("/");
	c.setDomain(".enuri.com");
	response.addCookie(c);
}
%>