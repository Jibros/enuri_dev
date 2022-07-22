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
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data" scope="page" />
<jsp:useBean id="Emoney_Proc" class="com.enuri.bean.mobile.Emoney_Proc" scope="page" />
<jsp:useBean id="Mobile_Push_Proc" class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
<%
String strCoupon_code = ChkNull.chkStr(request.getParameter("coupon_code"));	//선택한 상품의 code
String strChk_id = ChkNull.chkStr(request.getParameter("chk_id"),"");

String strUserid = cb.GetCookie("MEM_INFO","USER_ID");

//String strInfoUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponInfo?CODE=0413&PASS=enuri0413&COUPONCODE="+strCoupon_code;

//String strInfoUrl = "http://issuev3apitest.m2i.kr:9999/serviceapi.asmx/ServiceCouponInfo?CODE=0413&PASS=enuri0413&COUPONCODE="+strCoupon_code;

String strInfoUrl = "http://100.100.100.80:3303/ServiceCouponInfo";
strInfoUrl += "?COUPONCODE="+strCoupon_code;

DocumentBuilderFactory Infofactory = DocumentBuilderFactory.newInstance();
DocumentBuilder Infobuilder = Infofactory.newDocumentBuilder();
Document Infodocument = Infobuilder.parse(strInfoUrl);

NodeList nodeInfoResultcode    	= Infodocument.getElementsByTagName("RESULTCODE");	//응답코드
NodeList nodeInfoResultmsg    	= Infodocument.getElementsByTagName("RESULTMSG");		//응답메세지
NodeList nodeInfoComp_name    = Infodocument.getElementsByTagName("COMP_NAME");		//제휴사명
NodeList nodeInfoCouponanme   = Infodocument.getElementsByTagName("COUPONNAME");	//상품명칭
NodeList nodeInfoComp_code    	= Infodocument.getElementsByTagName("COMP_CODE");		//제휴사코드
NodeList nodeInfoMenu_code    	= Infodocument.getElementsByTagName("MENU_CODE");		//상품코드
NodeList nodeInfoUseprice    		= Infodocument.getElementsByTagName("USEPRICE");		//소비자가격
NodeList nodeInfoSel_price    		= Infodocument.getElementsByTagName("SEL_PRICE");		//판매가격
NodeList nodeInfoUse_area    	= Infodocument.getElementsByTagName("USE_AREA");		//사용장소
NodeList nodeInfoTax_yn    		= Infodocument.getElementsByTagName("TAX_YN");			//과세유무
NodeList nodeInfoUse_limit    		= Infodocument.getElementsByTagName("USE_LIMIT");		//제한사항
NodeList nodeInfoUse_note    	= Infodocument.getElementsByTagName("USE_NOTE");		//주의사항
NodeList nodeInfoOld_pcode    	= Infodocument.getElementsByTagName("OLD_PCODE");		//구상품코드
NodeList nodeInfoUse_term		= Infodocument.getElementsByTagName("USE_TERM");		//유효기간
NodeList nodeInfoBasic_img		= Infodocument.getElementsByTagName("BASIC_IMG");		//이미지
NodeList nodeInfoView_img1		= Infodocument.getElementsByTagName("VIEW_IMG1");		//상세이미지1
NodeList nodeInfoView_img2		= Infodocument.getElementsByTagName("VIEW_IMG2");		//상세이미지2
NodeList nodeInfoView_img3		= Infodocument.getElementsByTagName("VIEW_IMG3");		//상세이미지3
NodeList nodeInfoPath				= Infodocument.getElementsByTagName("PATH");				//이미지경로

String strResultcode    	= "";
String strResultmsg    	= "";
String strComp_name    = "";
String strCouponanme   = "";
String strComp_code    	= "";
String strMenu_code    	= "";
String strUseprice    		= "";
String strSel_price    	= "";
String strUse_area    	= "";
String strTax_yn    		= "";
String strUse_limit    	= "";
String strUse_note    	= "";
String strOld_pcode    	= "";
String strUse_term		= "";
String strBasic_img		= "";
String strView_img1		= "";
String strView_img2		= "";
String strView_img3		= "";
String strPath				= "";

strResultcode    	= nodeInfoResultcode.item(0).getFirstChild().getNodeValue();
strResultmsg    	= nodeInfoResultmsg.item(0).getFirstChild().getNodeValue();

try{
	if(strResultcode.equals("00")){
		if(nodeInfoComp_name.item(0).getFirstChild() != null)
			strComp_name    = nodeInfoComp_name.item(0).getFirstChild().getNodeValue();
		if(nodeInfoCouponanme.item(0).getFirstChild() != null)
			strCouponanme   = nodeInfoCouponanme.item(0).getFirstChild().getNodeValue();
		if(nodeInfoComp_code.item(0).getFirstChild() != null)		
			strComp_code    	= nodeInfoComp_code.item(0).getFirstChild().getNodeValue();
		if(nodeInfoMenu_code.item(0).getFirstChild() != null)			
			strMenu_code    	= nodeInfoMenu_code.item(0).getFirstChild().getNodeValue();
		if(nodeInfoUseprice.item(0).getFirstChild() != null)			
			strUseprice    		= nodeInfoUseprice.item(0).getFirstChild().getNodeValue();
		if(nodeInfoSel_price.item(0).getFirstChild() != null)	
			strSel_price    		= nodeInfoSel_price.item(0).getFirstChild().getNodeValue();
		if(nodeInfoUse_area.item(0).getFirstChild() != null)
			strUse_area    		= nodeInfoUse_area.item(0).getFirstChild().getNodeValue();
		if(nodeInfoTax_yn.item(0).getFirstChild() != null)	
			strTax_yn    		= nodeInfoTax_yn.item(0).getFirstChild().getNodeValue();
		if(nodeInfoUse_limit.item(0).getFirstChild() != null)
			strUse_limit    		= nodeInfoUse_limit.item(0).getFirstChild().getNodeValue();
		if(nodeInfoUse_note.item(0).getFirstChild() != null)
			strUse_note    	= nodeInfoUse_note.item(0).getFirstChild().getNodeValue();
		if(nodeInfoOld_pcode.item(0).getFirstChild() != null)
			strOld_pcode    	= nodeInfoOld_pcode.item(0).getFirstChild().getNodeValue();
		if(nodeInfoUse_term.item(0).getFirstChild() != null)
			strUse_term		= nodeInfoUse_term.item(0).getFirstChild().getNodeValue();
		if(nodeInfoBasic_img.item(0).getFirstChild() != null)
			strBasic_img		= nodeInfoBasic_img.item(0).getFirstChild().getNodeValue();
		if(nodeInfoView_img1.item(0).getFirstChild() != null)
			strView_img1		= nodeInfoView_img1.item(0).getFirstChild().getNodeValue();
		if(nodeInfoView_img2.item(0).getFirstChild() != null)
			strView_img2		= nodeInfoView_img2.item(0).getFirstChild().getNodeValue();
		if(nodeInfoView_img3.item(0).getFirstChild() != null)
			strView_img3		= nodeInfoView_img3.item(0).getFirstChild().getNodeValue();
		if(nodeInfoPath.item(0).getFirstChild() != null)
			strPath				= nodeInfoPath.item(0).getFirstChild().getNodeValue();
	}
}catch(Exception e){}

out.println("{");
out.println(" \"RESULTCODE\" : \""+ toJS2(strResultcode) +"\", ");
out.println(" \"RESULTMSG\" : \""+ toJS2(strResultmsg) +"\", ");
out.println(" \"COMP_NAME\" : \""+ toJS2(strComp_name) +"\", ");
out.println(" \"COUPONNAME\" : \""+ toJS2(strCouponanme) +"\", ");
out.println(" \"COMP_CODE\" : \""+ toJS2(strComp_code) +"\", ");
out.println(" \"MENU_CODE\" : \""+ toJS2(strMenu_code) +"\", ");
out.println(" \"USEPRICE\" : \""+ toJS2(strUseprice) +"\", ");
out.println(" \"SEL_PRICE\" : \""+ toJS2(strSel_price) +"\", ");
out.println(" \"USE_AREA\" : \""+ toJS2(strUse_area) +"\", ");
out.println(" \"TAX_YN\" : \""+ toJS2(strTax_yn) +"\", ");
out.println(" \"USE_LIMIT\" : \""+ toJS2(strUse_limit) +"\", ");
out.println(" \"USE_NOTE\" : \""+ toJS2(strUse_note) +"\", ");
out.println(" \"OLD_PCODE\" : \""+ toJS2(strOld_pcode) +"\", ");
out.println(" \"USE_TERM\" : \""+ toJS2(strUse_term) +"\", ");
out.println(" \"BASIC_IMG\" : \""+ toJS2(strBasic_img) +"\", ");
out.println(" \"VIEW_IMG1\" : \""+ toJS2(strView_img1) +"\", ");
out.println(" \"VIEW_IMG2\" : \""+ toJS2(strView_img2) +"\", ");
out.println(" \"VIEW_IMG3\" : \""+ toJS2(strView_img3) +"\", ");
out.println(" \"PATH\" : \""+ toJS2(strPath) +"\" ");
out.println("}");

%>