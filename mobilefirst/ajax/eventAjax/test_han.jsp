<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Friend_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="com.enuri.bean.event.Members_Friend_Proc"%>
<jsp:useBean id="Members_Friend_Proc" class="com.enuri.bean.event.Members_Friend_Proc" scope="page" />
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	userId  =  "en710";  
	String userData =ChkNull.chkStr(request.getParameter("chkId"),""); 
	//userData ="4F0B7F11-FC65-4B8D-9A0E-8304EB1CED0B";
	JSONObject jsonToken = new JSONObject(); 
	jsonToken = mobile_Event_Proc.getInstalllData(userId);
	
	if(jsonToken.length() == 0){
		jsonToken.put("version_first","0");
		jsonToken.put("version_first_date","0");
	}else{
	
			String ver = StringUtils.replace(StringUtils.defaultString((String)jsonToken.get("version_first"),"0"),".","");
			if(ver.length() >= 5){
				ver = StringUtils.substring(ver,0,3);
			}
			int version_first = Integer.parseInt(ver) ;
			jsonToken.put("version_first",version_first);
		
	}
	
	JSONArray jsonPointDate = new JSONArray();
	jsonPointDate = mobile_Event_Proc.getShoppingData(userId);
	
	String point_date1 = StringUtils.defaultString((String)jsonPointDate.get(0),"0");
	String point_date2 = StringUtils.defaultString((String)jsonPointDate.get(1),"0");

	jsonToken.put("min_date_01",point_date1);
	jsonToken.put("min_date_04",point_date2);
	
	
	JSONArray jsonRecDate = new JSONArray();
	jsonRecDate = Members_Friend_Proc.getRecDate(userId);
	
	String rec_date = StringUtils.defaultString((String)jsonRecDate.get(0),"0");

	jsonToken.put("rec_date", rec_date);
	
	
	int firstYN = mobile_Event_Proc.getFirstUserData(userId);
	
	jsonToken.put("firstYN",firstYN);
	
	Event_Friend_Proc event_Friend_Proc = new Event_Friend_Proc();
    boolean nomieeYN = event_Friend_Proc.getNomieeUserYN(userId);
	jsonToken.put("nomieeYN",nomieeYN);
	
	int cartRealPrice = event_Friend_Proc.getCartRealPrice(userId);
	
	jsonToken.put("cartRealPrice",cartRealPrice);
	
	String cartChk = Members_Friend_Proc.cartChk(userId);
	jsonToken.put("cartChk", cartChk);
	
	JSONArray jsonPointIns = new JSONArray();
	jsonPointIns = Members_Friend_Proc.getPointIns(userId);
	
	String cart_status = StringUtils.defaultString((String)jsonPointIns.get(0),"0");
	String point_seq = StringUtils.defaultString((String)jsonPointIns.get(1),"0");
	String diff_day = StringUtils.defaultString((String)jsonPointIns.get(2),"0");
	
	jsonToken.put("cart_status", cart_status);
	jsonToken.put("point_seq", point_seq); 
	jsonToken.put("diff_day", diff_day);
		 
		
	/*if(cartChk.equals("04")){ 
		if(userId.trim().length() > 0) {
			boolean pointInsertNow = Members_Friend_Proc.pointInsertNow(userId);
		}	
	}*/
	
	
	String FirstBuyEventId = Members_Friend_Proc.FirstBuyEventId(userId);
	jsonToken.put("firstbuyeventid", FirstBuyEventId);
	
	out.println(jsonToken.toString());
%>