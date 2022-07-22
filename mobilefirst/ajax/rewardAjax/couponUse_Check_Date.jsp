<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.*"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page import="javax.net.ssl.HttpsURLConnection"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="Reward_Proc" scope="page" />
<%
//날짜구분으로 쿠폰 사용 체크 
//part = B :before(금일만료쿠폰리스트), A:after(작일만료쿠폰리스트)
String strPart = ChkNull.chkStr(request.getParameter("part"));
String strCoupon_id = "";	//선택한 쿠폰시퀀스 (A11,A22,A33)
String strCoupon_number = "";	//선택한 쿠폰번호 (A11,A22,A33)
String strDate = "";

Reward_Proc reward_proc = new Reward_Proc(); 

JSONObject jSONObject = new JSONObject();
JSONObject jSONObjectTemp = new JSONObject();
JSONArray jSONArrayTemp = new JSONArray();

Date today = new Date();
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

if(strPart.equals("1")){
	strDate = transFormat.format(today);

	jSONObject = reward_proc.get_EdateList(strDate);

}else if(strPart.equals("2")){
	cal.add(Calendar.DATE, +1);
	strDate = transFormat.format(cal.getTime());  
	
	jSONObject = reward_proc.get_EdateList(strDate);
}else if(strPart.equals("0")){
	cal.add(Calendar.DATE, -1);
	strDate = transFormat.format(cal.getTime());  
	
	jSONObject = reward_proc.get_EdateList(strDate);
}

String strTmp_Coupon_id = "";
String strTmp_Coupon_number = "";
String strTmp_Coupon_edate = "";
String strTmp_Gift_code = "";
String strUrl = "";
int intCnt = 0;

if(jSONObject != null){
	JSONArray  jSONArray  = (JSONArray)jSONObject.get("couponList");
	
	if(jSONArray.length() > 0){
		
		for(int i = 0; i < jSONArray.length(); i++){
			
			JSONObject jSONtemp = (JSONObject)jSONArray.get(i);
			   
			strTmp_Coupon_id = (String)jSONtemp.getString("coupon_id");
			strTmp_Coupon_number = (String)jSONtemp.getString("coupon_number");
			strTmp_Coupon_edate = (String)jSONtemp.getString("coupon_edate");
			strTmp_Gift_code = (String)jSONtemp.getString("gift_code");
			
			//out.println("strTmp_Coupon_id>>>>"+strTmp_Coupon_id);
			//out.println("strTmp_Coupon_number>>>>"+strTmp_Coupon_number);
			//out.println("============================================<br>");
			//out.println("strTmp_Coupon_edate>>>>"+strTmp_Coupon_edate+"<br>");
	
			//XML 데이터를 호출할 URL
			strUrl = "http://100.100.100.80:3303/ServiceCouponStateInfo";
			strUrl += "?COUPONCODE="+ strTmp_Gift_code +"&COUPONNUM="+strTmp_Coupon_number;
			//String strUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponCreate?CODE=0413&PASS=enuri0413&COUPONCODE=00EB036J00001&SEQNUMBER=3234567890";
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(strUrl);
			
			NodeList nodeResultcode   = document.getElementsByTagName("RESULTCODE");
			NodeList nodeResultmsg 	= document.getElementsByTagName("RESULTMSG");
			NodeList nodeUse_yn	    = document.getElementsByTagName("USE_YN");
			NodeList nodeUse_date    	= document.getElementsByTagName("USE_DATE");
			
			String strResultcode    = nodeResultcode.item(0).getFirstChild().getNodeValue();
			String strResultmsg   = nodeResultmsg.item(0).getFirstChild().getNodeValue();
			String strUse_yn    = nodeUse_yn.item(0).getFirstChild().getNodeValue();
			String strUse_date    = "";
			if(nodeUse_date.item(0).getFirstChild() != null){
				strUse_date    =   nodeUse_date.item(0).getFirstChild().getNodeValue();
			}
			
			//out.println("strResultcode>>>"+strResultcode+"<br>");
			//out.println("strResultmsg>>>"+strResultmsg+"<br>");
			//out.println("strUse_yn>>>"+strUse_yn+"<br>");
			//out.println("strUse_date>>>"+strUse_date+"<br>");
			
			if(strResultcode.equals("00") && strUse_yn.equals("Y")){
				//DB업데이트.
				int intCoupon_Use_Update = Reward_Proc.update_Gift_Coupon_Use("1", strUse_date, strTmp_Coupon_number);
				intCnt++;
			}
		}
		
	}
}
%>
{"result" : <%=intCnt %>}