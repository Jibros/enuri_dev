<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="org.json.*"%>
<%@page import="com.enuri.bean.bizm.Bizm_Data"%>
<%@ page import="com.enuri.bean.bizm.Bizm_Proc"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.include.RandomMain"%>
<jsp:useBean id="RandomMain" class="com.enuri.include.RandomMain" scope="page" />
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.main.Advertiser_Data"%>
<%@ page import="com.enuri.bean.main.Advertiser_Proc"%>
<jsp:useBean id="Members_Proc" class="com.enuri.bean.knowbox.Members_Proc" scope="page" />
<jsp:useBean id="Advertiser_Proc" class="com.enuri.bean.main.Advertiser_Proc"  />
<jsp:useBean id="Bizm_Proc" class="com.enuri.bean.bizm.Bizm_Proc">

<%
String referer = ChkNull.chkStr(request.getHeader("referer"));

if(referer.indexOf("enuri.com") > -1){
	
	String type = ChkNull.chkStr(request.getParameter("type"));
	String enuri_id = ChkNull.chkStr(request.getParameter("enuri_id"));
	String cs_tel = ChkNull.chkStr(request.getParameter("cs_tel"));
	String serverName = request.getRequestURL().toString();
	
	//ssl
	int[] iT = RandomMain.getRandomValueNoDupe(10);
	String cs_no = iT[0]+""+iT[1]+""+iT[2]+""+iT[3]+""+iT[4];
	int iCont_cnt = ChkNull.chkInt(cb.GetCookie("MEMJOIN_SELF_CONF","CONF_CNT"));
	
	int resultCode = 0;
	
	if(iCont_cnt>=100){
		resultCode = -1;
	}
	else if(!isPhoneNumber(cs_tel) && !type.equals("pw") ){
		resultCode=-4;
	}
	else {
		System.out.println("kkkk ------------------");
		System.out.println("kkkk servername: "+serverName);
		
		HttpSession ttsession = request.getSession(true);

		System.out.println("kkkk session.id:"+ttsession.getId());
		System.out.println("kkkk session.isNew:"+ttsession.isNew());
				
		ttsession.setMaxInactiveInterval(300);
		
		ttsession.setAttribute("MEMJOIN_SELF_CONF", "");
		ttsession.setAttribute("MEMJOIN_SELF_CONF", cs_no);
		ttsession.setAttribute("MEMJOIN_SELF_CONF_FAILCNT", "0");
		
		System.out.println("kkkk session cs_no:"+(String)ttsession.getAttribute("MEMJOIN_SELF_CONF"));
		ttsession = request.getSession(true);
		System.out.println("kkkk session cs_no2:"+(String)ttsession.getAttribute("MEMJOIN_SELF_CONF"));

		if(cs_tel.equals("")){ 
			
		}else{
			//기존회원테이블에 확인.
			boolean isUsedPhone = false;
			boolean isErrorFlag = false;
			String cs_tel1 = "";
			String cs_tel2 = "";
			String cs_tel3 = "";
			
			if(cs_tel.length()==11) {
				cs_tel1 = cs_tel.substring(0,3);
				cs_tel2 = cs_tel.substring(3,7);
				cs_tel3 = cs_tel.substring(7,11);
			} else {
				try {
					cs_tel1 = cs_tel.substring(0,3);
					cs_tel2 = cs_tel.substring(3,6);
					cs_tel3 = cs_tel.substring(6,10);
				} catch(Exception e) {
					isErrorFlag = true;
				}
			}
			isUsedPhone = Members_Proc.getDataCertifyPhone(cs_tel1, cs_tel2, cs_tel3, "");
		
			if(isErrorFlag) {
				resultCode = -2;
			} else if(isUsedPhone  && !type.equals("pw")) {
				resultCode = -3;
			} else {
				iCont_cnt++;
				cb.SetCookie("MEMJOIN_SELF_CONF","CONF_CNT",""+iCont_cnt);
				cb.SetCookieExpire("MEMJOIN_SELF_CONF", 3600*24);
				cb.responseAddCookie(response);
				
				// bizm용 전화번호. 01012345678 을 821012345678. 형식으로 가공. 국가번호(82:대한민국).
				String receiver_num = "";	// 
				receiver_num = "82" + cs_tel.substring(1, cs_tel.length());				
		
				String serverType = "real"; //실제용
				
				
				// 데이터 세팅
				Bizm_Data bizm_data = new Bizm_Data();
				bizm_data.setEnuri_id(enuri_id);
				bizm_data.setReceiver_num(receiver_num);
				bizm_data.setServerType(serverType);
				bizm_data.setAuthNum(cs_no);
				
				boolean InsertYN = false;
				
				// bizm 문자 전송 테이블에 INSERT.
				InsertYN = Bizm_Proc.insertBizmsg(bizm_data);
				// 인서트에 성공했다면
				if(InsertYN==true){
					resultCode = 1;
				}
			}
		}
	}
	
	JSONObject jSONObject = new JSONObject();  
	jSONObject.put("result", resultCode);    
	out.println(jSONObject.toString());		
}
%>

<%!
public boolean isPhoneNumber(String num){
	boolean isPhoneNumber = false;
	String firstNum = CutStr.cutStr(num, 3);
	
	if(firstNum.equals("010") || firstNum.equals("011") || firstNum.equals("016") || firstNum.equals("017") || firstNum.equals("018") || firstNum.equals("019")){
		isPhoneNumber = true;
	}
	
	return isPhoneNumber;
}
%>
