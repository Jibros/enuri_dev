<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="com.enuri.bean.log.Log_family_Proc"%>
<%
	// getParameter 
	String 	gubun 		= ChkNull.chkStr(request.getParameter("gubun"), "").trim();			//1: first insert, 2:lucky bag insert ......
	String 	ch_code 	= ChkNull.chkStr(request.getParameter("ch_code"), "").trim();
	String 	chk_id 		= ChkNull.chkStr(request.getParameter("chk_id"), "").trim();
	String 	url		 	= ChkNull.chkStr(request.getParameter("url"), "").trim();
	int 	shop_code 	= ChkNull.chkInt(request.getParameter("shop_code"), 0);
	long 	pl_no 		= ChkNull.chkLong(request.getParameter("pl_no"), 0);
	
	int intResultValue = 0;
	
	Log_family_Proc log_family_proc = new Log_family_Proc(); 
	
	if(gubun.equals("pageview")){
		try{
			intResultValue = log_family_proc.Insert_Pageview(ch_code, chk_id, url);
		}catch(Exception ex){}
	}else if(gubun.equals("clickout")){
		try{
			intResultValue = log_family_proc.Insert_Clickout(ch_code, chk_id, shop_code, pl_no);
		}catch(Exception ex){}
	}
%>{"result" : "<%=intResultValue %>" }


