<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	String strWhere = "";  
	String strCart_seq = ChkNull.chkStr(request.getParameter("cart_seq"),"");
	String[] arrCart_seq = strCart_seq.split(",");
	int intCart_seq = 0;
	boolean bl_return = false;
	
	
	for(int i=0;i<arrCart_seq.length;i++){
		intCart_seq = Integer.parseInt(arrCart_seq[i]);
		if(intCart_seq > 0 && strUserid != null && !strUserid.equals("")){
			Emoney_Proc emoney_proc = new Emoney_Proc();  
			bl_return = emoney_proc.getPoint_act(intCart_seq, strUserid); 
		} 
	}
	
	
	//System.out.println("bl_return>>>>"+bl_return);
	
	out.println(bl_return);
%> 