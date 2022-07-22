<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.net.ssl.HttpsURLConnection"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc" scope="page" />
<%
//쿠폰 취소.(환불)
String strCoupon_id = ChkNull.chkStr(request.getParameter("coupon_id"));					
String strCoupon_number = ChkNull.chkStr(request.getParameter("coupon_number"));

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

boolean blReturn = false;

String strResultcode = "";
String strResultmsg = "";

//System.out.println("strCoupon_id>>>"+strCoupon_id);
//System.out.println("strCoupon_number>>>"+strCoupon_number);


//if(strUserid != null && !strUserid.equals("") && referer.indexOf("/mobilefirst/reward/reward_store.jsp") > -1){
if(strUserid != null && !strUserid.equals("")){	
	//String strUrl = "http://100.100.100.80:3303/ServiceCancelSeq";
	//node.js 에서 jsp로 변경. 2018-10-11. shwoo.
	String strUrl = "http://100.100.100.80:8080/mobilefirst/api/ServiceCancelSeq.jsp";
	strUrl += "?COUPONCODE="+ strCoupon_number +"&SEQNUMBER="+strCoupon_id;
	//String strUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponCreate?CODE=0413&PASS=enuri0413&COUPONCODE=00EB036J00001&SEQNUMBER=3234567890";
	
	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = factory.newDocumentBuilder();
	Document document = builder.parse(strUrl);
	
	NodeList nodeResultcode    = document.getElementsByTagName("RESULTCODE");
	NodeList nodeResultmsg    = document.getElementsByTagName("RESULTMSG");
	
	strResultcode    = nodeResultcode.item(0).getFirstChild().getNodeValue();
	strResultmsg   = nodeResultmsg.item(0).getFirstChild().getNodeValue();
	
	//System.out.println("strResultcode>>>"+strResultcode);
	//System.out.println("strResultmsg>>>"+strResultmsg);
	
	if(strResultcode.equals("00")){
		//DB업데이트.
		int intRefund_Update = Reward_Proc.update_Refund_Coupon(strUserid, Integer.parseInt(strCoupon_id));
		
		if(intRefund_Update > 0){
			//정상입력
			blReturn = true;
		}
	}
}
%><%=blReturn %>