<%@page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.event.Event_Luckytime"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.*"%>
<jsp:useBean id="CrazyDeal_Proc" class="com.enuri.bean.main.deal.CrazyDeal_Proc" scope="page" />
<%

	//String strEventid = ChkNull.chkStr(request.getParameter("eventNo"));
	//int intItem_id = ChkNull.chkInt(request.getParameter("item_id"),1);
	//JSONObject jSONObject = new JSONObject();
	//Event_Luckytime event_proc = new Event_Luckytime(); 
	//jSONObject = event_proc.get_Dealtimeitem(strEventid,intItem_id);
	
	int intSeq = ChkNull.chkInt(request.getParameter("seq"),0);
	if(intSeq  == 0)		return ;
		
	String devYN = "N";
	if( request.getServerName().indexOf("dev.enuri.com") > -1 || request.getServerName().indexOf("my.enuri.com") > -1  ){
		devYN = "Y";
	}
	String strEnuriId =  ChkNull.chkStr(StringUtils.trim(cb.GetCookie("MEM_INFO","USER_ID")));
	
	Edeal_Order_Proc edeal_order_proc = new Edeal_Order_Proc();
	boolean IsEnuriEmployee = false;
	
	if(strEnuriId.length()>0) {
		IsEnuriEmployee = edeal_order_proc.isEnuriEmployee(strEnuriId);
	}

	JSONObject jSONObject = new JSONObject();
	
	if(IsEnuriEmployee){//
		jSONObject.put("result",99);
		out.println(jSONObject.toString());
		return;
	}
	
	Event_Luckytime event_Luckytime = new Event_Luckytime();
	jSONObject = event_Luckytime.getCrazyDealUrlSoldOutFlag(intSeq, devYN );
	
	if(jSONObject.length() == 0 ){
		
		jSONObject.put("result","E"); //없다
		out.println(jSONObject.toString());
		return;
	}
	
	int  GOODS_URL_TYPE =   jSONObject.getInt("GOODS_URL_TYPE");
	int  GOODS_QUANTITY =   ChkNull.chkInt(jSONObject.getString("GOODS_QUANTITY"));
	String  EVENT_SOLDOUT_YN =   jSONObject.getString("EVENT_SOLDOUT_YN");
	int  GOODS_PRICE =   ChkNull.chkInt(jSONObject.getString("GOODS_PRICE")); //point
	int per_cnt = 1;
	int item_id = 1; //회차
	
	String EVENT_NO =   StringUtils.defaultString(jSONObject.getString("EVENT_NO")); //
	
	String strOsType = "";
	
	if(EVENT_SOLDOUT_YN.equals("Y")){
		jSONObject.put("result", 0); //품절입니다.
		out.println(jSONObject.toString());
		return;
	}
	
	if(!"".equals(EVENT_NO) &&  GOODS_URL_TYPE ==  3 ){ //딜타임 이벤트
		
		if((ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Linux") >= 0 )){
			strOsType = "MWA"; // WEB
		}else if(
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0) ||
				(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 && ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Mac") >= 0)){
			strOsType = "MWI"; // WEB
		}else{
			strOsType = "PC";
		}
		
		//result = 2 중복 , 1 성공 , 0 리미트 카운트
		int result = 99;
		if(!strEnuriId.equals("") && !EVENT_NO.equals("")){
			result = event_Luckytime.dealtimeUserIns(strEnuriId, 1, strOsType, EVENT_NO, GOODS_QUANTITY, GOODS_PRICE, per_cnt);
			
			if(result == 0){
				boolean vReturn = false;
				CrazyDeal_Proc crazyDeal_Proc = new CrazyDeal_Proc();
				if(intSeq > 0)		vReturn = event_Luckytime.upd_CrazyDeal_time_soldout(intSeq,devYN);
				//if(vReturn)		urlGo("http://100.100.100.80:8080/mobilefirst/api/crazy_deal_ctu_send.jsp?devYN="+devYN);
				if(vReturn)		urlGo("http://27.122.133.180:8080/mobilefirst/api/crazy_deal_ctu_send.jsp?devYN="+devYN);
			}
		}
		if(strEnuriId.equals("")){
			result = 4; // 유저아이디 없음 쿠키 
		}
		jSONObject.put("result", result);
	}
	out.println(jSONObject.toString());
%>
<%!
public void urlGo(String strUrl) {
	
	try {
		BufferedReader br = new BufferedReader(new InputStreamReader((new URL(strUrl)).openConnection().getInputStream(),"UTF-8"));
		StringBuilder sbJson = new StringBuilder();
		String strLine = "";
		while ((strLine = br.readLine()) != null)	sbJson.append(strLine);
		br.close();
	} catch (Exception e) {
		System.out.println("********* error ************:"+e);
	}
}

