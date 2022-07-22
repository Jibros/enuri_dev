<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	// procType:1 -> IsAutoLogin
	// procType:2 -> 오토로그인 시작
	// procType:3 -> 오토로그인 해제
	int procType = Integer.parseInt(ChkNull.chkStr(request.getParameter("procType"), "0"));

	if(procType==1) {
		String autologin = cb.GetCookie("MYINFO","AUTOLOGIN");
		String autologinId = cb.GetCookie("MYINFO","AUTOLOGINID");
		out.println("{");
		if(autologin.equals("Y") && autologinId.length()>4) {
			out.println("\"IsAutoLogin\":\"true\"");
		} else {
			out.println("\"IsAutoLogin\":\"false\"");
		}
		out.println("}");
	}

	if(procType==2) {
		String strID = cb.GetCookie("MEM_INFO","USER_ID");

		if(strID.length()>4) {
			cb.SetCookie("MYINFO","AUTOLOGIN","Y");
			cb.SetCookie("MYINFO","AUTOLOGINID",strID);
		}
	}

	if(procType==3) {
		cb.SetCookie("MYINFO","AUTOLOGIN","");
		cb.SetCookie("MYINFO","AUTOLOGINID","");
	}
%>