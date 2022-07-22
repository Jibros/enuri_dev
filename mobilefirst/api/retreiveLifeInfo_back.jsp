<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBDataTable"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.main.brandplacement.DBWrap"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.util.date.DateUtil"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<%@ page import="com.enuri.bean.knowbox.Members_Data"%>
<%@ page import="com.enuri.bean.knowbox.Members_Proc"%>
<%@ page import="com.enuri.bean.member.Login_Data"%>
<%@ page import="com.enuri.bean.member.Login_Proc"%>
<jsp:useBean id="Login_Data" class="com.enuri.bean.member.Login_Data" />
<jsp:useBean id="Login_Proc" class="com.enuri.bean.member.Login_Proc" />
<jsp:useBean id="Members_Data"
				class="com.enuri.bean.knowbox.Members_Data" />
<jsp:useBean id="Members_Proc"
				class="com.enuri.bean.knowbox.Members_Proc" />
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" />
<jsp:useBean id="Mobile_Push_Proc"
				class="com.enuri.bean.mobile.Mobile_Push_Proc" scope="page" />
				
<%@ page import="com.enuri.bean.mobile.PDManager_Proc"%>
<%@ page import="com.enuri.bean.mobile.PDManager_PD_Data"%>
<%@ page import="com.enuri.bean.mobile.PDManager_T1_Data"%>
<%
	CRSA rsa = new CRSA();

	//ti 풀어서 넘어온 uuid 랑 pd에 있는 uuid가 동일하면 t1을 새로 말아서 던져줌.
	//
	// app에서 call할때 넘겨주는 값들
	// 2016.10.14
	/* 

	PDManager_Proc pdmanager = new PDManager_Proc();
	
	PDManager_PD_Data pdData = pdmanager.chkPD(request);

	out.println(pdData.toString());
	out.println(pdData.getNickname());
	out.println(URLDecoder.decode(pdData.getNickname(),"UTF-8"));
	out.println(URLDecoder.decode(pdData.getName(),"UTF-8"));
	 */
	
	
%>