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
//아이디check, referer 체크
//
//1. 라면 쿠폰 클릭 하면 upd_reward_point_use 콜해서 seq번호 받아옴.
//2. 받아온 쿠폰seq번호로 api 호출
//3. 호출후 넘어온 xml파싱
//4. 파싱 후 원하는 데이터 다시 저장.
String strGift_code = ChkNull.chkStr(request.getParameter("gift_code"));	//선택한 상품의 code (111,222,333)
String strCoupon_number = ChkNull.chkStr(request.getParameter("coupon_number"));	//선택한 쿠폰번호 (A11,A22,A33)
String strNouse = ChkNull.chkStr(request.getParameter("nouse"));	//nouse = 1 이면 사용완료를 미사용으로 변경

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

if(strUserid != null && !strUserid.equals("")){	
	
	String[] arrGift_code = strGift_code.split(",");
	String[] arrCoupon_number = strCoupon_number.split(",");
	
	if(arrGift_code != null && arrGift_code.length > 0){
		
		for(int i = 0; i < arrGift_code.length; i++){

			try {
			
				//XML 데이터를 호출할 URL
				//String strUrl = "http://100.100.100.80:3303/ServiceCouponStateInfo";
				//node.js 에서 jsp로 변경. 2018-10-11. shwoo.
				String strUrl = "http://100.100.100.80:8080/mobilefirst/api/ServiceCouponStateInfo.jsp";
				strUrl += "?COUPONCODE="+ arrGift_code[i] +"&COUPONNUM="+arrCoupon_number[i];
				//String strUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponCreate?CODE=0413&PASS=enuri0413&COUPONCODE=00EB036J00001&SEQNUMBER=3234567890";
				
				//System.out.println("strUrl>>>>>>>"+strUrl);
				
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
				//out.println("strCouponnumber>>>"+strCouponnumber+"<br>");
				//out.println("strPinnumber>>>"+strPinnumber+"<br>"+"<br>");
				
				//미사용 데이터만 업데이트
				if(strUse_yn.equals("Y")  && !strNouse.equals("1")){
					//DB업데이트.
					int intCoupon_Use_Update = Reward_Proc.update_Gift_Coupon_Use("1", strUse_date, arrCoupon_number[i]);
				}
	
				//취소건만 업데이트
				if(strUse_yn.equals("C") && strNouse.equals("1")){	//사용완료 리스트에서 리플레시를 클릭했을때만 업데이트 처리됨.
					//DB업데이트.
					//System.out.println("arrCoupon_number[i]>>>>>"+arrCoupon_number[i]);
					int intCoupon_Use_Update = Reward_Proc.update_Gift_Coupon_Use("0", "", arrCoupon_number[i]);
				}
				
			} catch (Exception e){
				 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				 String today = formatter.format(new java.util.Date());
				 
				System.out.println(today + "] ==  couponUse_Check.jsp ==> " +  e.getMessage());
			}			
			
		}
	}
}
%>