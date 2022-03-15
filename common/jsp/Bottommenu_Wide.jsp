<%@ page contentType="text/html; charset=euc-kr" %>
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
<style type="text/css">
#footer {
	clear:both;
	width:981px;
}
/*하단메뉴*/
#bottom_menu {
	width:980px;
	height:31px;
	background-color:#cccccc;
}
#bottom_menu .bm_1{
	height:21px;
	margin:10 0 0 25;
	text-align:center;
	color:#676767;
	font-size:8pt;
}
#bottom_menu .bm_2{
    height:21px;
    margin:10 15 0 15;
	color:#676767;
}
#bottom_menu .bm_3{
    height:21px;
    margin:10 0 0 0;
	color:#676767;
	font-size:8pt;
}
#bottom_menu .bm_1 a:link, #bottom_menu .bm_1 a:visited {
    color: #676767;
    text-decoration:none;
}
#bottom_menu .bm_1 a:active {
	color: red;
	text-decoration:underline;
}
#bottom_menu .bm_1 a:hover{
	color: red;
	text-decoration:none;
}
#bottom_menu .bm_3 a:link, a:visited {
    color: #676767;
    text-decoration:none;
}
#bottom_menu .bm_3 a:active {
	color: red;
	text-decoration:underline;
}
#bottom_menu .bm_3 a:hover{
	color: red;
	text-decoration:none;
}
</style>
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
<%
/*
%>
<table cellpadding='0' cellspacing='0' width='774' height='25' bgcolor='#b2b2b2'>
	<tr>
		<td align='center'>
			<a href='/' class='partner' target="_top">HOME</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/etc/enuri_intro/Enuriintro.jsp" class='partner'>회사소개</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/etc/Ad.jsp" class='partner'>광고안내</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<% if( bSDUlinkShow ){%>
			<a href='#' onclick="GotoSDU_Login('/sdu/login/Login.jsp')" class='partner'>SDU[EDU]</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<%}%>
			<a href="/etc/Secure.jsp" class='partner'>개인정보</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/etc/Duty.jsp" class='partner'>법적고지</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="#" onclick="Cmd_Sitemap_All_Bottom();"  class='partner'>전체메뉴</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/view/mallsearch/Listmall.jsp" class='partner'>쇼핑몰검색</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/board/Viewboard_Old.jsp?lscate=1000" class='partner'>FAQ/게시판</a>&nbsp;&nbsp;<img src='<%=ConfigManager.IMG_ENURI_COM%>/images/main_image/grey_line.gif'>&nbsp;&nbsp;
			<a href="/mallregister/Everintro.jsp" class='partner'>입점안내/에버몰</a>
		</td>
	</tr>
</table>
<%
*/
%>

<div id="footer">
<div id="bottom_menu">
    <span class="bm_1"><a href="/">HOME</a></span>
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/etc/enuri_intro/Enuriintro.jsp">회사소개</a></span>
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/etc/Ad.jsp">광고안내</a></span>	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/mallregister/Mallregister.jsp?cmd1=11">입점안내/레드링크</a></span>	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="#" onclick="GotoSDU_Login('/sdu/login/Login.jsp')" >SDU</a></span>	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/etc/Secure.jsp">개인정보</a></span>	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/etc/Duty.jsp">법적고지</a></span>	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/view/mallsearch/Listmall.jsp">쇼핑몰검색</a></span>	    	    	    	    	    	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/board/Viewboard_Old.jsp?lscate=1000">FAQ/게시판</a></span>	    	    	    	    	    	    
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="#" onclick="Cmd_Sitemap_All_Bottom();" >전체메뉴</a></span>
    <span class="bm_2"><img src="<%=ConfigManager.IMG_ENURI_COM%>/images/main_2007/b_bottm_menu_line.gif" align='absmiddle'></span>
    <span class="bm_3"><a href="/etc/Site_map.jsp">사이트맵</a></span>	    	    	    	    	    	    	    	    
</div>
</div>	

<form name="fmBtmLog2" 	style="margin:0px;">
	<input type="hidden" name="swidth" value="">
	<input type="hidden" name="sheight" value="">
</form>
<iframe name="ifrmBTMHidden1" id="ifrmBTMHidden1" width="0" height="0" border="0"></iframe>
<script language=javascript>
<!--
function CmdScreenLog(){
	try{
		var obj2 = document.fmBtmLog2;
		obj2.swidth.value = window.screen.width;
		obj2.sheight.value = window.screen.height;
		obj2.target="ifrmBTMHidden1";
		obj2.action="/include/Screenlog.jsp";
		obj2.submit();
	}catch(e){
		//alert(e);
		window.status="";
	}
}
<%
//if(DateUtil.getDaysDiff(DateStr.nowStr("yyyy-MM-dd"),"2007-02-27") < 1){
		//if(DateUtil.getDaysDiff(DateStr.nowStr("yyyy-MM-dd"),"2007-03-01") > 0){
			//System.out.println("check====aaa");
%>
//CmdScreenLog();
<%//}
//}%>

//-->
</script>
