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
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc" scope="page" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%
//아이디check, referer 체크
//
//1. 라면 쿠폰 클릭 하면 upd_reward_point_use 콜해서 seq번호 받아옴.
//2. 받아온 쿠폰seq번호로 api 호출
//3. 호출후 넘어온 xml파싱
//4. 파싱 후 원하는 데이터 다시 저장.
String strGift_code = ChkNull.chkStr(request.getParameter("gift_code"));	//선택한 상품의 code
int intGift_seq = ChkNull.chkInt(request.getParameter("gift_seq"));	//선택한 상품의 seq

String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");
int intUse_point = 1000;
String strPoint_code = "04";	//04 : 사용

String strReturn_code = "";

//chk_id :uuid , uuid 로 마지막 로그인 한 아이디가 strUserid 이면 통과~ 아니면 패스~

//if(strUserid != null && !strUserid.equals("") && referer.indexOf("/mobilefirst/reward/reward_store.jsp") > -1){
if(strUserid != null && !strUserid.equals("") && strChk_id != null && !strChk_id.equals("")){
	//아이디와 uuid 체크하는 로직
	int intSeqno = Mobile_Push_Proc.chk_reward_request(strChk_id, strUserid);
	
	if(intSeqno > 0){
		strReturn_code = "00";
		int intPoint_seq = Reward_Proc.Reward_Point_Use(strUserid, intUse_point, strPoint_code, intGift_seq);
		
		if(intPoint_seq  > 0){
			//strGift_code = "00EB036J00001";
			//XML 데이터를 호출할 URL
			String strUrl = "http://100.100.100.80:3303/ServiceCouponCreate";
			strUrl += "?COUPONCODE="+ strGift_code +"&SEQNUMBER="+intPoint_seq;
			//String strUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponCreate?CODE=0413&PASS=enuri0413&COUPONCODE=00EB036J00001&SEQNUMBER=3234567890";
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(strUrl);
			
			NodeList nodeResultcode    = document.getElementsByTagName("RESULTCODE");
			NodeList nodeResultmsg    = document.getElementsByTagName("RESULTMSG");
			NodeList nodeCouponnumber    = document.getElementsByTagName("COUPONNUMBER");
			NodeList nodePinnumber    = document.getElementsByTagName("PINNUMBER");
			
			String strResultcode    = nodeResultcode.item(0).getFirstChild().getNodeValue();
			String strResultmsg   = nodeResultmsg.item(0).getFirstChild().getNodeValue();
			String strCouponnumber    = nodeCouponnumber.item(0).getFirstChild().getNodeValue();
			String strPinnumber    = nodePinnumber.item(0).getFirstChild().getNodeValue();
			
			//out.println("strResultcode>>>"+strResultcode+"<br>");
			//out.println("strResultmsg>>>"+strResultmsg+"<br>");
			//out.println("strCouponnumber>>>"+strCouponnumber+"<br>");
			//out.println("strPinnumber>>>"+strPinnumber+"<br>"+"<br>");
			
			if(strResultcode.equals("00")){
				//정상적으로 넘어왔으면. 쿠폰 정보수집을 위해 다시한번 api get
				//String strInfoUrl = "http://issuev3apitest.m2i.kr:9999/app/appapi.asmx/AppMMSData?CODE=0413&PASS=enuri0413&GUCODE=01&PINNUMBER="+strPinnumber;
				
				String strInfoUrl = "http://100.100.100.80:3303/AppMMSData";
				strInfoUrl += "?PINNUMBER="+strPinnumber;
				
				DocumentBuilderFactory Infofactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder Infobuilder = Infofactory.newDocumentBuilder();
				Document Infodocument = Infobuilder.parse(strInfoUrl);
				
				NodeList nodeInfoRescode    = Infodocument.getElementsByTagName("RESCODE");
				NodeList nodeInfoResmsg    = Infodocument.getElementsByTagName("RESMSG");
				NodeList nodeCouponimage    = Infodocument.getElementsByTagName("COUPONIMAGE");
				NodeList nodeCompname    = Infodocument.getElementsByTagName("COMPNAME");
				NodeList nodeCouponname    = Infodocument.getElementsByTagName("COUPONNAME");
				NodeList nodeEnddate    = Infodocument.getElementsByTagName("ENDDATE");
				NodeList nodeUselimit    = Infodocument.getElementsByTagName("USELIMIT");
				NodeList nodeUsedirection    = Infodocument.getElementsByTagName("USEDIRECTION");
				NodeList nodeUseplace    = Infodocument.getElementsByTagName("USEPLACE");
				NodeList nodeTel    = Infodocument.getElementsByTagName("TEL");
				
				String strInfoRescode    = nodeInfoRescode.item(0).getFirstChild().getNodeValue();
				String strInfoResmsg   	= nodeInfoResmsg.item(0).getFirstChild().getNodeValue();
				String strCouponimage    	= nodeCouponimage.item(0).getFirstChild().getNodeValue();
				String strCompname    		= nodeCompname.item(0).getFirstChild().getNodeValue();
				String strCouponname    	= nodeCouponname.item(0).getFirstChild().getNodeValue();
				String strEnddate    			= nodeEnddate.item(0).getFirstChild().getNodeValue();
				String strUselimit    			= nodeUselimit.item(0).getFirstChild().getNodeValue();
				String strUsedirection    	= nodeUsedirection.item(0).getFirstChild().getNodeValue();
				String strUseplace    		= nodeUseplace.item(0).getFirstChild().getNodeValue();
				String strTel    				= nodeTel.item(0).getFirstChild().getNodeValue();
				
				//out.println("strCouponimage>>>"+strCouponimage+"<br>");
				//out.println("strCompname>>>"+strCompname+"<br>");
				//out.println("strCouponname>>>"+strCouponname+"<br>");
				//out.println("strEnddate>>>"+strEnddate+"<br>");
				//out.println("strUselimit>>>"+strUselimit+"<br>");
				//out.println("strUsedirection>>>"+strUsedirection+"<br>");
				//out.println("strUseplace>>>"+strUseplace+"<br>");
				//out.println("strTel>>>"+strTel+"<br>");
				
				//DB업데이트.
				int intPoint_Update = Reward_Proc.update_Gift_Coupon(strPinnumber, strEnddate, strCouponimage, strCouponname, strCompname, strTel, strUserid,  intPoint_seq, strCouponnumber);
				
				if(intPoint_Update > 0){
					//정상입력
				}else{
					//오류 포인트도 빠지고 쿠폰발행도 됐는데 저장이 안됨...... 어떻게 처리를 하지..;;;;
					strReturn_code = "04";
				}
			}else{
				//포인트 빠지고 쿠폰발행시 쿠폰 발행안됨 2. 어떻게 처리를 하죠....
				strReturn_code = "03";
			}
		}else{
			//포인트는 빠지고 쿠폰은 발행안됨. 어떻게 처리를 하죠.....흠...
			strReturn_code = "02";
		}
	}else{
		strReturn_code = "01";
	}
}
%><%=strReturn_code %>