<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.bean.mobile.RSAMains"%>
<%@ page import="com.enuri.bean.mobile.Mobile_Push_Proc"%>
<%@ page import="com.enuri.bean.mobile.CRSA"%>
<%@ page import="com.enuri.bean.mobile.Reward_Data"%>
<%@ page import="com.enuri.bean.mobile.Reward_Proc"%>
<jsp:useBean id="Reward_Data" class="com.enuri.bean.mobile.Reward_Data"
	scope="page" />
<jsp:useBean id="Reward_Proc" class="com.enuri.bean.mobile.Reward_Proc"
	scope="page" />

<%@ page import="com.enuri.bean.mobile.PDSweetTrackerManager_Proc"%>



<%
	//t1=@@@&enuri_id=@@@&shop_code=@@@&order_no=@@@&user_data=@@@
	//20171113 손진욱 t1 pd 모듈
	
	boolean fDevServer = false;
fDevServer = request.getServerName().equals("dev.enuri.com");
//데브 테스트용 절대 배포 금지 
if(fDevServer){
	PDSweetTrackerManager_Proc pdmanager = new PDSweetTrackerManager_Proc();

	out.println( pdmanager.chkPDSweetTracker(request));
}
	
%>
