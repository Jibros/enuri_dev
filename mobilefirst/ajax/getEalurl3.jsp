<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.json.JSONObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@page import="com.enuri.bean.main.deal.CrazyDeal_Proc"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.log.Log_main_Proc"%>
<jsp:useBean id="Members_Data" class="com.enuri.bean.knowbox.Members_Data"  />
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc"  />
<jsp:useBean id="CrazyDeal_Proc" class="com.enuri.bean.main.deal.CrazyDeal_Proc" scope="page" />
<%@ page import="com.enuri.bean.edeal.Edeal_Order_Proc"%>
<%
	//쓰리고 딜 에서 사용함
	int intSeq = ChkNull.chkInt(request.getParameter("seq"),0);
	if(intSeq  == 0)		return ;
	
	String devYN = "N";
	if( request.getServerName().equals("dev.enuri.com")  ){
		devYN = "Y";
	}
	String type = ChkNull.chkStr(request.getParameter("type"),"C");
	
	JSONObject jsonUrlSoldoutflag = CrazyDeal_Proc.getCrazyDealUrlSoldOutFlag(intSeq,devYN,type);

	String referer = "";
	String pageNm = "";
	
	try{
		referer = ChkNull.chkStr(request.getHeader("referer")).trim();
		if(referer.indexOf("index.jsp") > -1){
			pageNm = "H";
		}else if(referer.indexOf("mobile_deal.jsp") > -1){
			pageNm = "R";
		}
	}catch(Exception ex){}
	
	String strUrl = "";
	boolean blLogin = false;
	String strSold_out = "";
	int cnt = 0;
	String resultMsg = "";
	String alertMsg = "";
	String newmemChkDate = "";
	try{
		strUrl = jsonUrlSoldoutflag.getString("GOODS_URL");
		blLogin = jsonUrlSoldoutflag.getBoolean("login_need");
		strSold_out = jsonUrlSoldoutflag.getString("GOODS_SOLD_FLAG");
		cnt = jsonUrlSoldoutflag.getInt("CNT");
		newmemChkDate = jsonUrlSoldoutflag.getString("DEAL_APL_DT");
		
	}catch(Exception e){}
	
	String strUser_ip = ChkNull.chkStr(request.getParameter("user_ip"), "0");	//모바일웹 & PC는 페이지내 처리
	strUser_ip = request.getRemoteAddr();
    
    String strEnuriId = "";
    String strEnuriPw = "";
	String strOsType  = "";
	

	
    out.println("{");
    
	if(strUrl != null && !strUrl.equals("")){
		resultMsg = "SUCCESS";
		out.println("\"resultUrl\" : \""+ strUrl + "\", ");
        out.println("\"EnuriId\": \""+ strEnuriId + "\"," );
                

	}else{
		resultMsg = "FAIL";
		out.println("\"resultUrl\" : \"\", ");
	}
	out.println("\"resultMsg\" : \""+ resultMsg +"\", ");

	if(!"".equals(alertMsg)) {
		out.println("\"msg\" : \""+ alertMsg +"\", ");
	}
	
	//out.println("\"IsEnuriEmployee\" : "+IsEnuriEmployee+","); //직원여부
	out.println("\"cnt\" : "+cnt+","); //솔드아웃
	if(cnt > 0 ) out.println("\"soldout\" : \"Y\", "); // 날짜가 지난 상품은 솔드아웃	
	else out.println("\"soldout\" : \""+ strSold_out + "\", "); //판매날짜에 안에있는 상품만
	
	out.println("\"login_need\" : \""+ blLogin + "\" ");
		
	out.println("}");
	
%>
<%!
//특수문자 제거 하기
public String StringReplace(String str){       
	String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
	str =str.replaceAll(match, "").trim();
	//str =str.replaceAll("?","").trim();
	return str;
}
%>