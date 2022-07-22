<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*,java.text.*,com.enuri.util.common.*,com.enuri.util.http.*,com.enuri.util.date.*"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.notification.Mobile_Push_Proc"%>
<%
String sfashoinDiv = ConfigManager.RequestStr(request, "fashoinDiv", "");
String srtnUrl = ConfigManager.RequestStr(request, "rtnUrl", "");
String strFrom = ConfigManager.RequestStr(request, "from", "").trim();

session.removeAttribute("state");
session.removeAttribute("access_token");

cb.SetCookie("MEM_INFO", "USER_ID", "");
cb.SetCookie("MEM_INFO", "USER_NAME", "");
cb.SetCookie("MEM_INFO", "USER_NICK", "");
cb.SetCookie("MEM_INFO", "USER_GROUP", "");
cb.SetCookie("MEM_INFO", "USER_BROWSERNO", "");
cb.SetCookie("MEM_INFO", "USER_REGDATE", "");
cb.SetCookie("MEM_INFO", "LOGIN_RECONFIRM", "");
cb.SetCookie("MEM_INFO", "ADULT", "");
cb.SetCookie("MEM_INFO", "LOGIN_NICK", "");
cb.SetCookie("MEM_INFO", "SNSTYPE", "");
cb.SetCookieExpire("MEM_INFO",0);

//자동차 추가
cb.SetCookie("MEM_INFO_AUTO", "USER_ID", "");
cb.SetCookie("MEM_INFO_AUTO", "USER_NICK", "");
cb.SetCookieExpire("MEM_INFO_AUTO",0);

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

cb.responseAddCookie(response);

//자동로그인 설정상태 초기화
cb.SetCookie("MYINFO","AUTOLOGIN","");
cb.SetCookie("MYINFO","AUTOLOGINID","");
cb.SetCookieExpire("MYINFO", 3600*24*30);
cb.responseAddCookie(response);

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

/**********20201124 에누리 자동차 로그아웃**********/
{
	Cookie c = new Cookie("MEM_INFO_AUTO", "");
	c.setPath("/");
	c.setDomain(".enuri.com");
	response.addCookie(c);
}

{
	Cookie c = new Cookie("MEM_INFO", "");
	c.setPath("/");
	c.setDomain(".enuri.com");
	response.addCookie(c);
}
/**********20201124 에누리 자동차 로그아웃**********/
%>
