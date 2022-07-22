<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.net.ssl.HttpsURLConnection"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Emoney_Proc"%>
<%@ page import="com.enuri.bean.mobile.Estore_Proc"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.member.Sns_Login"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<jsp:useBean id="Estore_Proc" class="com.enuri.bean.mobile.Estore_Proc" scope="page" />
<jsp:useBean id="Sns_Login" class="com.enuri.bean.member.Sns_Login" scope="page" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc"  />
<%
//아이디check, referer 체크
//
//1. 라면 쿠폰 클릭 하면 upd_reward_point_use 콜해서 seq번호 받아옴.
//2. 받아온 쿠폰seq번호로 api 호출
//3. 호출후 넘어온 xml파싱
//4. 파싱 후 원하는 데이터 다시 저장.
//String strGift_code = ChkNull.chkStr(request.getParameter("gift_code"));	//선택한 상품의 code
int intGift_seq = ChkNull.chkInt(request.getParameter("gift_seq"));	//선택한 상품의 seq
int intGift_term = ChkNull.chkInt(request.getParameter("gift_term"));	//선택한 상품의  유효기한

String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

int intUse_point = Estore_Proc.get_ItemPrice(intGift_seq);
String strGiftCode = Estore_Proc.getItemGiftCode(intGift_seq);
//int intCouponBuyIDCount = Estore_Proc.getCouponBuyCount(strUserid);
//int intCouponBuyIDAndGiftSeqCount = Estore_Proc.getCouponBuyCount(strUserid,intGift_seq);
boolean blCouponBuyLimitFlag = Estore_Proc.bUserCouponLimit(strUserid);
String strPoint_code = "04";	//04 : 사용
String strReturn_code = "";
String strDevice = "M";
String strOsTpCd = "MAI";

if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0) strOsTpCd = "MAA";
//블랙리스트 페이지 제한 로그 입력 _ start
String userIp = ChkNull.chkStr(ConfigManager.szConnectIp(request), "");
String reqUri = ChkNull.chkStr(request.getRequestURI().toString(), "");
String reqUrl = "";
String reqDomain = ChkNull.chkStr(request.getServerName().toString(), "");
String reqUrlQry = "";
String reqTel1 = "";
String reqTel2 = "";
String reqTel3 = "";
String strEmail = "";
//Seed_Proc seed_proc = new Seed_Proc();

if(request.getServerPort() == 8443){
	reqUrl = "https://"+reqDomain+reqUri;
}else{
	reqUrl = "http://"+reqDomain+reqUri;
}

if(request.getQueryString() != null){
	reqUrlQry = reqUrl+"?"+ ChkNull.chkStr(request.getQueryString().toString(), "");
}else{
	reqUrlQry = reqUrl;
}
int hst_no = 5;
//int iPassCnt = Login_Proc.getPassCnt(userIp, 1); //1일 
boolean bPassLog= Login_Proc.insPassLog(hst_no, reqUri, reqUrlQry, strUserid, reqTel1, reqTel2,reqTel3, strEmail, intGift_seq, userIp, strOsTpCd);

log(request,"GIFT_SEQ",String.valueOf(intGift_seq));
log(request,"GIFT_CODE",String.valueOf(strGiftCode));
log(request,"GIFT_TERM",String.valueOf(intGift_term));
log(request,"COOKIE_USERID",String.valueOf(strUserid));
log(request,"OSTPCD",String.valueOf(strOsTpCd));
log(request,"COUPONBUYLIMIT",String.valueOf(blCouponBuyLimitFlag));
//chk_id :uuid , uuid 로 마지막 로그인 한 아이디가 strUserid 이면 통과~ 아니면 패스~
if(!Sns_Login.chkMemberStatus(strUserid)){ //정상회원이면 쿠폰 교환 
	strReturn_code = "01";
}else if(strUserid != null && !strUserid.equals("") && strChk_id != null && !strChk_id.equals("") && intUse_point > 0 && (blCouponBuyLimitFlag)){
	//아이디와 uuid 체크하는 로직
	int intSeqno = Mobile_Push_Proc.chk_reward_request(strChk_id, strUserid);
	log(request,"CHK_ID(USER_DATA)",String.valueOf(strChk_id));
	if(intSeqno > 0){
		strReturn_code = "00";
		int intPoint_seq = Estore_Proc.Estore_Point_Use(strUserid, intUse_point, strPoint_code, intGift_seq, strDevice, strOsTpCd);
		log(request,"POINT_SEQ",String.valueOf(intPoint_seq));
		//System.out.println("intPoint_seq>>>"+intPoint_seq);

		if(intPoint_seq  > 0){
			//strGift_code = "00EB036J00001";
			//XML 데이터를 호출할 URL
			//String strUrl = "http://100.100.100.80:3303/ServiceCouponCreate";
			//node.js 에서 jsp로 변경. 2018-10-11. shwoo.
			String strUrl = "http://100.100.100.80:8080/mobilefirst/api/ServiceCouponCreate.jsp";
			strUrl += "?COUPONCODE="+ strGiftCode +"&SEQNUMBER="+intPoint_seq;
			//String strUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponCreate";
			//strUrl += "?CODE=0413&PASS=enuri0413&COUPONCODE="+ strGift_code +"&SEQNUMBER="+ intPoint_seq;

			//System.out.println("ServiceCouponCreate strUrl >>>"+strUrl);

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(strUrl);

			NodeList nodeResultcode    = document.getElementsByTagName("RESULTCODE");
			NodeList nodeResultmsg    = document.getElementsByTagName("RESULTMSG");
			NodeList nodeCouponnumber    = document.getElementsByTagName("COUPONNUMBER");
			NodeList nodePinnumber    = document.getElementsByTagName("PINNUMBER");

			String strResultcode = "";
			String strResultmsg = "";
			String strCouponnumber = "";
			String strPinnumber = "";

			if(nodeResultcode.item(0).getFirstChild() != null)
				strResultcode    = nodeResultcode.item(0).getFirstChild().getNodeValue();
			if(nodeResultmsg.item(0).getFirstChild() != null)
				strResultmsg   = nodeResultmsg.item(0).getFirstChild().getNodeValue();
			if(nodeCouponnumber.item(0).getFirstChild() != null)
				strCouponnumber    = nodeCouponnumber.item(0).getFirstChild().getNodeValue();
			if(nodePinnumber.item(0).getFirstChild() != null)
				strPinnumber    = nodePinnumber.item(0).getFirstChild().getNodeValue();

			//System.out.println("strResultcode>>>"+strResultcode);
			//System.out.println("strResultmsg>>>"+strResultmsg);
			//System.out.println("strCouponnumber>>>"+strCouponnumber);
			//System.out.println("strPinnumber>>>"+strPinnumber);

			if(strResultcode.equals("00")){
				//정상적으로 넘어왔으면. 쿠폰 정보수집을 위해 다시한번 api get
				//String strInfoUrl = "http://issuev3apitest.m2i.kr:9999/app/appapi.asmx/AppMMSData?CODE=0413&PASS=enuri0413&GUCODE=01&PINNUMBER="+strPinnumber;

				//String strInfoUrl = "http://100.100.100.80:3303/AppMMSData";
				//node.js 에서 jsp로 변경. 2018-10-11. shwoo.
				String strInfoUrl = "http://100.100.100.80:8080/mobilefirst/api/AppMMSData.jsp";
				strInfoUrl += "?PINNUMBER="+strPinnumber;

				//System.out.println("AppMMSData strUrl >>>"+strInfoUrl);

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

				String strInfoRescode = "";
				String strInfoResmsg = "";
				String strCouponimage = "";
				String strCompname = "";
				String strCouponname = "";
				String strEnddate = "";
				String strUselimit = "";
				String strUsedirection = "";
				String strUseplace = "";
				String strTel = "";

				if(nodeInfoRescode.item(0).getFirstChild() != null)
					strInfoRescode    = nodeInfoRescode.item(0).getFirstChild().getNodeValue();
				if(nodeInfoResmsg.item(0).getFirstChild() != null)
					strInfoResmsg   	= nodeInfoResmsg.item(0).getFirstChild().getNodeValue();
				if(nodeCouponimage.item(0).getFirstChild() != null)
					strCouponimage    	= nodeCouponimage.item(0).getFirstChild().getNodeValue();
				if(nodeCompname.item(0).getFirstChild() != null)
					strCompname    		= nodeCompname.item(0).getFirstChild().getNodeValue();
				if(nodeCouponname.item(0).getFirstChild() != null)
					strCouponname    	= nodeCouponname.item(0).getFirstChild().getNodeValue();
				if(nodeEnddate.item(0).getFirstChild() != null)
					strEnddate    			= nodeEnddate.item(0).getFirstChild().getNodeValue();
				if(nodeUselimit.item(0).getFirstChild() != null)
					strUselimit    			= nodeUselimit.item(0).getFirstChild().getNodeValue();
				if(nodeUsedirection.item(0).getFirstChild() != null)
					strUsedirection    	= nodeUsedirection.item(0).getFirstChild().getNodeValue();
				if(nodeUseplace.item(0).getFirstChild() != null)
					strUseplace    		= nodeUseplace.item(0).getFirstChild().getNodeValue();
				if(nodeTel.item(0).getFirstChild() != null)
					strTel    				= nodeTel.item(0).getFirstChild().getNodeValue();

				//System.out.println("strCouponimage>>>"+strCouponimage);
				//System.out.println("strCompname>>>"+strCompname);
				//System.out.println("strCouponname>>>"+strCouponname);
				//System.out.println("strEnddate>>>"+strEnddate);
				//System.out.println("strUselimit>>>"+strUselimit);
				//System.out.println("strUsedirection>>>"+strUsedirection);
				//System.out.println("strUseplace>>>"+strUseplace);
				//System.out.println("strTel>>>"+strTel);

				//DB업데이트.
				int intPoint_Update = Emoney_Proc.update_Gift_Coupon(strPinnumber, strEnddate, strCouponimage, strCouponname, strCompname, strTel, strUserid,  intPoint_seq, strCouponnumber, intGift_term);

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
	log(request,"RETURN_CODE",String.valueOf(strReturn_code));
}
%><%=strReturn_code %>
<%!
	public void log(HttpServletRequest request, String k, String v) throws Exception {
		String uri = request.getRequestURI();
		String servername = request.getServerName();
		System.out.println("["+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())+" "+uri+" ] => ["+k+"] = ["+v+"]");
	}
%>
