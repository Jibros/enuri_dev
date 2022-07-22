<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.logdata.Move_log_Data"%>
<%@ page import="com.enuri.bean.logdata.Move_log_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Proc"%>
<%@ page import="com.enuri.bean.main.Pricelist_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>

<jsp:useBean id="Move_log_Data" class="com.enuri.bean.logdata.Move_log_Data"  />
<jsp:useBean id="Move_log_Proc" class="com.enuri.bean.logdata.Move_log_Proc"  />
 
<%
	long iPlno = ChkNull.chkLong(request.getParameter("pl_no"));
	int iRank = ChkNull.chkInt(request.getParameter("rank"),0);
	int intVcode = ChkNull.chkInt(request.getParameter("vcode"));
	int iModelno = ChkNull.chkInt(request.getParameter("modelno"));
	String strCate = ChkNull.chkStr(request.getParameter("cate"),"");
	String strPd = ChkNull.chkStr(request.getParameter("pd"));
	String strT1 = ChkNull.chkStr(request.getParameter("t1"));
	String strEnrReferer = ChkNull.chkStr(request.getParameter("referrer"),"");
	
	Cookie[] carr = request.getCookies();
	String strAd_id = "";
	String strMcate = "";

	boolean blCheck_app = false;
	boolean blCheck_web = false;

	String strAppYN = "";
	String strUserId = "";
	String strApp_type = "";
	String strApp_id = "";
	String strOsType = "";
	PDManager_Proc pdmanager = new PDManager_Proc();
	PDManager_PD_Data pdData = null;

	if(!strPd.equals("") && !strT1.equals("")){
		pdData = pdmanager.chkT1PD(request); //t1 있다==>login
	}else if(!strPd.equals("") && strT1.equals("")){
		pdData = pdmanager.chkPD(request);	//t1 없다==>no login
	}else{
		//앱 웹뷰 OR 모바일 웹 
	}
	/*System.out.println("pdData >>>>> " + pdData);
	System.out.println("pd >>>>> " + ChkNull.chkStr(request.getParameter("pd")));
	System.out.println("t1 >>>>> " + ChkNull.chkStr(request.getParameter("t1")));
	System.out.println("user-agent >>>>> " + ChkNull.chkStr((request.getHeader("User-Agent"))));*/
	
	if(pdData==null){											//쿠키 사용
		//앱 웹뷰 OR 모바일 웹 
		if(carr!=null){
			for(int i=0;i<carr.length;i++){
				if(carr[i].getName().equals("appYN")){
					strAppYN = carr[i].getValue();
					break;
				}
			}
		}
		//모바일웹
		if(strAppYN.equals("")){
			if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
				strOsType = "MWA";
			}else if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
				strOsType="MWI";
			}else{
				strOsType="PC";
			}
		}else{
			//앱=>웹뷰 
			if(ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0){
				strOsType = "MAA";
			}else{
				strOsType = "MAI";
			}
		}
		strUserId = cb.GetCookie("MEM_INFO","USER_ID");
		strApp_type = strOsType;
		blCheck_web = true;
	}else{
		//앱 
		strApp_type = pdData.getApp_type();
		strUserId = pdData.getEnuri_id();
		if( strApp_type.equals("A") || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("Android") >= 0 ){
			strOsType = "MAA";
		}else if(strApp_type.equals("I") || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPhone") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPod") >= 0 || ChkNull.chkStr(request.getHeader("User-Agent")).indexOf("iPad") >= 0){
			strOsType= "MAI";
		}
		blCheck_app = true;
	}

	Pricelist_Proc pricelist_proc = new Pricelist_Proc();
	Pricelist_Data pricelist_data = pricelist_proc.getData_Delivery(iPlno);
  	if(pricelist_data!=null){
		iModelno = pricelist_data.getModelno();
		strCate  = pricelist_data.getCa_code();
		 if(strCate.length()>=4){
			strMcate = strCate.substring(0,4);
		}
	}
	try {
		for(int i=0;i<carr.length;i++){
		    if(carr[i].getName().equals("adid")){
		    	strAd_id = carr[i].getValue();
		    	break;
		    } 
		}
	} catch(Exception e) {
	}



	String strReferer = ChkNull.chkStr(request.getHeader("REFERER"),"");
	//String M_Ip = request.getRemoteAddr();
	String M_Ip = getClientIpAddr(request);
	//System.out.println("M_Ip?>>>>>"+M_Ip);
    String strRefererM = strReferer; 
    if (strRefererM.indexOf("?") >= 0){
        strRefererM = strRefererM.substring(0,strRefererM.lastIndexOf("?"));
    }
	if(strEnrReferer.equals("lp")){
		strEnrReferer = "L";
	}else if ( strEnrReferer.equals("srp")){
		strEnrReferer = "S";
	}else{
		if(strRefererM.indexOf("/list.jsp") >=0 ) strEnrReferer = "L";
		else if(strRefererM.indexOf("/search.jsp") >=0 ) strEnrReferer = "S";
		else if(strRefererM.indexOf("/vip.jsp") >= 0 ){
			strEnrReferer = "V";
		} else{
			strEnrReferer = strRefererM;
		}
	}


    //System.out.println("=1========================================="+strEnrReferer);
    
	//Move_log_Proc.Mobile_MoveLog_Insert3(output, M_Ip, strCate, iModelno, iRank, iPlno, intVcode,strRefererM,cUserId);
	//.Mobile_MoveLog_Insert5(output, M_Ip, strMcate, iModelno, iRank, iPlno, intVcode,strEnrReferer,cUserId,strAd_id);
    Move_log_Proc.Mobile_MoveLog_Insert6(output, M_Ip, strMcate, iModelno, iRank, iPlno, intVcode,strEnrReferer,strUserId,strAd_id,strOsType);
	//System.out.println(output+", "+M_Ip+", "+strCate+", "+iModelno+", "+iRank+", "+iPlno+", "+intVcode);
    
   // System.out.println("==2========================================");
    //System.out.println(output+", "+M_Ip+", "+strCate+", "+iModelno+", "+iRank+", "+iPlno+", "+intVcode+" , "+ strEnrReferer + ","+ cUserId + ", "+strAd_id);
   // System.out.println("==3========================================");
%>  
<%!
public static String getClientIpAddr(HttpServletRequest request) {
	String ip = request.getHeader("X-Forwarded-For");
 
	if(ip != null && ip.indexOf(",")>-1) {
		ip = ip.split(",")[0];
	}
	
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_CLIENT_IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	return ip;
}
%>