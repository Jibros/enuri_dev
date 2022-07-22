<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/m/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.mobile.Mobile_Plan_Event_Proc"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<%
	Mobile_Plan_Event_Proc mobile_Plan_Event_Proc = new Mobile_Plan_Event_Proc();

	JSONObject jSONObject = new JSONObject();
	jSONObject = mobile_Plan_Event_Proc.mobilePlanBannerJson();

	JSONArray  jSONArray  = (JSONArray)jSONObject.get("planList");

	JSONObject jSONObjectTemp = new JSONObject();
	JSONArray jSONArrayTemp = new JSONArray();

	long cTime = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
	String nowDate = dayTime.format(new Date(cTime));//진짜시간

	for(int i= 0 ; i < jSONArray.length(); i++){


	   JSONObject jSONtemp = (JSONObject)jSONArray.get(i);
	   String todayId = (String)jSONtemp.getString("TODAY_ID");
	   String todayType = (String)jSONtemp.getString("TODAY_TYPE");

	   String imgSrc = IMG_ENURI_COM+"/images/mobilefirst/planlist/"+todayType+"_"+todayId+"/"+todayType+"_"+todayId+"_main.png";

	   /*
	   URL url = new URL(imgSrc);
	   URLConnection con = url.openConnection();
	   HttpURLConnection exitCode = (HttpURLConnection)con;

       if(exitCode.getResponseCode() == 404){
        imgSrc = IMG_ENURI_COM+"/images/mobilefirst/planlist/"+todayType+"_"+todayId+"/"+todayType+"_"+todayId+"_main.jpg";
       }
       */

       String goUrl = "http://m.enuri.com/mobilefirst/planlist.jsp?t=B_"+todayId;

	   jSONtemp.put("IMGSRC",imgSrc);
	   jSONtemp.put("URL",goUrl);

	   jSONArrayTemp.put(jSONtemp);

	}
	jSONObjectTemp.putOpt("planList",jSONArrayTemp);
	out.println(jSONObjectTemp.toString());
%>