<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%
	String strType = ChkNull.chkStr(request.getParameter("type"),"");	
	
	if(strType.equals("mobile_movie_1607")){
		if(	ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0  ){
			response.sendRedirect("https://ref.ad-brix.com/v1/referrallink?ak=252353546&ck=8533332&sub_referral=5862847");
		}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 ){
			response.sendRedirect("http://itunes.apple.com/kr/app/enuriapp/id476264124?l=ko&ls=1&mt=8");
		}	
	}
%>    