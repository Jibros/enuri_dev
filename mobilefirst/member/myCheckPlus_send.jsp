<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/mobilefirst/include/Base_Inc_Mobile.jsp"%>
<%@ page import="com.enuri.util.seed.Seed_Proc"%>
<jsp:useBean id="Seed_Proc" class="com.enuri.util.seed.Seed_Proc" scope="page" />
<%
/*
String sMobileNo = ChkNull.chkStr(request.getParameter("smobileno"),"");
String sConnInfo = ChkNull.chkStr(request.getParameter("sconninfo"),"");
String sDupInfo = ChkNull.chkStr(request.getParameter("sdopinfo"),"");
String sMobileCo = ChkNull.chkStr(request.getParameter("smobileco"),"");

String sName = ChkNull.chkStr(request.getParameter("sname"),"");
String sMyAuth = ChkNull.chkStr(request.getParameter("myauth"),"");
*/
//APP
String strApp = "";

Cookie[] carr = request.getCookies();
try {
	for(int i=0;i<carr.length;i++){
	    if(carr[i].getName().equals("appYN")){
	    	strApp = carr[i].getValue();
	    }
	}
} catch(Exception e) {
}


String sMobileNo = ChkNull.chkStr(request.getParameter("enus1"),"");
String sConnInfo = ChkNull.chkStr(request.getParameter("enus2"),"");
String sDupInfo = ChkNull.chkStr(request.getParameter("enus3"),"");
String sMobileCo = ChkNull.chkStr(request.getParameter("enus4"),"");

String sName = ChkNull.chkStr(request.getParameter("enus5"),"");
String sMyAuth = ChkNull.chkStr(request.getParameter("enus6"),"");

if(!sMobileNo.equals("")){
	sMobileNo = Seed_Proc.DePass(sMobileNo);
}
if(!sDupInfo.equals("")){
	//sDupInfo 	=	Seed_Proc.DePass(sDupInfo);
}
if(!sConnInfo.equals("")){
	//sConnInfo = Seed_Proc.DePass(sConnInfo);
}
if(!sMobileCo.equals("")){
	sMobileCo = Seed_Proc.DePass_Seed(sMobileCo);
}
if(!sName.equals("")){
	sName 		= Seed_Proc.DePass_Seed(sName);
}

if(sName.equals("")){
	HttpSession ttsession = request.getSession(true);
	sName = (String)ttsession.getAttribute("MEMJOIN_NAME");
}

%>
<script language="javascript">
	//alert('mobileNo222:'+'<%=sMobileNo%>');
	//if('<%=strApp%>' == "Y"){
	//	location.href = "close://";
	//	window.close();
	//}else{
		try{
			opener.opener.afterMyAuth('<%=sMobileNo%>', '<%=sConnInfo%>', '<%=sDupInfo%>', '<%=sMobileCo%>', '<%=sName%>','<%=sMyAuth%>');
			window.close();
		}catch(e){
			opener.afterMyAuth('<%=sMobileNo%>', '<%=sConnInfo%>', '<%=sDupInfo%>', '<%=sMobileCo%>', '<%=sName%>','<%=sMyAuth%>');
			window.close();
		}
	//}
</script>