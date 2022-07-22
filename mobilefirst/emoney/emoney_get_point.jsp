<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@ page import="org.json.*"%>
<%@ page import="com.enuri.util.http.*"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.util.common.ChkNull"%>
<%
	//String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
	String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

	String os = ChkNull.chkStr(request.getParameter("os"),"");
    if(os!=null && os.equals("and") ){
//	if((strUserid == null || strUserid.equals(""))  && os!=null && (os.equals("and")|| os.equals("ios")) ){
		String id = ChkNull.chkStr(request.getParameter("id"),"");
	  	if(id.length()>2){
			Seed_Proc seed_proc = new Seed_Proc();
			strUserid = seed_proc.DePass_Seed(id);
		}
	}	

	JSONArray jSONArray = new JSONArray(); 
	
	Emoney_Proc emoney_proc = new Emoney_Proc(); 
	//try{
		JSONObject jSONPoint = emoney_proc.get_Point_ver2(strUserid);
		
		//값에 ".0" 있으면 없에고 return;
		String sPOINT_REMAIN = (String)jSONPoint.get("POINT_REMAIN");

		if(sPOINT_REMAIN.equals("")){
			sPOINT_REMAIN = "0";
		}
		JSONObject jSONData = new JSONObject(); 
		
		jSONData.put("POINT_REMAIN", sPOINT_REMAIN);
		jSONData.put("USERID",strUserid);
		jSONData.put("POINT_UNIT","점");
		
		out.println(jSONData.toString());
	//} catch (Exception e) {}
%>
