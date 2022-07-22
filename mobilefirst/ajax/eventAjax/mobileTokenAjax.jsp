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
	//String userId="orangex";  
    //userId  =  "qwer9201";
	String userData =ChkNull.chkStr(request.getParameter("chkId"),"");
	//userData ="BF597E88-A836-4665-B23F-C1597851E577";
    //String userData="c7e836450927fa75";
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
	//jsonToken.put("min_date_01","211");
	//jsonToken.put("min_date_04","211");
	int firstYN = mobile_Event_Proc.getFirstUserData(userId);
	jsonToken.put("firstYN",firstYN);
	//jsonToken.put("firstYN",1);
  
	Event_Friend_Proc event_Friend_Proc = new Event_Friend_Proc();

    int isFriend = mobile_Event_Proc.isFriend(userId);
    jsonToken.put("isFriend", isFriend);
    //jsonToken.put("isFriend", 1);

    int buyPointCount = mobile_Event_Proc.buyPointCount(userId);
    jsonToken.put("buyPointCount",buyPointCount);
    //jsonToken.put("buyPointCount",2);
   
	int cartRealPrice = event_Friend_Proc.getCartRealPrice(userId);
	jsonToken.put("cartRealPrice",cartRealPrice);
    
    String cart_status = mobile_Event_Proc.getCartStatus(userId);
    jsonToken.put("cart_status",cart_status);
	//jsonToken.put("cartRealPrice",30000);
  
	out.println(jsonToken.toString());
%>