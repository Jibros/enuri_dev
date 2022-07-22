<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="com.enuri.bean.mobile.Social_Coupon_Home"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<% 
    String type=StringUtils.defaultString(request.getParameter("type"));
	//System.out.println("strSearch_query==="+strSearch_query);
	Social_Coupon_Home social_Coupon_Home = new Social_Coupon_Home();
  
    JSONObject jSONObject = new JSONObject();
    if(type.equals("dev")){
    	jSONObject = social_Coupon_Home.homeItemList_dev();     

    }else if(type.equals("real")){
    	jSONObject = social_Coupon_Home.homeItemList();     
    }
	out.println(jSONObject);
%>
