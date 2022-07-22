<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Event_Proc"%>
<%@page import="com.enuri.bean.mobile.Event_Friend_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	JSONObject jSONObject = new JSONObject();
	
	Mobile_Event_Proc mobile_Event_Proc = new Mobile_Event_Proc();
			 
	String userId  =  ChkNull.chkStr(cb.GetCookie("MEM_INFO","USER_ID"),"");
	String userData =ChkNull.chkStr(request.getParameter("chkId"),"");
    JSONObject jsonToken = new JSONObject(); 
	//jsonToken = mobile_Event_Proc.getTokenData(userId); //userId, user_data, version_first
    jsonToken = mobile_Event_Proc.getInstalllData(userId); //userId, user_data, version_first
	
	if(jsonToken.length() == 0){
		jsonToken.put("version_first","0");
	}
    else{
			String ver = StringUtils.replace(StringUtils.defaultString((String)jsonToken.get("version_first"),"0"),".","");
			if(ver.length() >= 5){
				ver = StringUtils.substring(ver,0,3);
			}
			int version_first = Integer.parseInt(ver) ;
			jsonToken.put("version_first",version_first);  	
	}
    
	JSONArray jsonPointDate = new JSONArray();
	jsonPointDate = mobile_Event_Proc.getConvertShoppingData(userId); //1차체결날짜, 2차체결날짜
	String cart_status = mobile_Event_Proc.getCartStatus(userId); //cart_status

	String point_date1 = StringUtils.defaultString((String)jsonPointDate.get(0),"0");
	String point_date2 = StringUtils.defaultString((String)jsonPointDate.get(1),"0");
    	
	Event_Friend_Proc event_Friend_Proc = new Event_Friend_Proc();
    
    int isFriend = mobile_Event_Proc.isFriend(userId); //친구초대코드 존재여부
	int cartRealPrice = event_Friend_Proc.getCartRealPrice(userId); //실제구매금액
    
    jsonToken.put("min_date_01",point_date1);
	jsonToken.put("min_date_04",point_date2);
    jsonToken.put("isFriend", isFriend);
    jsonToken.put("cartRealPrice",cartRealPrice);
    jsonToken.put("cart_status",cart_status);
  
	out.println(jsonToken.toString());
%>