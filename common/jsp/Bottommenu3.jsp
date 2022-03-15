<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="/include/Base_Inc.jsp"%>
<%
	boolean bSDUlinkShow=true;
	
	String strUserId = "";
	String strShopId = "";
	
	if (cb.GetCookie("MEM_INFO", "USER_ID") != null)
	{
		strUserId = cb.GetCookie("MEM_INFO", "USER_ID");
	}
	if (cb.GetCookie("SDU", "SHOP_ID") != null)
	{
		strShopId = cb.GetCookie("SDU", "SHOP_ID");
	}
		
	if (strUserId.trim().length() > 0 && strShopId.trim().length() == 0)
	{
		bSDUlinkShow = false;
	}
	
%>
<html>
<head>
<%=incMeta.getHeader()%>
<link REL="stylesheet" HREF="/common/css/main.css" TYPE="text/css">
<script language=javascript src="/common/js/function.js"></script>
<script LANGUAGE="JavaScript">
<!--
function GotoSDU_Login(sURL)
{
	var k = window.open(sURL,'WinSDULogin','width=450 height=330');
		k.focus();	
}
function Cmd_Sitemap_All_Bottom(){
	//window.open("/etc/Sitemap.jsp?root=main","sitemap","toolbar=no,menubar=no,status=no,location=no,scrollbars=yes,resizable=yes,top=0,left=0,width=795,height="+screen.availHeight);
	top.document.getElementById("frmAllMenu").src = "/etc/All_Menu.jsp";	
}

//-->
</script>



</head>

<body>
<table width="774" border="0" cellspacing="0" cellpadding="0"
	height="100%" valign=top bgcolor="#d1d1d1">
	<tr height=1>
		<td></td>
	</tr>
	<tr bgcolor="#D2D2D2">
		<td align=center>
		<table border=0 cellpadding=0 cellspacing=0 width="100%"
			align="center" height="28">
			<tr>
				<td align="center"><font color="#626262"> <a href="/"
					!target="_top">HOME</a> | <a href="/etc/enuri_intro/Enuriintro.jsp"
					!target="enuri_bodyframe">회사소개</a> | <a href="/etc/Ad.jsp"
					!target="enuri_bodyframe">광고안내</a> | <a
					href="/enuriap/info/Ap_1.jsp" !target="enuri_bodyframe">수익배분프로그램</a>
				| <!--<a href="/etc/Search_Guide.jsp" !target="enuri_bodyframe">사용자가이드</a>-->
				<a href="/etc/Search_Guide.jsp" !target="enuri_bodyframe">가이드</a> <%
 if (bSDUlinkShow) {
 %>
				| <a href="#" onclick="GotoSDU_Login('/sdu/login/Login.jsp')">SDU(EDU)</a>
				<%
				}
				%> | <a href="/etc/Secure.jsp" !target="enuri_bodyframe">개인정보</a> |
				<a href="/etc/Duty.jsp" !target="enuri_bodyframe">법적고지</a> | <a
					href="#" onclick="Cmd_Sitemap_All_Bottom();"  !target="enuri_bodyframe">전체메뉴</a><!--a href="/etc/Proposal.jsp" target="enuri_bodyframe">서비스제안</a-->
				| <a href="/board/Viewboard_Old.jsp?lscate=1000"
					!target="enuri_bodyframe">FAQ/게시판</a> | <!--<a href="/MallRegister/Everintro.asp" !target="enuri_bodyframe">입점안내(에버몰)</a>-->
				<a href="/MallRegister/Everintro.asp" !target="enuri_bodyframe">1111입점안내</a>

				<!--
					|
					<a href="/escrow/myenuri/Esboardmain.jsp?bannervalue=esboard" !target="enuri_bodyframe">안심구매게시판</font></a>m					-->
				<!--
					|
					<a href="/view/fashion/Fashion.jsp" !target="enuri_bodyframe">의류</a>
					|
					--> </font></td>
			</tr>
		</table>
		</td>
		<form name="fmBtmLog" id="fmBtmLog" target="ifrmBTMHidden"><input
			type="hidden" name="swidth"> <input type="hidden"
			name="sheight"></form>
		<iframe id="ifrmBTMHidden" name="ifrmBTMHidden" src=""
			style="width:0;height:0;" frameborder=0></iframe>
	</tr>

</table>
</body>
</html>
<script language=javascript>
<!--
function CmdScreenLog(){
	try{
		var obj = document.fmBtmLog;
		obj.swidth.value= window.screen.width;
		obj.sheight.value= window.screen.height;
		obj.target="ifrmBTMHidden";
		obj.action="/include/Screenlog.jsp";
		obj.submit();
	}catch(e){
		window.status="";
	}
}
//CmdScreenLog();
//-->
</script>



